`timescale 1ns / 1ps

// Simplified ARTERY + Network Top Module
// Reuses the working udp_10G module from xczu47dr-two-dac-bringup
// Only includes: 10G UDP network + ARTERY core

module artery_network_top (
    // 10G SFP+ network interface (same as original Top.v)
    input  wire        sfp_refclkp,
    input  wire        sfp_refclkn,
    input  wire        sfp_rxp,
    input  wire        sfp_rxn,
    output wire        sfp_txp,
    output wire        sfp_txn,
    output wire        SFP_TX_DIS,

    // System clock from PL clock pins
    input  wire        PL_CLK_P_0,
    input  wire        PL_CLK_N_0
);

    // =========================================================================
    // Clock Generation: 100MHz input to global clock
    // 全部使用 100MHz 时钟
    // =========================================================================

    wire clk_100mhz;
    wire sys_reset;

    // Input buffer for differential clock
    IBUFDS #(
        .DIFF_TERM("FALSE"),
        .IBUF_LOW_PWR("TRUE"),
        .IOSTANDARD("DEFAULT")
    ) ibufds_sys_clk (
        .O(clk_100mhz),
        .I(PL_CLK_P_0),
        .IB(PL_CLK_N_0)
    );

    // Global buffer for 100MHz clock
    wire clk_100mhz_bufg;
    BUFG bufg_100mhz (
        .I(clk_100mhz),
        .O(clk_100mhz_bufg)
    );

    // Power-on reset synchronizer
    reg [7:0] reset_counter = 8'hFF;
    always @(posedge clk_100mhz_bufg) begin
        if (reset_counter != 8'h00)
            reset_counter <= reset_counter - 8'd1;
    end
    assign sys_reset = (reset_counter != 8'h00);

    // =========================================================================
    // 10G UDP Network (reuse existing working module)
    // =========================================================================

    wire        udp_rcv_vld;
    wire [63:0] udp_rcv_dat;
    wire        udp_tx_fifo_af;
    wire        artery_tx_wr;
    wire [63:0] artery_tx_data;

    assign SFP_TX_DIS = 1'b0;

    // One ARTERY prediction is a single 64-bit UDP payload word.
    udp_10G #(
        .PAYLOAD_LEN(8)
    ) udp_10g_inst (
        .gt_rxp_in(sfp_rxp),
        .gt_rxn_in(sfp_rxn),
        .gt_txp_out(sfp_txp),
        .gt_txn_out(sfp_txn),
        .gt_refclk_p(sfp_refclkp),
        .gt_refclk_n(sfp_refclkn),
        .clk_100Mhz(clk_100mhz_bufg),
        .clk(clk_100mhz_bufg),        // 网络用 100MHz 时钟
        .rst(sys_reset),

        // TX interface (ARTERY output)
        .fifo64_wr(artery_tx_wr),
        .fifo64_din(artery_tx_data),
        .fifo64_af(udp_tx_fifo_af),

        // RX interface (network input)
        .rcv_vld(udp_rcv_vld),
        .rcv_dat(udp_rcv_dat),

        .gap_num_vio(24'd0),      // Match original project setting
        .loop_en(1'b0)
    );

    // =========================================================================
    // ARTERY Data Path: UDP (64-bit) -> ARTERY (32-bit)
    // 全部使用 100MHz 时钟
    // =========================================================================

    // RX: Extract 32-bit data from 64-bit UDP packets
    wire        artery_rx_valid;
    wire [31:0] artery_rx_data;
    wire        artery_rx_ready;

    reg [31:0] rx_data_reg;
    reg        rx_valid_reg;

    always @(posedge clk_100mhz_bufg) begin
        if (sys_reset) begin
            rx_data_reg <= 32'd0;
            rx_valid_reg <= 1'b0;
        end else begin
            if (udp_rcv_vld) begin
                rx_data_reg <= udp_rcv_dat[31:0];  // Lower 32 bits
                rx_valid_reg <= 1'b1;
            end else if (artery_rx_ready) begin
                rx_valid_reg <= 1'b0;
            end
        end
    end

    assign artery_rx_data = rx_data_reg;
    assign artery_rx_valid = rx_valid_reg;

    // TX: Pack ARTERY output (3 bits) into 64-bit UDP packets
    wire        artery_pred_valid;
    wire        artery_pred_state;
    wire        artery_actual_state;
    wire        artery_pred_correct;

    reg [63:0] tx_data_reg;
    reg        tx_wr_reg;

    always @(posedge clk_100mhz_bufg) begin
        if (sys_reset) begin
            tx_data_reg <= 64'd0;
            tx_wr_reg <= 1'b0;
        end else begin
            if (artery_pred_valid && !udp_tx_fifo_af) begin
                // Pack one coherent status snapshot into lower 32 bits.
                tx_data_reg <= {32'd0, 29'd0,
                                (artery_pred_state == artery_actual_state),
                                artery_actual_state,
                                artery_pred_state};
                tx_wr_reg <= 1'b1;
            end else begin
                tx_wr_reg <= 1'b0;
            end
        end
    end

    assign artery_tx_data = tx_data_reg;
    assign artery_tx_wr = tx_wr_reg;

    // =========================================================================
    // ARTERY Core Instance
    // =========================================================================

    // ARTERY configuration (default values)
    wire [31:0] artery_omega = 32'h0;           // Demodulation frequency
    wire [15:0] artery_window_start = 16'd0;    // Window start
    wire [15:0] artery_window_len = 16'd1024;   // Window length
    wire [31:0] artery_center_zero_i = 32'h0;   // Center for state |0> (I)
    wire [31:0] artery_center_zero_q = 32'h0;   // Center for state |0> (Q)
    wire [31:0] artery_center_one_i = 32'h0;    // Center for state |1> (I)
    wire [31:0] artery_center_one_q = 32'h0;    // Center for state |1> (Q)
    wire [15:0] artery_prior_prob = 16'h8000;   // Prior probability (0.5)
    wire [15:0] artery_threshold = 16'h8000;    // Decision threshold (0.5)
    wire        artery_enable = 1'b1;           // Enable ARTERY
    wire        artery_config_reset = 1'b0;     // Config reset

    // ARTERY status outputs (unused but required)
    wire [15:0] artery_predict_prob;
    wire [15:0] artery_trigger_time;
    wire [31:0] artery_total_shots;
    wire [31:0] artery_correct_preds;
    wire [15:0] artery_accuracy;
    wire [15:0] artery_pred_latency;
    wire [15:0] artery_total_latency;
    wire        artery_done;

    // Sample index counter
    reg [15:0] sample_index;
    always @(posedge clk_100mhz_bufg) begin
        if (sys_reset)
            sample_index <= 16'd0;
        else if (artery_rx_valid && artery_rx_ready) begin
            if (sample_index == artery_window_len - 16'd1)
                sample_index <= artery_window_start;
            else
                sample_index <= sample_index + 16'd1;
        end
    end

    ARTERYCore artery_core_inst (
        .clock(clk_100mhz_bufg),
        .reset(sys_reset),

        // IQ input stream (from network data)
        .io_iqIn_ready(artery_rx_ready),
        .io_iqIn_valid(artery_rx_valid),
        .io_iqIn_bits_i(artery_rx_data[15:0]),   // I component (lower 16 bits)
        .io_iqIn_bits_q(artery_rx_data[31:16]),  // Q component (upper 16 bits)
        .io_sampleIndex(sample_index),

        // Configuration inputs
        .io_config_omega(artery_omega),
        .io_config_windowStart(artery_window_start),
        .io_config_windowLen(artery_window_len),
        .io_config_centerZeroI(artery_center_zero_i),
        .io_config_centerZeroQ(artery_center_zero_q),
        .io_config_centerOneI(artery_center_one_i),
        .io_config_centerOneQ(artery_center_one_q),
        .io_config_priorProb(artery_prior_prob),
        .io_config_threshold(artery_threshold),
        .io_config_enable(artery_enable),
        .io_config_reset(artery_config_reset),

        // Status outputs
        .io_status_predictProb(artery_predict_prob),
        .io_status_predictState(artery_pred_state),
        .io_status_triggerTime(artery_trigger_time),
        .io_status_actualState(artery_actual_state),
        .io_status_predCorrect(artery_pred_correct),
        .io_status_totalShots(artery_total_shots),
        .io_status_correctPreds(artery_correct_preds),
        .io_status_accuracy(artery_accuracy),
        .io_status_predLatency(artery_pred_latency),
        .io_status_totalLatency(artery_total_latency),
        .io_status_done(artery_pred_valid)
    );

endmodule
