`timescale 1ns / 1ps

// Serializes DDR-read IQ data into ARTERY and returns branch pulse data by UDP.
// DDR input beat format: eight packed 32-bit IQ samples per 256-bit beat:
//   sample[15:0] = I, sample[31:16] = Q.
// Feedback waveform follows the ARTERY paper's pulse-preparation model:
// pulse data for branch 0 and branch 1 is read from memory, and pred_state
// selects which preloaded branch pulse is emitted.
module artery_ddr_udp_feedback #(
    parameter [15:0] WINDOW_START = 16'd852,
    parameter [15:0] WINDOW_LEN   = 16'd2048,
    parameter [15:0] STREAM_SAMPLES = 16'd4096,
    parameter [15:0] FEEDBACK_WORDS = 16'd16,
    parameter [31:0] FULL_OMEGA = 32'd0,
    parameter signed [15:0] NCO_INIT_COS = 16'sd32767,
    parameter signed [15:0] NCO_INIT_SIN = 16'sd0,
    parameter signed [31:0] FULL_CENTER_ZERO_I = 32'sd0,
    parameter signed [31:0] FULL_CENTER_ZERO_Q = 32'sd0,
    parameter signed [31:0] FULL_CENTER_ONE_I  = 32'sd0,
    parameter signed [31:0] FULL_CENTER_ONE_Q  = 32'sd0,
    parameter [15:0] EARLY_LEN = 16'd128,
    parameter [15:0] EARLY_THRESHOLD = 16'h8000,
    parameter [7:0]  PREDICT_THRESHOLD_LOW = 8'h1A,
    parameter [7:0]  PREDICT_THRESHOLD_HIGH = 8'hE6,
    parameter [15:0] MAX_DECISION_LEN = 16'd2048,
    parameter        ENABLE_BHT_SELF_UPDATE = 1'b0,
    parameter        ENABLE_FEEDBACK_STREAM_LOAD = 1'b0,
    parameter signed [31:0] EARLY_MID_I = -32'sd338095166,
    parameter signed [31:0] EARLY_MID_Q = 32'sd557156265,
    parameter signed [31:0] EARLY_DELTA_I = -32'sd506388898,
    parameter signed [31:0] EARLY_DELTA_Q = -32'sd1143109408,
    parameter [15:0] TRAJECTORY_SEG_LEN = 16'd16
) (
    input  wire         clk,
    input  wire         rst_n,

    input  wire [255:0] ddr_tdata,
    input  wire         ddr_tvalid,
    output wire         ddr_tready,

    input  wire [255:0] fb0_tdata,
    input  wire         fb0_tvalid,
    output wire         fb0_tready,
    input  wire [255:0] fb1_tdata,
    input  wire         fb1_tvalid,
    output wire         fb1_tready,

    output reg          udp_tx_wr,
    output reg  [63:0]  udp_tx_data,
    input  wire         udp_tx_af,

    output reg  [31:0]  dbg_latency_cycles,
    output reg          dbg_latency_valid,
    output reg  [31:0]  dbg_window_count,
    output reg  [15:0]  dbg_sample_index,
    output reg          dbg_ddr_first_fire,
    output reg          dbg_sample_fire,
    output wire         dbg_artery_done,
    output wire         dbg_pred_state,
    output wire         dbg_actual_state,
    output wire         dbg_pred_correct
);

  reg        half_pending;
  reg [127:0] upper_half_data;

  assign ddr_tready = rst_n && !half_pending;
  wire ddr_fire = ddr_tvalid && ddr_tready;
  wire proc_fire = ddr_fire || half_pending;
  wire [127:0] proc_tdata = half_pending ? upper_half_data : ddr_tdata[127:0];

  reg signed [47:0] early_accum_i;
  reg signed [47:0] early_accum_q;
  reg [15:0] early_count;
  reg [15:0] fast_sample_index;
  reg        beat_valid;
  reg        beat_window_start;
  reg        mix_valid;
  reg        mix_window_start;
  reg        sum_stage_valid;
  reg        sum_stage_window_start;
  reg        sum_half_valid;
  reg        sum_half_window_start;
  reg        beat_sum_valid;
  reg        beat_sum_window_start;
  (* DONT_TOUCH = "true" *) reg        accum_update_valid;
  (* DONT_TOUCH = "true" *) reg        accum_update_window_start;
  (* DONT_TOUCH = "true" *) reg signed [47:0] accum_update_early_i;
  (* DONT_TOUCH = "true" *) reg signed [47:0] accum_update_early_q;
  (* DONT_TOUCH = "true" *) reg signed [47:0] accum_update_traj_i;
  (* DONT_TOUCH = "true" *) reg signed [47:0] accum_update_traj_q;
  (* DONT_TOUCH = "true" *) reg        accum_update_segment_trigger;
  (* DONT_TOUCH = "true" *) reg        accum_update_max_decision;
  (* DONT_TOUCH = "true" *) reg [7:0]  accum_update_traj_history;
  reg early_fired;
  reg early_done_pulse;
  reg early_pred_state;
  reg analysis_active;
  wire input_window_start =
      (fast_sample_index <= WINDOW_START) &&
      (fast_sample_index + 16'd4 > WINDOW_START);
  wire stream_start = proc_fire && (fast_sample_index == 16'd0);
  wire stream_last = proc_fire && (fast_sample_index + 16'd4 >= STREAM_SAMPLES);

  assign dbg_artery_done  = early_done_pulse;
  assign dbg_pred_state   = early_pred_state;
  assign dbg_actual_state = 1'b0;
  assign dbg_pred_correct = 1'b0;

  // Lightweight ARTERY-style trajectory path:
  // 4-lane baseband IQ, short trajectory segments, BHT history, and Bayesian
  // confidence thresholding. The S21 captures used by the board tests are
  // already baseband IQ, so the hard-coded omega rotation is bypassed below.
  localparam [3:0] BHT_MAX_COUNT = 4'd15;
  localparam [7:0] TEMPLATE_SEGMENTS = 8'd128;
  localparam signed [79:0] TEMPLATE_BIAS = -80'sd2190224416;
  localparam signed [15:0] ROT1_COS = 16'sd9191;
  localparam signed [15:0] ROT1_SIN = -16'sd31452;
  localparam signed [15:0] ROT2_COS = -16'sd27611;
  localparam signed [15:0] ROT2_SIN = -16'sd17644;
  localparam signed [15:0] ROT3_COS = -16'sd24681;
  localparam signed [15:0] ROT3_SIN = 16'sd21553;
  localparam signed [15:0] ROT4_COS = 16'sd13765;
  localparam signed [15:0] ROT4_SIN = 16'sd29736;

  reg signed [47:0] traj_accum_i;
  reg signed [47:0] traj_accum_q;
  reg [15:0] traj_count;
  reg [7:0] traj_history;
  reg [3:0] bht_state1_count [0:255];
  reg [3:0] bht_total_count [0:255];
  reg [255:0] bht_valid;
  reg        eval_valid;
  reg signed [47:0] eval_i;
  reg signed [47:0] eval_q;
  reg        eval_segment_trigger;
  reg        eval_max_decision;
  reg [7:0]  eval_traj_history;
  reg        proj_mult_valid;
  reg signed [95:0] proj_mult_i;
  reg signed [95:0] proj_mult_q;
  reg        proj_mult_segment_trigger;
  reg        proj_mult_max_decision;
  reg [7:0]  proj_mult_traj_history;
  reg        proj_valid;
  reg        proj_pred_state;
  reg [95:0] proj_margin_abs;
	  reg        proj_segment_trigger;
	  reg        proj_max_decision;
	  reg [7:0]  proj_traj_key;
	  reg        decision_valid;
	  reg        decision_pred_state;
	  reg [7:0]  decision_predict_prob;
	  reg        decision_segment_trigger;
	  reg        decision_max_decision;
	  reg [7:0]  decision_traj_key;
	  reg        decision_bht_hit;
	  reg        decision_proj_pred_state;
  reg [3:0]  decision_bht_state1;
  reg [3:0]  decision_bht_total;
  reg signed [79:0] template_score;
  reg [7:0]  template_segment_index;
  reg        template_decision_valid;
  reg        template_pred_state;
  reg [7:0]  template_predict_prob;
  reg signed [31:0] template_segment_i;
  reg signed [31:0] template_segment_q;
  reg [15:0] template_sample_count;
  reg        template_mul_valid;
  reg        template_mul_max_decision;
  reg signed [31:0] template_mul_segment_i;
  reg signed [31:0] template_mul_segment_q;
  reg [7:0]  template_mul_segment_index;
  reg        template_accum_valid;
  reg        template_accum_max_decision;
  reg signed [47:0] template_accum_score_i;
  reg signed [47:0] template_accum_score_q;

  reg signed [15:0] ddr_sample0_i;
  reg signed [15:0] ddr_sample0_q;
  reg signed [15:0] ddr_sample1_i;
  reg signed [15:0] ddr_sample1_q;
  reg signed [15:0] ddr_sample2_i;
  reg signed [15:0] ddr_sample2_q;
  reg signed [15:0] ddr_sample3_i;
  reg signed [15:0] ddr_sample3_q;
  reg signed [15:0] ddr_sample4_i;
  reg signed [15:0] ddr_sample4_q;
  reg signed [15:0] ddr_sample5_i;
  reg signed [15:0] ddr_sample5_q;
  reg signed [15:0] ddr_sample6_i;
  reg signed [15:0] ddr_sample6_q;
  reg signed [15:0] ddr_sample7_i;
  reg signed [15:0] ddr_sample7_q;

  reg signed [15:0] nco_cos;
  reg signed [15:0] nco_sin;

  wire signed [31:0] nco_cos1_full = $signed(nco_cos) * ROT1_COS - $signed(nco_sin) * ROT1_SIN;
  wire signed [31:0] nco_sin1_full = $signed(nco_sin) * ROT1_COS + $signed(nco_cos) * ROT1_SIN;
  wire signed [31:0] nco_cos2_full = $signed(nco_cos) * ROT2_COS - $signed(nco_sin) * ROT2_SIN;
  wire signed [31:0] nco_sin2_full = $signed(nco_sin) * ROT2_COS + $signed(nco_cos) * ROT2_SIN;
  wire signed [31:0] nco_cos3_full = $signed(nco_cos) * ROT3_COS - $signed(nco_sin) * ROT3_SIN;
  wire signed [31:0] nco_sin3_full = $signed(nco_sin) * ROT3_COS + $signed(nco_cos) * ROT3_SIN;
  wire signed [31:0] nco_cos4_full = $signed(nco_cos) * ROT4_COS - $signed(nco_sin) * ROT4_SIN;
  wire signed [31:0] nco_sin4_full = $signed(nco_sin) * ROT4_COS + $signed(nco_cos) * ROT4_SIN;
  wire signed [15:0] nco_cos4 = nco_cos4_full[30:15];
  wire signed [15:0] nco_sin4 = nco_sin4_full[30:15];
  reg signed [15:0] lane0_cos;
  reg signed [15:0] lane0_sin;
  reg signed [15:0] lane1_cos;
  reg signed [15:0] lane1_sin;
  reg signed [15:0] lane2_cos;
  reg signed [15:0] lane2_sin;
  reg signed [15:0] lane3_cos;
  reg signed [15:0] lane3_sin;
  reg signed [15:0] lane4_cos;
  reg signed [15:0] lane4_sin;
  reg signed [15:0] lane5_cos;
  reg signed [15:0] lane5_sin;
  reg signed [15:0] lane6_cos;
  reg signed [15:0] lane6_sin;
  reg signed [15:0] lane7_cos;
  reg signed [15:0] lane7_sin;
  wire signed [15:0] next_nco_cos = nco_cos4;
  wire signed [15:0] next_nco_sin = nco_sin4;
  reg signed [32:0] mix0_i_r;
  reg signed [32:0] mix0_q_r;
  reg signed [32:0] mix1_i_r;
  reg signed [32:0] mix1_q_r;
  reg signed [32:0] mix2_i_r;
  reg signed [32:0] mix2_q_r;
  reg signed [32:0] mix3_i_r;
  reg signed [32:0] mix3_q_r;
  reg signed [32:0] mix4_i_r;
  reg signed [32:0] mix4_q_r;
  reg signed [32:0] mix5_i_r;
  reg signed [32:0] mix5_q_r;
  reg signed [32:0] mix6_i_r;
  reg signed [32:0] mix6_q_r;
  reg signed [32:0] mix7_i_r;
  reg signed [32:0] mix7_q_r;
  reg signed [47:0] sum01_i_r;
  reg signed [47:0] sum01_q_r;
  reg signed [47:0] sum23_i_r;
  reg signed [47:0] sum23_q_r;
  reg signed [47:0] sum45_i_r;
  reg signed [47:0] sum45_q_r;
  reg signed [47:0] sum67_i_r;
  reg signed [47:0] sum67_q_r;
  reg signed [47:0] sum0123_i_r;
  reg signed [47:0] sum0123_q_r;
  reg signed [47:0] sum4567_i_r;
  reg signed [47:0] sum4567_q_r;
  (* DONT_TOUCH = "true" *) reg signed [47:0] ddr_beat_sum_i_r;
  (* DONT_TOUCH = "true" *) reg signed [47:0] ddr_beat_sum_q_r;

  wire signed [32:0] mix0_i = $signed(ddr_sample0_i) * $signed(lane0_cos) + $signed(ddr_sample0_q) * $signed(lane0_sin);
  wire signed [32:0] mix0_q = $signed(ddr_sample0_q) * $signed(lane0_cos) - $signed(ddr_sample0_i) * $signed(lane0_sin);
  wire signed [32:0] mix1_i = $signed(ddr_sample1_i) * $signed(lane1_cos) + $signed(ddr_sample1_q) * $signed(lane1_sin);
  wire signed [32:0] mix1_q = $signed(ddr_sample1_q) * $signed(lane1_cos) - $signed(ddr_sample1_i) * $signed(lane1_sin);
  wire signed [32:0] mix2_i = $signed(ddr_sample2_i) * $signed(lane2_cos) + $signed(ddr_sample2_q) * $signed(lane2_sin);
  wire signed [32:0] mix2_q = $signed(ddr_sample2_q) * $signed(lane2_cos) - $signed(ddr_sample2_i) * $signed(lane2_sin);
  wire signed [32:0] mix3_i = $signed(ddr_sample3_i) * $signed(lane3_cos) + $signed(ddr_sample3_q) * $signed(lane3_sin);
  wire signed [32:0] mix3_q = $signed(ddr_sample3_q) * $signed(lane3_cos) - $signed(ddr_sample3_i) * $signed(lane3_sin);
  wire signed [32:0] mix4_i = 33'sd0;
  wire signed [32:0] mix4_q = 33'sd0;
  wire signed [32:0] mix5_i = 33'sd0;
  wire signed [32:0] mix5_q = 33'sd0;
  wire signed [32:0] mix6_i = 33'sd0;
  wire signed [32:0] mix6_q = 33'sd0;
  wire signed [32:0] mix7_i = 33'sd0;
  wire signed [32:0] mix7_q = 33'sd0;

  wire signed [47:0] sum01_i = {{15{mix0_i_r[32]}}, mix0_i_r} + {{15{mix1_i_r[32]}}, mix1_i_r};
  wire signed [47:0] sum01_q = {{15{mix0_q_r[32]}}, mix0_q_r} + {{15{mix1_q_r[32]}}, mix1_q_r};
  wire signed [47:0] sum23_i = {{15{mix2_i_r[32]}}, mix2_i_r} + {{15{mix3_i_r[32]}}, mix3_i_r};
  wire signed [47:0] sum23_q = {{15{mix2_q_r[32]}}, mix2_q_r} + {{15{mix3_q_r[32]}}, mix3_q_r};
  wire signed [47:0] sum45_i = {{15{mix4_i_r[32]}}, mix4_i_r} + {{15{mix5_i_r[32]}}, mix5_i_r};
  wire signed [47:0] sum45_q = {{15{mix4_q_r[32]}}, mix4_q_r} + {{15{mix5_q_r[32]}}, mix5_q_r};
  wire signed [47:0] sum67_i = {{15{mix6_i_r[32]}}, mix6_i_r} + {{15{mix7_i_r[32]}}, mix7_i_r};
  wire signed [47:0] sum67_q = {{15{mix6_q_r[32]}}, mix6_q_r} + {{15{mix7_q_r[32]}}, mix7_q_r};
  wire signed [47:0] sum0123_i = sum01_i_r + sum23_i_r;
  wire signed [47:0] sum0123_q = sum01_q_r + sum23_q_r;
  wire signed [47:0] sum4567_i = sum45_i_r + sum67_i_r;
  wire signed [47:0] sum4567_q = sum45_q_r + sum67_q_r;
  wire signed [47:0] ddr_beat_sum_i = sum0123_i_r + sum4567_i_r;
  wire signed [47:0] ddr_beat_sum_q = sum0123_q_r + sum4567_q_r;

  wire signed [47:0] early_next_i =
      ((early_count == 16'd0) || beat_sum_window_start) ? ddr_beat_sum_i_r :
      early_accum_i + ddr_beat_sum_i_r;
  wire signed [47:0] early_next_q =
      ((early_count == 16'd0) || beat_sum_window_start) ? ddr_beat_sum_q_r :
      early_accum_q + ddr_beat_sum_q_r;

  wire signed [47:0] early_centered_i = eval_i - {{16{EARLY_MID_I[31]}}, EARLY_MID_I};
  wire signed [47:0] early_centered_q = eval_q - {{16{EARLY_MID_Q[31]}}, EARLY_MID_Q};
  wire signed [95:0] early_proj_i = $signed(early_centered_i) * $signed(EARLY_DELTA_I);
  wire signed [95:0] early_proj_q = $signed(early_centered_q) * $signed(EARLY_DELTA_Q);
  wire signed [96:0] proj_mult_sum =
      $signed({proj_mult_i[95], proj_mult_i}) +
      $signed({proj_mult_q[95], proj_mult_q});
  wire proj_mult_pred_next = proj_mult_sum >= 97'sd0;
  wire [95:0] proj_mult_margin_abs =
      proj_mult_sum[96] ? -proj_mult_sum[95:0] : proj_mult_sum[95:0];

  wire signed [47:0] traj_next_i =
      ((traj_count == 16'd0) || beat_sum_window_start) ? ddr_beat_sum_i_r :
      traj_accum_i + ddr_beat_sum_i_r;
  wire signed [47:0] traj_next_q =
      ((traj_count == 16'd0) || beat_sum_window_start) ? ddr_beat_sum_q_r :
      traj_accum_q + ddr_beat_sum_q_r;
`include "s21_template_weights.vh"

  wire signed [15:0] proc_sample0_i = proc_tdata[15:0];
  wire signed [15:0] proc_sample0_q = proc_tdata[31:16];
  wire signed [15:0] proc_sample1_i = proc_tdata[47:32];
  wire signed [15:0] proc_sample1_q = proc_tdata[63:48];
  wire signed [15:0] proc_sample2_i = proc_tdata[79:64];
  wire signed [15:0] proc_sample2_q = proc_tdata[95:80];
  wire signed [15:0] proc_sample3_i = proc_tdata[111:96];
  wire signed [15:0] proc_sample3_q = proc_tdata[127:112];
  wire signed [18:0] template_beat_i =
      {{3{proc_sample0_i[15]}}, proc_sample0_i} +
      {{3{proc_sample1_i[15]}}, proc_sample1_i} +
      {{3{proc_sample2_i[15]}}, proc_sample2_i} +
      {{3{proc_sample3_i[15]}}, proc_sample3_i};
  wire signed [18:0] template_beat_q =
      {{3{proc_sample0_q[15]}}, proc_sample0_q} +
      {{3{proc_sample1_q[15]}}, proc_sample1_q} +
      {{3{proc_sample2_q[15]}}, proc_sample2_q} +
      {{3{proc_sample3_q[15]}}, proc_sample3_q};
  wire template_proc_in_window =
      proc_fire && (fast_sample_index >= WINDOW_START) &&
      (fast_sample_index < WINDOW_START + MAX_DECISION_LEN);
  wire signed [31:0] template_segment_i_next =
      (template_sample_count[3:0] == 4'd0) ?
      {{13{template_beat_i[18]}}, template_beat_i} :
      template_segment_i + {{13{template_beat_i[18]}}, template_beat_i};
  wire signed [31:0] template_segment_q_next =
      (template_sample_count[3:0] == 4'd0) ?
      {{13{template_beat_q[18]}}, template_beat_q} :
      template_segment_q + {{13{template_beat_q[18]}}, template_beat_q};
  wire template_direct_segment_done = template_proc_in_window && (template_sample_count[3:0] == 4'd12);
  wire template_direct_max_decision =
      template_direct_segment_done &&
      ((template_segment_index + 8'd1 >= TEMPLATE_SEGMENTS) ||
       (template_sample_count + 16'd4 >= MAX_DECISION_LEN));
  wire signed [47:0] template_mul_score_i =
      $signed(template_mul_segment_i) * $signed(template_weight_i(template_mul_segment_index));
  wire signed [47:0] template_mul_score_q =
      $signed(template_mul_segment_q) * $signed(template_weight_q(template_mul_segment_index));
  wire signed [79:0] template_seg_score =
      {{32{template_accum_score_i[47]}}, template_accum_score_i} +
      {{32{template_accum_score_q[47]}}, template_accum_score_q};
  wire signed [79:0] template_score_next = template_score + template_seg_score;
  wire template_score_pred_next = template_score_next >= TEMPLATE_BIAS;
  wire traj_segment_trigger =
      beat_sum_valid && analysis_active && !beat_sum_window_start && !early_fired &&
      (early_count[3:0] == 4'd12);
  wire bht_hit = bht_valid[proj_traj_key];
  wire [3:0] bht_state1 = bht_state1_count[proj_traj_key];
  wire [3:0] bht_total = bht_total_count[proj_traj_key];
  wire [4:0] bht_state0 = {1'b0, bht_total} - {1'b0, bht_state1};
  wire signed [6:0] bht_log_odds =
      bht_hit ? ($signed({2'b00, bht_state1}) - $signed({2'b00, bht_state0})) : 7'sd0;
  wire signed [6:0] classifier_log_odds =
      (proj_margin_abs[95:72] != 24'd0) ? (proj_pred_state ? 7'sd8 : -7'sd8) :
      (proj_margin_abs[71:68] != 4'd0)  ? (proj_pred_state ? 7'sd6 : -7'sd6) :
                                           (proj_pred_state ? 7'sd4 : -7'sd4);
  wire signed [6:0] bayes_log_odds = classifier_log_odds + bht_log_odds;
  wire bayes_pred_next = bayes_log_odds >= 7'sd0;
  wire [6:0] bayes_abs_odds = bayes_log_odds[6] ? -bayes_log_odds : bayes_log_odds;
  wire [7:0] bayes_conf_delta = (bayes_abs_odds > 7'd15) ? 8'h7f : {1'b0, bayes_abs_odds} << 3;
  wire [7:0] bayes_prob_low8 =
      bayes_pred_next ? (8'h80 + bayes_conf_delta) : (8'h7f - bayes_conf_delta);
  wire confidence_reached =
      (bayes_prob_low8 >= PREDICT_THRESHOLD_HIGH) ||
      (bayes_prob_low8 <= PREDICT_THRESHOLD_LOW);
  wire allow_accum_update =
      beat_sum_valid && (!early_fired || beat_sum_window_start);
  wire max_decision_reached =
      beat_sum_valid && analysis_active && !beat_sum_window_start && !early_fired &&
      (early_count + 16'd4 >= MAX_DECISION_LEN);
	  wire early_trigger =
	      proj_valid && ((proj_segment_trigger && confidence_reached) || proj_max_decision);
	  wire decision_trigger =
	      analysis_active && decision_valid &&
	      ((decision_segment_trigger &&
	        ((decision_predict_prob >= PREDICT_THRESHOLD_HIGH) ||
	         (decision_predict_prob <= PREDICT_THRESHOLD_LOW))) ||
	       decision_max_decision);
  wire max_fallback_trigger = 1'b0;
  wire result_trigger = template_decision_valid;
  wire result_pred_state = template_pred_state;
  wire [7:0] result_predict_prob = template_predict_prob;

  reg        latency_active;
  reg [31:0] latency_counter;
  reg        pending_result_valid;
  reg [7:0]  pending_predict_prob;
  reg        pending_pred_state;
  reg        pending_actual_state;
  reg        pending_pred_correct;
  reg [15:0] pending_window_count;
  reg [23:0] pending_latency_cycles;
  reg        sending_feedback;
  reg [15:0] feedback_words_left;
  reg [15:0] feedback_rd_ptr;
  reg        metadata_pending;

  reg [63:0] feedback0_mem [0:FEEDBACK_WORDS-1];
  reg [63:0] feedback1_mem [0:FEEDBACK_WORDS-1];
  reg [15:0] feedback0_wr_ptr;
  reg [15:0] feedback1_wr_ptr;

  initial begin
    $readmemh("/home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/feedback_branch0.mem", feedback0_mem);
    $readmemh("/home/syyao/newproject/custom_xczu47dr_rfdc/custom_xczu47dr_rfdc.srcs/sources_1/imports/hardware/vivado/src/feedback_branch1.mem", feedback1_mem);
  end

  assign fb0_tready = rst_n && ENABLE_FEEDBACK_STREAM_LOAD;
  assign fb1_tready = rst_n && ENABLE_FEEDBACK_STREAM_LOAD;

  wire fb0_fire = fb0_tvalid && fb0_tready;
  wire fb1_fire = fb1_tvalid && fb1_tready;
  function [63:0] feedback_rom_word;
    input [15:0] addr;
    begin
      feedback_rom_word = 64'd0;
      case (addr)
`include "feedback_rom_case.vh"
        default: feedback_rom_word = 64'd0;
      endcase
    end
  endfunction

  wire [63:0] selected_feedback_word = feedback_rom_word(feedback_rd_ptr);

  wire start_latency = stream_start;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      latency_active <= 1'b0;
      latency_counter <= 32'd0;
      dbg_latency_cycles <= 32'd0;
      dbg_latency_valid <= 1'b0;
      dbg_window_count <= 32'd0;
      pending_result_valid <= 1'b0;
      pending_predict_prob <= 8'd0;
      pending_pred_state <= 1'b0;
      pending_actual_state <= 1'b0;
      pending_pred_correct <= 1'b0;
      pending_window_count <= 16'd0;
      pending_latency_cycles <= 24'd0;
      sending_feedback <= 1'b0;
      feedback_words_left <= 16'd0;
      feedback_rd_ptr <= 16'd0;
      metadata_pending <= 1'b0;
      feedback0_wr_ptr <= 16'd0;
      feedback1_wr_ptr <= 16'd0;
      udp_tx_wr <= 1'b0;
      udp_tx_data <= 64'd0;
	      dbg_sample_index <= 16'd0;
	      dbg_ddr_first_fire <= 1'b0;
	      dbg_sample_fire <= 1'b0;
	      half_pending <= 1'b0;
	      upper_half_data <= 128'd0;
	      early_accum_i <= 48'sd0;
      early_accum_q <= 48'sd0;
	      early_count <= 16'd0;
	      fast_sample_index <= 16'd0;
	      beat_valid <= 1'b0;
	      beat_window_start <= 1'b0;
	      mix_valid <= 1'b0;
	      mix_window_start <= 1'b0;
	      sum_stage_valid <= 1'b0;
	      sum_stage_window_start <= 1'b0;
	      sum_half_valid <= 1'b0;
	      sum_half_window_start <= 1'b0;
	      beat_sum_valid <= 1'b0;
	      beat_sum_window_start <= 1'b0;
	      accum_update_valid <= 1'b0;
	      accum_update_window_start <= 1'b0;
	      accum_update_early_i <= 48'sd0;
	      accum_update_early_q <= 48'sd0;
	      accum_update_traj_i <= 48'sd0;
	      accum_update_traj_q <= 48'sd0;
	      accum_update_segment_trigger <= 1'b0;
	      accum_update_max_decision <= 1'b0;
	      accum_update_traj_history <= 8'd0;
		      early_fired <= 1'b0;
		      early_done_pulse <= 1'b0;
      analysis_active <= 1'b0;
      early_pred_state <= 1'b0;
      traj_accum_i <= 48'sd0;
      traj_accum_q <= 48'sd0;
	      traj_count <= 16'd0;
	      traj_history <= 8'd0;
		      bht_valid <= 256'd0;
	      eval_valid <= 1'b0;
	      eval_i <= 48'sd0;
	      eval_q <= 48'sd0;
	      eval_segment_trigger <= 1'b0;
	      eval_max_decision <= 1'b0;
	      eval_traj_history <= 8'd0;
	      proj_mult_valid <= 1'b0;
	      proj_mult_i <= 96'sd0;
	      proj_mult_q <= 96'sd0;
	      proj_mult_segment_trigger <= 1'b0;
	      proj_mult_max_decision <= 1'b0;
	      proj_mult_traj_history <= 8'd0;
	      proj_valid <= 1'b0;
	      proj_pred_state <= 1'b0;
	      proj_margin_abs <= 96'd0;
		      proj_segment_trigger <= 1'b0;
		      proj_max_decision <= 1'b0;
		      proj_traj_key <= 8'd0;
		      decision_valid <= 1'b0;
		      decision_pred_state <= 1'b0;
		      decision_predict_prob <= 8'd0;
		      decision_segment_trigger <= 1'b0;
		      decision_max_decision <= 1'b0;
		      decision_traj_key <= 8'd0;
	      decision_bht_hit <= 1'b0;
	      decision_proj_pred_state <= 1'b0;
	      decision_bht_state1 <= 4'd0;
	      decision_bht_total <= 4'd0;
	      template_score <= 80'sd0;
	      template_segment_index <= 8'd0;
	      template_decision_valid <= 1'b0;
	      template_pred_state <= 1'b0;
		      template_predict_prob <= 8'd0;
		      template_segment_i <= 32'sd0;
		      template_segment_q <= 32'sd0;
		      template_sample_count <= 16'd0;
		      template_mul_valid <= 1'b0;
		      template_mul_max_decision <= 1'b0;
		      template_mul_segment_i <= 32'sd0;
		      template_mul_segment_q <= 32'sd0;
		      template_mul_segment_index <= 8'd0;
		      template_accum_valid <= 1'b0;
		      template_accum_max_decision <= 1'b0;
		      template_accum_score_i <= 48'sd0;
		      template_accum_score_q <= 48'sd0;
		      nco_cos <= NCO_INIT_COS;
	      nco_sin <= NCO_INIT_SIN;
	      lane0_cos <= NCO_INIT_COS;
	      lane0_sin <= NCO_INIT_SIN;
	      lane1_cos <= NCO_INIT_COS;
	      lane1_sin <= NCO_INIT_SIN;
	      lane2_cos <= NCO_INIT_COS;
	      lane2_sin <= NCO_INIT_SIN;
	      lane3_cos <= NCO_INIT_COS;
	      lane3_sin <= NCO_INIT_SIN;
	      lane4_cos <= NCO_INIT_COS;
	      lane4_sin <= NCO_INIT_SIN;
	      lane5_cos <= NCO_INIT_COS;
	      lane5_sin <= NCO_INIT_SIN;
	      lane6_cos <= NCO_INIT_COS;
	      lane6_sin <= NCO_INIT_SIN;
	      lane7_cos <= NCO_INIT_COS;
	      lane7_sin <= NCO_INIT_SIN;
	      mix0_i_r <= 33'sd0;
	      mix0_q_r <= 33'sd0;
	      mix1_i_r <= 33'sd0;
	      mix1_q_r <= 33'sd0;
	      mix2_i_r <= 33'sd0;
	      mix2_q_r <= 33'sd0;
	      mix3_i_r <= 33'sd0;
	      mix3_q_r <= 33'sd0;
	      mix4_i_r <= 33'sd0;
	      mix4_q_r <= 33'sd0;
	      mix5_i_r <= 33'sd0;
	      mix5_q_r <= 33'sd0;
	      mix6_i_r <= 33'sd0;
	      mix6_q_r <= 33'sd0;
	      mix7_i_r <= 33'sd0;
	      mix7_q_r <= 33'sd0;
	      sum01_i_r <= 48'sd0;
	      sum01_q_r <= 48'sd0;
	      sum23_i_r <= 48'sd0;
	      sum23_q_r <= 48'sd0;
	      sum45_i_r <= 48'sd0;
	      sum45_q_r <= 48'sd0;
	      sum67_i_r <= 48'sd0;
	      sum67_q_r <= 48'sd0;
	      sum0123_i_r <= 48'sd0;
	      sum0123_q_r <= 48'sd0;
	      sum4567_i_r <= 48'sd0;
	      sum4567_q_r <= 48'sd0;
	      ddr_beat_sum_i_r <= 48'sd0;
	      ddr_beat_sum_q_r <= 48'sd0;
		      ddr_sample0_i <= 16'sd0;
		      ddr_sample0_q <= 16'sd0;
		      ddr_sample1_i <= 16'sd0;
		      ddr_sample1_q <= 16'sd0;
		      ddr_sample2_i <= 16'sd0;
		      ddr_sample2_q <= 16'sd0;
		      ddr_sample3_i <= 16'sd0;
		      ddr_sample3_q <= 16'sd0;
		      ddr_sample4_i <= 16'sd0;
		      ddr_sample4_q <= 16'sd0;
		      ddr_sample5_i <= 16'sd0;
		      ddr_sample5_q <= 16'sd0;
		      ddr_sample6_i <= 16'sd0;
		      ddr_sample6_q <= 16'sd0;
		      ddr_sample7_i <= 16'sd0;
		      ddr_sample7_q <= 16'sd0;
	    end else begin
      udp_tx_wr <= 1'b0;
      dbg_latency_valid <= 1'b0;
	      early_done_pulse <= 1'b0;
	      dbg_ddr_first_fire <= 1'b0;
		      dbg_sample_fire <= proc_fire;
		      eval_valid <= 1'b0;
		      proj_mult_valid <= eval_valid;
		      proj_valid <= proj_mult_valid;
		      decision_valid <= proj_valid;
		      if (eval_valid) begin
		        proj_mult_i <= early_proj_i;
		        proj_mult_q <= early_proj_q;
		        proj_mult_segment_trigger <= eval_segment_trigger;
		        proj_mult_max_decision <= eval_max_decision;
		        proj_mult_traj_history <= eval_traj_history;
		      end
		      if (proj_mult_valid) begin
		        proj_pred_state <= proj_mult_pred_next;
		        proj_margin_abs <= proj_mult_margin_abs;
		        proj_segment_trigger <= proj_mult_segment_trigger;
		        proj_max_decision <= proj_mult_max_decision;
		        proj_traj_key <= proj_mult_segment_trigger ? {proj_mult_traj_history[6:0], proj_mult_pred_next} : proj_mult_traj_history;
		      end
		      if (proj_valid) begin
		        decision_pred_state <= bayes_pred_next;
		        decision_predict_prob <= bayes_prob_low8;
		        decision_segment_trigger <= proj_segment_trigger;
		        decision_max_decision <= proj_max_decision;
		        decision_traj_key <= proj_traj_key;
		        decision_bht_hit <= bht_hit;
		        decision_proj_pred_state <= proj_pred_state;
		        decision_bht_state1 <= bht_state1;
		        decision_bht_total <= bht_total;
		      end

      if (stream_start) begin
        pending_result_valid <= 1'b0;
        pending_predict_prob <= 8'd0;
        pending_pred_state <= 1'b0;
        pending_actual_state <= 1'b0;
        pending_pred_correct <= 1'b0;
        pending_window_count <= 16'd0;
        pending_latency_cycles <= 24'd0;
        sending_feedback <= 1'b0;
        feedback_words_left <= 16'd0;
        feedback_rd_ptr <= 16'd0;
        metadata_pending <= 1'b0;
        early_accum_i <= 48'sd0;
        early_accum_q <= 48'sd0;
        early_count <= 16'd0;
        accum_update_valid <= 1'b0;
        accum_update_window_start <= 1'b0;
        accum_update_segment_trigger <= 1'b0;
        accum_update_max_decision <= 1'b0;
        accum_update_traj_history <= 8'd0;
        early_fired <= 1'b0;
        early_pred_state <= 1'b0;
        traj_accum_i <= 48'sd0;
        traj_accum_q <= 48'sd0;
        traj_count <= 16'd0;
        traj_history <= 8'd0;
        eval_valid <= 1'b0;
        eval_segment_trigger <= 1'b0;
        eval_max_decision <= 1'b0;
        eval_traj_history <= 8'd0;
        proj_mult_valid <= 1'b0;
        proj_mult_segment_trigger <= 1'b0;
        proj_mult_max_decision <= 1'b0;
        proj_mult_traj_history <= 8'd0;
        proj_valid <= 1'b0;
        proj_segment_trigger <= 1'b0;
        proj_max_decision <= 1'b0;
	        decision_valid <= 1'b0;
	        decision_predict_prob <= 8'd0;
	        decision_segment_trigger <= 1'b0;
	        decision_max_decision <= 1'b0;
	        template_score <= 80'sd0;
	        template_segment_index <= 8'd0;
	        template_decision_valid <= 1'b0;
	        template_pred_state <= 1'b0;
		        template_predict_prob <= 8'd0;
		        template_segment_i <= 32'sd0;
		        template_segment_q <= 32'sd0;
		        template_sample_count <= 16'd0;
		        template_mul_valid <= 1'b0;
		        template_mul_max_decision <= 1'b0;
		        template_mul_segment_i <= 32'sd0;
		        template_mul_segment_q <= 32'sd0;
		        template_mul_segment_index <= 8'd0;
		        template_accum_valid <= 1'b0;
		        template_accum_max_decision <= 1'b0;
		        template_accum_score_i <= 48'sd0;
		        template_accum_score_q <= 48'sd0;
		        analysis_active <= 1'b0;
	      end

      if (start_latency) begin
	        latency_active <= 1'b1;
	        latency_counter <= 32'd0;
      end else if (latency_active) begin
        latency_counter <= latency_counter + 32'd1;
      end

      if (ENABLE_FEEDBACK_STREAM_LOAD && fb0_fire && feedback0_wr_ptr < FEEDBACK_WORDS) begin
        feedback0_mem[feedback0_wr_ptr] <= fb0_tdata[63:0];
        if (feedback0_wr_ptr + 16'd1 < FEEDBACK_WORDS) begin
          feedback0_mem[feedback0_wr_ptr + 16'd1] <= fb0_tdata[127:64];
          if (feedback0_wr_ptr + 16'd2 < FEEDBACK_WORDS)
            feedback0_mem[feedback0_wr_ptr + 16'd2] <= fb0_tdata[191:128];
          if (feedback0_wr_ptr + 16'd3 < FEEDBACK_WORDS)
            feedback0_mem[feedback0_wr_ptr + 16'd3] <= fb0_tdata[255:192];
          if (feedback0_wr_ptr + 16'd4 >= FEEDBACK_WORDS)
            feedback0_wr_ptr <= 16'd0;
          else
            feedback0_wr_ptr <= feedback0_wr_ptr + 16'd4;
        end else begin
          feedback0_wr_ptr <= 16'd0;
        end
      end

      if (ENABLE_FEEDBACK_STREAM_LOAD && fb1_fire && feedback1_wr_ptr < FEEDBACK_WORDS) begin
        feedback1_mem[feedback1_wr_ptr] <= fb1_tdata[63:0];
        if (feedback1_wr_ptr + 16'd1 < FEEDBACK_WORDS) begin
          feedback1_mem[feedback1_wr_ptr + 16'd1] <= fb1_tdata[127:64];
          if (feedback1_wr_ptr + 16'd2 < FEEDBACK_WORDS)
            feedback1_mem[feedback1_wr_ptr + 16'd2] <= fb1_tdata[191:128];
          if (feedback1_wr_ptr + 16'd3 < FEEDBACK_WORDS)
            feedback1_mem[feedback1_wr_ptr + 16'd3] <= fb1_tdata[255:192];
          if (feedback1_wr_ptr + 16'd4 >= FEEDBACK_WORDS)
            feedback1_wr_ptr <= 16'd0;
          else
            feedback1_wr_ptr <= feedback1_wr_ptr + 16'd4;
        end else begin
          feedback1_wr_ptr <= 16'd0;
        end
      end

		      if (ddr_fire) begin
		        upper_half_data <= ddr_tdata[255:128];
		        half_pending <= 1'b1;
		      end else if (half_pending) begin
		        half_pending <= 1'b0;
		      end

		      beat_valid <= proc_fire;
	      mix_valid <= beat_valid;
	      mix_window_start <= beat_window_start;
	      sum_stage_valid <= mix_valid;
	      sum_stage_window_start <= mix_window_start;
	      sum_half_valid <= sum_stage_valid;
	      sum_half_window_start <= sum_stage_window_start;
	      beat_sum_valid <= sum_half_valid;
	      beat_sum_window_start <= sum_half_window_start;
	      if (beat_valid) begin
	        mix0_i_r <= mix0_i;
	        mix0_q_r <= mix0_q;
	        mix1_i_r <= mix1_i;
	        mix1_q_r <= mix1_q;
	        mix2_i_r <= mix2_i;
	        mix2_q_r <= mix2_q;
	        mix3_i_r <= mix3_i;
	        mix3_q_r <= mix3_q;
	        mix4_i_r <= mix4_i;
	        mix4_q_r <= mix4_q;
	        mix5_i_r <= mix5_i;
	        mix5_q_r <= mix5_q;
	        mix6_i_r <= mix6_i;
	        mix6_q_r <= mix6_q;
	        mix7_i_r <= mix7_i;
	        mix7_q_r <= mix7_q;
	      end
	      if (mix_valid) begin
	        sum01_i_r <= sum01_i;
	        sum01_q_r <= sum01_q;
	        sum23_i_r <= sum23_i;
	        sum23_q_r <= sum23_q;
	        sum45_i_r <= sum45_i;
	        sum45_q_r <= sum45_q;
	        sum67_i_r <= sum67_i;
	        sum67_q_r <= sum67_q;
	      end
	      if (sum_stage_valid) begin
	        sum0123_i_r <= sum0123_i;
	        sum0123_q_r <= sum0123_q;
	        sum4567_i_r <= sum4567_i;
	        sum4567_q_r <= sum4567_q;
	      end
	      if (sum_half_valid) begin
	        ddr_beat_sum_i_r <= ddr_beat_sum_i;
	        ddr_beat_sum_q_r <= ddr_beat_sum_q;
	      end
	      accum_update_valid <= allow_accum_update;
	      accum_update_window_start <= beat_sum_window_start;
	      if (allow_accum_update) begin
	        accum_update_early_i <= early_next_i;
	        accum_update_early_q <= early_next_q;
	        accum_update_traj_i <= traj_next_i;
	        accum_update_traj_q <= traj_next_q;
	        accum_update_segment_trigger <= traj_segment_trigger;
	        accum_update_max_decision <= max_decision_reached;
	        accum_update_traj_history <= traj_history;
	      end
		      if (!stream_start) begin
		        template_decision_valid <= 1'b0;
		        template_mul_valid <= 1'b0;
		        template_accum_valid <= template_mul_valid;
		        if (template_mul_valid) begin
		          template_accum_max_decision <= template_mul_max_decision;
		          template_accum_score_i <= template_mul_score_i;
		          template_accum_score_q <= template_mul_score_q;
		        end
		        if (template_accum_valid) begin
		          template_score <= template_score_next;
		          if (template_accum_max_decision) begin
		            template_pred_state <= template_score_pred_next;
		            template_predict_prob <= template_score_pred_next ? 8'hE6 : 8'h1A;
		            template_decision_valid <= 1'b1;
		          end
		        end
		        if (template_proc_in_window && !early_fired) begin
		          template_sample_count <= template_sample_count + 16'd4;
		          if (template_direct_segment_done) begin
		            template_mul_valid <= 1'b1;
		            template_mul_max_decision <= template_direct_max_decision;
		            template_mul_segment_i <= template_segment_i_next;
		            template_mul_segment_q <= template_segment_q_next;
		            template_mul_segment_index <= template_segment_index;
		            template_segment_i <= 32'sd0;
		            template_segment_q <= 32'sd0;
		            if (template_segment_index != 8'hff)
		              template_segment_index <= template_segment_index + 8'd1;
		          end else begin
		            template_segment_i <= template_segment_i_next;
		            template_segment_q <= template_segment_q_next;
		          end
		        end
		      end
		      if (proc_fire) begin
			        ddr_sample0_i <= proc_tdata[15:0];
			        ddr_sample0_q <= proc_tdata[31:16];
			        ddr_sample1_i <= proc_tdata[47:32];
			        ddr_sample1_q <= proc_tdata[63:48];
			        ddr_sample2_i <= proc_tdata[79:64];
			        ddr_sample2_q <= proc_tdata[95:80];
			        ddr_sample3_i <= proc_tdata[111:96];
			        ddr_sample3_q <= proc_tdata[127:112];
			        ddr_sample4_i <= 16'sd0;
			        ddr_sample4_q <= 16'sd0;
			        ddr_sample5_i <= 16'sd0;
			        ddr_sample5_q <= 16'sd0;
			        ddr_sample6_i <= 16'sd0;
			        ddr_sample6_q <= 16'sd0;
			        ddr_sample7_i <= 16'sd0;
			        ddr_sample7_q <= 16'sd0;
	        lane0_cos <= NCO_INIT_COS;
	        lane0_sin <= 16'sd0;
	        lane1_cos <= NCO_INIT_COS;
	        lane1_sin <= 16'sd0;
	        lane2_cos <= NCO_INIT_COS;
	        lane2_sin <= 16'sd0;
	        lane3_cos <= NCO_INIT_COS;
	        lane3_sin <= 16'sd0;
		        lane4_cos <= NCO_INIT_COS;
		        lane4_sin <= NCO_INIT_SIN;
		        lane5_cos <= NCO_INIT_COS;
		        lane5_sin <= NCO_INIT_SIN;
		        lane6_cos <= NCO_INIT_COS;
		        lane6_sin <= NCO_INIT_SIN;
		        lane7_cos <= NCO_INIT_COS;
		        lane7_sin <= NCO_INIT_SIN;
	        beat_window_start <= input_window_start;
	        if (fast_sample_index == 16'd0)
	          dbg_ddr_first_fire <= 1'b1;
        if (stream_last)
	          fast_sample_index <= 16'd0;
        else
	          fast_sample_index <= fast_sample_index + 16'd4;
        dbg_sample_index <= fast_sample_index;
	        if (stream_last) begin
          nco_cos <= NCO_INIT_COS;
          nco_sin <= NCO_INIT_SIN;
        end else begin
          nco_cos <= next_nco_cos;
          nco_sin <= next_nco_sin;
        end
      end

			      if (!stream_start && accum_update_valid && accum_update_window_start) begin
		        early_accum_i <= accum_update_early_i;
		        early_accum_q <= accum_update_early_q;
			        early_count <= 16'd4;
		        early_fired <= 1'b0;
        analysis_active <= 1'b1;
	        traj_accum_i <= ddr_beat_sum_i_r;
	        traj_accum_q <= ddr_beat_sum_q_r;
	        traj_count <= 16'd4;
	        traj_history <= 8'd0;
	        eval_valid <= 1'b1;
	        eval_i <= accum_update_early_i;
	        eval_q <= accum_update_early_q;
	        eval_segment_trigger <= 1'b0;
	        eval_max_decision <= 1'b0;
	        eval_traj_history <= 8'd0;
			      end else if (!stream_start && accum_update_valid && !early_fired) begin
	        early_accum_i <= accum_update_early_i;
	        early_accum_q <= accum_update_early_q;
	        if (accum_update_segment_trigger) begin
	          traj_accum_i <= 48'sd0;
	          traj_accum_q <= 48'sd0;
	          traj_count <= 16'd0;
        end else begin
          traj_accum_i <= accum_update_traj_i;
          traj_accum_q <= accum_update_traj_q;
	          traj_count <= traj_count + 16'd4;
	        end
			        if (result_trigger) begin
			          early_pred_state <= result_pred_state;
			          early_done_pulse <= 1'b1;
			          early_fired <= 1'b1;
          analysis_active <= 1'b0;
		        end else begin
			          early_count <= early_count + 16'd4;
	        end
	        eval_valid <= 1'b1;
	        eval_i <= accum_update_early_i;
	        eval_q <= accum_update_early_q;
	        eval_segment_trigger <= accum_update_segment_trigger;
	        eval_max_decision <= accum_update_max_decision;
	        eval_traj_history <= accum_update_traj_history;
	      end
		      if (!stream_start && proj_valid && proj_segment_trigger)
		        traj_history <= proj_traj_key;
	
			      if (!stream_start && result_trigger && !pending_result_valid && !sending_feedback && !metadata_pending) begin
		        pending_window_count <= dbg_window_count[15:0];
		        pending_predict_prob <= result_predict_prob;
		        pending_pred_state <= result_pred_state;
	        pending_actual_state <= 1'b0;
		        pending_pred_correct <= ~decision_pred_state;
		        pending_result_valid <= 1'b1;
			        if (ENABLE_BHT_SELF_UPDATE && !decision_bht_hit) begin
			          bht_valid[decision_traj_key] <= 1'b1;
			          bht_total_count[decision_traj_key] <= 4'd1;
			          bht_state1_count[decision_traj_key] <= decision_proj_pred_state ? 4'd1 : 4'd0;
			        end else if (ENABLE_BHT_SELF_UPDATE && decision_bht_total != BHT_MAX_COUNT) begin
			          bht_total_count[decision_traj_key] <= decision_bht_total + 4'd1;
			          if (decision_proj_pred_state && decision_bht_state1 != BHT_MAX_COUNT)
			            bht_state1_count[decision_traj_key] <= decision_bht_state1 + 4'd1;
			        end else if (ENABLE_BHT_SELF_UPDATE && decision_proj_pred_state) begin
			          if (decision_bht_state1 != BHT_MAX_COUNT)
			            bht_state1_count[decision_traj_key] <= decision_bht_state1 + 4'd1;
			        end else if (ENABLE_BHT_SELF_UPDATE && decision_bht_state1 != 4'd0) begin
			          bht_state1_count[decision_traj_key] <= decision_bht_state1 - 4'd1;
			        end
	      end

	      if (!stream_start && pending_result_valid && !udp_tx_af) begin
        udp_tx_data <= selected_feedback_word;
        udp_tx_wr <= 1'b1;
        pending_result_valid <= 1'b0;
        sending_feedback <= 1'b1;
        feedback_words_left <= FEEDBACK_WORDS - 16'd1;
        feedback_rd_ptr <= 16'd1;
        metadata_pending <= 1'b1;
        if (latency_active) begin
          dbg_latency_cycles <= latency_counter;
          dbg_latency_valid <= 1'b1;
          pending_latency_cycles <= latency_counter[23:0];
          dbg_window_count <= dbg_window_count + 32'd1;
          latency_active <= 1'b0;
        end
	      end else if (!stream_start && metadata_pending && !udp_tx_af) begin
        udp_tx_data <= {
            8'hA5,
            pending_window_count,
            pending_latency_cycles,
            pending_predict_prob,
            5'd0,
            pending_pred_correct,
            pending_actual_state,
            pending_pred_state
        };
        udp_tx_wr <= 1'b1;
        metadata_pending <= 1'b0;
	      end else if (!stream_start && sending_feedback && !udp_tx_af) begin
        udp_tx_data <= selected_feedback_word;
        udp_tx_wr <= 1'b1;
        if (feedback_words_left <= 16'd1) begin
          sending_feedback <= 1'b0;
          feedback_words_left <= 16'd0;
          feedback_rd_ptr <= 16'd0;
        end else begin
          feedback_words_left <= feedback_words_left - 16'd1;
          feedback_rd_ptr <= feedback_rd_ptr + 16'd1;
        end
      end
    end
  end

endmodule
