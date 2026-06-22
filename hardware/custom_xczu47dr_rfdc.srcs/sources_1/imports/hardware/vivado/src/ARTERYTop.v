module DDRDataPlayer(
  input         clock,
  input         reset,
  input         io_trigger,
  input         io_iqOut_ready,
  output        io_iqOut_valid,
  output [15:0] io_iqOut_bits_i,
  output [15:0] io_iqOut_bits_q,
  output [15:0] io_sampleIndex
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[DDRDataPlayer.scala 23:22]
  reg [15:0] sampleCnt; // @[DDRDataPlayer.scala 25:26]
  wire [7:0] _testI_T_1 = sampleCnt[7:0]; // @[DDRDataPlayer.scala 33:29]
  wire [15:0] _testI_T_2 = $signed(_testI_T_1) * 8'sh64; // @[DDRDataPlayer.scala 33:36]
  wire [7:0] _testI_T_3 = _testI_T_2[15:8]; // @[DDRDataPlayer.scala 33:45]
  wire [15:0] _testQ_T_2 = $signed(_testI_T_1) * 8'sh50; // @[DDRDataPlayer.scala 34:36]
  wire [7:0] _testQ_T_3 = _testQ_T_2[15:8]; // @[DDRDataPlayer.scala 34:44]
  wire  _T = 2'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == state; // @[Conditional.scala 37:30]
  wire [15:0] _sampleCnt_T_1 = sampleCnt + 16'h1; // @[DDRDataPlayer.scala 46:32]
  wire [1:0] _GEN_2 = sampleCnt >= 16'hfff ? 2'h2 : state; // @[DDRDataPlayer.scala 47:54 DDRDataPlayer.scala 48:17 DDRDataPlayer.scala 23:22]
  wire  _T_3 = 2'h2 == state; // @[Conditional.scala 37:30]
  wire [1:0] _GEN_5 = ~io_trigger ? 2'h0 : state; // @[DDRDataPlayer.scala 54:25 DDRDataPlayer.scala 55:15 DDRDataPlayer.scala 23:22]
  assign io_iqOut_valid = state == 2'h1; // @[DDRDataPlayer.scala 60:28]
  assign io_iqOut_bits_i = {{8{_testI_T_3[7]}},_testI_T_3}; // @[DDRDataPlayer.scala 29:19 DDRDataPlayer.scala 33:9]
  assign io_iqOut_bits_q = {{8{_testQ_T_3[7]}},_testQ_T_3}; // @[DDRDataPlayer.scala 30:19 DDRDataPlayer.scala 34:9]
  assign io_sampleIndex = sampleCnt; // @[DDRDataPlayer.scala 63:18]
  always @(posedge clock) begin
    if (reset) begin // @[DDRDataPlayer.scala 23:22]
      state <= 2'h0; // @[DDRDataPlayer.scala 23:22]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_trigger) begin // @[DDRDataPlayer.scala 38:24]
        state <= 2'h1; // @[DDRDataPlayer.scala 39:15]
      end
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (io_iqOut_ready) begin // @[DDRDataPlayer.scala 45:28]
        state <= _GEN_2;
      end
    end else if (_T_3) begin // @[Conditional.scala 39:67]
      state <= _GEN_5;
    end
    if (reset) begin // @[DDRDataPlayer.scala 25:26]
      sampleCnt <= 16'h0; // @[DDRDataPlayer.scala 25:26]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_trigger) begin // @[DDRDataPlayer.scala 38:24]
        sampleCnt <= 16'h0; // @[DDRDataPlayer.scala 40:19]
      end
    end else if (_T_1) begin // @[Conditional.scala 39:67]
      if (io_iqOut_ready) begin // @[DDRDataPlayer.scala 45:28]
        sampleCnt <= _sampleCnt_T_1; // @[DDRDataPlayer.scala 46:19]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  sampleCnt = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NCO(
  input         clock,
  input         reset,
  input  [31:0] io_omega,
  input         io_enable,
  input         io_reset,
  output [15:0] io_cosOut,
  output [15:0] io_sinOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] phase; // @[NCO.scala 18:22]
  wire [31:0] _phase_T_1 = phase + io_omega; // @[NCO.scala 23:20]
  wire [9:0] lutAddr = phase[31:22]; // @[NCO.scala 44:22]
  wire [15:0] _GEN_3 = 10'h1 == lutAddr ? $signed(16'sh7ffe) : $signed(16'sh7fff); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_4 = 10'h2 == lutAddr ? $signed(16'sh7ffc) : $signed(_GEN_3); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_5 = 10'h3 == lutAddr ? $signed(16'sh7ff9) : $signed(_GEN_4); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_6 = 10'h4 == lutAddr ? $signed(16'sh7ff5) : $signed(_GEN_5); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_7 = 10'h5 == lutAddr ? $signed(16'sh7fef) : $signed(_GEN_6); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_8 = 10'h6 == lutAddr ? $signed(16'sh7fe8) : $signed(_GEN_7); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_9 = 10'h7 == lutAddr ? $signed(16'sh7fe0) : $signed(_GEN_8); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_10 = 10'h8 == lutAddr ? $signed(16'sh7fd7) : $signed(_GEN_9); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_11 = 10'h9 == lutAddr ? $signed(16'sh7fcd) : $signed(_GEN_10); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_12 = 10'ha == lutAddr ? $signed(16'sh7fc1) : $signed(_GEN_11); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_13 = 10'hb == lutAddr ? $signed(16'sh7fb4) : $signed(_GEN_12); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_14 = 10'hc == lutAddr ? $signed(16'sh7fa6) : $signed(_GEN_13); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_15 = 10'hd == lutAddr ? $signed(16'sh7f96) : $signed(_GEN_14); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_16 = 10'he == lutAddr ? $signed(16'sh7f86) : $signed(_GEN_15); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_17 = 10'hf == lutAddr ? $signed(16'sh7f74) : $signed(_GEN_16); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_18 = 10'h10 == lutAddr ? $signed(16'sh7f61) : $signed(_GEN_17); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_19 = 10'h11 == lutAddr ? $signed(16'sh7f4c) : $signed(_GEN_18); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_20 = 10'h12 == lutAddr ? $signed(16'sh7f37) : $signed(_GEN_19); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_21 = 10'h13 == lutAddr ? $signed(16'sh7f20) : $signed(_GEN_20); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_22 = 10'h14 == lutAddr ? $signed(16'sh7f08) : $signed(_GEN_21); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_23 = 10'h15 == lutAddr ? $signed(16'sh7eef) : $signed(_GEN_22); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_24 = 10'h16 == lutAddr ? $signed(16'sh7ed4) : $signed(_GEN_23); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_25 = 10'h17 == lutAddr ? $signed(16'sh7eb9) : $signed(_GEN_24); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_26 = 10'h18 == lutAddr ? $signed(16'sh7e9c) : $signed(_GEN_25); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_27 = 10'h19 == lutAddr ? $signed(16'sh7e7e) : $signed(_GEN_26); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_28 = 10'h1a == lutAddr ? $signed(16'sh7e5e) : $signed(_GEN_27); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_29 = 10'h1b == lutAddr ? $signed(16'sh7e3e) : $signed(_GEN_28); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_30 = 10'h1c == lutAddr ? $signed(16'sh7e1c) : $signed(_GEN_29); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_31 = 10'h1d == lutAddr ? $signed(16'sh7df9) : $signed(_GEN_30); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_32 = 10'h1e == lutAddr ? $signed(16'sh7dd5) : $signed(_GEN_31); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_33 = 10'h1f == lutAddr ? $signed(16'sh7db0) : $signed(_GEN_32); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_34 = 10'h20 == lutAddr ? $signed(16'sh7d89) : $signed(_GEN_33); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_35 = 10'h21 == lutAddr ? $signed(16'sh7d61) : $signed(_GEN_34); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_36 = 10'h22 == lutAddr ? $signed(16'sh7d38) : $signed(_GEN_35); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_37 = 10'h23 == lutAddr ? $signed(16'sh7d0e) : $signed(_GEN_36); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_38 = 10'h24 == lutAddr ? $signed(16'sh7ce2) : $signed(_GEN_37); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_39 = 10'h25 == lutAddr ? $signed(16'sh7cb6) : $signed(_GEN_38); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_40 = 10'h26 == lutAddr ? $signed(16'sh7c88) : $signed(_GEN_39); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_41 = 10'h27 == lutAddr ? $signed(16'sh7c59) : $signed(_GEN_40); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_42 = 10'h28 == lutAddr ? $signed(16'sh7c29) : $signed(_GEN_41); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_43 = 10'h29 == lutAddr ? $signed(16'sh7bf7) : $signed(_GEN_42); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_44 = 10'h2a == lutAddr ? $signed(16'sh7bc4) : $signed(_GEN_43); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_45 = 10'h2b == lutAddr ? $signed(16'sh7b91) : $signed(_GEN_44); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_46 = 10'h2c == lutAddr ? $signed(16'sh7b5c) : $signed(_GEN_45); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_47 = 10'h2d == lutAddr ? $signed(16'sh7b25) : $signed(_GEN_46); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_48 = 10'h2e == lutAddr ? $signed(16'sh7aee) : $signed(_GEN_47); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_49 = 10'h2f == lutAddr ? $signed(16'sh7ab5) : $signed(_GEN_48); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_50 = 10'h30 == lutAddr ? $signed(16'sh7a7c) : $signed(_GEN_49); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_51 = 10'h31 == lutAddr ? $signed(16'sh7a41) : $signed(_GEN_50); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_52 = 10'h32 == lutAddr ? $signed(16'sh7a04) : $signed(_GEN_51); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_53 = 10'h33 == lutAddr ? $signed(16'sh79c7) : $signed(_GEN_52); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_54 = 10'h34 == lutAddr ? $signed(16'sh7989) : $signed(_GEN_53); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_55 = 10'h35 == lutAddr ? $signed(16'sh7949) : $signed(_GEN_54); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_56 = 10'h36 == lutAddr ? $signed(16'sh7908) : $signed(_GEN_55); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_57 = 10'h37 == lutAddr ? $signed(16'sh78c6) : $signed(_GEN_56); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_58 = 10'h38 == lutAddr ? $signed(16'sh7883) : $signed(_GEN_57); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_59 = 10'h39 == lutAddr ? $signed(16'sh783f) : $signed(_GEN_58); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_60 = 10'h3a == lutAddr ? $signed(16'sh77f9) : $signed(_GEN_59); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_61 = 10'h3b == lutAddr ? $signed(16'sh77b3) : $signed(_GEN_60); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_62 = 10'h3c == lutAddr ? $signed(16'sh776b) : $signed(_GEN_61); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_63 = 10'h3d == lutAddr ? $signed(16'sh7722) : $signed(_GEN_62); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_64 = 10'h3e == lutAddr ? $signed(16'sh76d8) : $signed(_GEN_63); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_65 = 10'h3f == lutAddr ? $signed(16'sh768d) : $signed(_GEN_64); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_66 = 10'h40 == lutAddr ? $signed(16'sh7640) : $signed(_GEN_65); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_67 = 10'h41 == lutAddr ? $signed(16'sh75f3) : $signed(_GEN_66); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_68 = 10'h42 == lutAddr ? $signed(16'sh75a4) : $signed(_GEN_67); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_69 = 10'h43 == lutAddr ? $signed(16'sh7554) : $signed(_GEN_68); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_70 = 10'h44 == lutAddr ? $signed(16'sh7503) : $signed(_GEN_69); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_71 = 10'h45 == lutAddr ? $signed(16'sh74b1) : $signed(_GEN_70); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_72 = 10'h46 == lutAddr ? $signed(16'sh745e) : $signed(_GEN_71); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_73 = 10'h47 == lutAddr ? $signed(16'sh740a) : $signed(_GEN_72); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_74 = 10'h48 == lutAddr ? $signed(16'sh73b5) : $signed(_GEN_73); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_75 = 10'h49 == lutAddr ? $signed(16'sh735e) : $signed(_GEN_74); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_76 = 10'h4a == lutAddr ? $signed(16'sh7306) : $signed(_GEN_75); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_77 = 10'h4b == lutAddr ? $signed(16'sh72ae) : $signed(_GEN_76); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_78 = 10'h4c == lutAddr ? $signed(16'sh7254) : $signed(_GEN_77); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_79 = 10'h4d == lutAddr ? $signed(16'sh71f9) : $signed(_GEN_78); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_80 = 10'h4e == lutAddr ? $signed(16'sh719d) : $signed(_GEN_79); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_81 = 10'h4f == lutAddr ? $signed(16'sh7140) : $signed(_GEN_80); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_82 = 10'h50 == lutAddr ? $signed(16'sh70e1) : $signed(_GEN_81); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_83 = 10'h51 == lutAddr ? $signed(16'sh7082) : $signed(_GEN_82); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_84 = 10'h52 == lutAddr ? $signed(16'sh7022) : $signed(_GEN_83); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_85 = 10'h53 == lutAddr ? $signed(16'sh6fc0) : $signed(_GEN_84); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_86 = 10'h54 == lutAddr ? $signed(16'sh6f5e) : $signed(_GEN_85); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_87 = 10'h55 == lutAddr ? $signed(16'sh6efa) : $signed(_GEN_86); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_88 = 10'h56 == lutAddr ? $signed(16'sh6e95) : $signed(_GEN_87); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_89 = 10'h57 == lutAddr ? $signed(16'sh6e30) : $signed(_GEN_88); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_90 = 10'h58 == lutAddr ? $signed(16'sh6dc9) : $signed(_GEN_89); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_91 = 10'h59 == lutAddr ? $signed(16'sh6d61) : $signed(_GEN_90); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_92 = 10'h5a == lutAddr ? $signed(16'sh6cf8) : $signed(_GEN_91); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_93 = 10'h5b == lutAddr ? $signed(16'sh6c8e) : $signed(_GEN_92); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_94 = 10'h5c == lutAddr ? $signed(16'sh6c23) : $signed(_GEN_93); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_95 = 10'h5d == lutAddr ? $signed(16'sh6bb7) : $signed(_GEN_94); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_96 = 10'h5e == lutAddr ? $signed(16'sh6b4a) : $signed(_GEN_95); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_97 = 10'h5f == lutAddr ? $signed(16'sh6adb) : $signed(_GEN_96); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_98 = 10'h60 == lutAddr ? $signed(16'sh6a6c) : $signed(_GEN_97); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_99 = 10'h61 == lutAddr ? $signed(16'sh69fc) : $signed(_GEN_98); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_100 = 10'h62 == lutAddr ? $signed(16'sh698b) : $signed(_GEN_99); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_101 = 10'h63 == lutAddr ? $signed(16'sh6919) : $signed(_GEN_100); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_102 = 10'h64 == lutAddr ? $signed(16'sh68a5) : $signed(_GEN_101); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_103 = 10'h65 == lutAddr ? $signed(16'sh6831) : $signed(_GEN_102); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_104 = 10'h66 == lutAddr ? $signed(16'sh67bc) : $signed(_GEN_103); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_105 = 10'h67 == lutAddr ? $signed(16'sh6745) : $signed(_GEN_104); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_106 = 10'h68 == lutAddr ? $signed(16'sh66ce) : $signed(_GEN_105); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_107 = 10'h69 == lutAddr ? $signed(16'sh6656) : $signed(_GEN_106); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_108 = 10'h6a == lutAddr ? $signed(16'sh65dd) : $signed(_GEN_107); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_109 = 10'h6b == lutAddr ? $signed(16'sh6562) : $signed(_GEN_108); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_110 = 10'h6c == lutAddr ? $signed(16'sh64e7) : $signed(_GEN_109); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_111 = 10'h6d == lutAddr ? $signed(16'sh646b) : $signed(_GEN_110); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_112 = 10'h6e == lutAddr ? $signed(16'sh63ee) : $signed(_GEN_111); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_113 = 10'h6f == lutAddr ? $signed(16'sh6370) : $signed(_GEN_112); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_114 = 10'h70 == lutAddr ? $signed(16'sh62f1) : $signed(_GEN_113); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_115 = 10'h71 == lutAddr ? $signed(16'sh6271) : $signed(_GEN_114); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_116 = 10'h72 == lutAddr ? $signed(16'sh61f0) : $signed(_GEN_115); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_117 = 10'h73 == lutAddr ? $signed(16'sh616e) : $signed(_GEN_116); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_118 = 10'h74 == lutAddr ? $signed(16'sh60eb) : $signed(_GEN_117); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_119 = 10'h75 == lutAddr ? $signed(16'sh6067) : $signed(_GEN_118); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_120 = 10'h76 == lutAddr ? $signed(16'sh5fe2) : $signed(_GEN_119); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_121 = 10'h77 == lutAddr ? $signed(16'sh5f5d) : $signed(_GEN_120); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_122 = 10'h78 == lutAddr ? $signed(16'sh5ed6) : $signed(_GEN_121); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_123 = 10'h79 == lutAddr ? $signed(16'sh5e4f) : $signed(_GEN_122); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_124 = 10'h7a == lutAddr ? $signed(16'sh5dc6) : $signed(_GEN_123); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_125 = 10'h7b == lutAddr ? $signed(16'sh5d3d) : $signed(_GEN_124); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_126 = 10'h7c == lutAddr ? $signed(16'sh5cb3) : $signed(_GEN_125); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_127 = 10'h7d == lutAddr ? $signed(16'sh5c28) : $signed(_GEN_126); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_128 = 10'h7e == lutAddr ? $signed(16'sh5b9c) : $signed(_GEN_127); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_129 = 10'h7f == lutAddr ? $signed(16'sh5b0f) : $signed(_GEN_128); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_130 = 10'h80 == lutAddr ? $signed(16'sh5a81) : $signed(_GEN_129); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_131 = 10'h81 == lutAddr ? $signed(16'sh59f3) : $signed(_GEN_130); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_132 = 10'h82 == lutAddr ? $signed(16'sh5963) : $signed(_GEN_131); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_133 = 10'h83 == lutAddr ? $signed(16'sh58d3) : $signed(_GEN_132); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_134 = 10'h84 == lutAddr ? $signed(16'sh5842) : $signed(_GEN_133); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_135 = 10'h85 == lutAddr ? $signed(16'sh57b0) : $signed(_GEN_134); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_136 = 10'h86 == lutAddr ? $signed(16'sh571d) : $signed(_GEN_135); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_137 = 10'h87 == lutAddr ? $signed(16'sh5689) : $signed(_GEN_136); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_138 = 10'h88 == lutAddr ? $signed(16'sh55f4) : $signed(_GEN_137); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_139 = 10'h89 == lutAddr ? $signed(16'sh555f) : $signed(_GEN_138); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_140 = 10'h8a == lutAddr ? $signed(16'sh54c9) : $signed(_GEN_139); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_141 = 10'h8b == lutAddr ? $signed(16'sh5432) : $signed(_GEN_140); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_142 = 10'h8c == lutAddr ? $signed(16'sh539a) : $signed(_GEN_141); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_143 = 10'h8d == lutAddr ? $signed(16'sh5301) : $signed(_GEN_142); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_144 = 10'h8e == lutAddr ? $signed(16'sh5268) : $signed(_GEN_143); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_145 = 10'h8f == lutAddr ? $signed(16'sh51ce) : $signed(_GEN_144); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_146 = 10'h90 == lutAddr ? $signed(16'sh5133) : $signed(_GEN_145); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_147 = 10'h91 == lutAddr ? $signed(16'sh5097) : $signed(_GEN_146); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_148 = 10'h92 == lutAddr ? $signed(16'sh4ffa) : $signed(_GEN_147); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_149 = 10'h93 == lutAddr ? $signed(16'sh4f5d) : $signed(_GEN_148); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_150 = 10'h94 == lutAddr ? $signed(16'sh4ebf) : $signed(_GEN_149); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_151 = 10'h95 == lutAddr ? $signed(16'sh4e20) : $signed(_GEN_150); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_152 = 10'h96 == lutAddr ? $signed(16'sh4d80) : $signed(_GEN_151); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_153 = 10'h97 == lutAddr ? $signed(16'sh4ce0) : $signed(_GEN_152); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_154 = 10'h98 == lutAddr ? $signed(16'sh4c3f) : $signed(_GEN_153); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_155 = 10'h99 == lutAddr ? $signed(16'sh4b9d) : $signed(_GEN_154); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_156 = 10'h9a == lutAddr ? $signed(16'sh4afa) : $signed(_GEN_155); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_157 = 10'h9b == lutAddr ? $signed(16'sh4a57) : $signed(_GEN_156); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_158 = 10'h9c == lutAddr ? $signed(16'sh49b3) : $signed(_GEN_157); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_159 = 10'h9d == lutAddr ? $signed(16'sh490e) : $signed(_GEN_158); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_160 = 10'h9e == lutAddr ? $signed(16'sh4869) : $signed(_GEN_159); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_161 = 10'h9f == lutAddr ? $signed(16'sh47c3) : $signed(_GEN_160); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_162 = 10'ha0 == lutAddr ? $signed(16'sh471c) : $signed(_GEN_161); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_163 = 10'ha1 == lutAddr ? $signed(16'sh4674) : $signed(_GEN_162); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_164 = 10'ha2 == lutAddr ? $signed(16'sh45cc) : $signed(_GEN_163); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_165 = 10'ha3 == lutAddr ? $signed(16'sh4523) : $signed(_GEN_164); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_166 = 10'ha4 == lutAddr ? $signed(16'sh447a) : $signed(_GEN_165); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_167 = 10'ha5 == lutAddr ? $signed(16'sh43d0) : $signed(_GEN_166); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_168 = 10'ha6 == lutAddr ? $signed(16'sh4325) : $signed(_GEN_167); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_169 = 10'ha7 == lutAddr ? $signed(16'sh4279) : $signed(_GEN_168); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_170 = 10'ha8 == lutAddr ? $signed(16'sh41cd) : $signed(_GEN_169); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_171 = 10'ha9 == lutAddr ? $signed(16'sh4120) : $signed(_GEN_170); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_172 = 10'haa == lutAddr ? $signed(16'sh4073) : $signed(_GEN_171); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_173 = 10'hab == lutAddr ? $signed(16'sh3fc5) : $signed(_GEN_172); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_174 = 10'hac == lutAddr ? $signed(16'sh3f16) : $signed(_GEN_173); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_175 = 10'had == lutAddr ? $signed(16'sh3e67) : $signed(_GEN_174); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_176 = 10'hae == lutAddr ? $signed(16'sh3db7) : $signed(_GEN_175); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_177 = 10'haf == lutAddr ? $signed(16'sh3d07) : $signed(_GEN_176); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_178 = 10'hb0 == lutAddr ? $signed(16'sh3c56) : $signed(_GEN_177); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_179 = 10'hb1 == lutAddr ? $signed(16'sh3ba4) : $signed(_GEN_178); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_180 = 10'hb2 == lutAddr ? $signed(16'sh3af2) : $signed(_GEN_179); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_181 = 10'hb3 == lutAddr ? $signed(16'sh3a3f) : $signed(_GEN_180); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_182 = 10'hb4 == lutAddr ? $signed(16'sh398c) : $signed(_GEN_181); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_183 = 10'hb5 == lutAddr ? $signed(16'sh38d8) : $signed(_GEN_182); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_184 = 10'hb6 == lutAddr ? $signed(16'sh3824) : $signed(_GEN_183); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_185 = 10'hb7 == lutAddr ? $signed(16'sh376f) : $signed(_GEN_184); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_186 = 10'hb8 == lutAddr ? $signed(16'sh36b9) : $signed(_GEN_185); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_187 = 10'hb9 == lutAddr ? $signed(16'sh3603) : $signed(_GEN_186); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_188 = 10'hba == lutAddr ? $signed(16'sh354d) : $signed(_GEN_187); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_189 = 10'hbb == lutAddr ? $signed(16'sh3496) : $signed(_GEN_188); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_190 = 10'hbc == lutAddr ? $signed(16'sh33de) : $signed(_GEN_189); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_191 = 10'hbd == lutAddr ? $signed(16'sh3326) : $signed(_GEN_190); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_192 = 10'hbe == lutAddr ? $signed(16'sh326d) : $signed(_GEN_191); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_193 = 10'hbf == lutAddr ? $signed(16'sh31b4) : $signed(_GEN_192); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_194 = 10'hc0 == lutAddr ? $signed(16'sh30fb) : $signed(_GEN_193); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_195 = 10'hc1 == lutAddr ? $signed(16'sh3041) : $signed(_GEN_194); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_196 = 10'hc2 == lutAddr ? $signed(16'sh2f86) : $signed(_GEN_195); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_197 = 10'hc3 == lutAddr ? $signed(16'sh2ecc) : $signed(_GEN_196); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_198 = 10'hc4 == lutAddr ? $signed(16'sh2e10) : $signed(_GEN_197); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_199 = 10'hc5 == lutAddr ? $signed(16'sh2d54) : $signed(_GEN_198); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_200 = 10'hc6 == lutAddr ? $signed(16'sh2c98) : $signed(_GEN_199); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_201 = 10'hc7 == lutAddr ? $signed(16'sh2bdb) : $signed(_GEN_200); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_202 = 10'hc8 == lutAddr ? $signed(16'sh2b1e) : $signed(_GEN_201); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_203 = 10'hc9 == lutAddr ? $signed(16'sh2a61) : $signed(_GEN_202); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_204 = 10'hca == lutAddr ? $signed(16'sh29a3) : $signed(_GEN_203); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_205 = 10'hcb == lutAddr ? $signed(16'sh28e5) : $signed(_GEN_204); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_206 = 10'hcc == lutAddr ? $signed(16'sh2826) : $signed(_GEN_205); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_207 = 10'hcd == lutAddr ? $signed(16'sh2767) : $signed(_GEN_206); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_208 = 10'hce == lutAddr ? $signed(16'sh26a7) : $signed(_GEN_207); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_209 = 10'hcf == lutAddr ? $signed(16'sh25e7) : $signed(_GEN_208); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_210 = 10'hd0 == lutAddr ? $signed(16'sh2527) : $signed(_GEN_209); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_211 = 10'hd1 == lutAddr ? $signed(16'sh2467) : $signed(_GEN_210); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_212 = 10'hd2 == lutAddr ? $signed(16'sh23a6) : $signed(_GEN_211); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_213 = 10'hd3 == lutAddr ? $signed(16'sh22e4) : $signed(_GEN_212); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_214 = 10'hd4 == lutAddr ? $signed(16'sh2223) : $signed(_GEN_213); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_215 = 10'hd5 == lutAddr ? $signed(16'sh2161) : $signed(_GEN_214); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_216 = 10'hd6 == lutAddr ? $signed(16'sh209f) : $signed(_GEN_215); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_217 = 10'hd7 == lutAddr ? $signed(16'sh1fdc) : $signed(_GEN_216); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_218 = 10'hd8 == lutAddr ? $signed(16'sh1f19) : $signed(_GEN_217); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_219 = 10'hd9 == lutAddr ? $signed(16'sh1e56) : $signed(_GEN_218); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_220 = 10'hda == lutAddr ? $signed(16'sh1d93) : $signed(_GEN_219); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_221 = 10'hdb == lutAddr ? $signed(16'sh1ccf) : $signed(_GEN_220); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_222 = 10'hdc == lutAddr ? $signed(16'sh1c0b) : $signed(_GEN_221); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_223 = 10'hdd == lutAddr ? $signed(16'sh1b46) : $signed(_GEN_222); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_224 = 10'hde == lutAddr ? $signed(16'sh1a82) : $signed(_GEN_223); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_225 = 10'hdf == lutAddr ? $signed(16'sh19bd) : $signed(_GEN_224); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_226 = 10'he0 == lutAddr ? $signed(16'sh18f8) : $signed(_GEN_225); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_227 = 10'he1 == lutAddr ? $signed(16'sh1833) : $signed(_GEN_226); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_228 = 10'he2 == lutAddr ? $signed(16'sh176d) : $signed(_GEN_227); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_229 = 10'he3 == lutAddr ? $signed(16'sh16a7) : $signed(_GEN_228); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_230 = 10'he4 == lutAddr ? $signed(16'sh15e1) : $signed(_GEN_229); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_231 = 10'he5 == lutAddr ? $signed(16'sh151b) : $signed(_GEN_230); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_232 = 10'he6 == lutAddr ? $signed(16'sh1455) : $signed(_GEN_231); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_233 = 10'he7 == lutAddr ? $signed(16'sh138e) : $signed(_GEN_232); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_234 = 10'he8 == lutAddr ? $signed(16'sh12c7) : $signed(_GEN_233); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_235 = 10'he9 == lutAddr ? $signed(16'sh1200) : $signed(_GEN_234); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_236 = 10'hea == lutAddr ? $signed(16'sh1139) : $signed(_GEN_235); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_237 = 10'heb == lutAddr ? $signed(16'sh1072) : $signed(_GEN_236); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_238 = 10'hec == lutAddr ? $signed(16'shfab) : $signed(_GEN_237); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_239 = 10'hed == lutAddr ? $signed(16'shee3) : $signed(_GEN_238); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_240 = 10'hee == lutAddr ? $signed(16'she1b) : $signed(_GEN_239); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_241 = 10'hef == lutAddr ? $signed(16'shd53) : $signed(_GEN_240); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_242 = 10'hf0 == lutAddr ? $signed(16'shc8b) : $signed(_GEN_241); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_243 = 10'hf1 == lutAddr ? $signed(16'shbc3) : $signed(_GEN_242); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_244 = 10'hf2 == lutAddr ? $signed(16'shafb) : $signed(_GEN_243); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_245 = 10'hf3 == lutAddr ? $signed(16'sha32) : $signed(_GEN_244); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_246 = 10'hf4 == lutAddr ? $signed(16'sh96a) : $signed(_GEN_245); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_247 = 10'hf5 == lutAddr ? $signed(16'sh8a1) : $signed(_GEN_246); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_248 = 10'hf6 == lutAddr ? $signed(16'sh7d9) : $signed(_GEN_247); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_249 = 10'hf7 == lutAddr ? $signed(16'sh710) : $signed(_GEN_248); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_250 = 10'hf8 == lutAddr ? $signed(16'sh647) : $signed(_GEN_249); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_251 = 10'hf9 == lutAddr ? $signed(16'sh57e) : $signed(_GEN_250); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_252 = 10'hfa == lutAddr ? $signed(16'sh4b6) : $signed(_GEN_251); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_253 = 10'hfb == lutAddr ? $signed(16'sh3ed) : $signed(_GEN_252); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_254 = 10'hfc == lutAddr ? $signed(16'sh324) : $signed(_GEN_253); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_255 = 10'hfd == lutAddr ? $signed(16'sh25b) : $signed(_GEN_254); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_256 = 10'hfe == lutAddr ? $signed(16'sh192) : $signed(_GEN_255); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_257 = 10'hff == lutAddr ? $signed(16'shc9) : $signed(_GEN_256); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_258 = 10'h100 == lutAddr ? $signed(16'sh0) : $signed(_GEN_257); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_259 = 10'h101 == lutAddr ? $signed(-16'shc9) : $signed(_GEN_258); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_260 = 10'h102 == lutAddr ? $signed(-16'sh192) : $signed(_GEN_259); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_261 = 10'h103 == lutAddr ? $signed(-16'sh25b) : $signed(_GEN_260); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_262 = 10'h104 == lutAddr ? $signed(-16'sh324) : $signed(_GEN_261); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_263 = 10'h105 == lutAddr ? $signed(-16'sh3ed) : $signed(_GEN_262); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_264 = 10'h106 == lutAddr ? $signed(-16'sh4b6) : $signed(_GEN_263); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_265 = 10'h107 == lutAddr ? $signed(-16'sh57e) : $signed(_GEN_264); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_266 = 10'h108 == lutAddr ? $signed(-16'sh647) : $signed(_GEN_265); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_267 = 10'h109 == lutAddr ? $signed(-16'sh710) : $signed(_GEN_266); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_268 = 10'h10a == lutAddr ? $signed(-16'sh7d9) : $signed(_GEN_267); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_269 = 10'h10b == lutAddr ? $signed(-16'sh8a1) : $signed(_GEN_268); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_270 = 10'h10c == lutAddr ? $signed(-16'sh96a) : $signed(_GEN_269); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_271 = 10'h10d == lutAddr ? $signed(-16'sha32) : $signed(_GEN_270); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_272 = 10'h10e == lutAddr ? $signed(-16'shafb) : $signed(_GEN_271); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_273 = 10'h10f == lutAddr ? $signed(-16'shbc3) : $signed(_GEN_272); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_274 = 10'h110 == lutAddr ? $signed(-16'shc8b) : $signed(_GEN_273); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_275 = 10'h111 == lutAddr ? $signed(-16'shd53) : $signed(_GEN_274); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_276 = 10'h112 == lutAddr ? $signed(-16'she1b) : $signed(_GEN_275); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_277 = 10'h113 == lutAddr ? $signed(-16'shee3) : $signed(_GEN_276); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_278 = 10'h114 == lutAddr ? $signed(-16'shfab) : $signed(_GEN_277); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_279 = 10'h115 == lutAddr ? $signed(-16'sh1072) : $signed(_GEN_278); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_280 = 10'h116 == lutAddr ? $signed(-16'sh1139) : $signed(_GEN_279); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_281 = 10'h117 == lutAddr ? $signed(-16'sh1200) : $signed(_GEN_280); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_282 = 10'h118 == lutAddr ? $signed(-16'sh12c7) : $signed(_GEN_281); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_283 = 10'h119 == lutAddr ? $signed(-16'sh138e) : $signed(_GEN_282); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_284 = 10'h11a == lutAddr ? $signed(-16'sh1455) : $signed(_GEN_283); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_285 = 10'h11b == lutAddr ? $signed(-16'sh151b) : $signed(_GEN_284); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_286 = 10'h11c == lutAddr ? $signed(-16'sh15e1) : $signed(_GEN_285); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_287 = 10'h11d == lutAddr ? $signed(-16'sh16a7) : $signed(_GEN_286); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_288 = 10'h11e == lutAddr ? $signed(-16'sh176d) : $signed(_GEN_287); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_289 = 10'h11f == lutAddr ? $signed(-16'sh1833) : $signed(_GEN_288); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_290 = 10'h120 == lutAddr ? $signed(-16'sh18f8) : $signed(_GEN_289); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_291 = 10'h121 == lutAddr ? $signed(-16'sh19bd) : $signed(_GEN_290); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_292 = 10'h122 == lutAddr ? $signed(-16'sh1a82) : $signed(_GEN_291); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_293 = 10'h123 == lutAddr ? $signed(-16'sh1b46) : $signed(_GEN_292); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_294 = 10'h124 == lutAddr ? $signed(-16'sh1c0b) : $signed(_GEN_293); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_295 = 10'h125 == lutAddr ? $signed(-16'sh1ccf) : $signed(_GEN_294); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_296 = 10'h126 == lutAddr ? $signed(-16'sh1d93) : $signed(_GEN_295); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_297 = 10'h127 == lutAddr ? $signed(-16'sh1e56) : $signed(_GEN_296); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_298 = 10'h128 == lutAddr ? $signed(-16'sh1f19) : $signed(_GEN_297); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_299 = 10'h129 == lutAddr ? $signed(-16'sh1fdc) : $signed(_GEN_298); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_300 = 10'h12a == lutAddr ? $signed(-16'sh209f) : $signed(_GEN_299); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_301 = 10'h12b == lutAddr ? $signed(-16'sh2161) : $signed(_GEN_300); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_302 = 10'h12c == lutAddr ? $signed(-16'sh2223) : $signed(_GEN_301); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_303 = 10'h12d == lutAddr ? $signed(-16'sh22e4) : $signed(_GEN_302); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_304 = 10'h12e == lutAddr ? $signed(-16'sh23a6) : $signed(_GEN_303); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_305 = 10'h12f == lutAddr ? $signed(-16'sh2467) : $signed(_GEN_304); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_306 = 10'h130 == lutAddr ? $signed(-16'sh2527) : $signed(_GEN_305); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_307 = 10'h131 == lutAddr ? $signed(-16'sh25e7) : $signed(_GEN_306); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_308 = 10'h132 == lutAddr ? $signed(-16'sh26a7) : $signed(_GEN_307); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_309 = 10'h133 == lutAddr ? $signed(-16'sh2767) : $signed(_GEN_308); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_310 = 10'h134 == lutAddr ? $signed(-16'sh2826) : $signed(_GEN_309); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_311 = 10'h135 == lutAddr ? $signed(-16'sh28e5) : $signed(_GEN_310); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_312 = 10'h136 == lutAddr ? $signed(-16'sh29a3) : $signed(_GEN_311); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_313 = 10'h137 == lutAddr ? $signed(-16'sh2a61) : $signed(_GEN_312); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_314 = 10'h138 == lutAddr ? $signed(-16'sh2b1e) : $signed(_GEN_313); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_315 = 10'h139 == lutAddr ? $signed(-16'sh2bdb) : $signed(_GEN_314); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_316 = 10'h13a == lutAddr ? $signed(-16'sh2c98) : $signed(_GEN_315); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_317 = 10'h13b == lutAddr ? $signed(-16'sh2d54) : $signed(_GEN_316); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_318 = 10'h13c == lutAddr ? $signed(-16'sh2e10) : $signed(_GEN_317); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_319 = 10'h13d == lutAddr ? $signed(-16'sh2ecc) : $signed(_GEN_318); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_320 = 10'h13e == lutAddr ? $signed(-16'sh2f86) : $signed(_GEN_319); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_321 = 10'h13f == lutAddr ? $signed(-16'sh3041) : $signed(_GEN_320); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_322 = 10'h140 == lutAddr ? $signed(-16'sh30fb) : $signed(_GEN_321); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_323 = 10'h141 == lutAddr ? $signed(-16'sh31b4) : $signed(_GEN_322); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_324 = 10'h142 == lutAddr ? $signed(-16'sh326d) : $signed(_GEN_323); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_325 = 10'h143 == lutAddr ? $signed(-16'sh3326) : $signed(_GEN_324); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_326 = 10'h144 == lutAddr ? $signed(-16'sh33de) : $signed(_GEN_325); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_327 = 10'h145 == lutAddr ? $signed(-16'sh3496) : $signed(_GEN_326); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_328 = 10'h146 == lutAddr ? $signed(-16'sh354d) : $signed(_GEN_327); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_329 = 10'h147 == lutAddr ? $signed(-16'sh3603) : $signed(_GEN_328); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_330 = 10'h148 == lutAddr ? $signed(-16'sh36b9) : $signed(_GEN_329); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_331 = 10'h149 == lutAddr ? $signed(-16'sh376f) : $signed(_GEN_330); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_332 = 10'h14a == lutAddr ? $signed(-16'sh3824) : $signed(_GEN_331); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_333 = 10'h14b == lutAddr ? $signed(-16'sh38d8) : $signed(_GEN_332); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_334 = 10'h14c == lutAddr ? $signed(-16'sh398c) : $signed(_GEN_333); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_335 = 10'h14d == lutAddr ? $signed(-16'sh3a3f) : $signed(_GEN_334); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_336 = 10'h14e == lutAddr ? $signed(-16'sh3af2) : $signed(_GEN_335); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_337 = 10'h14f == lutAddr ? $signed(-16'sh3ba4) : $signed(_GEN_336); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_338 = 10'h150 == lutAddr ? $signed(-16'sh3c56) : $signed(_GEN_337); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_339 = 10'h151 == lutAddr ? $signed(-16'sh3d07) : $signed(_GEN_338); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_340 = 10'h152 == lutAddr ? $signed(-16'sh3db7) : $signed(_GEN_339); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_341 = 10'h153 == lutAddr ? $signed(-16'sh3e67) : $signed(_GEN_340); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_342 = 10'h154 == lutAddr ? $signed(-16'sh3f16) : $signed(_GEN_341); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_343 = 10'h155 == lutAddr ? $signed(-16'sh3fc5) : $signed(_GEN_342); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_344 = 10'h156 == lutAddr ? $signed(-16'sh4073) : $signed(_GEN_343); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_345 = 10'h157 == lutAddr ? $signed(-16'sh4120) : $signed(_GEN_344); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_346 = 10'h158 == lutAddr ? $signed(-16'sh41cd) : $signed(_GEN_345); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_347 = 10'h159 == lutAddr ? $signed(-16'sh4279) : $signed(_GEN_346); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_348 = 10'h15a == lutAddr ? $signed(-16'sh4325) : $signed(_GEN_347); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_349 = 10'h15b == lutAddr ? $signed(-16'sh43d0) : $signed(_GEN_348); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_350 = 10'h15c == lutAddr ? $signed(-16'sh447a) : $signed(_GEN_349); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_351 = 10'h15d == lutAddr ? $signed(-16'sh4523) : $signed(_GEN_350); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_352 = 10'h15e == lutAddr ? $signed(-16'sh45cc) : $signed(_GEN_351); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_353 = 10'h15f == lutAddr ? $signed(-16'sh4674) : $signed(_GEN_352); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_354 = 10'h160 == lutAddr ? $signed(-16'sh471c) : $signed(_GEN_353); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_355 = 10'h161 == lutAddr ? $signed(-16'sh47c3) : $signed(_GEN_354); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_356 = 10'h162 == lutAddr ? $signed(-16'sh4869) : $signed(_GEN_355); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_357 = 10'h163 == lutAddr ? $signed(-16'sh490e) : $signed(_GEN_356); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_358 = 10'h164 == lutAddr ? $signed(-16'sh49b3) : $signed(_GEN_357); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_359 = 10'h165 == lutAddr ? $signed(-16'sh4a57) : $signed(_GEN_358); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_360 = 10'h166 == lutAddr ? $signed(-16'sh4afa) : $signed(_GEN_359); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_361 = 10'h167 == lutAddr ? $signed(-16'sh4b9d) : $signed(_GEN_360); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_362 = 10'h168 == lutAddr ? $signed(-16'sh4c3f) : $signed(_GEN_361); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_363 = 10'h169 == lutAddr ? $signed(-16'sh4ce0) : $signed(_GEN_362); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_364 = 10'h16a == lutAddr ? $signed(-16'sh4d80) : $signed(_GEN_363); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_365 = 10'h16b == lutAddr ? $signed(-16'sh4e20) : $signed(_GEN_364); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_366 = 10'h16c == lutAddr ? $signed(-16'sh4ebf) : $signed(_GEN_365); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_367 = 10'h16d == lutAddr ? $signed(-16'sh4f5d) : $signed(_GEN_366); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_368 = 10'h16e == lutAddr ? $signed(-16'sh4ffa) : $signed(_GEN_367); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_369 = 10'h16f == lutAddr ? $signed(-16'sh5097) : $signed(_GEN_368); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_370 = 10'h170 == lutAddr ? $signed(-16'sh5133) : $signed(_GEN_369); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_371 = 10'h171 == lutAddr ? $signed(-16'sh51ce) : $signed(_GEN_370); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_372 = 10'h172 == lutAddr ? $signed(-16'sh5268) : $signed(_GEN_371); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_373 = 10'h173 == lutAddr ? $signed(-16'sh5301) : $signed(_GEN_372); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_374 = 10'h174 == lutAddr ? $signed(-16'sh539a) : $signed(_GEN_373); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_375 = 10'h175 == lutAddr ? $signed(-16'sh5432) : $signed(_GEN_374); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_376 = 10'h176 == lutAddr ? $signed(-16'sh54c9) : $signed(_GEN_375); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_377 = 10'h177 == lutAddr ? $signed(-16'sh555f) : $signed(_GEN_376); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_378 = 10'h178 == lutAddr ? $signed(-16'sh55f4) : $signed(_GEN_377); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_379 = 10'h179 == lutAddr ? $signed(-16'sh5689) : $signed(_GEN_378); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_380 = 10'h17a == lutAddr ? $signed(-16'sh571d) : $signed(_GEN_379); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_381 = 10'h17b == lutAddr ? $signed(-16'sh57b0) : $signed(_GEN_380); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_382 = 10'h17c == lutAddr ? $signed(-16'sh5842) : $signed(_GEN_381); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_383 = 10'h17d == lutAddr ? $signed(-16'sh58d3) : $signed(_GEN_382); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_384 = 10'h17e == lutAddr ? $signed(-16'sh5963) : $signed(_GEN_383); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_385 = 10'h17f == lutAddr ? $signed(-16'sh59f3) : $signed(_GEN_384); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_386 = 10'h180 == lutAddr ? $signed(-16'sh5a81) : $signed(_GEN_385); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_387 = 10'h181 == lutAddr ? $signed(-16'sh5b0f) : $signed(_GEN_386); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_388 = 10'h182 == lutAddr ? $signed(-16'sh5b9c) : $signed(_GEN_387); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_389 = 10'h183 == lutAddr ? $signed(-16'sh5c28) : $signed(_GEN_388); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_390 = 10'h184 == lutAddr ? $signed(-16'sh5cb3) : $signed(_GEN_389); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_391 = 10'h185 == lutAddr ? $signed(-16'sh5d3d) : $signed(_GEN_390); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_392 = 10'h186 == lutAddr ? $signed(-16'sh5dc6) : $signed(_GEN_391); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_393 = 10'h187 == lutAddr ? $signed(-16'sh5e4f) : $signed(_GEN_392); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_394 = 10'h188 == lutAddr ? $signed(-16'sh5ed6) : $signed(_GEN_393); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_395 = 10'h189 == lutAddr ? $signed(-16'sh5f5d) : $signed(_GEN_394); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_396 = 10'h18a == lutAddr ? $signed(-16'sh5fe2) : $signed(_GEN_395); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_397 = 10'h18b == lutAddr ? $signed(-16'sh6067) : $signed(_GEN_396); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_398 = 10'h18c == lutAddr ? $signed(-16'sh60eb) : $signed(_GEN_397); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_399 = 10'h18d == lutAddr ? $signed(-16'sh616e) : $signed(_GEN_398); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_400 = 10'h18e == lutAddr ? $signed(-16'sh61f0) : $signed(_GEN_399); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_401 = 10'h18f == lutAddr ? $signed(-16'sh6271) : $signed(_GEN_400); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_402 = 10'h190 == lutAddr ? $signed(-16'sh62f1) : $signed(_GEN_401); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_403 = 10'h191 == lutAddr ? $signed(-16'sh6370) : $signed(_GEN_402); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_404 = 10'h192 == lutAddr ? $signed(-16'sh63ee) : $signed(_GEN_403); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_405 = 10'h193 == lutAddr ? $signed(-16'sh646b) : $signed(_GEN_404); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_406 = 10'h194 == lutAddr ? $signed(-16'sh64e7) : $signed(_GEN_405); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_407 = 10'h195 == lutAddr ? $signed(-16'sh6562) : $signed(_GEN_406); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_408 = 10'h196 == lutAddr ? $signed(-16'sh65dd) : $signed(_GEN_407); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_409 = 10'h197 == lutAddr ? $signed(-16'sh6656) : $signed(_GEN_408); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_410 = 10'h198 == lutAddr ? $signed(-16'sh66ce) : $signed(_GEN_409); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_411 = 10'h199 == lutAddr ? $signed(-16'sh6745) : $signed(_GEN_410); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_412 = 10'h19a == lutAddr ? $signed(-16'sh67bc) : $signed(_GEN_411); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_413 = 10'h19b == lutAddr ? $signed(-16'sh6831) : $signed(_GEN_412); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_414 = 10'h19c == lutAddr ? $signed(-16'sh68a5) : $signed(_GEN_413); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_415 = 10'h19d == lutAddr ? $signed(-16'sh6919) : $signed(_GEN_414); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_416 = 10'h19e == lutAddr ? $signed(-16'sh698b) : $signed(_GEN_415); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_417 = 10'h19f == lutAddr ? $signed(-16'sh69fc) : $signed(_GEN_416); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_418 = 10'h1a0 == lutAddr ? $signed(-16'sh6a6c) : $signed(_GEN_417); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_419 = 10'h1a1 == lutAddr ? $signed(-16'sh6adb) : $signed(_GEN_418); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_420 = 10'h1a2 == lutAddr ? $signed(-16'sh6b4a) : $signed(_GEN_419); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_421 = 10'h1a3 == lutAddr ? $signed(-16'sh6bb7) : $signed(_GEN_420); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_422 = 10'h1a4 == lutAddr ? $signed(-16'sh6c23) : $signed(_GEN_421); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_423 = 10'h1a5 == lutAddr ? $signed(-16'sh6c8e) : $signed(_GEN_422); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_424 = 10'h1a6 == lutAddr ? $signed(-16'sh6cf8) : $signed(_GEN_423); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_425 = 10'h1a7 == lutAddr ? $signed(-16'sh6d61) : $signed(_GEN_424); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_426 = 10'h1a8 == lutAddr ? $signed(-16'sh6dc9) : $signed(_GEN_425); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_427 = 10'h1a9 == lutAddr ? $signed(-16'sh6e30) : $signed(_GEN_426); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_428 = 10'h1aa == lutAddr ? $signed(-16'sh6e95) : $signed(_GEN_427); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_429 = 10'h1ab == lutAddr ? $signed(-16'sh6efa) : $signed(_GEN_428); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_430 = 10'h1ac == lutAddr ? $signed(-16'sh6f5e) : $signed(_GEN_429); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_431 = 10'h1ad == lutAddr ? $signed(-16'sh6fc0) : $signed(_GEN_430); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_432 = 10'h1ae == lutAddr ? $signed(-16'sh7022) : $signed(_GEN_431); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_433 = 10'h1af == lutAddr ? $signed(-16'sh7082) : $signed(_GEN_432); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_434 = 10'h1b0 == lutAddr ? $signed(-16'sh70e1) : $signed(_GEN_433); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_435 = 10'h1b1 == lutAddr ? $signed(-16'sh7140) : $signed(_GEN_434); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_436 = 10'h1b2 == lutAddr ? $signed(-16'sh719d) : $signed(_GEN_435); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_437 = 10'h1b3 == lutAddr ? $signed(-16'sh71f9) : $signed(_GEN_436); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_438 = 10'h1b4 == lutAddr ? $signed(-16'sh7254) : $signed(_GEN_437); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_439 = 10'h1b5 == lutAddr ? $signed(-16'sh72ae) : $signed(_GEN_438); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_440 = 10'h1b6 == lutAddr ? $signed(-16'sh7306) : $signed(_GEN_439); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_441 = 10'h1b7 == lutAddr ? $signed(-16'sh735e) : $signed(_GEN_440); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_442 = 10'h1b8 == lutAddr ? $signed(-16'sh73b5) : $signed(_GEN_441); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_443 = 10'h1b9 == lutAddr ? $signed(-16'sh740a) : $signed(_GEN_442); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_444 = 10'h1ba == lutAddr ? $signed(-16'sh745e) : $signed(_GEN_443); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_445 = 10'h1bb == lutAddr ? $signed(-16'sh74b1) : $signed(_GEN_444); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_446 = 10'h1bc == lutAddr ? $signed(-16'sh7503) : $signed(_GEN_445); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_447 = 10'h1bd == lutAddr ? $signed(-16'sh7554) : $signed(_GEN_446); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_448 = 10'h1be == lutAddr ? $signed(-16'sh75a4) : $signed(_GEN_447); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_449 = 10'h1bf == lutAddr ? $signed(-16'sh75f3) : $signed(_GEN_448); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_450 = 10'h1c0 == lutAddr ? $signed(-16'sh7640) : $signed(_GEN_449); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_451 = 10'h1c1 == lutAddr ? $signed(-16'sh768d) : $signed(_GEN_450); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_452 = 10'h1c2 == lutAddr ? $signed(-16'sh76d8) : $signed(_GEN_451); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_453 = 10'h1c3 == lutAddr ? $signed(-16'sh7722) : $signed(_GEN_452); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_454 = 10'h1c4 == lutAddr ? $signed(-16'sh776b) : $signed(_GEN_453); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_455 = 10'h1c5 == lutAddr ? $signed(-16'sh77b3) : $signed(_GEN_454); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_456 = 10'h1c6 == lutAddr ? $signed(-16'sh77f9) : $signed(_GEN_455); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_457 = 10'h1c7 == lutAddr ? $signed(-16'sh783f) : $signed(_GEN_456); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_458 = 10'h1c8 == lutAddr ? $signed(-16'sh7883) : $signed(_GEN_457); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_459 = 10'h1c9 == lutAddr ? $signed(-16'sh78c6) : $signed(_GEN_458); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_460 = 10'h1ca == lutAddr ? $signed(-16'sh7908) : $signed(_GEN_459); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_461 = 10'h1cb == lutAddr ? $signed(-16'sh7949) : $signed(_GEN_460); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_462 = 10'h1cc == lutAddr ? $signed(-16'sh7989) : $signed(_GEN_461); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_463 = 10'h1cd == lutAddr ? $signed(-16'sh79c7) : $signed(_GEN_462); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_464 = 10'h1ce == lutAddr ? $signed(-16'sh7a04) : $signed(_GEN_463); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_465 = 10'h1cf == lutAddr ? $signed(-16'sh7a41) : $signed(_GEN_464); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_466 = 10'h1d0 == lutAddr ? $signed(-16'sh7a7c) : $signed(_GEN_465); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_467 = 10'h1d1 == lutAddr ? $signed(-16'sh7ab5) : $signed(_GEN_466); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_468 = 10'h1d2 == lutAddr ? $signed(-16'sh7aee) : $signed(_GEN_467); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_469 = 10'h1d3 == lutAddr ? $signed(-16'sh7b25) : $signed(_GEN_468); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_470 = 10'h1d4 == lutAddr ? $signed(-16'sh7b5c) : $signed(_GEN_469); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_471 = 10'h1d5 == lutAddr ? $signed(-16'sh7b91) : $signed(_GEN_470); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_472 = 10'h1d6 == lutAddr ? $signed(-16'sh7bc4) : $signed(_GEN_471); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_473 = 10'h1d7 == lutAddr ? $signed(-16'sh7bf7) : $signed(_GEN_472); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_474 = 10'h1d8 == lutAddr ? $signed(-16'sh7c29) : $signed(_GEN_473); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_475 = 10'h1d9 == lutAddr ? $signed(-16'sh7c59) : $signed(_GEN_474); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_476 = 10'h1da == lutAddr ? $signed(-16'sh7c88) : $signed(_GEN_475); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_477 = 10'h1db == lutAddr ? $signed(-16'sh7cb6) : $signed(_GEN_476); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_478 = 10'h1dc == lutAddr ? $signed(-16'sh7ce2) : $signed(_GEN_477); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_479 = 10'h1dd == lutAddr ? $signed(-16'sh7d0e) : $signed(_GEN_478); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_480 = 10'h1de == lutAddr ? $signed(-16'sh7d38) : $signed(_GEN_479); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_481 = 10'h1df == lutAddr ? $signed(-16'sh7d61) : $signed(_GEN_480); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_482 = 10'h1e0 == lutAddr ? $signed(-16'sh7d89) : $signed(_GEN_481); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_483 = 10'h1e1 == lutAddr ? $signed(-16'sh7db0) : $signed(_GEN_482); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_484 = 10'h1e2 == lutAddr ? $signed(-16'sh7dd5) : $signed(_GEN_483); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_485 = 10'h1e3 == lutAddr ? $signed(-16'sh7df9) : $signed(_GEN_484); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_486 = 10'h1e4 == lutAddr ? $signed(-16'sh7e1c) : $signed(_GEN_485); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_487 = 10'h1e5 == lutAddr ? $signed(-16'sh7e3e) : $signed(_GEN_486); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_488 = 10'h1e6 == lutAddr ? $signed(-16'sh7e5e) : $signed(_GEN_487); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_489 = 10'h1e7 == lutAddr ? $signed(-16'sh7e7e) : $signed(_GEN_488); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_490 = 10'h1e8 == lutAddr ? $signed(-16'sh7e9c) : $signed(_GEN_489); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_491 = 10'h1e9 == lutAddr ? $signed(-16'sh7eb9) : $signed(_GEN_490); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_492 = 10'h1ea == lutAddr ? $signed(-16'sh7ed4) : $signed(_GEN_491); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_493 = 10'h1eb == lutAddr ? $signed(-16'sh7eef) : $signed(_GEN_492); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_494 = 10'h1ec == lutAddr ? $signed(-16'sh7f08) : $signed(_GEN_493); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_495 = 10'h1ed == lutAddr ? $signed(-16'sh7f20) : $signed(_GEN_494); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_496 = 10'h1ee == lutAddr ? $signed(-16'sh7f37) : $signed(_GEN_495); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_497 = 10'h1ef == lutAddr ? $signed(-16'sh7f4c) : $signed(_GEN_496); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_498 = 10'h1f0 == lutAddr ? $signed(-16'sh7f61) : $signed(_GEN_497); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_499 = 10'h1f1 == lutAddr ? $signed(-16'sh7f74) : $signed(_GEN_498); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_500 = 10'h1f2 == lutAddr ? $signed(-16'sh7f86) : $signed(_GEN_499); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_501 = 10'h1f3 == lutAddr ? $signed(-16'sh7f96) : $signed(_GEN_500); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_502 = 10'h1f4 == lutAddr ? $signed(-16'sh7fa6) : $signed(_GEN_501); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_503 = 10'h1f5 == lutAddr ? $signed(-16'sh7fb4) : $signed(_GEN_502); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_504 = 10'h1f6 == lutAddr ? $signed(-16'sh7fc1) : $signed(_GEN_503); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_505 = 10'h1f7 == lutAddr ? $signed(-16'sh7fcd) : $signed(_GEN_504); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_506 = 10'h1f8 == lutAddr ? $signed(-16'sh7fd7) : $signed(_GEN_505); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_507 = 10'h1f9 == lutAddr ? $signed(-16'sh7fe0) : $signed(_GEN_506); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_508 = 10'h1fa == lutAddr ? $signed(-16'sh7fe8) : $signed(_GEN_507); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_509 = 10'h1fb == lutAddr ? $signed(-16'sh7fef) : $signed(_GEN_508); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_510 = 10'h1fc == lutAddr ? $signed(-16'sh7ff5) : $signed(_GEN_509); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_511 = 10'h1fd == lutAddr ? $signed(-16'sh7ff9) : $signed(_GEN_510); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_512 = 10'h1fe == lutAddr ? $signed(-16'sh7ffc) : $signed(_GEN_511); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_513 = 10'h1ff == lutAddr ? $signed(-16'sh7ffe) : $signed(_GEN_512); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_514 = 10'h200 == lutAddr ? $signed(-16'sh7fff) : $signed(_GEN_513); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_515 = 10'h201 == lutAddr ? $signed(-16'sh7ffe) : $signed(_GEN_514); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_516 = 10'h202 == lutAddr ? $signed(-16'sh7ffc) : $signed(_GEN_515); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_517 = 10'h203 == lutAddr ? $signed(-16'sh7ff9) : $signed(_GEN_516); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_518 = 10'h204 == lutAddr ? $signed(-16'sh7ff5) : $signed(_GEN_517); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_519 = 10'h205 == lutAddr ? $signed(-16'sh7fef) : $signed(_GEN_518); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_520 = 10'h206 == lutAddr ? $signed(-16'sh7fe8) : $signed(_GEN_519); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_521 = 10'h207 == lutAddr ? $signed(-16'sh7fe0) : $signed(_GEN_520); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_522 = 10'h208 == lutAddr ? $signed(-16'sh7fd7) : $signed(_GEN_521); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_523 = 10'h209 == lutAddr ? $signed(-16'sh7fcd) : $signed(_GEN_522); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_524 = 10'h20a == lutAddr ? $signed(-16'sh7fc1) : $signed(_GEN_523); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_525 = 10'h20b == lutAddr ? $signed(-16'sh7fb4) : $signed(_GEN_524); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_526 = 10'h20c == lutAddr ? $signed(-16'sh7fa6) : $signed(_GEN_525); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_527 = 10'h20d == lutAddr ? $signed(-16'sh7f96) : $signed(_GEN_526); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_528 = 10'h20e == lutAddr ? $signed(-16'sh7f86) : $signed(_GEN_527); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_529 = 10'h20f == lutAddr ? $signed(-16'sh7f74) : $signed(_GEN_528); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_530 = 10'h210 == lutAddr ? $signed(-16'sh7f61) : $signed(_GEN_529); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_531 = 10'h211 == lutAddr ? $signed(-16'sh7f4c) : $signed(_GEN_530); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_532 = 10'h212 == lutAddr ? $signed(-16'sh7f37) : $signed(_GEN_531); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_533 = 10'h213 == lutAddr ? $signed(-16'sh7f20) : $signed(_GEN_532); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_534 = 10'h214 == lutAddr ? $signed(-16'sh7f08) : $signed(_GEN_533); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_535 = 10'h215 == lutAddr ? $signed(-16'sh7eef) : $signed(_GEN_534); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_536 = 10'h216 == lutAddr ? $signed(-16'sh7ed4) : $signed(_GEN_535); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_537 = 10'h217 == lutAddr ? $signed(-16'sh7eb9) : $signed(_GEN_536); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_538 = 10'h218 == lutAddr ? $signed(-16'sh7e9c) : $signed(_GEN_537); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_539 = 10'h219 == lutAddr ? $signed(-16'sh7e7e) : $signed(_GEN_538); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_540 = 10'h21a == lutAddr ? $signed(-16'sh7e5e) : $signed(_GEN_539); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_541 = 10'h21b == lutAddr ? $signed(-16'sh7e3e) : $signed(_GEN_540); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_542 = 10'h21c == lutAddr ? $signed(-16'sh7e1c) : $signed(_GEN_541); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_543 = 10'h21d == lutAddr ? $signed(-16'sh7df9) : $signed(_GEN_542); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_544 = 10'h21e == lutAddr ? $signed(-16'sh7dd5) : $signed(_GEN_543); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_545 = 10'h21f == lutAddr ? $signed(-16'sh7db0) : $signed(_GEN_544); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_546 = 10'h220 == lutAddr ? $signed(-16'sh7d89) : $signed(_GEN_545); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_547 = 10'h221 == lutAddr ? $signed(-16'sh7d61) : $signed(_GEN_546); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_548 = 10'h222 == lutAddr ? $signed(-16'sh7d38) : $signed(_GEN_547); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_549 = 10'h223 == lutAddr ? $signed(-16'sh7d0e) : $signed(_GEN_548); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_550 = 10'h224 == lutAddr ? $signed(-16'sh7ce2) : $signed(_GEN_549); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_551 = 10'h225 == lutAddr ? $signed(-16'sh7cb6) : $signed(_GEN_550); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_552 = 10'h226 == lutAddr ? $signed(-16'sh7c88) : $signed(_GEN_551); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_553 = 10'h227 == lutAddr ? $signed(-16'sh7c59) : $signed(_GEN_552); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_554 = 10'h228 == lutAddr ? $signed(-16'sh7c29) : $signed(_GEN_553); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_555 = 10'h229 == lutAddr ? $signed(-16'sh7bf7) : $signed(_GEN_554); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_556 = 10'h22a == lutAddr ? $signed(-16'sh7bc4) : $signed(_GEN_555); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_557 = 10'h22b == lutAddr ? $signed(-16'sh7b91) : $signed(_GEN_556); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_558 = 10'h22c == lutAddr ? $signed(-16'sh7b5c) : $signed(_GEN_557); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_559 = 10'h22d == lutAddr ? $signed(-16'sh7b25) : $signed(_GEN_558); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_560 = 10'h22e == lutAddr ? $signed(-16'sh7aee) : $signed(_GEN_559); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_561 = 10'h22f == lutAddr ? $signed(-16'sh7ab5) : $signed(_GEN_560); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_562 = 10'h230 == lutAddr ? $signed(-16'sh7a7c) : $signed(_GEN_561); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_563 = 10'h231 == lutAddr ? $signed(-16'sh7a41) : $signed(_GEN_562); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_564 = 10'h232 == lutAddr ? $signed(-16'sh7a04) : $signed(_GEN_563); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_565 = 10'h233 == lutAddr ? $signed(-16'sh79c7) : $signed(_GEN_564); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_566 = 10'h234 == lutAddr ? $signed(-16'sh7989) : $signed(_GEN_565); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_567 = 10'h235 == lutAddr ? $signed(-16'sh7949) : $signed(_GEN_566); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_568 = 10'h236 == lutAddr ? $signed(-16'sh7908) : $signed(_GEN_567); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_569 = 10'h237 == lutAddr ? $signed(-16'sh78c6) : $signed(_GEN_568); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_570 = 10'h238 == lutAddr ? $signed(-16'sh7883) : $signed(_GEN_569); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_571 = 10'h239 == lutAddr ? $signed(-16'sh783f) : $signed(_GEN_570); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_572 = 10'h23a == lutAddr ? $signed(-16'sh77f9) : $signed(_GEN_571); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_573 = 10'h23b == lutAddr ? $signed(-16'sh77b3) : $signed(_GEN_572); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_574 = 10'h23c == lutAddr ? $signed(-16'sh776b) : $signed(_GEN_573); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_575 = 10'h23d == lutAddr ? $signed(-16'sh7722) : $signed(_GEN_574); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_576 = 10'h23e == lutAddr ? $signed(-16'sh76d8) : $signed(_GEN_575); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_577 = 10'h23f == lutAddr ? $signed(-16'sh768d) : $signed(_GEN_576); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_578 = 10'h240 == lutAddr ? $signed(-16'sh7640) : $signed(_GEN_577); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_579 = 10'h241 == lutAddr ? $signed(-16'sh75f3) : $signed(_GEN_578); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_580 = 10'h242 == lutAddr ? $signed(-16'sh75a4) : $signed(_GEN_579); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_581 = 10'h243 == lutAddr ? $signed(-16'sh7554) : $signed(_GEN_580); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_582 = 10'h244 == lutAddr ? $signed(-16'sh7503) : $signed(_GEN_581); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_583 = 10'h245 == lutAddr ? $signed(-16'sh74b1) : $signed(_GEN_582); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_584 = 10'h246 == lutAddr ? $signed(-16'sh745e) : $signed(_GEN_583); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_585 = 10'h247 == lutAddr ? $signed(-16'sh740a) : $signed(_GEN_584); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_586 = 10'h248 == lutAddr ? $signed(-16'sh73b5) : $signed(_GEN_585); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_587 = 10'h249 == lutAddr ? $signed(-16'sh735e) : $signed(_GEN_586); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_588 = 10'h24a == lutAddr ? $signed(-16'sh7306) : $signed(_GEN_587); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_589 = 10'h24b == lutAddr ? $signed(-16'sh72ae) : $signed(_GEN_588); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_590 = 10'h24c == lutAddr ? $signed(-16'sh7254) : $signed(_GEN_589); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_591 = 10'h24d == lutAddr ? $signed(-16'sh71f9) : $signed(_GEN_590); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_592 = 10'h24e == lutAddr ? $signed(-16'sh719d) : $signed(_GEN_591); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_593 = 10'h24f == lutAddr ? $signed(-16'sh7140) : $signed(_GEN_592); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_594 = 10'h250 == lutAddr ? $signed(-16'sh70e1) : $signed(_GEN_593); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_595 = 10'h251 == lutAddr ? $signed(-16'sh7082) : $signed(_GEN_594); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_596 = 10'h252 == lutAddr ? $signed(-16'sh7022) : $signed(_GEN_595); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_597 = 10'h253 == lutAddr ? $signed(-16'sh6fc0) : $signed(_GEN_596); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_598 = 10'h254 == lutAddr ? $signed(-16'sh6f5e) : $signed(_GEN_597); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_599 = 10'h255 == lutAddr ? $signed(-16'sh6efa) : $signed(_GEN_598); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_600 = 10'h256 == lutAddr ? $signed(-16'sh6e95) : $signed(_GEN_599); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_601 = 10'h257 == lutAddr ? $signed(-16'sh6e30) : $signed(_GEN_600); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_602 = 10'h258 == lutAddr ? $signed(-16'sh6dc9) : $signed(_GEN_601); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_603 = 10'h259 == lutAddr ? $signed(-16'sh6d61) : $signed(_GEN_602); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_604 = 10'h25a == lutAddr ? $signed(-16'sh6cf8) : $signed(_GEN_603); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_605 = 10'h25b == lutAddr ? $signed(-16'sh6c8e) : $signed(_GEN_604); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_606 = 10'h25c == lutAddr ? $signed(-16'sh6c23) : $signed(_GEN_605); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_607 = 10'h25d == lutAddr ? $signed(-16'sh6bb7) : $signed(_GEN_606); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_608 = 10'h25e == lutAddr ? $signed(-16'sh6b4a) : $signed(_GEN_607); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_609 = 10'h25f == lutAddr ? $signed(-16'sh6adb) : $signed(_GEN_608); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_610 = 10'h260 == lutAddr ? $signed(-16'sh6a6c) : $signed(_GEN_609); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_611 = 10'h261 == lutAddr ? $signed(-16'sh69fc) : $signed(_GEN_610); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_612 = 10'h262 == lutAddr ? $signed(-16'sh698b) : $signed(_GEN_611); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_613 = 10'h263 == lutAddr ? $signed(-16'sh6919) : $signed(_GEN_612); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_614 = 10'h264 == lutAddr ? $signed(-16'sh68a5) : $signed(_GEN_613); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_615 = 10'h265 == lutAddr ? $signed(-16'sh6831) : $signed(_GEN_614); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_616 = 10'h266 == lutAddr ? $signed(-16'sh67bc) : $signed(_GEN_615); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_617 = 10'h267 == lutAddr ? $signed(-16'sh6745) : $signed(_GEN_616); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_618 = 10'h268 == lutAddr ? $signed(-16'sh66ce) : $signed(_GEN_617); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_619 = 10'h269 == lutAddr ? $signed(-16'sh6656) : $signed(_GEN_618); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_620 = 10'h26a == lutAddr ? $signed(-16'sh65dd) : $signed(_GEN_619); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_621 = 10'h26b == lutAddr ? $signed(-16'sh6562) : $signed(_GEN_620); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_622 = 10'h26c == lutAddr ? $signed(-16'sh64e7) : $signed(_GEN_621); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_623 = 10'h26d == lutAddr ? $signed(-16'sh646b) : $signed(_GEN_622); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_624 = 10'h26e == lutAddr ? $signed(-16'sh63ee) : $signed(_GEN_623); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_625 = 10'h26f == lutAddr ? $signed(-16'sh6370) : $signed(_GEN_624); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_626 = 10'h270 == lutAddr ? $signed(-16'sh62f1) : $signed(_GEN_625); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_627 = 10'h271 == lutAddr ? $signed(-16'sh6271) : $signed(_GEN_626); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_628 = 10'h272 == lutAddr ? $signed(-16'sh61f0) : $signed(_GEN_627); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_629 = 10'h273 == lutAddr ? $signed(-16'sh616e) : $signed(_GEN_628); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_630 = 10'h274 == lutAddr ? $signed(-16'sh60eb) : $signed(_GEN_629); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_631 = 10'h275 == lutAddr ? $signed(-16'sh6067) : $signed(_GEN_630); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_632 = 10'h276 == lutAddr ? $signed(-16'sh5fe2) : $signed(_GEN_631); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_633 = 10'h277 == lutAddr ? $signed(-16'sh5f5d) : $signed(_GEN_632); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_634 = 10'h278 == lutAddr ? $signed(-16'sh5ed6) : $signed(_GEN_633); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_635 = 10'h279 == lutAddr ? $signed(-16'sh5e4f) : $signed(_GEN_634); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_636 = 10'h27a == lutAddr ? $signed(-16'sh5dc6) : $signed(_GEN_635); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_637 = 10'h27b == lutAddr ? $signed(-16'sh5d3d) : $signed(_GEN_636); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_638 = 10'h27c == lutAddr ? $signed(-16'sh5cb3) : $signed(_GEN_637); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_639 = 10'h27d == lutAddr ? $signed(-16'sh5c28) : $signed(_GEN_638); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_640 = 10'h27e == lutAddr ? $signed(-16'sh5b9c) : $signed(_GEN_639); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_641 = 10'h27f == lutAddr ? $signed(-16'sh5b0f) : $signed(_GEN_640); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_642 = 10'h280 == lutAddr ? $signed(-16'sh5a81) : $signed(_GEN_641); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_643 = 10'h281 == lutAddr ? $signed(-16'sh59f3) : $signed(_GEN_642); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_644 = 10'h282 == lutAddr ? $signed(-16'sh5963) : $signed(_GEN_643); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_645 = 10'h283 == lutAddr ? $signed(-16'sh58d3) : $signed(_GEN_644); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_646 = 10'h284 == lutAddr ? $signed(-16'sh5842) : $signed(_GEN_645); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_647 = 10'h285 == lutAddr ? $signed(-16'sh57b0) : $signed(_GEN_646); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_648 = 10'h286 == lutAddr ? $signed(-16'sh571d) : $signed(_GEN_647); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_649 = 10'h287 == lutAddr ? $signed(-16'sh5689) : $signed(_GEN_648); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_650 = 10'h288 == lutAddr ? $signed(-16'sh55f4) : $signed(_GEN_649); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_651 = 10'h289 == lutAddr ? $signed(-16'sh555f) : $signed(_GEN_650); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_652 = 10'h28a == lutAddr ? $signed(-16'sh54c9) : $signed(_GEN_651); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_653 = 10'h28b == lutAddr ? $signed(-16'sh5432) : $signed(_GEN_652); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_654 = 10'h28c == lutAddr ? $signed(-16'sh539a) : $signed(_GEN_653); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_655 = 10'h28d == lutAddr ? $signed(-16'sh5301) : $signed(_GEN_654); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_656 = 10'h28e == lutAddr ? $signed(-16'sh5268) : $signed(_GEN_655); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_657 = 10'h28f == lutAddr ? $signed(-16'sh51ce) : $signed(_GEN_656); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_658 = 10'h290 == lutAddr ? $signed(-16'sh5133) : $signed(_GEN_657); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_659 = 10'h291 == lutAddr ? $signed(-16'sh5097) : $signed(_GEN_658); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_660 = 10'h292 == lutAddr ? $signed(-16'sh4ffa) : $signed(_GEN_659); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_661 = 10'h293 == lutAddr ? $signed(-16'sh4f5d) : $signed(_GEN_660); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_662 = 10'h294 == lutAddr ? $signed(-16'sh4ebf) : $signed(_GEN_661); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_663 = 10'h295 == lutAddr ? $signed(-16'sh4e20) : $signed(_GEN_662); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_664 = 10'h296 == lutAddr ? $signed(-16'sh4d80) : $signed(_GEN_663); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_665 = 10'h297 == lutAddr ? $signed(-16'sh4ce0) : $signed(_GEN_664); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_666 = 10'h298 == lutAddr ? $signed(-16'sh4c3f) : $signed(_GEN_665); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_667 = 10'h299 == lutAddr ? $signed(-16'sh4b9d) : $signed(_GEN_666); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_668 = 10'h29a == lutAddr ? $signed(-16'sh4afa) : $signed(_GEN_667); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_669 = 10'h29b == lutAddr ? $signed(-16'sh4a57) : $signed(_GEN_668); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_670 = 10'h29c == lutAddr ? $signed(-16'sh49b3) : $signed(_GEN_669); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_671 = 10'h29d == lutAddr ? $signed(-16'sh490e) : $signed(_GEN_670); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_672 = 10'h29e == lutAddr ? $signed(-16'sh4869) : $signed(_GEN_671); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_673 = 10'h29f == lutAddr ? $signed(-16'sh47c3) : $signed(_GEN_672); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_674 = 10'h2a0 == lutAddr ? $signed(-16'sh471c) : $signed(_GEN_673); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_675 = 10'h2a1 == lutAddr ? $signed(-16'sh4674) : $signed(_GEN_674); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_676 = 10'h2a2 == lutAddr ? $signed(-16'sh45cc) : $signed(_GEN_675); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_677 = 10'h2a3 == lutAddr ? $signed(-16'sh4523) : $signed(_GEN_676); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_678 = 10'h2a4 == lutAddr ? $signed(-16'sh447a) : $signed(_GEN_677); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_679 = 10'h2a5 == lutAddr ? $signed(-16'sh43d0) : $signed(_GEN_678); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_680 = 10'h2a6 == lutAddr ? $signed(-16'sh4325) : $signed(_GEN_679); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_681 = 10'h2a7 == lutAddr ? $signed(-16'sh4279) : $signed(_GEN_680); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_682 = 10'h2a8 == lutAddr ? $signed(-16'sh41cd) : $signed(_GEN_681); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_683 = 10'h2a9 == lutAddr ? $signed(-16'sh4120) : $signed(_GEN_682); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_684 = 10'h2aa == lutAddr ? $signed(-16'sh4073) : $signed(_GEN_683); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_685 = 10'h2ab == lutAddr ? $signed(-16'sh3fc5) : $signed(_GEN_684); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_686 = 10'h2ac == lutAddr ? $signed(-16'sh3f16) : $signed(_GEN_685); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_687 = 10'h2ad == lutAddr ? $signed(-16'sh3e67) : $signed(_GEN_686); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_688 = 10'h2ae == lutAddr ? $signed(-16'sh3db7) : $signed(_GEN_687); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_689 = 10'h2af == lutAddr ? $signed(-16'sh3d07) : $signed(_GEN_688); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_690 = 10'h2b0 == lutAddr ? $signed(-16'sh3c56) : $signed(_GEN_689); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_691 = 10'h2b1 == lutAddr ? $signed(-16'sh3ba4) : $signed(_GEN_690); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_692 = 10'h2b2 == lutAddr ? $signed(-16'sh3af2) : $signed(_GEN_691); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_693 = 10'h2b3 == lutAddr ? $signed(-16'sh3a3f) : $signed(_GEN_692); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_694 = 10'h2b4 == lutAddr ? $signed(-16'sh398c) : $signed(_GEN_693); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_695 = 10'h2b5 == lutAddr ? $signed(-16'sh38d8) : $signed(_GEN_694); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_696 = 10'h2b6 == lutAddr ? $signed(-16'sh3824) : $signed(_GEN_695); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_697 = 10'h2b7 == lutAddr ? $signed(-16'sh376f) : $signed(_GEN_696); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_698 = 10'h2b8 == lutAddr ? $signed(-16'sh36b9) : $signed(_GEN_697); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_699 = 10'h2b9 == lutAddr ? $signed(-16'sh3603) : $signed(_GEN_698); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_700 = 10'h2ba == lutAddr ? $signed(-16'sh354d) : $signed(_GEN_699); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_701 = 10'h2bb == lutAddr ? $signed(-16'sh3496) : $signed(_GEN_700); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_702 = 10'h2bc == lutAddr ? $signed(-16'sh33de) : $signed(_GEN_701); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_703 = 10'h2bd == lutAddr ? $signed(-16'sh3326) : $signed(_GEN_702); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_704 = 10'h2be == lutAddr ? $signed(-16'sh326d) : $signed(_GEN_703); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_705 = 10'h2bf == lutAddr ? $signed(-16'sh31b4) : $signed(_GEN_704); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_706 = 10'h2c0 == lutAddr ? $signed(-16'sh30fb) : $signed(_GEN_705); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_707 = 10'h2c1 == lutAddr ? $signed(-16'sh3041) : $signed(_GEN_706); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_708 = 10'h2c2 == lutAddr ? $signed(-16'sh2f86) : $signed(_GEN_707); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_709 = 10'h2c3 == lutAddr ? $signed(-16'sh2ecc) : $signed(_GEN_708); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_710 = 10'h2c4 == lutAddr ? $signed(-16'sh2e10) : $signed(_GEN_709); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_711 = 10'h2c5 == lutAddr ? $signed(-16'sh2d54) : $signed(_GEN_710); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_712 = 10'h2c6 == lutAddr ? $signed(-16'sh2c98) : $signed(_GEN_711); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_713 = 10'h2c7 == lutAddr ? $signed(-16'sh2bdb) : $signed(_GEN_712); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_714 = 10'h2c8 == lutAddr ? $signed(-16'sh2b1e) : $signed(_GEN_713); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_715 = 10'h2c9 == lutAddr ? $signed(-16'sh2a61) : $signed(_GEN_714); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_716 = 10'h2ca == lutAddr ? $signed(-16'sh29a3) : $signed(_GEN_715); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_717 = 10'h2cb == lutAddr ? $signed(-16'sh28e5) : $signed(_GEN_716); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_718 = 10'h2cc == lutAddr ? $signed(-16'sh2826) : $signed(_GEN_717); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_719 = 10'h2cd == lutAddr ? $signed(-16'sh2767) : $signed(_GEN_718); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_720 = 10'h2ce == lutAddr ? $signed(-16'sh26a7) : $signed(_GEN_719); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_721 = 10'h2cf == lutAddr ? $signed(-16'sh25e7) : $signed(_GEN_720); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_722 = 10'h2d0 == lutAddr ? $signed(-16'sh2527) : $signed(_GEN_721); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_723 = 10'h2d1 == lutAddr ? $signed(-16'sh2467) : $signed(_GEN_722); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_724 = 10'h2d2 == lutAddr ? $signed(-16'sh23a6) : $signed(_GEN_723); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_725 = 10'h2d3 == lutAddr ? $signed(-16'sh22e4) : $signed(_GEN_724); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_726 = 10'h2d4 == lutAddr ? $signed(-16'sh2223) : $signed(_GEN_725); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_727 = 10'h2d5 == lutAddr ? $signed(-16'sh2161) : $signed(_GEN_726); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_728 = 10'h2d6 == lutAddr ? $signed(-16'sh209f) : $signed(_GEN_727); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_729 = 10'h2d7 == lutAddr ? $signed(-16'sh1fdc) : $signed(_GEN_728); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_730 = 10'h2d8 == lutAddr ? $signed(-16'sh1f19) : $signed(_GEN_729); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_731 = 10'h2d9 == lutAddr ? $signed(-16'sh1e56) : $signed(_GEN_730); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_732 = 10'h2da == lutAddr ? $signed(-16'sh1d93) : $signed(_GEN_731); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_733 = 10'h2db == lutAddr ? $signed(-16'sh1ccf) : $signed(_GEN_732); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_734 = 10'h2dc == lutAddr ? $signed(-16'sh1c0b) : $signed(_GEN_733); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_735 = 10'h2dd == lutAddr ? $signed(-16'sh1b46) : $signed(_GEN_734); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_736 = 10'h2de == lutAddr ? $signed(-16'sh1a82) : $signed(_GEN_735); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_737 = 10'h2df == lutAddr ? $signed(-16'sh19bd) : $signed(_GEN_736); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_738 = 10'h2e0 == lutAddr ? $signed(-16'sh18f8) : $signed(_GEN_737); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_739 = 10'h2e1 == lutAddr ? $signed(-16'sh1833) : $signed(_GEN_738); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_740 = 10'h2e2 == lutAddr ? $signed(-16'sh176d) : $signed(_GEN_739); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_741 = 10'h2e3 == lutAddr ? $signed(-16'sh16a7) : $signed(_GEN_740); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_742 = 10'h2e4 == lutAddr ? $signed(-16'sh15e1) : $signed(_GEN_741); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_743 = 10'h2e5 == lutAddr ? $signed(-16'sh151b) : $signed(_GEN_742); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_744 = 10'h2e6 == lutAddr ? $signed(-16'sh1455) : $signed(_GEN_743); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_745 = 10'h2e7 == lutAddr ? $signed(-16'sh138e) : $signed(_GEN_744); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_746 = 10'h2e8 == lutAddr ? $signed(-16'sh12c7) : $signed(_GEN_745); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_747 = 10'h2e9 == lutAddr ? $signed(-16'sh1200) : $signed(_GEN_746); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_748 = 10'h2ea == lutAddr ? $signed(-16'sh1139) : $signed(_GEN_747); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_749 = 10'h2eb == lutAddr ? $signed(-16'sh1072) : $signed(_GEN_748); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_750 = 10'h2ec == lutAddr ? $signed(-16'shfab) : $signed(_GEN_749); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_751 = 10'h2ed == lutAddr ? $signed(-16'shee3) : $signed(_GEN_750); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_752 = 10'h2ee == lutAddr ? $signed(-16'she1b) : $signed(_GEN_751); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_753 = 10'h2ef == lutAddr ? $signed(-16'shd53) : $signed(_GEN_752); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_754 = 10'h2f0 == lutAddr ? $signed(-16'shc8b) : $signed(_GEN_753); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_755 = 10'h2f1 == lutAddr ? $signed(-16'shbc3) : $signed(_GEN_754); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_756 = 10'h2f2 == lutAddr ? $signed(-16'shafb) : $signed(_GEN_755); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_757 = 10'h2f3 == lutAddr ? $signed(-16'sha32) : $signed(_GEN_756); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_758 = 10'h2f4 == lutAddr ? $signed(-16'sh96a) : $signed(_GEN_757); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_759 = 10'h2f5 == lutAddr ? $signed(-16'sh8a1) : $signed(_GEN_758); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_760 = 10'h2f6 == lutAddr ? $signed(-16'sh7d9) : $signed(_GEN_759); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_761 = 10'h2f7 == lutAddr ? $signed(-16'sh710) : $signed(_GEN_760); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_762 = 10'h2f8 == lutAddr ? $signed(-16'sh647) : $signed(_GEN_761); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_763 = 10'h2f9 == lutAddr ? $signed(-16'sh57e) : $signed(_GEN_762); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_764 = 10'h2fa == lutAddr ? $signed(-16'sh4b6) : $signed(_GEN_763); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_765 = 10'h2fb == lutAddr ? $signed(-16'sh3ed) : $signed(_GEN_764); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_766 = 10'h2fc == lutAddr ? $signed(-16'sh324) : $signed(_GEN_765); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_767 = 10'h2fd == lutAddr ? $signed(-16'sh25b) : $signed(_GEN_766); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_768 = 10'h2fe == lutAddr ? $signed(-16'sh192) : $signed(_GEN_767); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_769 = 10'h2ff == lutAddr ? $signed(-16'shc9) : $signed(_GEN_768); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_770 = 10'h300 == lutAddr ? $signed(16'sh0) : $signed(_GEN_769); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_771 = 10'h301 == lutAddr ? $signed(16'shc9) : $signed(_GEN_770); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_772 = 10'h302 == lutAddr ? $signed(16'sh192) : $signed(_GEN_771); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_773 = 10'h303 == lutAddr ? $signed(16'sh25b) : $signed(_GEN_772); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_774 = 10'h304 == lutAddr ? $signed(16'sh324) : $signed(_GEN_773); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_775 = 10'h305 == lutAddr ? $signed(16'sh3ed) : $signed(_GEN_774); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_776 = 10'h306 == lutAddr ? $signed(16'sh4b6) : $signed(_GEN_775); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_777 = 10'h307 == lutAddr ? $signed(16'sh57e) : $signed(_GEN_776); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_778 = 10'h308 == lutAddr ? $signed(16'sh647) : $signed(_GEN_777); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_779 = 10'h309 == lutAddr ? $signed(16'sh710) : $signed(_GEN_778); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_780 = 10'h30a == lutAddr ? $signed(16'sh7d9) : $signed(_GEN_779); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_781 = 10'h30b == lutAddr ? $signed(16'sh8a1) : $signed(_GEN_780); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_782 = 10'h30c == lutAddr ? $signed(16'sh96a) : $signed(_GEN_781); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_783 = 10'h30d == lutAddr ? $signed(16'sha32) : $signed(_GEN_782); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_784 = 10'h30e == lutAddr ? $signed(16'shafb) : $signed(_GEN_783); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_785 = 10'h30f == lutAddr ? $signed(16'shbc3) : $signed(_GEN_784); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_786 = 10'h310 == lutAddr ? $signed(16'shc8b) : $signed(_GEN_785); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_787 = 10'h311 == lutAddr ? $signed(16'shd53) : $signed(_GEN_786); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_788 = 10'h312 == lutAddr ? $signed(16'she1b) : $signed(_GEN_787); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_789 = 10'h313 == lutAddr ? $signed(16'shee3) : $signed(_GEN_788); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_790 = 10'h314 == lutAddr ? $signed(16'shfab) : $signed(_GEN_789); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_791 = 10'h315 == lutAddr ? $signed(16'sh1072) : $signed(_GEN_790); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_792 = 10'h316 == lutAddr ? $signed(16'sh1139) : $signed(_GEN_791); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_793 = 10'h317 == lutAddr ? $signed(16'sh1200) : $signed(_GEN_792); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_794 = 10'h318 == lutAddr ? $signed(16'sh12c7) : $signed(_GEN_793); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_795 = 10'h319 == lutAddr ? $signed(16'sh138e) : $signed(_GEN_794); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_796 = 10'h31a == lutAddr ? $signed(16'sh1455) : $signed(_GEN_795); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_797 = 10'h31b == lutAddr ? $signed(16'sh151b) : $signed(_GEN_796); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_798 = 10'h31c == lutAddr ? $signed(16'sh15e1) : $signed(_GEN_797); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_799 = 10'h31d == lutAddr ? $signed(16'sh16a7) : $signed(_GEN_798); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_800 = 10'h31e == lutAddr ? $signed(16'sh176d) : $signed(_GEN_799); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_801 = 10'h31f == lutAddr ? $signed(16'sh1833) : $signed(_GEN_800); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_802 = 10'h320 == lutAddr ? $signed(16'sh18f8) : $signed(_GEN_801); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_803 = 10'h321 == lutAddr ? $signed(16'sh19bd) : $signed(_GEN_802); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_804 = 10'h322 == lutAddr ? $signed(16'sh1a82) : $signed(_GEN_803); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_805 = 10'h323 == lutAddr ? $signed(16'sh1b46) : $signed(_GEN_804); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_806 = 10'h324 == lutAddr ? $signed(16'sh1c0b) : $signed(_GEN_805); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_807 = 10'h325 == lutAddr ? $signed(16'sh1ccf) : $signed(_GEN_806); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_808 = 10'h326 == lutAddr ? $signed(16'sh1d93) : $signed(_GEN_807); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_809 = 10'h327 == lutAddr ? $signed(16'sh1e56) : $signed(_GEN_808); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_810 = 10'h328 == lutAddr ? $signed(16'sh1f19) : $signed(_GEN_809); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_811 = 10'h329 == lutAddr ? $signed(16'sh1fdc) : $signed(_GEN_810); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_812 = 10'h32a == lutAddr ? $signed(16'sh209f) : $signed(_GEN_811); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_813 = 10'h32b == lutAddr ? $signed(16'sh2161) : $signed(_GEN_812); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_814 = 10'h32c == lutAddr ? $signed(16'sh2223) : $signed(_GEN_813); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_815 = 10'h32d == lutAddr ? $signed(16'sh22e4) : $signed(_GEN_814); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_816 = 10'h32e == lutAddr ? $signed(16'sh23a6) : $signed(_GEN_815); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_817 = 10'h32f == lutAddr ? $signed(16'sh2467) : $signed(_GEN_816); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_818 = 10'h330 == lutAddr ? $signed(16'sh2527) : $signed(_GEN_817); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_819 = 10'h331 == lutAddr ? $signed(16'sh25e7) : $signed(_GEN_818); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_820 = 10'h332 == lutAddr ? $signed(16'sh26a7) : $signed(_GEN_819); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_821 = 10'h333 == lutAddr ? $signed(16'sh2767) : $signed(_GEN_820); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_822 = 10'h334 == lutAddr ? $signed(16'sh2826) : $signed(_GEN_821); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_823 = 10'h335 == lutAddr ? $signed(16'sh28e5) : $signed(_GEN_822); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_824 = 10'h336 == lutAddr ? $signed(16'sh29a3) : $signed(_GEN_823); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_825 = 10'h337 == lutAddr ? $signed(16'sh2a61) : $signed(_GEN_824); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_826 = 10'h338 == lutAddr ? $signed(16'sh2b1e) : $signed(_GEN_825); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_827 = 10'h339 == lutAddr ? $signed(16'sh2bdb) : $signed(_GEN_826); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_828 = 10'h33a == lutAddr ? $signed(16'sh2c98) : $signed(_GEN_827); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_829 = 10'h33b == lutAddr ? $signed(16'sh2d54) : $signed(_GEN_828); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_830 = 10'h33c == lutAddr ? $signed(16'sh2e10) : $signed(_GEN_829); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_831 = 10'h33d == lutAddr ? $signed(16'sh2ecc) : $signed(_GEN_830); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_832 = 10'h33e == lutAddr ? $signed(16'sh2f86) : $signed(_GEN_831); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_833 = 10'h33f == lutAddr ? $signed(16'sh3041) : $signed(_GEN_832); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_834 = 10'h340 == lutAddr ? $signed(16'sh30fb) : $signed(_GEN_833); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_835 = 10'h341 == lutAddr ? $signed(16'sh31b4) : $signed(_GEN_834); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_836 = 10'h342 == lutAddr ? $signed(16'sh326d) : $signed(_GEN_835); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_837 = 10'h343 == lutAddr ? $signed(16'sh3326) : $signed(_GEN_836); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_838 = 10'h344 == lutAddr ? $signed(16'sh33de) : $signed(_GEN_837); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_839 = 10'h345 == lutAddr ? $signed(16'sh3496) : $signed(_GEN_838); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_840 = 10'h346 == lutAddr ? $signed(16'sh354d) : $signed(_GEN_839); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_841 = 10'h347 == lutAddr ? $signed(16'sh3603) : $signed(_GEN_840); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_842 = 10'h348 == lutAddr ? $signed(16'sh36b9) : $signed(_GEN_841); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_843 = 10'h349 == lutAddr ? $signed(16'sh376f) : $signed(_GEN_842); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_844 = 10'h34a == lutAddr ? $signed(16'sh3824) : $signed(_GEN_843); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_845 = 10'h34b == lutAddr ? $signed(16'sh38d8) : $signed(_GEN_844); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_846 = 10'h34c == lutAddr ? $signed(16'sh398c) : $signed(_GEN_845); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_847 = 10'h34d == lutAddr ? $signed(16'sh3a3f) : $signed(_GEN_846); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_848 = 10'h34e == lutAddr ? $signed(16'sh3af2) : $signed(_GEN_847); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_849 = 10'h34f == lutAddr ? $signed(16'sh3ba4) : $signed(_GEN_848); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_850 = 10'h350 == lutAddr ? $signed(16'sh3c56) : $signed(_GEN_849); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_851 = 10'h351 == lutAddr ? $signed(16'sh3d07) : $signed(_GEN_850); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_852 = 10'h352 == lutAddr ? $signed(16'sh3db7) : $signed(_GEN_851); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_853 = 10'h353 == lutAddr ? $signed(16'sh3e67) : $signed(_GEN_852); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_854 = 10'h354 == lutAddr ? $signed(16'sh3f16) : $signed(_GEN_853); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_855 = 10'h355 == lutAddr ? $signed(16'sh3fc5) : $signed(_GEN_854); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_856 = 10'h356 == lutAddr ? $signed(16'sh4073) : $signed(_GEN_855); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_857 = 10'h357 == lutAddr ? $signed(16'sh4120) : $signed(_GEN_856); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_858 = 10'h358 == lutAddr ? $signed(16'sh41cd) : $signed(_GEN_857); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_859 = 10'h359 == lutAddr ? $signed(16'sh4279) : $signed(_GEN_858); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_860 = 10'h35a == lutAddr ? $signed(16'sh4325) : $signed(_GEN_859); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_861 = 10'h35b == lutAddr ? $signed(16'sh43d0) : $signed(_GEN_860); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_862 = 10'h35c == lutAddr ? $signed(16'sh447a) : $signed(_GEN_861); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_863 = 10'h35d == lutAddr ? $signed(16'sh4523) : $signed(_GEN_862); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_864 = 10'h35e == lutAddr ? $signed(16'sh45cc) : $signed(_GEN_863); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_865 = 10'h35f == lutAddr ? $signed(16'sh4674) : $signed(_GEN_864); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_866 = 10'h360 == lutAddr ? $signed(16'sh471c) : $signed(_GEN_865); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_867 = 10'h361 == lutAddr ? $signed(16'sh47c3) : $signed(_GEN_866); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_868 = 10'h362 == lutAddr ? $signed(16'sh4869) : $signed(_GEN_867); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_869 = 10'h363 == lutAddr ? $signed(16'sh490e) : $signed(_GEN_868); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_870 = 10'h364 == lutAddr ? $signed(16'sh49b3) : $signed(_GEN_869); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_871 = 10'h365 == lutAddr ? $signed(16'sh4a57) : $signed(_GEN_870); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_872 = 10'h366 == lutAddr ? $signed(16'sh4afa) : $signed(_GEN_871); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_873 = 10'h367 == lutAddr ? $signed(16'sh4b9d) : $signed(_GEN_872); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_874 = 10'h368 == lutAddr ? $signed(16'sh4c3f) : $signed(_GEN_873); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_875 = 10'h369 == lutAddr ? $signed(16'sh4ce0) : $signed(_GEN_874); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_876 = 10'h36a == lutAddr ? $signed(16'sh4d80) : $signed(_GEN_875); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_877 = 10'h36b == lutAddr ? $signed(16'sh4e20) : $signed(_GEN_876); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_878 = 10'h36c == lutAddr ? $signed(16'sh4ebf) : $signed(_GEN_877); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_879 = 10'h36d == lutAddr ? $signed(16'sh4f5d) : $signed(_GEN_878); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_880 = 10'h36e == lutAddr ? $signed(16'sh4ffa) : $signed(_GEN_879); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_881 = 10'h36f == lutAddr ? $signed(16'sh5097) : $signed(_GEN_880); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_882 = 10'h370 == lutAddr ? $signed(16'sh5133) : $signed(_GEN_881); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_883 = 10'h371 == lutAddr ? $signed(16'sh51ce) : $signed(_GEN_882); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_884 = 10'h372 == lutAddr ? $signed(16'sh5268) : $signed(_GEN_883); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_885 = 10'h373 == lutAddr ? $signed(16'sh5301) : $signed(_GEN_884); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_886 = 10'h374 == lutAddr ? $signed(16'sh539a) : $signed(_GEN_885); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_887 = 10'h375 == lutAddr ? $signed(16'sh5432) : $signed(_GEN_886); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_888 = 10'h376 == lutAddr ? $signed(16'sh54c9) : $signed(_GEN_887); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_889 = 10'h377 == lutAddr ? $signed(16'sh555f) : $signed(_GEN_888); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_890 = 10'h378 == lutAddr ? $signed(16'sh55f4) : $signed(_GEN_889); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_891 = 10'h379 == lutAddr ? $signed(16'sh5689) : $signed(_GEN_890); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_892 = 10'h37a == lutAddr ? $signed(16'sh571d) : $signed(_GEN_891); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_893 = 10'h37b == lutAddr ? $signed(16'sh57b0) : $signed(_GEN_892); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_894 = 10'h37c == lutAddr ? $signed(16'sh5842) : $signed(_GEN_893); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_895 = 10'h37d == lutAddr ? $signed(16'sh58d3) : $signed(_GEN_894); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_896 = 10'h37e == lutAddr ? $signed(16'sh5963) : $signed(_GEN_895); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_897 = 10'h37f == lutAddr ? $signed(16'sh59f3) : $signed(_GEN_896); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_898 = 10'h380 == lutAddr ? $signed(16'sh5a81) : $signed(_GEN_897); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_899 = 10'h381 == lutAddr ? $signed(16'sh5b0f) : $signed(_GEN_898); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_900 = 10'h382 == lutAddr ? $signed(16'sh5b9c) : $signed(_GEN_899); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_901 = 10'h383 == lutAddr ? $signed(16'sh5c28) : $signed(_GEN_900); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_902 = 10'h384 == lutAddr ? $signed(16'sh5cb3) : $signed(_GEN_901); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_903 = 10'h385 == lutAddr ? $signed(16'sh5d3d) : $signed(_GEN_902); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_904 = 10'h386 == lutAddr ? $signed(16'sh5dc6) : $signed(_GEN_903); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_905 = 10'h387 == lutAddr ? $signed(16'sh5e4f) : $signed(_GEN_904); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_906 = 10'h388 == lutAddr ? $signed(16'sh5ed6) : $signed(_GEN_905); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_907 = 10'h389 == lutAddr ? $signed(16'sh5f5d) : $signed(_GEN_906); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_908 = 10'h38a == lutAddr ? $signed(16'sh5fe2) : $signed(_GEN_907); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_909 = 10'h38b == lutAddr ? $signed(16'sh6067) : $signed(_GEN_908); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_910 = 10'h38c == lutAddr ? $signed(16'sh60eb) : $signed(_GEN_909); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_911 = 10'h38d == lutAddr ? $signed(16'sh616e) : $signed(_GEN_910); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_912 = 10'h38e == lutAddr ? $signed(16'sh61f0) : $signed(_GEN_911); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_913 = 10'h38f == lutAddr ? $signed(16'sh6271) : $signed(_GEN_912); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_914 = 10'h390 == lutAddr ? $signed(16'sh62f1) : $signed(_GEN_913); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_915 = 10'h391 == lutAddr ? $signed(16'sh6370) : $signed(_GEN_914); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_916 = 10'h392 == lutAddr ? $signed(16'sh63ee) : $signed(_GEN_915); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_917 = 10'h393 == lutAddr ? $signed(16'sh646b) : $signed(_GEN_916); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_918 = 10'h394 == lutAddr ? $signed(16'sh64e7) : $signed(_GEN_917); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_919 = 10'h395 == lutAddr ? $signed(16'sh6562) : $signed(_GEN_918); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_920 = 10'h396 == lutAddr ? $signed(16'sh65dd) : $signed(_GEN_919); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_921 = 10'h397 == lutAddr ? $signed(16'sh6656) : $signed(_GEN_920); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_922 = 10'h398 == lutAddr ? $signed(16'sh66ce) : $signed(_GEN_921); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_923 = 10'h399 == lutAddr ? $signed(16'sh6745) : $signed(_GEN_922); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_924 = 10'h39a == lutAddr ? $signed(16'sh67bc) : $signed(_GEN_923); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_925 = 10'h39b == lutAddr ? $signed(16'sh6831) : $signed(_GEN_924); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_926 = 10'h39c == lutAddr ? $signed(16'sh68a5) : $signed(_GEN_925); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_927 = 10'h39d == lutAddr ? $signed(16'sh6919) : $signed(_GEN_926); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_928 = 10'h39e == lutAddr ? $signed(16'sh698b) : $signed(_GEN_927); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_929 = 10'h39f == lutAddr ? $signed(16'sh69fc) : $signed(_GEN_928); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_930 = 10'h3a0 == lutAddr ? $signed(16'sh6a6c) : $signed(_GEN_929); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_931 = 10'h3a1 == lutAddr ? $signed(16'sh6adb) : $signed(_GEN_930); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_932 = 10'h3a2 == lutAddr ? $signed(16'sh6b4a) : $signed(_GEN_931); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_933 = 10'h3a3 == lutAddr ? $signed(16'sh6bb7) : $signed(_GEN_932); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_934 = 10'h3a4 == lutAddr ? $signed(16'sh6c23) : $signed(_GEN_933); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_935 = 10'h3a5 == lutAddr ? $signed(16'sh6c8e) : $signed(_GEN_934); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_936 = 10'h3a6 == lutAddr ? $signed(16'sh6cf8) : $signed(_GEN_935); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_937 = 10'h3a7 == lutAddr ? $signed(16'sh6d61) : $signed(_GEN_936); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_938 = 10'h3a8 == lutAddr ? $signed(16'sh6dc9) : $signed(_GEN_937); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_939 = 10'h3a9 == lutAddr ? $signed(16'sh6e30) : $signed(_GEN_938); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_940 = 10'h3aa == lutAddr ? $signed(16'sh6e95) : $signed(_GEN_939); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_941 = 10'h3ab == lutAddr ? $signed(16'sh6efa) : $signed(_GEN_940); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_942 = 10'h3ac == lutAddr ? $signed(16'sh6f5e) : $signed(_GEN_941); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_943 = 10'h3ad == lutAddr ? $signed(16'sh6fc0) : $signed(_GEN_942); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_944 = 10'h3ae == lutAddr ? $signed(16'sh7022) : $signed(_GEN_943); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_945 = 10'h3af == lutAddr ? $signed(16'sh7082) : $signed(_GEN_944); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_946 = 10'h3b0 == lutAddr ? $signed(16'sh70e1) : $signed(_GEN_945); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_947 = 10'h3b1 == lutAddr ? $signed(16'sh7140) : $signed(_GEN_946); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_948 = 10'h3b2 == lutAddr ? $signed(16'sh719d) : $signed(_GEN_947); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_949 = 10'h3b3 == lutAddr ? $signed(16'sh71f9) : $signed(_GEN_948); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_950 = 10'h3b4 == lutAddr ? $signed(16'sh7254) : $signed(_GEN_949); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_951 = 10'h3b5 == lutAddr ? $signed(16'sh72ae) : $signed(_GEN_950); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_952 = 10'h3b6 == lutAddr ? $signed(16'sh7306) : $signed(_GEN_951); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_953 = 10'h3b7 == lutAddr ? $signed(16'sh735e) : $signed(_GEN_952); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_954 = 10'h3b8 == lutAddr ? $signed(16'sh73b5) : $signed(_GEN_953); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_955 = 10'h3b9 == lutAddr ? $signed(16'sh740a) : $signed(_GEN_954); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_956 = 10'h3ba == lutAddr ? $signed(16'sh745e) : $signed(_GEN_955); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_957 = 10'h3bb == lutAddr ? $signed(16'sh74b1) : $signed(_GEN_956); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_958 = 10'h3bc == lutAddr ? $signed(16'sh7503) : $signed(_GEN_957); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_959 = 10'h3bd == lutAddr ? $signed(16'sh7554) : $signed(_GEN_958); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_960 = 10'h3be == lutAddr ? $signed(16'sh75a4) : $signed(_GEN_959); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_961 = 10'h3bf == lutAddr ? $signed(16'sh75f3) : $signed(_GEN_960); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_962 = 10'h3c0 == lutAddr ? $signed(16'sh7640) : $signed(_GEN_961); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_963 = 10'h3c1 == lutAddr ? $signed(16'sh768d) : $signed(_GEN_962); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_964 = 10'h3c2 == lutAddr ? $signed(16'sh76d8) : $signed(_GEN_963); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_965 = 10'h3c3 == lutAddr ? $signed(16'sh7722) : $signed(_GEN_964); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_966 = 10'h3c4 == lutAddr ? $signed(16'sh776b) : $signed(_GEN_965); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_967 = 10'h3c5 == lutAddr ? $signed(16'sh77b3) : $signed(_GEN_966); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_968 = 10'h3c6 == lutAddr ? $signed(16'sh77f9) : $signed(_GEN_967); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_969 = 10'h3c7 == lutAddr ? $signed(16'sh783f) : $signed(_GEN_968); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_970 = 10'h3c8 == lutAddr ? $signed(16'sh7883) : $signed(_GEN_969); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_971 = 10'h3c9 == lutAddr ? $signed(16'sh78c6) : $signed(_GEN_970); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_972 = 10'h3ca == lutAddr ? $signed(16'sh7908) : $signed(_GEN_971); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_973 = 10'h3cb == lutAddr ? $signed(16'sh7949) : $signed(_GEN_972); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_974 = 10'h3cc == lutAddr ? $signed(16'sh7989) : $signed(_GEN_973); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_975 = 10'h3cd == lutAddr ? $signed(16'sh79c7) : $signed(_GEN_974); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_976 = 10'h3ce == lutAddr ? $signed(16'sh7a04) : $signed(_GEN_975); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_977 = 10'h3cf == lutAddr ? $signed(16'sh7a41) : $signed(_GEN_976); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_978 = 10'h3d0 == lutAddr ? $signed(16'sh7a7c) : $signed(_GEN_977); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_979 = 10'h3d1 == lutAddr ? $signed(16'sh7ab5) : $signed(_GEN_978); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_980 = 10'h3d2 == lutAddr ? $signed(16'sh7aee) : $signed(_GEN_979); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_981 = 10'h3d3 == lutAddr ? $signed(16'sh7b25) : $signed(_GEN_980); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_982 = 10'h3d4 == lutAddr ? $signed(16'sh7b5c) : $signed(_GEN_981); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_983 = 10'h3d5 == lutAddr ? $signed(16'sh7b91) : $signed(_GEN_982); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_984 = 10'h3d6 == lutAddr ? $signed(16'sh7bc4) : $signed(_GEN_983); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_985 = 10'h3d7 == lutAddr ? $signed(16'sh7bf7) : $signed(_GEN_984); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_986 = 10'h3d8 == lutAddr ? $signed(16'sh7c29) : $signed(_GEN_985); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_987 = 10'h3d9 == lutAddr ? $signed(16'sh7c59) : $signed(_GEN_986); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_988 = 10'h3da == lutAddr ? $signed(16'sh7c88) : $signed(_GEN_987); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_989 = 10'h3db == lutAddr ? $signed(16'sh7cb6) : $signed(_GEN_988); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_990 = 10'h3dc == lutAddr ? $signed(16'sh7ce2) : $signed(_GEN_989); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_991 = 10'h3dd == lutAddr ? $signed(16'sh7d0e) : $signed(_GEN_990); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_992 = 10'h3de == lutAddr ? $signed(16'sh7d38) : $signed(_GEN_991); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_993 = 10'h3df == lutAddr ? $signed(16'sh7d61) : $signed(_GEN_992); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_994 = 10'h3e0 == lutAddr ? $signed(16'sh7d89) : $signed(_GEN_993); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_995 = 10'h3e1 == lutAddr ? $signed(16'sh7db0) : $signed(_GEN_994); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_996 = 10'h3e2 == lutAddr ? $signed(16'sh7dd5) : $signed(_GEN_995); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_997 = 10'h3e3 == lutAddr ? $signed(16'sh7df9) : $signed(_GEN_996); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_998 = 10'h3e4 == lutAddr ? $signed(16'sh7e1c) : $signed(_GEN_997); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_999 = 10'h3e5 == lutAddr ? $signed(16'sh7e3e) : $signed(_GEN_998); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1000 = 10'h3e6 == lutAddr ? $signed(16'sh7e5e) : $signed(_GEN_999); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1001 = 10'h3e7 == lutAddr ? $signed(16'sh7e7e) : $signed(_GEN_1000); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1002 = 10'h3e8 == lutAddr ? $signed(16'sh7e9c) : $signed(_GEN_1001); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1003 = 10'h3e9 == lutAddr ? $signed(16'sh7eb9) : $signed(_GEN_1002); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1004 = 10'h3ea == lutAddr ? $signed(16'sh7ed4) : $signed(_GEN_1003); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1005 = 10'h3eb == lutAddr ? $signed(16'sh7eef) : $signed(_GEN_1004); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1006 = 10'h3ec == lutAddr ? $signed(16'sh7f08) : $signed(_GEN_1005); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1007 = 10'h3ed == lutAddr ? $signed(16'sh7f20) : $signed(_GEN_1006); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1008 = 10'h3ee == lutAddr ? $signed(16'sh7f37) : $signed(_GEN_1007); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1009 = 10'h3ef == lutAddr ? $signed(16'sh7f4c) : $signed(_GEN_1008); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1010 = 10'h3f0 == lutAddr ? $signed(16'sh7f61) : $signed(_GEN_1009); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1011 = 10'h3f1 == lutAddr ? $signed(16'sh7f74) : $signed(_GEN_1010); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1012 = 10'h3f2 == lutAddr ? $signed(16'sh7f86) : $signed(_GEN_1011); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1013 = 10'h3f3 == lutAddr ? $signed(16'sh7f96) : $signed(_GEN_1012); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1014 = 10'h3f4 == lutAddr ? $signed(16'sh7fa6) : $signed(_GEN_1013); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1015 = 10'h3f5 == lutAddr ? $signed(16'sh7fb4) : $signed(_GEN_1014); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1016 = 10'h3f6 == lutAddr ? $signed(16'sh7fc1) : $signed(_GEN_1015); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1017 = 10'h3f7 == lutAddr ? $signed(16'sh7fcd) : $signed(_GEN_1016); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1018 = 10'h3f8 == lutAddr ? $signed(16'sh7fd7) : $signed(_GEN_1017); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1019 = 10'h3f9 == lutAddr ? $signed(16'sh7fe0) : $signed(_GEN_1018); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1020 = 10'h3fa == lutAddr ? $signed(16'sh7fe8) : $signed(_GEN_1019); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1021 = 10'h3fb == lutAddr ? $signed(16'sh7fef) : $signed(_GEN_1020); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1022 = 10'h3fc == lutAddr ? $signed(16'sh7ff5) : $signed(_GEN_1021); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1023 = 10'h3fd == lutAddr ? $signed(16'sh7ff9) : $signed(_GEN_1022); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1024 = 10'h3fe == lutAddr ? $signed(16'sh7ffc) : $signed(_GEN_1023); // @[NCO.scala 46:13 NCO.scala 46:13]
  wire [15:0] _GEN_1027 = 10'h1 == lutAddr ? $signed(16'shc9) : $signed(16'sh0); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1028 = 10'h2 == lutAddr ? $signed(16'sh192) : $signed(_GEN_1027); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1029 = 10'h3 == lutAddr ? $signed(16'sh25b) : $signed(_GEN_1028); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1030 = 10'h4 == lutAddr ? $signed(16'sh324) : $signed(_GEN_1029); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1031 = 10'h5 == lutAddr ? $signed(16'sh3ed) : $signed(_GEN_1030); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1032 = 10'h6 == lutAddr ? $signed(16'sh4b6) : $signed(_GEN_1031); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1033 = 10'h7 == lutAddr ? $signed(16'sh57e) : $signed(_GEN_1032); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1034 = 10'h8 == lutAddr ? $signed(16'sh647) : $signed(_GEN_1033); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1035 = 10'h9 == lutAddr ? $signed(16'sh710) : $signed(_GEN_1034); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1036 = 10'ha == lutAddr ? $signed(16'sh7d9) : $signed(_GEN_1035); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1037 = 10'hb == lutAddr ? $signed(16'sh8a1) : $signed(_GEN_1036); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1038 = 10'hc == lutAddr ? $signed(16'sh96a) : $signed(_GEN_1037); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1039 = 10'hd == lutAddr ? $signed(16'sha32) : $signed(_GEN_1038); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1040 = 10'he == lutAddr ? $signed(16'shafb) : $signed(_GEN_1039); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1041 = 10'hf == lutAddr ? $signed(16'shbc3) : $signed(_GEN_1040); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1042 = 10'h10 == lutAddr ? $signed(16'shc8b) : $signed(_GEN_1041); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1043 = 10'h11 == lutAddr ? $signed(16'shd53) : $signed(_GEN_1042); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1044 = 10'h12 == lutAddr ? $signed(16'she1b) : $signed(_GEN_1043); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1045 = 10'h13 == lutAddr ? $signed(16'shee3) : $signed(_GEN_1044); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1046 = 10'h14 == lutAddr ? $signed(16'shfab) : $signed(_GEN_1045); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1047 = 10'h15 == lutAddr ? $signed(16'sh1072) : $signed(_GEN_1046); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1048 = 10'h16 == lutAddr ? $signed(16'sh1139) : $signed(_GEN_1047); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1049 = 10'h17 == lutAddr ? $signed(16'sh1200) : $signed(_GEN_1048); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1050 = 10'h18 == lutAddr ? $signed(16'sh12c7) : $signed(_GEN_1049); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1051 = 10'h19 == lutAddr ? $signed(16'sh138e) : $signed(_GEN_1050); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1052 = 10'h1a == lutAddr ? $signed(16'sh1455) : $signed(_GEN_1051); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1053 = 10'h1b == lutAddr ? $signed(16'sh151b) : $signed(_GEN_1052); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1054 = 10'h1c == lutAddr ? $signed(16'sh15e1) : $signed(_GEN_1053); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1055 = 10'h1d == lutAddr ? $signed(16'sh16a7) : $signed(_GEN_1054); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1056 = 10'h1e == lutAddr ? $signed(16'sh176d) : $signed(_GEN_1055); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1057 = 10'h1f == lutAddr ? $signed(16'sh1833) : $signed(_GEN_1056); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1058 = 10'h20 == lutAddr ? $signed(16'sh18f8) : $signed(_GEN_1057); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1059 = 10'h21 == lutAddr ? $signed(16'sh19bd) : $signed(_GEN_1058); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1060 = 10'h22 == lutAddr ? $signed(16'sh1a82) : $signed(_GEN_1059); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1061 = 10'h23 == lutAddr ? $signed(16'sh1b46) : $signed(_GEN_1060); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1062 = 10'h24 == lutAddr ? $signed(16'sh1c0b) : $signed(_GEN_1061); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1063 = 10'h25 == lutAddr ? $signed(16'sh1ccf) : $signed(_GEN_1062); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1064 = 10'h26 == lutAddr ? $signed(16'sh1d93) : $signed(_GEN_1063); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1065 = 10'h27 == lutAddr ? $signed(16'sh1e56) : $signed(_GEN_1064); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1066 = 10'h28 == lutAddr ? $signed(16'sh1f19) : $signed(_GEN_1065); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1067 = 10'h29 == lutAddr ? $signed(16'sh1fdc) : $signed(_GEN_1066); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1068 = 10'h2a == lutAddr ? $signed(16'sh209f) : $signed(_GEN_1067); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1069 = 10'h2b == lutAddr ? $signed(16'sh2161) : $signed(_GEN_1068); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1070 = 10'h2c == lutAddr ? $signed(16'sh2223) : $signed(_GEN_1069); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1071 = 10'h2d == lutAddr ? $signed(16'sh22e4) : $signed(_GEN_1070); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1072 = 10'h2e == lutAddr ? $signed(16'sh23a6) : $signed(_GEN_1071); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1073 = 10'h2f == lutAddr ? $signed(16'sh2467) : $signed(_GEN_1072); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1074 = 10'h30 == lutAddr ? $signed(16'sh2527) : $signed(_GEN_1073); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1075 = 10'h31 == lutAddr ? $signed(16'sh25e7) : $signed(_GEN_1074); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1076 = 10'h32 == lutAddr ? $signed(16'sh26a7) : $signed(_GEN_1075); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1077 = 10'h33 == lutAddr ? $signed(16'sh2767) : $signed(_GEN_1076); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1078 = 10'h34 == lutAddr ? $signed(16'sh2826) : $signed(_GEN_1077); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1079 = 10'h35 == lutAddr ? $signed(16'sh28e5) : $signed(_GEN_1078); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1080 = 10'h36 == lutAddr ? $signed(16'sh29a3) : $signed(_GEN_1079); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1081 = 10'h37 == lutAddr ? $signed(16'sh2a61) : $signed(_GEN_1080); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1082 = 10'h38 == lutAddr ? $signed(16'sh2b1e) : $signed(_GEN_1081); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1083 = 10'h39 == lutAddr ? $signed(16'sh2bdb) : $signed(_GEN_1082); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1084 = 10'h3a == lutAddr ? $signed(16'sh2c98) : $signed(_GEN_1083); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1085 = 10'h3b == lutAddr ? $signed(16'sh2d54) : $signed(_GEN_1084); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1086 = 10'h3c == lutAddr ? $signed(16'sh2e10) : $signed(_GEN_1085); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1087 = 10'h3d == lutAddr ? $signed(16'sh2ecc) : $signed(_GEN_1086); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1088 = 10'h3e == lutAddr ? $signed(16'sh2f86) : $signed(_GEN_1087); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1089 = 10'h3f == lutAddr ? $signed(16'sh3041) : $signed(_GEN_1088); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1090 = 10'h40 == lutAddr ? $signed(16'sh30fb) : $signed(_GEN_1089); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1091 = 10'h41 == lutAddr ? $signed(16'sh31b4) : $signed(_GEN_1090); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1092 = 10'h42 == lutAddr ? $signed(16'sh326d) : $signed(_GEN_1091); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1093 = 10'h43 == lutAddr ? $signed(16'sh3326) : $signed(_GEN_1092); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1094 = 10'h44 == lutAddr ? $signed(16'sh33de) : $signed(_GEN_1093); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1095 = 10'h45 == lutAddr ? $signed(16'sh3496) : $signed(_GEN_1094); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1096 = 10'h46 == lutAddr ? $signed(16'sh354d) : $signed(_GEN_1095); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1097 = 10'h47 == lutAddr ? $signed(16'sh3603) : $signed(_GEN_1096); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1098 = 10'h48 == lutAddr ? $signed(16'sh36b9) : $signed(_GEN_1097); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1099 = 10'h49 == lutAddr ? $signed(16'sh376f) : $signed(_GEN_1098); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1100 = 10'h4a == lutAddr ? $signed(16'sh3824) : $signed(_GEN_1099); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1101 = 10'h4b == lutAddr ? $signed(16'sh38d8) : $signed(_GEN_1100); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1102 = 10'h4c == lutAddr ? $signed(16'sh398c) : $signed(_GEN_1101); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1103 = 10'h4d == lutAddr ? $signed(16'sh3a3f) : $signed(_GEN_1102); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1104 = 10'h4e == lutAddr ? $signed(16'sh3af2) : $signed(_GEN_1103); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1105 = 10'h4f == lutAddr ? $signed(16'sh3ba4) : $signed(_GEN_1104); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1106 = 10'h50 == lutAddr ? $signed(16'sh3c56) : $signed(_GEN_1105); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1107 = 10'h51 == lutAddr ? $signed(16'sh3d07) : $signed(_GEN_1106); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1108 = 10'h52 == lutAddr ? $signed(16'sh3db7) : $signed(_GEN_1107); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1109 = 10'h53 == lutAddr ? $signed(16'sh3e67) : $signed(_GEN_1108); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1110 = 10'h54 == lutAddr ? $signed(16'sh3f16) : $signed(_GEN_1109); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1111 = 10'h55 == lutAddr ? $signed(16'sh3fc5) : $signed(_GEN_1110); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1112 = 10'h56 == lutAddr ? $signed(16'sh4073) : $signed(_GEN_1111); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1113 = 10'h57 == lutAddr ? $signed(16'sh4120) : $signed(_GEN_1112); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1114 = 10'h58 == lutAddr ? $signed(16'sh41cd) : $signed(_GEN_1113); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1115 = 10'h59 == lutAddr ? $signed(16'sh4279) : $signed(_GEN_1114); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1116 = 10'h5a == lutAddr ? $signed(16'sh4325) : $signed(_GEN_1115); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1117 = 10'h5b == lutAddr ? $signed(16'sh43d0) : $signed(_GEN_1116); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1118 = 10'h5c == lutAddr ? $signed(16'sh447a) : $signed(_GEN_1117); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1119 = 10'h5d == lutAddr ? $signed(16'sh4523) : $signed(_GEN_1118); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1120 = 10'h5e == lutAddr ? $signed(16'sh45cc) : $signed(_GEN_1119); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1121 = 10'h5f == lutAddr ? $signed(16'sh4674) : $signed(_GEN_1120); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1122 = 10'h60 == lutAddr ? $signed(16'sh471c) : $signed(_GEN_1121); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1123 = 10'h61 == lutAddr ? $signed(16'sh47c3) : $signed(_GEN_1122); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1124 = 10'h62 == lutAddr ? $signed(16'sh4869) : $signed(_GEN_1123); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1125 = 10'h63 == lutAddr ? $signed(16'sh490e) : $signed(_GEN_1124); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1126 = 10'h64 == lutAddr ? $signed(16'sh49b3) : $signed(_GEN_1125); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1127 = 10'h65 == lutAddr ? $signed(16'sh4a57) : $signed(_GEN_1126); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1128 = 10'h66 == lutAddr ? $signed(16'sh4afa) : $signed(_GEN_1127); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1129 = 10'h67 == lutAddr ? $signed(16'sh4b9d) : $signed(_GEN_1128); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1130 = 10'h68 == lutAddr ? $signed(16'sh4c3f) : $signed(_GEN_1129); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1131 = 10'h69 == lutAddr ? $signed(16'sh4ce0) : $signed(_GEN_1130); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1132 = 10'h6a == lutAddr ? $signed(16'sh4d80) : $signed(_GEN_1131); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1133 = 10'h6b == lutAddr ? $signed(16'sh4e20) : $signed(_GEN_1132); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1134 = 10'h6c == lutAddr ? $signed(16'sh4ebf) : $signed(_GEN_1133); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1135 = 10'h6d == lutAddr ? $signed(16'sh4f5d) : $signed(_GEN_1134); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1136 = 10'h6e == lutAddr ? $signed(16'sh4ffa) : $signed(_GEN_1135); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1137 = 10'h6f == lutAddr ? $signed(16'sh5097) : $signed(_GEN_1136); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1138 = 10'h70 == lutAddr ? $signed(16'sh5133) : $signed(_GEN_1137); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1139 = 10'h71 == lutAddr ? $signed(16'sh51ce) : $signed(_GEN_1138); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1140 = 10'h72 == lutAddr ? $signed(16'sh5268) : $signed(_GEN_1139); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1141 = 10'h73 == lutAddr ? $signed(16'sh5301) : $signed(_GEN_1140); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1142 = 10'h74 == lutAddr ? $signed(16'sh539a) : $signed(_GEN_1141); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1143 = 10'h75 == lutAddr ? $signed(16'sh5432) : $signed(_GEN_1142); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1144 = 10'h76 == lutAddr ? $signed(16'sh54c9) : $signed(_GEN_1143); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1145 = 10'h77 == lutAddr ? $signed(16'sh555f) : $signed(_GEN_1144); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1146 = 10'h78 == lutAddr ? $signed(16'sh55f4) : $signed(_GEN_1145); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1147 = 10'h79 == lutAddr ? $signed(16'sh5689) : $signed(_GEN_1146); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1148 = 10'h7a == lutAddr ? $signed(16'sh571d) : $signed(_GEN_1147); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1149 = 10'h7b == lutAddr ? $signed(16'sh57b0) : $signed(_GEN_1148); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1150 = 10'h7c == lutAddr ? $signed(16'sh5842) : $signed(_GEN_1149); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1151 = 10'h7d == lutAddr ? $signed(16'sh58d3) : $signed(_GEN_1150); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1152 = 10'h7e == lutAddr ? $signed(16'sh5963) : $signed(_GEN_1151); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1153 = 10'h7f == lutAddr ? $signed(16'sh59f3) : $signed(_GEN_1152); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1154 = 10'h80 == lutAddr ? $signed(16'sh5a81) : $signed(_GEN_1153); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1155 = 10'h81 == lutAddr ? $signed(16'sh5b0f) : $signed(_GEN_1154); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1156 = 10'h82 == lutAddr ? $signed(16'sh5b9c) : $signed(_GEN_1155); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1157 = 10'h83 == lutAddr ? $signed(16'sh5c28) : $signed(_GEN_1156); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1158 = 10'h84 == lutAddr ? $signed(16'sh5cb3) : $signed(_GEN_1157); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1159 = 10'h85 == lutAddr ? $signed(16'sh5d3d) : $signed(_GEN_1158); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1160 = 10'h86 == lutAddr ? $signed(16'sh5dc6) : $signed(_GEN_1159); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1161 = 10'h87 == lutAddr ? $signed(16'sh5e4f) : $signed(_GEN_1160); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1162 = 10'h88 == lutAddr ? $signed(16'sh5ed6) : $signed(_GEN_1161); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1163 = 10'h89 == lutAddr ? $signed(16'sh5f5d) : $signed(_GEN_1162); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1164 = 10'h8a == lutAddr ? $signed(16'sh5fe2) : $signed(_GEN_1163); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1165 = 10'h8b == lutAddr ? $signed(16'sh6067) : $signed(_GEN_1164); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1166 = 10'h8c == lutAddr ? $signed(16'sh60eb) : $signed(_GEN_1165); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1167 = 10'h8d == lutAddr ? $signed(16'sh616e) : $signed(_GEN_1166); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1168 = 10'h8e == lutAddr ? $signed(16'sh61f0) : $signed(_GEN_1167); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1169 = 10'h8f == lutAddr ? $signed(16'sh6271) : $signed(_GEN_1168); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1170 = 10'h90 == lutAddr ? $signed(16'sh62f1) : $signed(_GEN_1169); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1171 = 10'h91 == lutAddr ? $signed(16'sh6370) : $signed(_GEN_1170); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1172 = 10'h92 == lutAddr ? $signed(16'sh63ee) : $signed(_GEN_1171); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1173 = 10'h93 == lutAddr ? $signed(16'sh646b) : $signed(_GEN_1172); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1174 = 10'h94 == lutAddr ? $signed(16'sh64e7) : $signed(_GEN_1173); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1175 = 10'h95 == lutAddr ? $signed(16'sh6562) : $signed(_GEN_1174); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1176 = 10'h96 == lutAddr ? $signed(16'sh65dd) : $signed(_GEN_1175); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1177 = 10'h97 == lutAddr ? $signed(16'sh6656) : $signed(_GEN_1176); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1178 = 10'h98 == lutAddr ? $signed(16'sh66ce) : $signed(_GEN_1177); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1179 = 10'h99 == lutAddr ? $signed(16'sh6745) : $signed(_GEN_1178); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1180 = 10'h9a == lutAddr ? $signed(16'sh67bc) : $signed(_GEN_1179); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1181 = 10'h9b == lutAddr ? $signed(16'sh6831) : $signed(_GEN_1180); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1182 = 10'h9c == lutAddr ? $signed(16'sh68a5) : $signed(_GEN_1181); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1183 = 10'h9d == lutAddr ? $signed(16'sh6919) : $signed(_GEN_1182); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1184 = 10'h9e == lutAddr ? $signed(16'sh698b) : $signed(_GEN_1183); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1185 = 10'h9f == lutAddr ? $signed(16'sh69fc) : $signed(_GEN_1184); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1186 = 10'ha0 == lutAddr ? $signed(16'sh6a6c) : $signed(_GEN_1185); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1187 = 10'ha1 == lutAddr ? $signed(16'sh6adb) : $signed(_GEN_1186); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1188 = 10'ha2 == lutAddr ? $signed(16'sh6b4a) : $signed(_GEN_1187); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1189 = 10'ha3 == lutAddr ? $signed(16'sh6bb7) : $signed(_GEN_1188); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1190 = 10'ha4 == lutAddr ? $signed(16'sh6c23) : $signed(_GEN_1189); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1191 = 10'ha5 == lutAddr ? $signed(16'sh6c8e) : $signed(_GEN_1190); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1192 = 10'ha6 == lutAddr ? $signed(16'sh6cf8) : $signed(_GEN_1191); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1193 = 10'ha7 == lutAddr ? $signed(16'sh6d61) : $signed(_GEN_1192); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1194 = 10'ha8 == lutAddr ? $signed(16'sh6dc9) : $signed(_GEN_1193); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1195 = 10'ha9 == lutAddr ? $signed(16'sh6e30) : $signed(_GEN_1194); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1196 = 10'haa == lutAddr ? $signed(16'sh6e95) : $signed(_GEN_1195); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1197 = 10'hab == lutAddr ? $signed(16'sh6efa) : $signed(_GEN_1196); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1198 = 10'hac == lutAddr ? $signed(16'sh6f5e) : $signed(_GEN_1197); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1199 = 10'had == lutAddr ? $signed(16'sh6fc0) : $signed(_GEN_1198); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1200 = 10'hae == lutAddr ? $signed(16'sh7022) : $signed(_GEN_1199); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1201 = 10'haf == lutAddr ? $signed(16'sh7082) : $signed(_GEN_1200); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1202 = 10'hb0 == lutAddr ? $signed(16'sh70e1) : $signed(_GEN_1201); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1203 = 10'hb1 == lutAddr ? $signed(16'sh7140) : $signed(_GEN_1202); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1204 = 10'hb2 == lutAddr ? $signed(16'sh719d) : $signed(_GEN_1203); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1205 = 10'hb3 == lutAddr ? $signed(16'sh71f9) : $signed(_GEN_1204); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1206 = 10'hb4 == lutAddr ? $signed(16'sh7254) : $signed(_GEN_1205); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1207 = 10'hb5 == lutAddr ? $signed(16'sh72ae) : $signed(_GEN_1206); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1208 = 10'hb6 == lutAddr ? $signed(16'sh7306) : $signed(_GEN_1207); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1209 = 10'hb7 == lutAddr ? $signed(16'sh735e) : $signed(_GEN_1208); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1210 = 10'hb8 == lutAddr ? $signed(16'sh73b5) : $signed(_GEN_1209); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1211 = 10'hb9 == lutAddr ? $signed(16'sh740a) : $signed(_GEN_1210); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1212 = 10'hba == lutAddr ? $signed(16'sh745e) : $signed(_GEN_1211); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1213 = 10'hbb == lutAddr ? $signed(16'sh74b1) : $signed(_GEN_1212); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1214 = 10'hbc == lutAddr ? $signed(16'sh7503) : $signed(_GEN_1213); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1215 = 10'hbd == lutAddr ? $signed(16'sh7554) : $signed(_GEN_1214); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1216 = 10'hbe == lutAddr ? $signed(16'sh75a4) : $signed(_GEN_1215); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1217 = 10'hbf == lutAddr ? $signed(16'sh75f3) : $signed(_GEN_1216); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1218 = 10'hc0 == lutAddr ? $signed(16'sh7640) : $signed(_GEN_1217); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1219 = 10'hc1 == lutAddr ? $signed(16'sh768d) : $signed(_GEN_1218); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1220 = 10'hc2 == lutAddr ? $signed(16'sh76d8) : $signed(_GEN_1219); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1221 = 10'hc3 == lutAddr ? $signed(16'sh7722) : $signed(_GEN_1220); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1222 = 10'hc4 == lutAddr ? $signed(16'sh776b) : $signed(_GEN_1221); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1223 = 10'hc5 == lutAddr ? $signed(16'sh77b3) : $signed(_GEN_1222); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1224 = 10'hc6 == lutAddr ? $signed(16'sh77f9) : $signed(_GEN_1223); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1225 = 10'hc7 == lutAddr ? $signed(16'sh783f) : $signed(_GEN_1224); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1226 = 10'hc8 == lutAddr ? $signed(16'sh7883) : $signed(_GEN_1225); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1227 = 10'hc9 == lutAddr ? $signed(16'sh78c6) : $signed(_GEN_1226); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1228 = 10'hca == lutAddr ? $signed(16'sh7908) : $signed(_GEN_1227); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1229 = 10'hcb == lutAddr ? $signed(16'sh7949) : $signed(_GEN_1228); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1230 = 10'hcc == lutAddr ? $signed(16'sh7989) : $signed(_GEN_1229); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1231 = 10'hcd == lutAddr ? $signed(16'sh79c7) : $signed(_GEN_1230); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1232 = 10'hce == lutAddr ? $signed(16'sh7a04) : $signed(_GEN_1231); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1233 = 10'hcf == lutAddr ? $signed(16'sh7a41) : $signed(_GEN_1232); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1234 = 10'hd0 == lutAddr ? $signed(16'sh7a7c) : $signed(_GEN_1233); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1235 = 10'hd1 == lutAddr ? $signed(16'sh7ab5) : $signed(_GEN_1234); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1236 = 10'hd2 == lutAddr ? $signed(16'sh7aee) : $signed(_GEN_1235); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1237 = 10'hd3 == lutAddr ? $signed(16'sh7b25) : $signed(_GEN_1236); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1238 = 10'hd4 == lutAddr ? $signed(16'sh7b5c) : $signed(_GEN_1237); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1239 = 10'hd5 == lutAddr ? $signed(16'sh7b91) : $signed(_GEN_1238); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1240 = 10'hd6 == lutAddr ? $signed(16'sh7bc4) : $signed(_GEN_1239); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1241 = 10'hd7 == lutAddr ? $signed(16'sh7bf7) : $signed(_GEN_1240); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1242 = 10'hd8 == lutAddr ? $signed(16'sh7c29) : $signed(_GEN_1241); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1243 = 10'hd9 == lutAddr ? $signed(16'sh7c59) : $signed(_GEN_1242); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1244 = 10'hda == lutAddr ? $signed(16'sh7c88) : $signed(_GEN_1243); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1245 = 10'hdb == lutAddr ? $signed(16'sh7cb6) : $signed(_GEN_1244); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1246 = 10'hdc == lutAddr ? $signed(16'sh7ce2) : $signed(_GEN_1245); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1247 = 10'hdd == lutAddr ? $signed(16'sh7d0e) : $signed(_GEN_1246); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1248 = 10'hde == lutAddr ? $signed(16'sh7d38) : $signed(_GEN_1247); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1249 = 10'hdf == lutAddr ? $signed(16'sh7d61) : $signed(_GEN_1248); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1250 = 10'he0 == lutAddr ? $signed(16'sh7d89) : $signed(_GEN_1249); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1251 = 10'he1 == lutAddr ? $signed(16'sh7db0) : $signed(_GEN_1250); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1252 = 10'he2 == lutAddr ? $signed(16'sh7dd5) : $signed(_GEN_1251); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1253 = 10'he3 == lutAddr ? $signed(16'sh7df9) : $signed(_GEN_1252); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1254 = 10'he4 == lutAddr ? $signed(16'sh7e1c) : $signed(_GEN_1253); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1255 = 10'he5 == lutAddr ? $signed(16'sh7e3e) : $signed(_GEN_1254); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1256 = 10'he6 == lutAddr ? $signed(16'sh7e5e) : $signed(_GEN_1255); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1257 = 10'he7 == lutAddr ? $signed(16'sh7e7e) : $signed(_GEN_1256); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1258 = 10'he8 == lutAddr ? $signed(16'sh7e9c) : $signed(_GEN_1257); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1259 = 10'he9 == lutAddr ? $signed(16'sh7eb9) : $signed(_GEN_1258); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1260 = 10'hea == lutAddr ? $signed(16'sh7ed4) : $signed(_GEN_1259); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1261 = 10'heb == lutAddr ? $signed(16'sh7eef) : $signed(_GEN_1260); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1262 = 10'hec == lutAddr ? $signed(16'sh7f08) : $signed(_GEN_1261); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1263 = 10'hed == lutAddr ? $signed(16'sh7f20) : $signed(_GEN_1262); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1264 = 10'hee == lutAddr ? $signed(16'sh7f37) : $signed(_GEN_1263); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1265 = 10'hef == lutAddr ? $signed(16'sh7f4c) : $signed(_GEN_1264); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1266 = 10'hf0 == lutAddr ? $signed(16'sh7f61) : $signed(_GEN_1265); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1267 = 10'hf1 == lutAddr ? $signed(16'sh7f74) : $signed(_GEN_1266); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1268 = 10'hf2 == lutAddr ? $signed(16'sh7f86) : $signed(_GEN_1267); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1269 = 10'hf3 == lutAddr ? $signed(16'sh7f96) : $signed(_GEN_1268); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1270 = 10'hf4 == lutAddr ? $signed(16'sh7fa6) : $signed(_GEN_1269); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1271 = 10'hf5 == lutAddr ? $signed(16'sh7fb4) : $signed(_GEN_1270); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1272 = 10'hf6 == lutAddr ? $signed(16'sh7fc1) : $signed(_GEN_1271); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1273 = 10'hf7 == lutAddr ? $signed(16'sh7fcd) : $signed(_GEN_1272); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1274 = 10'hf8 == lutAddr ? $signed(16'sh7fd7) : $signed(_GEN_1273); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1275 = 10'hf9 == lutAddr ? $signed(16'sh7fe0) : $signed(_GEN_1274); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1276 = 10'hfa == lutAddr ? $signed(16'sh7fe8) : $signed(_GEN_1275); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1277 = 10'hfb == lutAddr ? $signed(16'sh7fef) : $signed(_GEN_1276); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1278 = 10'hfc == lutAddr ? $signed(16'sh7ff5) : $signed(_GEN_1277); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1279 = 10'hfd == lutAddr ? $signed(16'sh7ff9) : $signed(_GEN_1278); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1280 = 10'hfe == lutAddr ? $signed(16'sh7ffc) : $signed(_GEN_1279); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1281 = 10'hff == lutAddr ? $signed(16'sh7ffe) : $signed(_GEN_1280); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1282 = 10'h100 == lutAddr ? $signed(16'sh7fff) : $signed(_GEN_1281); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1283 = 10'h101 == lutAddr ? $signed(16'sh7ffe) : $signed(_GEN_1282); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1284 = 10'h102 == lutAddr ? $signed(16'sh7ffc) : $signed(_GEN_1283); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1285 = 10'h103 == lutAddr ? $signed(16'sh7ff9) : $signed(_GEN_1284); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1286 = 10'h104 == lutAddr ? $signed(16'sh7ff5) : $signed(_GEN_1285); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1287 = 10'h105 == lutAddr ? $signed(16'sh7fef) : $signed(_GEN_1286); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1288 = 10'h106 == lutAddr ? $signed(16'sh7fe8) : $signed(_GEN_1287); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1289 = 10'h107 == lutAddr ? $signed(16'sh7fe0) : $signed(_GEN_1288); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1290 = 10'h108 == lutAddr ? $signed(16'sh7fd7) : $signed(_GEN_1289); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1291 = 10'h109 == lutAddr ? $signed(16'sh7fcd) : $signed(_GEN_1290); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1292 = 10'h10a == lutAddr ? $signed(16'sh7fc1) : $signed(_GEN_1291); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1293 = 10'h10b == lutAddr ? $signed(16'sh7fb4) : $signed(_GEN_1292); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1294 = 10'h10c == lutAddr ? $signed(16'sh7fa6) : $signed(_GEN_1293); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1295 = 10'h10d == lutAddr ? $signed(16'sh7f96) : $signed(_GEN_1294); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1296 = 10'h10e == lutAddr ? $signed(16'sh7f86) : $signed(_GEN_1295); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1297 = 10'h10f == lutAddr ? $signed(16'sh7f74) : $signed(_GEN_1296); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1298 = 10'h110 == lutAddr ? $signed(16'sh7f61) : $signed(_GEN_1297); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1299 = 10'h111 == lutAddr ? $signed(16'sh7f4c) : $signed(_GEN_1298); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1300 = 10'h112 == lutAddr ? $signed(16'sh7f37) : $signed(_GEN_1299); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1301 = 10'h113 == lutAddr ? $signed(16'sh7f20) : $signed(_GEN_1300); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1302 = 10'h114 == lutAddr ? $signed(16'sh7f08) : $signed(_GEN_1301); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1303 = 10'h115 == lutAddr ? $signed(16'sh7eef) : $signed(_GEN_1302); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1304 = 10'h116 == lutAddr ? $signed(16'sh7ed4) : $signed(_GEN_1303); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1305 = 10'h117 == lutAddr ? $signed(16'sh7eb9) : $signed(_GEN_1304); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1306 = 10'h118 == lutAddr ? $signed(16'sh7e9c) : $signed(_GEN_1305); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1307 = 10'h119 == lutAddr ? $signed(16'sh7e7e) : $signed(_GEN_1306); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1308 = 10'h11a == lutAddr ? $signed(16'sh7e5e) : $signed(_GEN_1307); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1309 = 10'h11b == lutAddr ? $signed(16'sh7e3e) : $signed(_GEN_1308); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1310 = 10'h11c == lutAddr ? $signed(16'sh7e1c) : $signed(_GEN_1309); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1311 = 10'h11d == lutAddr ? $signed(16'sh7df9) : $signed(_GEN_1310); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1312 = 10'h11e == lutAddr ? $signed(16'sh7dd5) : $signed(_GEN_1311); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1313 = 10'h11f == lutAddr ? $signed(16'sh7db0) : $signed(_GEN_1312); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1314 = 10'h120 == lutAddr ? $signed(16'sh7d89) : $signed(_GEN_1313); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1315 = 10'h121 == lutAddr ? $signed(16'sh7d61) : $signed(_GEN_1314); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1316 = 10'h122 == lutAddr ? $signed(16'sh7d38) : $signed(_GEN_1315); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1317 = 10'h123 == lutAddr ? $signed(16'sh7d0e) : $signed(_GEN_1316); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1318 = 10'h124 == lutAddr ? $signed(16'sh7ce2) : $signed(_GEN_1317); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1319 = 10'h125 == lutAddr ? $signed(16'sh7cb6) : $signed(_GEN_1318); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1320 = 10'h126 == lutAddr ? $signed(16'sh7c88) : $signed(_GEN_1319); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1321 = 10'h127 == lutAddr ? $signed(16'sh7c59) : $signed(_GEN_1320); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1322 = 10'h128 == lutAddr ? $signed(16'sh7c29) : $signed(_GEN_1321); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1323 = 10'h129 == lutAddr ? $signed(16'sh7bf7) : $signed(_GEN_1322); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1324 = 10'h12a == lutAddr ? $signed(16'sh7bc4) : $signed(_GEN_1323); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1325 = 10'h12b == lutAddr ? $signed(16'sh7b91) : $signed(_GEN_1324); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1326 = 10'h12c == lutAddr ? $signed(16'sh7b5c) : $signed(_GEN_1325); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1327 = 10'h12d == lutAddr ? $signed(16'sh7b25) : $signed(_GEN_1326); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1328 = 10'h12e == lutAddr ? $signed(16'sh7aee) : $signed(_GEN_1327); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1329 = 10'h12f == lutAddr ? $signed(16'sh7ab5) : $signed(_GEN_1328); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1330 = 10'h130 == lutAddr ? $signed(16'sh7a7c) : $signed(_GEN_1329); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1331 = 10'h131 == lutAddr ? $signed(16'sh7a41) : $signed(_GEN_1330); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1332 = 10'h132 == lutAddr ? $signed(16'sh7a04) : $signed(_GEN_1331); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1333 = 10'h133 == lutAddr ? $signed(16'sh79c7) : $signed(_GEN_1332); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1334 = 10'h134 == lutAddr ? $signed(16'sh7989) : $signed(_GEN_1333); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1335 = 10'h135 == lutAddr ? $signed(16'sh7949) : $signed(_GEN_1334); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1336 = 10'h136 == lutAddr ? $signed(16'sh7908) : $signed(_GEN_1335); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1337 = 10'h137 == lutAddr ? $signed(16'sh78c6) : $signed(_GEN_1336); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1338 = 10'h138 == lutAddr ? $signed(16'sh7883) : $signed(_GEN_1337); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1339 = 10'h139 == lutAddr ? $signed(16'sh783f) : $signed(_GEN_1338); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1340 = 10'h13a == lutAddr ? $signed(16'sh77f9) : $signed(_GEN_1339); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1341 = 10'h13b == lutAddr ? $signed(16'sh77b3) : $signed(_GEN_1340); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1342 = 10'h13c == lutAddr ? $signed(16'sh776b) : $signed(_GEN_1341); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1343 = 10'h13d == lutAddr ? $signed(16'sh7722) : $signed(_GEN_1342); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1344 = 10'h13e == lutAddr ? $signed(16'sh76d8) : $signed(_GEN_1343); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1345 = 10'h13f == lutAddr ? $signed(16'sh768d) : $signed(_GEN_1344); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1346 = 10'h140 == lutAddr ? $signed(16'sh7640) : $signed(_GEN_1345); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1347 = 10'h141 == lutAddr ? $signed(16'sh75f3) : $signed(_GEN_1346); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1348 = 10'h142 == lutAddr ? $signed(16'sh75a4) : $signed(_GEN_1347); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1349 = 10'h143 == lutAddr ? $signed(16'sh7554) : $signed(_GEN_1348); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1350 = 10'h144 == lutAddr ? $signed(16'sh7503) : $signed(_GEN_1349); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1351 = 10'h145 == lutAddr ? $signed(16'sh74b1) : $signed(_GEN_1350); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1352 = 10'h146 == lutAddr ? $signed(16'sh745e) : $signed(_GEN_1351); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1353 = 10'h147 == lutAddr ? $signed(16'sh740a) : $signed(_GEN_1352); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1354 = 10'h148 == lutAddr ? $signed(16'sh73b5) : $signed(_GEN_1353); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1355 = 10'h149 == lutAddr ? $signed(16'sh735e) : $signed(_GEN_1354); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1356 = 10'h14a == lutAddr ? $signed(16'sh7306) : $signed(_GEN_1355); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1357 = 10'h14b == lutAddr ? $signed(16'sh72ae) : $signed(_GEN_1356); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1358 = 10'h14c == lutAddr ? $signed(16'sh7254) : $signed(_GEN_1357); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1359 = 10'h14d == lutAddr ? $signed(16'sh71f9) : $signed(_GEN_1358); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1360 = 10'h14e == lutAddr ? $signed(16'sh719d) : $signed(_GEN_1359); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1361 = 10'h14f == lutAddr ? $signed(16'sh7140) : $signed(_GEN_1360); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1362 = 10'h150 == lutAddr ? $signed(16'sh70e1) : $signed(_GEN_1361); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1363 = 10'h151 == lutAddr ? $signed(16'sh7082) : $signed(_GEN_1362); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1364 = 10'h152 == lutAddr ? $signed(16'sh7022) : $signed(_GEN_1363); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1365 = 10'h153 == lutAddr ? $signed(16'sh6fc0) : $signed(_GEN_1364); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1366 = 10'h154 == lutAddr ? $signed(16'sh6f5e) : $signed(_GEN_1365); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1367 = 10'h155 == lutAddr ? $signed(16'sh6efa) : $signed(_GEN_1366); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1368 = 10'h156 == lutAddr ? $signed(16'sh6e95) : $signed(_GEN_1367); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1369 = 10'h157 == lutAddr ? $signed(16'sh6e30) : $signed(_GEN_1368); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1370 = 10'h158 == lutAddr ? $signed(16'sh6dc9) : $signed(_GEN_1369); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1371 = 10'h159 == lutAddr ? $signed(16'sh6d61) : $signed(_GEN_1370); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1372 = 10'h15a == lutAddr ? $signed(16'sh6cf8) : $signed(_GEN_1371); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1373 = 10'h15b == lutAddr ? $signed(16'sh6c8e) : $signed(_GEN_1372); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1374 = 10'h15c == lutAddr ? $signed(16'sh6c23) : $signed(_GEN_1373); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1375 = 10'h15d == lutAddr ? $signed(16'sh6bb7) : $signed(_GEN_1374); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1376 = 10'h15e == lutAddr ? $signed(16'sh6b4a) : $signed(_GEN_1375); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1377 = 10'h15f == lutAddr ? $signed(16'sh6adb) : $signed(_GEN_1376); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1378 = 10'h160 == lutAddr ? $signed(16'sh6a6c) : $signed(_GEN_1377); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1379 = 10'h161 == lutAddr ? $signed(16'sh69fc) : $signed(_GEN_1378); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1380 = 10'h162 == lutAddr ? $signed(16'sh698b) : $signed(_GEN_1379); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1381 = 10'h163 == lutAddr ? $signed(16'sh6919) : $signed(_GEN_1380); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1382 = 10'h164 == lutAddr ? $signed(16'sh68a5) : $signed(_GEN_1381); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1383 = 10'h165 == lutAddr ? $signed(16'sh6831) : $signed(_GEN_1382); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1384 = 10'h166 == lutAddr ? $signed(16'sh67bc) : $signed(_GEN_1383); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1385 = 10'h167 == lutAddr ? $signed(16'sh6745) : $signed(_GEN_1384); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1386 = 10'h168 == lutAddr ? $signed(16'sh66ce) : $signed(_GEN_1385); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1387 = 10'h169 == lutAddr ? $signed(16'sh6656) : $signed(_GEN_1386); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1388 = 10'h16a == lutAddr ? $signed(16'sh65dd) : $signed(_GEN_1387); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1389 = 10'h16b == lutAddr ? $signed(16'sh6562) : $signed(_GEN_1388); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1390 = 10'h16c == lutAddr ? $signed(16'sh64e7) : $signed(_GEN_1389); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1391 = 10'h16d == lutAddr ? $signed(16'sh646b) : $signed(_GEN_1390); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1392 = 10'h16e == lutAddr ? $signed(16'sh63ee) : $signed(_GEN_1391); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1393 = 10'h16f == lutAddr ? $signed(16'sh6370) : $signed(_GEN_1392); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1394 = 10'h170 == lutAddr ? $signed(16'sh62f1) : $signed(_GEN_1393); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1395 = 10'h171 == lutAddr ? $signed(16'sh6271) : $signed(_GEN_1394); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1396 = 10'h172 == lutAddr ? $signed(16'sh61f0) : $signed(_GEN_1395); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1397 = 10'h173 == lutAddr ? $signed(16'sh616e) : $signed(_GEN_1396); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1398 = 10'h174 == lutAddr ? $signed(16'sh60eb) : $signed(_GEN_1397); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1399 = 10'h175 == lutAddr ? $signed(16'sh6067) : $signed(_GEN_1398); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1400 = 10'h176 == lutAddr ? $signed(16'sh5fe2) : $signed(_GEN_1399); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1401 = 10'h177 == lutAddr ? $signed(16'sh5f5d) : $signed(_GEN_1400); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1402 = 10'h178 == lutAddr ? $signed(16'sh5ed6) : $signed(_GEN_1401); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1403 = 10'h179 == lutAddr ? $signed(16'sh5e4f) : $signed(_GEN_1402); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1404 = 10'h17a == lutAddr ? $signed(16'sh5dc6) : $signed(_GEN_1403); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1405 = 10'h17b == lutAddr ? $signed(16'sh5d3d) : $signed(_GEN_1404); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1406 = 10'h17c == lutAddr ? $signed(16'sh5cb3) : $signed(_GEN_1405); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1407 = 10'h17d == lutAddr ? $signed(16'sh5c28) : $signed(_GEN_1406); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1408 = 10'h17e == lutAddr ? $signed(16'sh5b9c) : $signed(_GEN_1407); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1409 = 10'h17f == lutAddr ? $signed(16'sh5b0f) : $signed(_GEN_1408); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1410 = 10'h180 == lutAddr ? $signed(16'sh5a81) : $signed(_GEN_1409); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1411 = 10'h181 == lutAddr ? $signed(16'sh59f3) : $signed(_GEN_1410); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1412 = 10'h182 == lutAddr ? $signed(16'sh5963) : $signed(_GEN_1411); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1413 = 10'h183 == lutAddr ? $signed(16'sh58d3) : $signed(_GEN_1412); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1414 = 10'h184 == lutAddr ? $signed(16'sh5842) : $signed(_GEN_1413); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1415 = 10'h185 == lutAddr ? $signed(16'sh57b0) : $signed(_GEN_1414); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1416 = 10'h186 == lutAddr ? $signed(16'sh571d) : $signed(_GEN_1415); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1417 = 10'h187 == lutAddr ? $signed(16'sh5689) : $signed(_GEN_1416); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1418 = 10'h188 == lutAddr ? $signed(16'sh55f4) : $signed(_GEN_1417); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1419 = 10'h189 == lutAddr ? $signed(16'sh555f) : $signed(_GEN_1418); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1420 = 10'h18a == lutAddr ? $signed(16'sh54c9) : $signed(_GEN_1419); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1421 = 10'h18b == lutAddr ? $signed(16'sh5432) : $signed(_GEN_1420); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1422 = 10'h18c == lutAddr ? $signed(16'sh539a) : $signed(_GEN_1421); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1423 = 10'h18d == lutAddr ? $signed(16'sh5301) : $signed(_GEN_1422); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1424 = 10'h18e == lutAddr ? $signed(16'sh5268) : $signed(_GEN_1423); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1425 = 10'h18f == lutAddr ? $signed(16'sh51ce) : $signed(_GEN_1424); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1426 = 10'h190 == lutAddr ? $signed(16'sh5133) : $signed(_GEN_1425); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1427 = 10'h191 == lutAddr ? $signed(16'sh5097) : $signed(_GEN_1426); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1428 = 10'h192 == lutAddr ? $signed(16'sh4ffa) : $signed(_GEN_1427); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1429 = 10'h193 == lutAddr ? $signed(16'sh4f5d) : $signed(_GEN_1428); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1430 = 10'h194 == lutAddr ? $signed(16'sh4ebf) : $signed(_GEN_1429); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1431 = 10'h195 == lutAddr ? $signed(16'sh4e20) : $signed(_GEN_1430); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1432 = 10'h196 == lutAddr ? $signed(16'sh4d80) : $signed(_GEN_1431); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1433 = 10'h197 == lutAddr ? $signed(16'sh4ce0) : $signed(_GEN_1432); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1434 = 10'h198 == lutAddr ? $signed(16'sh4c3f) : $signed(_GEN_1433); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1435 = 10'h199 == lutAddr ? $signed(16'sh4b9d) : $signed(_GEN_1434); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1436 = 10'h19a == lutAddr ? $signed(16'sh4afa) : $signed(_GEN_1435); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1437 = 10'h19b == lutAddr ? $signed(16'sh4a57) : $signed(_GEN_1436); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1438 = 10'h19c == lutAddr ? $signed(16'sh49b3) : $signed(_GEN_1437); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1439 = 10'h19d == lutAddr ? $signed(16'sh490e) : $signed(_GEN_1438); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1440 = 10'h19e == lutAddr ? $signed(16'sh4869) : $signed(_GEN_1439); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1441 = 10'h19f == lutAddr ? $signed(16'sh47c3) : $signed(_GEN_1440); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1442 = 10'h1a0 == lutAddr ? $signed(16'sh471c) : $signed(_GEN_1441); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1443 = 10'h1a1 == lutAddr ? $signed(16'sh4674) : $signed(_GEN_1442); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1444 = 10'h1a2 == lutAddr ? $signed(16'sh45cc) : $signed(_GEN_1443); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1445 = 10'h1a3 == lutAddr ? $signed(16'sh4523) : $signed(_GEN_1444); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1446 = 10'h1a4 == lutAddr ? $signed(16'sh447a) : $signed(_GEN_1445); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1447 = 10'h1a5 == lutAddr ? $signed(16'sh43d0) : $signed(_GEN_1446); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1448 = 10'h1a6 == lutAddr ? $signed(16'sh4325) : $signed(_GEN_1447); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1449 = 10'h1a7 == lutAddr ? $signed(16'sh4279) : $signed(_GEN_1448); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1450 = 10'h1a8 == lutAddr ? $signed(16'sh41cd) : $signed(_GEN_1449); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1451 = 10'h1a9 == lutAddr ? $signed(16'sh4120) : $signed(_GEN_1450); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1452 = 10'h1aa == lutAddr ? $signed(16'sh4073) : $signed(_GEN_1451); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1453 = 10'h1ab == lutAddr ? $signed(16'sh3fc5) : $signed(_GEN_1452); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1454 = 10'h1ac == lutAddr ? $signed(16'sh3f16) : $signed(_GEN_1453); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1455 = 10'h1ad == lutAddr ? $signed(16'sh3e67) : $signed(_GEN_1454); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1456 = 10'h1ae == lutAddr ? $signed(16'sh3db7) : $signed(_GEN_1455); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1457 = 10'h1af == lutAddr ? $signed(16'sh3d07) : $signed(_GEN_1456); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1458 = 10'h1b0 == lutAddr ? $signed(16'sh3c56) : $signed(_GEN_1457); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1459 = 10'h1b1 == lutAddr ? $signed(16'sh3ba4) : $signed(_GEN_1458); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1460 = 10'h1b2 == lutAddr ? $signed(16'sh3af2) : $signed(_GEN_1459); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1461 = 10'h1b3 == lutAddr ? $signed(16'sh3a3f) : $signed(_GEN_1460); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1462 = 10'h1b4 == lutAddr ? $signed(16'sh398c) : $signed(_GEN_1461); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1463 = 10'h1b5 == lutAddr ? $signed(16'sh38d8) : $signed(_GEN_1462); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1464 = 10'h1b6 == lutAddr ? $signed(16'sh3824) : $signed(_GEN_1463); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1465 = 10'h1b7 == lutAddr ? $signed(16'sh376f) : $signed(_GEN_1464); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1466 = 10'h1b8 == lutAddr ? $signed(16'sh36b9) : $signed(_GEN_1465); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1467 = 10'h1b9 == lutAddr ? $signed(16'sh3603) : $signed(_GEN_1466); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1468 = 10'h1ba == lutAddr ? $signed(16'sh354d) : $signed(_GEN_1467); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1469 = 10'h1bb == lutAddr ? $signed(16'sh3496) : $signed(_GEN_1468); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1470 = 10'h1bc == lutAddr ? $signed(16'sh33de) : $signed(_GEN_1469); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1471 = 10'h1bd == lutAddr ? $signed(16'sh3326) : $signed(_GEN_1470); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1472 = 10'h1be == lutAddr ? $signed(16'sh326d) : $signed(_GEN_1471); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1473 = 10'h1bf == lutAddr ? $signed(16'sh31b4) : $signed(_GEN_1472); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1474 = 10'h1c0 == lutAddr ? $signed(16'sh30fb) : $signed(_GEN_1473); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1475 = 10'h1c1 == lutAddr ? $signed(16'sh3041) : $signed(_GEN_1474); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1476 = 10'h1c2 == lutAddr ? $signed(16'sh2f86) : $signed(_GEN_1475); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1477 = 10'h1c3 == lutAddr ? $signed(16'sh2ecc) : $signed(_GEN_1476); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1478 = 10'h1c4 == lutAddr ? $signed(16'sh2e10) : $signed(_GEN_1477); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1479 = 10'h1c5 == lutAddr ? $signed(16'sh2d54) : $signed(_GEN_1478); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1480 = 10'h1c6 == lutAddr ? $signed(16'sh2c98) : $signed(_GEN_1479); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1481 = 10'h1c7 == lutAddr ? $signed(16'sh2bdb) : $signed(_GEN_1480); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1482 = 10'h1c8 == lutAddr ? $signed(16'sh2b1e) : $signed(_GEN_1481); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1483 = 10'h1c9 == lutAddr ? $signed(16'sh2a61) : $signed(_GEN_1482); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1484 = 10'h1ca == lutAddr ? $signed(16'sh29a3) : $signed(_GEN_1483); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1485 = 10'h1cb == lutAddr ? $signed(16'sh28e5) : $signed(_GEN_1484); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1486 = 10'h1cc == lutAddr ? $signed(16'sh2826) : $signed(_GEN_1485); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1487 = 10'h1cd == lutAddr ? $signed(16'sh2767) : $signed(_GEN_1486); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1488 = 10'h1ce == lutAddr ? $signed(16'sh26a7) : $signed(_GEN_1487); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1489 = 10'h1cf == lutAddr ? $signed(16'sh25e7) : $signed(_GEN_1488); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1490 = 10'h1d0 == lutAddr ? $signed(16'sh2527) : $signed(_GEN_1489); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1491 = 10'h1d1 == lutAddr ? $signed(16'sh2467) : $signed(_GEN_1490); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1492 = 10'h1d2 == lutAddr ? $signed(16'sh23a6) : $signed(_GEN_1491); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1493 = 10'h1d3 == lutAddr ? $signed(16'sh22e4) : $signed(_GEN_1492); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1494 = 10'h1d4 == lutAddr ? $signed(16'sh2223) : $signed(_GEN_1493); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1495 = 10'h1d5 == lutAddr ? $signed(16'sh2161) : $signed(_GEN_1494); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1496 = 10'h1d6 == lutAddr ? $signed(16'sh209f) : $signed(_GEN_1495); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1497 = 10'h1d7 == lutAddr ? $signed(16'sh1fdc) : $signed(_GEN_1496); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1498 = 10'h1d8 == lutAddr ? $signed(16'sh1f19) : $signed(_GEN_1497); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1499 = 10'h1d9 == lutAddr ? $signed(16'sh1e56) : $signed(_GEN_1498); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1500 = 10'h1da == lutAddr ? $signed(16'sh1d93) : $signed(_GEN_1499); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1501 = 10'h1db == lutAddr ? $signed(16'sh1ccf) : $signed(_GEN_1500); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1502 = 10'h1dc == lutAddr ? $signed(16'sh1c0b) : $signed(_GEN_1501); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1503 = 10'h1dd == lutAddr ? $signed(16'sh1b46) : $signed(_GEN_1502); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1504 = 10'h1de == lutAddr ? $signed(16'sh1a82) : $signed(_GEN_1503); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1505 = 10'h1df == lutAddr ? $signed(16'sh19bd) : $signed(_GEN_1504); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1506 = 10'h1e0 == lutAddr ? $signed(16'sh18f8) : $signed(_GEN_1505); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1507 = 10'h1e1 == lutAddr ? $signed(16'sh1833) : $signed(_GEN_1506); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1508 = 10'h1e2 == lutAddr ? $signed(16'sh176d) : $signed(_GEN_1507); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1509 = 10'h1e3 == lutAddr ? $signed(16'sh16a7) : $signed(_GEN_1508); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1510 = 10'h1e4 == lutAddr ? $signed(16'sh15e1) : $signed(_GEN_1509); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1511 = 10'h1e5 == lutAddr ? $signed(16'sh151b) : $signed(_GEN_1510); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1512 = 10'h1e6 == lutAddr ? $signed(16'sh1455) : $signed(_GEN_1511); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1513 = 10'h1e7 == lutAddr ? $signed(16'sh138e) : $signed(_GEN_1512); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1514 = 10'h1e8 == lutAddr ? $signed(16'sh12c7) : $signed(_GEN_1513); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1515 = 10'h1e9 == lutAddr ? $signed(16'sh1200) : $signed(_GEN_1514); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1516 = 10'h1ea == lutAddr ? $signed(16'sh1139) : $signed(_GEN_1515); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1517 = 10'h1eb == lutAddr ? $signed(16'sh1072) : $signed(_GEN_1516); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1518 = 10'h1ec == lutAddr ? $signed(16'shfab) : $signed(_GEN_1517); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1519 = 10'h1ed == lutAddr ? $signed(16'shee3) : $signed(_GEN_1518); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1520 = 10'h1ee == lutAddr ? $signed(16'she1b) : $signed(_GEN_1519); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1521 = 10'h1ef == lutAddr ? $signed(16'shd53) : $signed(_GEN_1520); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1522 = 10'h1f0 == lutAddr ? $signed(16'shc8b) : $signed(_GEN_1521); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1523 = 10'h1f1 == lutAddr ? $signed(16'shbc3) : $signed(_GEN_1522); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1524 = 10'h1f2 == lutAddr ? $signed(16'shafb) : $signed(_GEN_1523); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1525 = 10'h1f3 == lutAddr ? $signed(16'sha32) : $signed(_GEN_1524); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1526 = 10'h1f4 == lutAddr ? $signed(16'sh96a) : $signed(_GEN_1525); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1527 = 10'h1f5 == lutAddr ? $signed(16'sh8a1) : $signed(_GEN_1526); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1528 = 10'h1f6 == lutAddr ? $signed(16'sh7d9) : $signed(_GEN_1527); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1529 = 10'h1f7 == lutAddr ? $signed(16'sh710) : $signed(_GEN_1528); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1530 = 10'h1f8 == lutAddr ? $signed(16'sh647) : $signed(_GEN_1529); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1531 = 10'h1f9 == lutAddr ? $signed(16'sh57e) : $signed(_GEN_1530); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1532 = 10'h1fa == lutAddr ? $signed(16'sh4b6) : $signed(_GEN_1531); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1533 = 10'h1fb == lutAddr ? $signed(16'sh3ed) : $signed(_GEN_1532); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1534 = 10'h1fc == lutAddr ? $signed(16'sh324) : $signed(_GEN_1533); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1535 = 10'h1fd == lutAddr ? $signed(16'sh25b) : $signed(_GEN_1534); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1536 = 10'h1fe == lutAddr ? $signed(16'sh192) : $signed(_GEN_1535); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1537 = 10'h1ff == lutAddr ? $signed(16'shc9) : $signed(_GEN_1536); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1538 = 10'h200 == lutAddr ? $signed(16'sh0) : $signed(_GEN_1537); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1539 = 10'h201 == lutAddr ? $signed(-16'shc9) : $signed(_GEN_1538); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1540 = 10'h202 == lutAddr ? $signed(-16'sh192) : $signed(_GEN_1539); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1541 = 10'h203 == lutAddr ? $signed(-16'sh25b) : $signed(_GEN_1540); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1542 = 10'h204 == lutAddr ? $signed(-16'sh324) : $signed(_GEN_1541); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1543 = 10'h205 == lutAddr ? $signed(-16'sh3ed) : $signed(_GEN_1542); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1544 = 10'h206 == lutAddr ? $signed(-16'sh4b6) : $signed(_GEN_1543); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1545 = 10'h207 == lutAddr ? $signed(-16'sh57e) : $signed(_GEN_1544); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1546 = 10'h208 == lutAddr ? $signed(-16'sh647) : $signed(_GEN_1545); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1547 = 10'h209 == lutAddr ? $signed(-16'sh710) : $signed(_GEN_1546); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1548 = 10'h20a == lutAddr ? $signed(-16'sh7d9) : $signed(_GEN_1547); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1549 = 10'h20b == lutAddr ? $signed(-16'sh8a1) : $signed(_GEN_1548); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1550 = 10'h20c == lutAddr ? $signed(-16'sh96a) : $signed(_GEN_1549); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1551 = 10'h20d == lutAddr ? $signed(-16'sha32) : $signed(_GEN_1550); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1552 = 10'h20e == lutAddr ? $signed(-16'shafb) : $signed(_GEN_1551); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1553 = 10'h20f == lutAddr ? $signed(-16'shbc3) : $signed(_GEN_1552); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1554 = 10'h210 == lutAddr ? $signed(-16'shc8b) : $signed(_GEN_1553); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1555 = 10'h211 == lutAddr ? $signed(-16'shd53) : $signed(_GEN_1554); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1556 = 10'h212 == lutAddr ? $signed(-16'she1b) : $signed(_GEN_1555); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1557 = 10'h213 == lutAddr ? $signed(-16'shee3) : $signed(_GEN_1556); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1558 = 10'h214 == lutAddr ? $signed(-16'shfab) : $signed(_GEN_1557); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1559 = 10'h215 == lutAddr ? $signed(-16'sh1072) : $signed(_GEN_1558); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1560 = 10'h216 == lutAddr ? $signed(-16'sh1139) : $signed(_GEN_1559); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1561 = 10'h217 == lutAddr ? $signed(-16'sh1200) : $signed(_GEN_1560); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1562 = 10'h218 == lutAddr ? $signed(-16'sh12c7) : $signed(_GEN_1561); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1563 = 10'h219 == lutAddr ? $signed(-16'sh138e) : $signed(_GEN_1562); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1564 = 10'h21a == lutAddr ? $signed(-16'sh1455) : $signed(_GEN_1563); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1565 = 10'h21b == lutAddr ? $signed(-16'sh151b) : $signed(_GEN_1564); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1566 = 10'h21c == lutAddr ? $signed(-16'sh15e1) : $signed(_GEN_1565); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1567 = 10'h21d == lutAddr ? $signed(-16'sh16a7) : $signed(_GEN_1566); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1568 = 10'h21e == lutAddr ? $signed(-16'sh176d) : $signed(_GEN_1567); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1569 = 10'h21f == lutAddr ? $signed(-16'sh1833) : $signed(_GEN_1568); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1570 = 10'h220 == lutAddr ? $signed(-16'sh18f8) : $signed(_GEN_1569); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1571 = 10'h221 == lutAddr ? $signed(-16'sh19bd) : $signed(_GEN_1570); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1572 = 10'h222 == lutAddr ? $signed(-16'sh1a82) : $signed(_GEN_1571); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1573 = 10'h223 == lutAddr ? $signed(-16'sh1b46) : $signed(_GEN_1572); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1574 = 10'h224 == lutAddr ? $signed(-16'sh1c0b) : $signed(_GEN_1573); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1575 = 10'h225 == lutAddr ? $signed(-16'sh1ccf) : $signed(_GEN_1574); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1576 = 10'h226 == lutAddr ? $signed(-16'sh1d93) : $signed(_GEN_1575); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1577 = 10'h227 == lutAddr ? $signed(-16'sh1e56) : $signed(_GEN_1576); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1578 = 10'h228 == lutAddr ? $signed(-16'sh1f19) : $signed(_GEN_1577); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1579 = 10'h229 == lutAddr ? $signed(-16'sh1fdc) : $signed(_GEN_1578); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1580 = 10'h22a == lutAddr ? $signed(-16'sh209f) : $signed(_GEN_1579); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1581 = 10'h22b == lutAddr ? $signed(-16'sh2161) : $signed(_GEN_1580); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1582 = 10'h22c == lutAddr ? $signed(-16'sh2223) : $signed(_GEN_1581); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1583 = 10'h22d == lutAddr ? $signed(-16'sh22e4) : $signed(_GEN_1582); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1584 = 10'h22e == lutAddr ? $signed(-16'sh23a6) : $signed(_GEN_1583); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1585 = 10'h22f == lutAddr ? $signed(-16'sh2467) : $signed(_GEN_1584); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1586 = 10'h230 == lutAddr ? $signed(-16'sh2527) : $signed(_GEN_1585); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1587 = 10'h231 == lutAddr ? $signed(-16'sh25e7) : $signed(_GEN_1586); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1588 = 10'h232 == lutAddr ? $signed(-16'sh26a7) : $signed(_GEN_1587); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1589 = 10'h233 == lutAddr ? $signed(-16'sh2767) : $signed(_GEN_1588); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1590 = 10'h234 == lutAddr ? $signed(-16'sh2826) : $signed(_GEN_1589); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1591 = 10'h235 == lutAddr ? $signed(-16'sh28e5) : $signed(_GEN_1590); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1592 = 10'h236 == lutAddr ? $signed(-16'sh29a3) : $signed(_GEN_1591); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1593 = 10'h237 == lutAddr ? $signed(-16'sh2a61) : $signed(_GEN_1592); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1594 = 10'h238 == lutAddr ? $signed(-16'sh2b1e) : $signed(_GEN_1593); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1595 = 10'h239 == lutAddr ? $signed(-16'sh2bdb) : $signed(_GEN_1594); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1596 = 10'h23a == lutAddr ? $signed(-16'sh2c98) : $signed(_GEN_1595); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1597 = 10'h23b == lutAddr ? $signed(-16'sh2d54) : $signed(_GEN_1596); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1598 = 10'h23c == lutAddr ? $signed(-16'sh2e10) : $signed(_GEN_1597); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1599 = 10'h23d == lutAddr ? $signed(-16'sh2ecc) : $signed(_GEN_1598); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1600 = 10'h23e == lutAddr ? $signed(-16'sh2f86) : $signed(_GEN_1599); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1601 = 10'h23f == lutAddr ? $signed(-16'sh3041) : $signed(_GEN_1600); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1602 = 10'h240 == lutAddr ? $signed(-16'sh30fb) : $signed(_GEN_1601); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1603 = 10'h241 == lutAddr ? $signed(-16'sh31b4) : $signed(_GEN_1602); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1604 = 10'h242 == lutAddr ? $signed(-16'sh326d) : $signed(_GEN_1603); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1605 = 10'h243 == lutAddr ? $signed(-16'sh3326) : $signed(_GEN_1604); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1606 = 10'h244 == lutAddr ? $signed(-16'sh33de) : $signed(_GEN_1605); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1607 = 10'h245 == lutAddr ? $signed(-16'sh3496) : $signed(_GEN_1606); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1608 = 10'h246 == lutAddr ? $signed(-16'sh354d) : $signed(_GEN_1607); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1609 = 10'h247 == lutAddr ? $signed(-16'sh3603) : $signed(_GEN_1608); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1610 = 10'h248 == lutAddr ? $signed(-16'sh36b9) : $signed(_GEN_1609); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1611 = 10'h249 == lutAddr ? $signed(-16'sh376f) : $signed(_GEN_1610); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1612 = 10'h24a == lutAddr ? $signed(-16'sh3824) : $signed(_GEN_1611); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1613 = 10'h24b == lutAddr ? $signed(-16'sh38d8) : $signed(_GEN_1612); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1614 = 10'h24c == lutAddr ? $signed(-16'sh398c) : $signed(_GEN_1613); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1615 = 10'h24d == lutAddr ? $signed(-16'sh3a3f) : $signed(_GEN_1614); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1616 = 10'h24e == lutAddr ? $signed(-16'sh3af2) : $signed(_GEN_1615); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1617 = 10'h24f == lutAddr ? $signed(-16'sh3ba4) : $signed(_GEN_1616); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1618 = 10'h250 == lutAddr ? $signed(-16'sh3c56) : $signed(_GEN_1617); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1619 = 10'h251 == lutAddr ? $signed(-16'sh3d07) : $signed(_GEN_1618); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1620 = 10'h252 == lutAddr ? $signed(-16'sh3db7) : $signed(_GEN_1619); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1621 = 10'h253 == lutAddr ? $signed(-16'sh3e67) : $signed(_GEN_1620); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1622 = 10'h254 == lutAddr ? $signed(-16'sh3f16) : $signed(_GEN_1621); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1623 = 10'h255 == lutAddr ? $signed(-16'sh3fc5) : $signed(_GEN_1622); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1624 = 10'h256 == lutAddr ? $signed(-16'sh4073) : $signed(_GEN_1623); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1625 = 10'h257 == lutAddr ? $signed(-16'sh4120) : $signed(_GEN_1624); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1626 = 10'h258 == lutAddr ? $signed(-16'sh41cd) : $signed(_GEN_1625); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1627 = 10'h259 == lutAddr ? $signed(-16'sh4279) : $signed(_GEN_1626); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1628 = 10'h25a == lutAddr ? $signed(-16'sh4325) : $signed(_GEN_1627); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1629 = 10'h25b == lutAddr ? $signed(-16'sh43d0) : $signed(_GEN_1628); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1630 = 10'h25c == lutAddr ? $signed(-16'sh447a) : $signed(_GEN_1629); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1631 = 10'h25d == lutAddr ? $signed(-16'sh4523) : $signed(_GEN_1630); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1632 = 10'h25e == lutAddr ? $signed(-16'sh45cc) : $signed(_GEN_1631); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1633 = 10'h25f == lutAddr ? $signed(-16'sh4674) : $signed(_GEN_1632); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1634 = 10'h260 == lutAddr ? $signed(-16'sh471c) : $signed(_GEN_1633); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1635 = 10'h261 == lutAddr ? $signed(-16'sh47c3) : $signed(_GEN_1634); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1636 = 10'h262 == lutAddr ? $signed(-16'sh4869) : $signed(_GEN_1635); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1637 = 10'h263 == lutAddr ? $signed(-16'sh490e) : $signed(_GEN_1636); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1638 = 10'h264 == lutAddr ? $signed(-16'sh49b3) : $signed(_GEN_1637); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1639 = 10'h265 == lutAddr ? $signed(-16'sh4a57) : $signed(_GEN_1638); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1640 = 10'h266 == lutAddr ? $signed(-16'sh4afa) : $signed(_GEN_1639); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1641 = 10'h267 == lutAddr ? $signed(-16'sh4b9d) : $signed(_GEN_1640); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1642 = 10'h268 == lutAddr ? $signed(-16'sh4c3f) : $signed(_GEN_1641); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1643 = 10'h269 == lutAddr ? $signed(-16'sh4ce0) : $signed(_GEN_1642); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1644 = 10'h26a == lutAddr ? $signed(-16'sh4d80) : $signed(_GEN_1643); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1645 = 10'h26b == lutAddr ? $signed(-16'sh4e20) : $signed(_GEN_1644); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1646 = 10'h26c == lutAddr ? $signed(-16'sh4ebf) : $signed(_GEN_1645); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1647 = 10'h26d == lutAddr ? $signed(-16'sh4f5d) : $signed(_GEN_1646); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1648 = 10'h26e == lutAddr ? $signed(-16'sh4ffa) : $signed(_GEN_1647); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1649 = 10'h26f == lutAddr ? $signed(-16'sh5097) : $signed(_GEN_1648); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1650 = 10'h270 == lutAddr ? $signed(-16'sh5133) : $signed(_GEN_1649); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1651 = 10'h271 == lutAddr ? $signed(-16'sh51ce) : $signed(_GEN_1650); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1652 = 10'h272 == lutAddr ? $signed(-16'sh5268) : $signed(_GEN_1651); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1653 = 10'h273 == lutAddr ? $signed(-16'sh5301) : $signed(_GEN_1652); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1654 = 10'h274 == lutAddr ? $signed(-16'sh539a) : $signed(_GEN_1653); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1655 = 10'h275 == lutAddr ? $signed(-16'sh5432) : $signed(_GEN_1654); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1656 = 10'h276 == lutAddr ? $signed(-16'sh54c9) : $signed(_GEN_1655); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1657 = 10'h277 == lutAddr ? $signed(-16'sh555f) : $signed(_GEN_1656); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1658 = 10'h278 == lutAddr ? $signed(-16'sh55f4) : $signed(_GEN_1657); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1659 = 10'h279 == lutAddr ? $signed(-16'sh5689) : $signed(_GEN_1658); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1660 = 10'h27a == lutAddr ? $signed(-16'sh571d) : $signed(_GEN_1659); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1661 = 10'h27b == lutAddr ? $signed(-16'sh57b0) : $signed(_GEN_1660); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1662 = 10'h27c == lutAddr ? $signed(-16'sh5842) : $signed(_GEN_1661); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1663 = 10'h27d == lutAddr ? $signed(-16'sh58d3) : $signed(_GEN_1662); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1664 = 10'h27e == lutAddr ? $signed(-16'sh5963) : $signed(_GEN_1663); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1665 = 10'h27f == lutAddr ? $signed(-16'sh59f3) : $signed(_GEN_1664); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1666 = 10'h280 == lutAddr ? $signed(-16'sh5a81) : $signed(_GEN_1665); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1667 = 10'h281 == lutAddr ? $signed(-16'sh5b0f) : $signed(_GEN_1666); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1668 = 10'h282 == lutAddr ? $signed(-16'sh5b9c) : $signed(_GEN_1667); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1669 = 10'h283 == lutAddr ? $signed(-16'sh5c28) : $signed(_GEN_1668); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1670 = 10'h284 == lutAddr ? $signed(-16'sh5cb3) : $signed(_GEN_1669); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1671 = 10'h285 == lutAddr ? $signed(-16'sh5d3d) : $signed(_GEN_1670); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1672 = 10'h286 == lutAddr ? $signed(-16'sh5dc6) : $signed(_GEN_1671); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1673 = 10'h287 == lutAddr ? $signed(-16'sh5e4f) : $signed(_GEN_1672); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1674 = 10'h288 == lutAddr ? $signed(-16'sh5ed6) : $signed(_GEN_1673); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1675 = 10'h289 == lutAddr ? $signed(-16'sh5f5d) : $signed(_GEN_1674); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1676 = 10'h28a == lutAddr ? $signed(-16'sh5fe2) : $signed(_GEN_1675); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1677 = 10'h28b == lutAddr ? $signed(-16'sh6067) : $signed(_GEN_1676); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1678 = 10'h28c == lutAddr ? $signed(-16'sh60eb) : $signed(_GEN_1677); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1679 = 10'h28d == lutAddr ? $signed(-16'sh616e) : $signed(_GEN_1678); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1680 = 10'h28e == lutAddr ? $signed(-16'sh61f0) : $signed(_GEN_1679); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1681 = 10'h28f == lutAddr ? $signed(-16'sh6271) : $signed(_GEN_1680); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1682 = 10'h290 == lutAddr ? $signed(-16'sh62f1) : $signed(_GEN_1681); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1683 = 10'h291 == lutAddr ? $signed(-16'sh6370) : $signed(_GEN_1682); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1684 = 10'h292 == lutAddr ? $signed(-16'sh63ee) : $signed(_GEN_1683); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1685 = 10'h293 == lutAddr ? $signed(-16'sh646b) : $signed(_GEN_1684); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1686 = 10'h294 == lutAddr ? $signed(-16'sh64e7) : $signed(_GEN_1685); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1687 = 10'h295 == lutAddr ? $signed(-16'sh6562) : $signed(_GEN_1686); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1688 = 10'h296 == lutAddr ? $signed(-16'sh65dd) : $signed(_GEN_1687); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1689 = 10'h297 == lutAddr ? $signed(-16'sh6656) : $signed(_GEN_1688); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1690 = 10'h298 == lutAddr ? $signed(-16'sh66ce) : $signed(_GEN_1689); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1691 = 10'h299 == lutAddr ? $signed(-16'sh6745) : $signed(_GEN_1690); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1692 = 10'h29a == lutAddr ? $signed(-16'sh67bc) : $signed(_GEN_1691); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1693 = 10'h29b == lutAddr ? $signed(-16'sh6831) : $signed(_GEN_1692); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1694 = 10'h29c == lutAddr ? $signed(-16'sh68a5) : $signed(_GEN_1693); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1695 = 10'h29d == lutAddr ? $signed(-16'sh6919) : $signed(_GEN_1694); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1696 = 10'h29e == lutAddr ? $signed(-16'sh698b) : $signed(_GEN_1695); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1697 = 10'h29f == lutAddr ? $signed(-16'sh69fc) : $signed(_GEN_1696); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1698 = 10'h2a0 == lutAddr ? $signed(-16'sh6a6c) : $signed(_GEN_1697); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1699 = 10'h2a1 == lutAddr ? $signed(-16'sh6adb) : $signed(_GEN_1698); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1700 = 10'h2a2 == lutAddr ? $signed(-16'sh6b4a) : $signed(_GEN_1699); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1701 = 10'h2a3 == lutAddr ? $signed(-16'sh6bb7) : $signed(_GEN_1700); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1702 = 10'h2a4 == lutAddr ? $signed(-16'sh6c23) : $signed(_GEN_1701); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1703 = 10'h2a5 == lutAddr ? $signed(-16'sh6c8e) : $signed(_GEN_1702); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1704 = 10'h2a6 == lutAddr ? $signed(-16'sh6cf8) : $signed(_GEN_1703); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1705 = 10'h2a7 == lutAddr ? $signed(-16'sh6d61) : $signed(_GEN_1704); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1706 = 10'h2a8 == lutAddr ? $signed(-16'sh6dc9) : $signed(_GEN_1705); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1707 = 10'h2a9 == lutAddr ? $signed(-16'sh6e30) : $signed(_GEN_1706); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1708 = 10'h2aa == lutAddr ? $signed(-16'sh6e95) : $signed(_GEN_1707); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1709 = 10'h2ab == lutAddr ? $signed(-16'sh6efa) : $signed(_GEN_1708); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1710 = 10'h2ac == lutAddr ? $signed(-16'sh6f5e) : $signed(_GEN_1709); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1711 = 10'h2ad == lutAddr ? $signed(-16'sh6fc0) : $signed(_GEN_1710); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1712 = 10'h2ae == lutAddr ? $signed(-16'sh7022) : $signed(_GEN_1711); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1713 = 10'h2af == lutAddr ? $signed(-16'sh7082) : $signed(_GEN_1712); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1714 = 10'h2b0 == lutAddr ? $signed(-16'sh70e1) : $signed(_GEN_1713); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1715 = 10'h2b1 == lutAddr ? $signed(-16'sh7140) : $signed(_GEN_1714); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1716 = 10'h2b2 == lutAddr ? $signed(-16'sh719d) : $signed(_GEN_1715); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1717 = 10'h2b3 == lutAddr ? $signed(-16'sh71f9) : $signed(_GEN_1716); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1718 = 10'h2b4 == lutAddr ? $signed(-16'sh7254) : $signed(_GEN_1717); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1719 = 10'h2b5 == lutAddr ? $signed(-16'sh72ae) : $signed(_GEN_1718); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1720 = 10'h2b6 == lutAddr ? $signed(-16'sh7306) : $signed(_GEN_1719); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1721 = 10'h2b7 == lutAddr ? $signed(-16'sh735e) : $signed(_GEN_1720); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1722 = 10'h2b8 == lutAddr ? $signed(-16'sh73b5) : $signed(_GEN_1721); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1723 = 10'h2b9 == lutAddr ? $signed(-16'sh740a) : $signed(_GEN_1722); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1724 = 10'h2ba == lutAddr ? $signed(-16'sh745e) : $signed(_GEN_1723); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1725 = 10'h2bb == lutAddr ? $signed(-16'sh74b1) : $signed(_GEN_1724); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1726 = 10'h2bc == lutAddr ? $signed(-16'sh7503) : $signed(_GEN_1725); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1727 = 10'h2bd == lutAddr ? $signed(-16'sh7554) : $signed(_GEN_1726); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1728 = 10'h2be == lutAddr ? $signed(-16'sh75a4) : $signed(_GEN_1727); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1729 = 10'h2bf == lutAddr ? $signed(-16'sh75f3) : $signed(_GEN_1728); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1730 = 10'h2c0 == lutAddr ? $signed(-16'sh7640) : $signed(_GEN_1729); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1731 = 10'h2c1 == lutAddr ? $signed(-16'sh768d) : $signed(_GEN_1730); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1732 = 10'h2c2 == lutAddr ? $signed(-16'sh76d8) : $signed(_GEN_1731); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1733 = 10'h2c3 == lutAddr ? $signed(-16'sh7722) : $signed(_GEN_1732); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1734 = 10'h2c4 == lutAddr ? $signed(-16'sh776b) : $signed(_GEN_1733); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1735 = 10'h2c5 == lutAddr ? $signed(-16'sh77b3) : $signed(_GEN_1734); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1736 = 10'h2c6 == lutAddr ? $signed(-16'sh77f9) : $signed(_GEN_1735); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1737 = 10'h2c7 == lutAddr ? $signed(-16'sh783f) : $signed(_GEN_1736); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1738 = 10'h2c8 == lutAddr ? $signed(-16'sh7883) : $signed(_GEN_1737); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1739 = 10'h2c9 == lutAddr ? $signed(-16'sh78c6) : $signed(_GEN_1738); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1740 = 10'h2ca == lutAddr ? $signed(-16'sh7908) : $signed(_GEN_1739); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1741 = 10'h2cb == lutAddr ? $signed(-16'sh7949) : $signed(_GEN_1740); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1742 = 10'h2cc == lutAddr ? $signed(-16'sh7989) : $signed(_GEN_1741); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1743 = 10'h2cd == lutAddr ? $signed(-16'sh79c7) : $signed(_GEN_1742); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1744 = 10'h2ce == lutAddr ? $signed(-16'sh7a04) : $signed(_GEN_1743); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1745 = 10'h2cf == lutAddr ? $signed(-16'sh7a41) : $signed(_GEN_1744); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1746 = 10'h2d0 == lutAddr ? $signed(-16'sh7a7c) : $signed(_GEN_1745); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1747 = 10'h2d1 == lutAddr ? $signed(-16'sh7ab5) : $signed(_GEN_1746); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1748 = 10'h2d2 == lutAddr ? $signed(-16'sh7aee) : $signed(_GEN_1747); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1749 = 10'h2d3 == lutAddr ? $signed(-16'sh7b25) : $signed(_GEN_1748); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1750 = 10'h2d4 == lutAddr ? $signed(-16'sh7b5c) : $signed(_GEN_1749); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1751 = 10'h2d5 == lutAddr ? $signed(-16'sh7b91) : $signed(_GEN_1750); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1752 = 10'h2d6 == lutAddr ? $signed(-16'sh7bc4) : $signed(_GEN_1751); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1753 = 10'h2d7 == lutAddr ? $signed(-16'sh7bf7) : $signed(_GEN_1752); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1754 = 10'h2d8 == lutAddr ? $signed(-16'sh7c29) : $signed(_GEN_1753); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1755 = 10'h2d9 == lutAddr ? $signed(-16'sh7c59) : $signed(_GEN_1754); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1756 = 10'h2da == lutAddr ? $signed(-16'sh7c88) : $signed(_GEN_1755); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1757 = 10'h2db == lutAddr ? $signed(-16'sh7cb6) : $signed(_GEN_1756); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1758 = 10'h2dc == lutAddr ? $signed(-16'sh7ce2) : $signed(_GEN_1757); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1759 = 10'h2dd == lutAddr ? $signed(-16'sh7d0e) : $signed(_GEN_1758); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1760 = 10'h2de == lutAddr ? $signed(-16'sh7d38) : $signed(_GEN_1759); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1761 = 10'h2df == lutAddr ? $signed(-16'sh7d61) : $signed(_GEN_1760); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1762 = 10'h2e0 == lutAddr ? $signed(-16'sh7d89) : $signed(_GEN_1761); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1763 = 10'h2e1 == lutAddr ? $signed(-16'sh7db0) : $signed(_GEN_1762); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1764 = 10'h2e2 == lutAddr ? $signed(-16'sh7dd5) : $signed(_GEN_1763); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1765 = 10'h2e3 == lutAddr ? $signed(-16'sh7df9) : $signed(_GEN_1764); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1766 = 10'h2e4 == lutAddr ? $signed(-16'sh7e1c) : $signed(_GEN_1765); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1767 = 10'h2e5 == lutAddr ? $signed(-16'sh7e3e) : $signed(_GEN_1766); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1768 = 10'h2e6 == lutAddr ? $signed(-16'sh7e5e) : $signed(_GEN_1767); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1769 = 10'h2e7 == lutAddr ? $signed(-16'sh7e7e) : $signed(_GEN_1768); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1770 = 10'h2e8 == lutAddr ? $signed(-16'sh7e9c) : $signed(_GEN_1769); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1771 = 10'h2e9 == lutAddr ? $signed(-16'sh7eb9) : $signed(_GEN_1770); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1772 = 10'h2ea == lutAddr ? $signed(-16'sh7ed4) : $signed(_GEN_1771); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1773 = 10'h2eb == lutAddr ? $signed(-16'sh7eef) : $signed(_GEN_1772); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1774 = 10'h2ec == lutAddr ? $signed(-16'sh7f08) : $signed(_GEN_1773); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1775 = 10'h2ed == lutAddr ? $signed(-16'sh7f20) : $signed(_GEN_1774); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1776 = 10'h2ee == lutAddr ? $signed(-16'sh7f37) : $signed(_GEN_1775); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1777 = 10'h2ef == lutAddr ? $signed(-16'sh7f4c) : $signed(_GEN_1776); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1778 = 10'h2f0 == lutAddr ? $signed(-16'sh7f61) : $signed(_GEN_1777); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1779 = 10'h2f1 == lutAddr ? $signed(-16'sh7f74) : $signed(_GEN_1778); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1780 = 10'h2f2 == lutAddr ? $signed(-16'sh7f86) : $signed(_GEN_1779); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1781 = 10'h2f3 == lutAddr ? $signed(-16'sh7f96) : $signed(_GEN_1780); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1782 = 10'h2f4 == lutAddr ? $signed(-16'sh7fa6) : $signed(_GEN_1781); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1783 = 10'h2f5 == lutAddr ? $signed(-16'sh7fb4) : $signed(_GEN_1782); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1784 = 10'h2f6 == lutAddr ? $signed(-16'sh7fc1) : $signed(_GEN_1783); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1785 = 10'h2f7 == lutAddr ? $signed(-16'sh7fcd) : $signed(_GEN_1784); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1786 = 10'h2f8 == lutAddr ? $signed(-16'sh7fd7) : $signed(_GEN_1785); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1787 = 10'h2f9 == lutAddr ? $signed(-16'sh7fe0) : $signed(_GEN_1786); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1788 = 10'h2fa == lutAddr ? $signed(-16'sh7fe8) : $signed(_GEN_1787); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1789 = 10'h2fb == lutAddr ? $signed(-16'sh7fef) : $signed(_GEN_1788); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1790 = 10'h2fc == lutAddr ? $signed(-16'sh7ff5) : $signed(_GEN_1789); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1791 = 10'h2fd == lutAddr ? $signed(-16'sh7ff9) : $signed(_GEN_1790); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1792 = 10'h2fe == lutAddr ? $signed(-16'sh7ffc) : $signed(_GEN_1791); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1793 = 10'h2ff == lutAddr ? $signed(-16'sh7ffe) : $signed(_GEN_1792); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1794 = 10'h300 == lutAddr ? $signed(-16'sh7fff) : $signed(_GEN_1793); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1795 = 10'h301 == lutAddr ? $signed(-16'sh7ffe) : $signed(_GEN_1794); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1796 = 10'h302 == lutAddr ? $signed(-16'sh7ffc) : $signed(_GEN_1795); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1797 = 10'h303 == lutAddr ? $signed(-16'sh7ff9) : $signed(_GEN_1796); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1798 = 10'h304 == lutAddr ? $signed(-16'sh7ff5) : $signed(_GEN_1797); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1799 = 10'h305 == lutAddr ? $signed(-16'sh7fef) : $signed(_GEN_1798); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1800 = 10'h306 == lutAddr ? $signed(-16'sh7fe8) : $signed(_GEN_1799); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1801 = 10'h307 == lutAddr ? $signed(-16'sh7fe0) : $signed(_GEN_1800); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1802 = 10'h308 == lutAddr ? $signed(-16'sh7fd7) : $signed(_GEN_1801); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1803 = 10'h309 == lutAddr ? $signed(-16'sh7fcd) : $signed(_GEN_1802); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1804 = 10'h30a == lutAddr ? $signed(-16'sh7fc1) : $signed(_GEN_1803); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1805 = 10'h30b == lutAddr ? $signed(-16'sh7fb4) : $signed(_GEN_1804); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1806 = 10'h30c == lutAddr ? $signed(-16'sh7fa6) : $signed(_GEN_1805); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1807 = 10'h30d == lutAddr ? $signed(-16'sh7f96) : $signed(_GEN_1806); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1808 = 10'h30e == lutAddr ? $signed(-16'sh7f86) : $signed(_GEN_1807); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1809 = 10'h30f == lutAddr ? $signed(-16'sh7f74) : $signed(_GEN_1808); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1810 = 10'h310 == lutAddr ? $signed(-16'sh7f61) : $signed(_GEN_1809); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1811 = 10'h311 == lutAddr ? $signed(-16'sh7f4c) : $signed(_GEN_1810); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1812 = 10'h312 == lutAddr ? $signed(-16'sh7f37) : $signed(_GEN_1811); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1813 = 10'h313 == lutAddr ? $signed(-16'sh7f20) : $signed(_GEN_1812); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1814 = 10'h314 == lutAddr ? $signed(-16'sh7f08) : $signed(_GEN_1813); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1815 = 10'h315 == lutAddr ? $signed(-16'sh7eef) : $signed(_GEN_1814); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1816 = 10'h316 == lutAddr ? $signed(-16'sh7ed4) : $signed(_GEN_1815); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1817 = 10'h317 == lutAddr ? $signed(-16'sh7eb9) : $signed(_GEN_1816); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1818 = 10'h318 == lutAddr ? $signed(-16'sh7e9c) : $signed(_GEN_1817); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1819 = 10'h319 == lutAddr ? $signed(-16'sh7e7e) : $signed(_GEN_1818); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1820 = 10'h31a == lutAddr ? $signed(-16'sh7e5e) : $signed(_GEN_1819); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1821 = 10'h31b == lutAddr ? $signed(-16'sh7e3e) : $signed(_GEN_1820); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1822 = 10'h31c == lutAddr ? $signed(-16'sh7e1c) : $signed(_GEN_1821); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1823 = 10'h31d == lutAddr ? $signed(-16'sh7df9) : $signed(_GEN_1822); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1824 = 10'h31e == lutAddr ? $signed(-16'sh7dd5) : $signed(_GEN_1823); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1825 = 10'h31f == lutAddr ? $signed(-16'sh7db0) : $signed(_GEN_1824); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1826 = 10'h320 == lutAddr ? $signed(-16'sh7d89) : $signed(_GEN_1825); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1827 = 10'h321 == lutAddr ? $signed(-16'sh7d61) : $signed(_GEN_1826); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1828 = 10'h322 == lutAddr ? $signed(-16'sh7d38) : $signed(_GEN_1827); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1829 = 10'h323 == lutAddr ? $signed(-16'sh7d0e) : $signed(_GEN_1828); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1830 = 10'h324 == lutAddr ? $signed(-16'sh7ce2) : $signed(_GEN_1829); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1831 = 10'h325 == lutAddr ? $signed(-16'sh7cb6) : $signed(_GEN_1830); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1832 = 10'h326 == lutAddr ? $signed(-16'sh7c88) : $signed(_GEN_1831); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1833 = 10'h327 == lutAddr ? $signed(-16'sh7c59) : $signed(_GEN_1832); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1834 = 10'h328 == lutAddr ? $signed(-16'sh7c29) : $signed(_GEN_1833); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1835 = 10'h329 == lutAddr ? $signed(-16'sh7bf7) : $signed(_GEN_1834); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1836 = 10'h32a == lutAddr ? $signed(-16'sh7bc4) : $signed(_GEN_1835); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1837 = 10'h32b == lutAddr ? $signed(-16'sh7b91) : $signed(_GEN_1836); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1838 = 10'h32c == lutAddr ? $signed(-16'sh7b5c) : $signed(_GEN_1837); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1839 = 10'h32d == lutAddr ? $signed(-16'sh7b25) : $signed(_GEN_1838); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1840 = 10'h32e == lutAddr ? $signed(-16'sh7aee) : $signed(_GEN_1839); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1841 = 10'h32f == lutAddr ? $signed(-16'sh7ab5) : $signed(_GEN_1840); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1842 = 10'h330 == lutAddr ? $signed(-16'sh7a7c) : $signed(_GEN_1841); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1843 = 10'h331 == lutAddr ? $signed(-16'sh7a41) : $signed(_GEN_1842); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1844 = 10'h332 == lutAddr ? $signed(-16'sh7a04) : $signed(_GEN_1843); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1845 = 10'h333 == lutAddr ? $signed(-16'sh79c7) : $signed(_GEN_1844); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1846 = 10'h334 == lutAddr ? $signed(-16'sh7989) : $signed(_GEN_1845); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1847 = 10'h335 == lutAddr ? $signed(-16'sh7949) : $signed(_GEN_1846); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1848 = 10'h336 == lutAddr ? $signed(-16'sh7908) : $signed(_GEN_1847); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1849 = 10'h337 == lutAddr ? $signed(-16'sh78c6) : $signed(_GEN_1848); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1850 = 10'h338 == lutAddr ? $signed(-16'sh7883) : $signed(_GEN_1849); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1851 = 10'h339 == lutAddr ? $signed(-16'sh783f) : $signed(_GEN_1850); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1852 = 10'h33a == lutAddr ? $signed(-16'sh77f9) : $signed(_GEN_1851); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1853 = 10'h33b == lutAddr ? $signed(-16'sh77b3) : $signed(_GEN_1852); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1854 = 10'h33c == lutAddr ? $signed(-16'sh776b) : $signed(_GEN_1853); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1855 = 10'h33d == lutAddr ? $signed(-16'sh7722) : $signed(_GEN_1854); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1856 = 10'h33e == lutAddr ? $signed(-16'sh76d8) : $signed(_GEN_1855); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1857 = 10'h33f == lutAddr ? $signed(-16'sh768d) : $signed(_GEN_1856); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1858 = 10'h340 == lutAddr ? $signed(-16'sh7640) : $signed(_GEN_1857); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1859 = 10'h341 == lutAddr ? $signed(-16'sh75f3) : $signed(_GEN_1858); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1860 = 10'h342 == lutAddr ? $signed(-16'sh75a4) : $signed(_GEN_1859); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1861 = 10'h343 == lutAddr ? $signed(-16'sh7554) : $signed(_GEN_1860); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1862 = 10'h344 == lutAddr ? $signed(-16'sh7503) : $signed(_GEN_1861); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1863 = 10'h345 == lutAddr ? $signed(-16'sh74b1) : $signed(_GEN_1862); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1864 = 10'h346 == lutAddr ? $signed(-16'sh745e) : $signed(_GEN_1863); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1865 = 10'h347 == lutAddr ? $signed(-16'sh740a) : $signed(_GEN_1864); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1866 = 10'h348 == lutAddr ? $signed(-16'sh73b5) : $signed(_GEN_1865); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1867 = 10'h349 == lutAddr ? $signed(-16'sh735e) : $signed(_GEN_1866); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1868 = 10'h34a == lutAddr ? $signed(-16'sh7306) : $signed(_GEN_1867); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1869 = 10'h34b == lutAddr ? $signed(-16'sh72ae) : $signed(_GEN_1868); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1870 = 10'h34c == lutAddr ? $signed(-16'sh7254) : $signed(_GEN_1869); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1871 = 10'h34d == lutAddr ? $signed(-16'sh71f9) : $signed(_GEN_1870); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1872 = 10'h34e == lutAddr ? $signed(-16'sh719d) : $signed(_GEN_1871); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1873 = 10'h34f == lutAddr ? $signed(-16'sh7140) : $signed(_GEN_1872); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1874 = 10'h350 == lutAddr ? $signed(-16'sh70e1) : $signed(_GEN_1873); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1875 = 10'h351 == lutAddr ? $signed(-16'sh7082) : $signed(_GEN_1874); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1876 = 10'h352 == lutAddr ? $signed(-16'sh7022) : $signed(_GEN_1875); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1877 = 10'h353 == lutAddr ? $signed(-16'sh6fc0) : $signed(_GEN_1876); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1878 = 10'h354 == lutAddr ? $signed(-16'sh6f5e) : $signed(_GEN_1877); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1879 = 10'h355 == lutAddr ? $signed(-16'sh6efa) : $signed(_GEN_1878); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1880 = 10'h356 == lutAddr ? $signed(-16'sh6e95) : $signed(_GEN_1879); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1881 = 10'h357 == lutAddr ? $signed(-16'sh6e30) : $signed(_GEN_1880); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1882 = 10'h358 == lutAddr ? $signed(-16'sh6dc9) : $signed(_GEN_1881); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1883 = 10'h359 == lutAddr ? $signed(-16'sh6d61) : $signed(_GEN_1882); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1884 = 10'h35a == lutAddr ? $signed(-16'sh6cf8) : $signed(_GEN_1883); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1885 = 10'h35b == lutAddr ? $signed(-16'sh6c8e) : $signed(_GEN_1884); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1886 = 10'h35c == lutAddr ? $signed(-16'sh6c23) : $signed(_GEN_1885); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1887 = 10'h35d == lutAddr ? $signed(-16'sh6bb7) : $signed(_GEN_1886); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1888 = 10'h35e == lutAddr ? $signed(-16'sh6b4a) : $signed(_GEN_1887); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1889 = 10'h35f == lutAddr ? $signed(-16'sh6adb) : $signed(_GEN_1888); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1890 = 10'h360 == lutAddr ? $signed(-16'sh6a6c) : $signed(_GEN_1889); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1891 = 10'h361 == lutAddr ? $signed(-16'sh69fc) : $signed(_GEN_1890); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1892 = 10'h362 == lutAddr ? $signed(-16'sh698b) : $signed(_GEN_1891); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1893 = 10'h363 == lutAddr ? $signed(-16'sh6919) : $signed(_GEN_1892); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1894 = 10'h364 == lutAddr ? $signed(-16'sh68a5) : $signed(_GEN_1893); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1895 = 10'h365 == lutAddr ? $signed(-16'sh6831) : $signed(_GEN_1894); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1896 = 10'h366 == lutAddr ? $signed(-16'sh67bc) : $signed(_GEN_1895); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1897 = 10'h367 == lutAddr ? $signed(-16'sh6745) : $signed(_GEN_1896); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1898 = 10'h368 == lutAddr ? $signed(-16'sh66ce) : $signed(_GEN_1897); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1899 = 10'h369 == lutAddr ? $signed(-16'sh6656) : $signed(_GEN_1898); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1900 = 10'h36a == lutAddr ? $signed(-16'sh65dd) : $signed(_GEN_1899); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1901 = 10'h36b == lutAddr ? $signed(-16'sh6562) : $signed(_GEN_1900); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1902 = 10'h36c == lutAddr ? $signed(-16'sh64e7) : $signed(_GEN_1901); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1903 = 10'h36d == lutAddr ? $signed(-16'sh646b) : $signed(_GEN_1902); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1904 = 10'h36e == lutAddr ? $signed(-16'sh63ee) : $signed(_GEN_1903); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1905 = 10'h36f == lutAddr ? $signed(-16'sh6370) : $signed(_GEN_1904); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1906 = 10'h370 == lutAddr ? $signed(-16'sh62f1) : $signed(_GEN_1905); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1907 = 10'h371 == lutAddr ? $signed(-16'sh6271) : $signed(_GEN_1906); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1908 = 10'h372 == lutAddr ? $signed(-16'sh61f0) : $signed(_GEN_1907); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1909 = 10'h373 == lutAddr ? $signed(-16'sh616e) : $signed(_GEN_1908); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1910 = 10'h374 == lutAddr ? $signed(-16'sh60eb) : $signed(_GEN_1909); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1911 = 10'h375 == lutAddr ? $signed(-16'sh6067) : $signed(_GEN_1910); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1912 = 10'h376 == lutAddr ? $signed(-16'sh5fe2) : $signed(_GEN_1911); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1913 = 10'h377 == lutAddr ? $signed(-16'sh5f5d) : $signed(_GEN_1912); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1914 = 10'h378 == lutAddr ? $signed(-16'sh5ed6) : $signed(_GEN_1913); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1915 = 10'h379 == lutAddr ? $signed(-16'sh5e4f) : $signed(_GEN_1914); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1916 = 10'h37a == lutAddr ? $signed(-16'sh5dc6) : $signed(_GEN_1915); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1917 = 10'h37b == lutAddr ? $signed(-16'sh5d3d) : $signed(_GEN_1916); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1918 = 10'h37c == lutAddr ? $signed(-16'sh5cb3) : $signed(_GEN_1917); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1919 = 10'h37d == lutAddr ? $signed(-16'sh5c28) : $signed(_GEN_1918); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1920 = 10'h37e == lutAddr ? $signed(-16'sh5b9c) : $signed(_GEN_1919); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1921 = 10'h37f == lutAddr ? $signed(-16'sh5b0f) : $signed(_GEN_1920); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1922 = 10'h380 == lutAddr ? $signed(-16'sh5a81) : $signed(_GEN_1921); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1923 = 10'h381 == lutAddr ? $signed(-16'sh59f3) : $signed(_GEN_1922); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1924 = 10'h382 == lutAddr ? $signed(-16'sh5963) : $signed(_GEN_1923); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1925 = 10'h383 == lutAddr ? $signed(-16'sh58d3) : $signed(_GEN_1924); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1926 = 10'h384 == lutAddr ? $signed(-16'sh5842) : $signed(_GEN_1925); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1927 = 10'h385 == lutAddr ? $signed(-16'sh57b0) : $signed(_GEN_1926); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1928 = 10'h386 == lutAddr ? $signed(-16'sh571d) : $signed(_GEN_1927); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1929 = 10'h387 == lutAddr ? $signed(-16'sh5689) : $signed(_GEN_1928); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1930 = 10'h388 == lutAddr ? $signed(-16'sh55f4) : $signed(_GEN_1929); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1931 = 10'h389 == lutAddr ? $signed(-16'sh555f) : $signed(_GEN_1930); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1932 = 10'h38a == lutAddr ? $signed(-16'sh54c9) : $signed(_GEN_1931); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1933 = 10'h38b == lutAddr ? $signed(-16'sh5432) : $signed(_GEN_1932); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1934 = 10'h38c == lutAddr ? $signed(-16'sh539a) : $signed(_GEN_1933); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1935 = 10'h38d == lutAddr ? $signed(-16'sh5301) : $signed(_GEN_1934); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1936 = 10'h38e == lutAddr ? $signed(-16'sh5268) : $signed(_GEN_1935); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1937 = 10'h38f == lutAddr ? $signed(-16'sh51ce) : $signed(_GEN_1936); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1938 = 10'h390 == lutAddr ? $signed(-16'sh5133) : $signed(_GEN_1937); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1939 = 10'h391 == lutAddr ? $signed(-16'sh5097) : $signed(_GEN_1938); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1940 = 10'h392 == lutAddr ? $signed(-16'sh4ffa) : $signed(_GEN_1939); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1941 = 10'h393 == lutAddr ? $signed(-16'sh4f5d) : $signed(_GEN_1940); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1942 = 10'h394 == lutAddr ? $signed(-16'sh4ebf) : $signed(_GEN_1941); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1943 = 10'h395 == lutAddr ? $signed(-16'sh4e20) : $signed(_GEN_1942); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1944 = 10'h396 == lutAddr ? $signed(-16'sh4d80) : $signed(_GEN_1943); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1945 = 10'h397 == lutAddr ? $signed(-16'sh4ce0) : $signed(_GEN_1944); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1946 = 10'h398 == lutAddr ? $signed(-16'sh4c3f) : $signed(_GEN_1945); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1947 = 10'h399 == lutAddr ? $signed(-16'sh4b9d) : $signed(_GEN_1946); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1948 = 10'h39a == lutAddr ? $signed(-16'sh4afa) : $signed(_GEN_1947); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1949 = 10'h39b == lutAddr ? $signed(-16'sh4a57) : $signed(_GEN_1948); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1950 = 10'h39c == lutAddr ? $signed(-16'sh49b3) : $signed(_GEN_1949); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1951 = 10'h39d == lutAddr ? $signed(-16'sh490e) : $signed(_GEN_1950); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1952 = 10'h39e == lutAddr ? $signed(-16'sh4869) : $signed(_GEN_1951); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1953 = 10'h39f == lutAddr ? $signed(-16'sh47c3) : $signed(_GEN_1952); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1954 = 10'h3a0 == lutAddr ? $signed(-16'sh471c) : $signed(_GEN_1953); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1955 = 10'h3a1 == lutAddr ? $signed(-16'sh4674) : $signed(_GEN_1954); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1956 = 10'h3a2 == lutAddr ? $signed(-16'sh45cc) : $signed(_GEN_1955); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1957 = 10'h3a3 == lutAddr ? $signed(-16'sh4523) : $signed(_GEN_1956); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1958 = 10'h3a4 == lutAddr ? $signed(-16'sh447a) : $signed(_GEN_1957); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1959 = 10'h3a5 == lutAddr ? $signed(-16'sh43d0) : $signed(_GEN_1958); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1960 = 10'h3a6 == lutAddr ? $signed(-16'sh4325) : $signed(_GEN_1959); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1961 = 10'h3a7 == lutAddr ? $signed(-16'sh4279) : $signed(_GEN_1960); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1962 = 10'h3a8 == lutAddr ? $signed(-16'sh41cd) : $signed(_GEN_1961); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1963 = 10'h3a9 == lutAddr ? $signed(-16'sh4120) : $signed(_GEN_1962); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1964 = 10'h3aa == lutAddr ? $signed(-16'sh4073) : $signed(_GEN_1963); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1965 = 10'h3ab == lutAddr ? $signed(-16'sh3fc5) : $signed(_GEN_1964); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1966 = 10'h3ac == lutAddr ? $signed(-16'sh3f16) : $signed(_GEN_1965); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1967 = 10'h3ad == lutAddr ? $signed(-16'sh3e67) : $signed(_GEN_1966); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1968 = 10'h3ae == lutAddr ? $signed(-16'sh3db7) : $signed(_GEN_1967); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1969 = 10'h3af == lutAddr ? $signed(-16'sh3d07) : $signed(_GEN_1968); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1970 = 10'h3b0 == lutAddr ? $signed(-16'sh3c56) : $signed(_GEN_1969); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1971 = 10'h3b1 == lutAddr ? $signed(-16'sh3ba4) : $signed(_GEN_1970); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1972 = 10'h3b2 == lutAddr ? $signed(-16'sh3af2) : $signed(_GEN_1971); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1973 = 10'h3b3 == lutAddr ? $signed(-16'sh3a3f) : $signed(_GEN_1972); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1974 = 10'h3b4 == lutAddr ? $signed(-16'sh398c) : $signed(_GEN_1973); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1975 = 10'h3b5 == lutAddr ? $signed(-16'sh38d8) : $signed(_GEN_1974); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1976 = 10'h3b6 == lutAddr ? $signed(-16'sh3824) : $signed(_GEN_1975); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1977 = 10'h3b7 == lutAddr ? $signed(-16'sh376f) : $signed(_GEN_1976); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1978 = 10'h3b8 == lutAddr ? $signed(-16'sh36b9) : $signed(_GEN_1977); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1979 = 10'h3b9 == lutAddr ? $signed(-16'sh3603) : $signed(_GEN_1978); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1980 = 10'h3ba == lutAddr ? $signed(-16'sh354d) : $signed(_GEN_1979); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1981 = 10'h3bb == lutAddr ? $signed(-16'sh3496) : $signed(_GEN_1980); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1982 = 10'h3bc == lutAddr ? $signed(-16'sh33de) : $signed(_GEN_1981); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1983 = 10'h3bd == lutAddr ? $signed(-16'sh3326) : $signed(_GEN_1982); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1984 = 10'h3be == lutAddr ? $signed(-16'sh326d) : $signed(_GEN_1983); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1985 = 10'h3bf == lutAddr ? $signed(-16'sh31b4) : $signed(_GEN_1984); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1986 = 10'h3c0 == lutAddr ? $signed(-16'sh30fb) : $signed(_GEN_1985); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1987 = 10'h3c1 == lutAddr ? $signed(-16'sh3041) : $signed(_GEN_1986); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1988 = 10'h3c2 == lutAddr ? $signed(-16'sh2f86) : $signed(_GEN_1987); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1989 = 10'h3c3 == lutAddr ? $signed(-16'sh2ecc) : $signed(_GEN_1988); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1990 = 10'h3c4 == lutAddr ? $signed(-16'sh2e10) : $signed(_GEN_1989); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1991 = 10'h3c5 == lutAddr ? $signed(-16'sh2d54) : $signed(_GEN_1990); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1992 = 10'h3c6 == lutAddr ? $signed(-16'sh2c98) : $signed(_GEN_1991); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1993 = 10'h3c7 == lutAddr ? $signed(-16'sh2bdb) : $signed(_GEN_1992); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1994 = 10'h3c8 == lutAddr ? $signed(-16'sh2b1e) : $signed(_GEN_1993); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1995 = 10'h3c9 == lutAddr ? $signed(-16'sh2a61) : $signed(_GEN_1994); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1996 = 10'h3ca == lutAddr ? $signed(-16'sh29a3) : $signed(_GEN_1995); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1997 = 10'h3cb == lutAddr ? $signed(-16'sh28e5) : $signed(_GEN_1996); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1998 = 10'h3cc == lutAddr ? $signed(-16'sh2826) : $signed(_GEN_1997); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_1999 = 10'h3cd == lutAddr ? $signed(-16'sh2767) : $signed(_GEN_1998); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2000 = 10'h3ce == lutAddr ? $signed(-16'sh26a7) : $signed(_GEN_1999); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2001 = 10'h3cf == lutAddr ? $signed(-16'sh25e7) : $signed(_GEN_2000); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2002 = 10'h3d0 == lutAddr ? $signed(-16'sh2527) : $signed(_GEN_2001); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2003 = 10'h3d1 == lutAddr ? $signed(-16'sh2467) : $signed(_GEN_2002); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2004 = 10'h3d2 == lutAddr ? $signed(-16'sh23a6) : $signed(_GEN_2003); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2005 = 10'h3d3 == lutAddr ? $signed(-16'sh22e4) : $signed(_GEN_2004); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2006 = 10'h3d4 == lutAddr ? $signed(-16'sh2223) : $signed(_GEN_2005); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2007 = 10'h3d5 == lutAddr ? $signed(-16'sh2161) : $signed(_GEN_2006); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2008 = 10'h3d6 == lutAddr ? $signed(-16'sh209f) : $signed(_GEN_2007); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2009 = 10'h3d7 == lutAddr ? $signed(-16'sh1fdc) : $signed(_GEN_2008); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2010 = 10'h3d8 == lutAddr ? $signed(-16'sh1f19) : $signed(_GEN_2009); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2011 = 10'h3d9 == lutAddr ? $signed(-16'sh1e56) : $signed(_GEN_2010); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2012 = 10'h3da == lutAddr ? $signed(-16'sh1d93) : $signed(_GEN_2011); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2013 = 10'h3db == lutAddr ? $signed(-16'sh1ccf) : $signed(_GEN_2012); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2014 = 10'h3dc == lutAddr ? $signed(-16'sh1c0b) : $signed(_GEN_2013); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2015 = 10'h3dd == lutAddr ? $signed(-16'sh1b46) : $signed(_GEN_2014); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2016 = 10'h3de == lutAddr ? $signed(-16'sh1a82) : $signed(_GEN_2015); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2017 = 10'h3df == lutAddr ? $signed(-16'sh19bd) : $signed(_GEN_2016); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2018 = 10'h3e0 == lutAddr ? $signed(-16'sh18f8) : $signed(_GEN_2017); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2019 = 10'h3e1 == lutAddr ? $signed(-16'sh1833) : $signed(_GEN_2018); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2020 = 10'h3e2 == lutAddr ? $signed(-16'sh176d) : $signed(_GEN_2019); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2021 = 10'h3e3 == lutAddr ? $signed(-16'sh16a7) : $signed(_GEN_2020); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2022 = 10'h3e4 == lutAddr ? $signed(-16'sh15e1) : $signed(_GEN_2021); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2023 = 10'h3e5 == lutAddr ? $signed(-16'sh151b) : $signed(_GEN_2022); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2024 = 10'h3e6 == lutAddr ? $signed(-16'sh1455) : $signed(_GEN_2023); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2025 = 10'h3e7 == lutAddr ? $signed(-16'sh138e) : $signed(_GEN_2024); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2026 = 10'h3e8 == lutAddr ? $signed(-16'sh12c7) : $signed(_GEN_2025); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2027 = 10'h3e9 == lutAddr ? $signed(-16'sh1200) : $signed(_GEN_2026); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2028 = 10'h3ea == lutAddr ? $signed(-16'sh1139) : $signed(_GEN_2027); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2029 = 10'h3eb == lutAddr ? $signed(-16'sh1072) : $signed(_GEN_2028); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2030 = 10'h3ec == lutAddr ? $signed(-16'shfab) : $signed(_GEN_2029); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2031 = 10'h3ed == lutAddr ? $signed(-16'shee3) : $signed(_GEN_2030); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2032 = 10'h3ee == lutAddr ? $signed(-16'she1b) : $signed(_GEN_2031); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2033 = 10'h3ef == lutAddr ? $signed(-16'shd53) : $signed(_GEN_2032); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2034 = 10'h3f0 == lutAddr ? $signed(-16'shc8b) : $signed(_GEN_2033); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2035 = 10'h3f1 == lutAddr ? $signed(-16'shbc3) : $signed(_GEN_2034); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2036 = 10'h3f2 == lutAddr ? $signed(-16'shafb) : $signed(_GEN_2035); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2037 = 10'h3f3 == lutAddr ? $signed(-16'sha32) : $signed(_GEN_2036); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2038 = 10'h3f4 == lutAddr ? $signed(-16'sh96a) : $signed(_GEN_2037); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2039 = 10'h3f5 == lutAddr ? $signed(-16'sh8a1) : $signed(_GEN_2038); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2040 = 10'h3f6 == lutAddr ? $signed(-16'sh7d9) : $signed(_GEN_2039); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2041 = 10'h3f7 == lutAddr ? $signed(-16'sh710) : $signed(_GEN_2040); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2042 = 10'h3f8 == lutAddr ? $signed(-16'sh647) : $signed(_GEN_2041); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2043 = 10'h3f9 == lutAddr ? $signed(-16'sh57e) : $signed(_GEN_2042); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2044 = 10'h3fa == lutAddr ? $signed(-16'sh4b6) : $signed(_GEN_2043); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2045 = 10'h3fb == lutAddr ? $signed(-16'sh3ed) : $signed(_GEN_2044); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2046 = 10'h3fc == lutAddr ? $signed(-16'sh324) : $signed(_GEN_2045); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2047 = 10'h3fd == lutAddr ? $signed(-16'sh25b) : $signed(_GEN_2046); // @[NCO.scala 47:13 NCO.scala 47:13]
  wire [15:0] _GEN_2048 = 10'h3fe == lutAddr ? $signed(-16'sh192) : $signed(_GEN_2047); // @[NCO.scala 47:13 NCO.scala 47:13]
  assign io_cosOut = 10'h3ff == lutAddr ? $signed(16'sh7ffe) : $signed(_GEN_1024); // @[NCO.scala 46:13 NCO.scala 46:13]
  assign io_sinOut = 10'h3ff == lutAddr ? $signed(-16'shc9) : $signed(_GEN_2048); // @[NCO.scala 47:13 NCO.scala 47:13]
  always @(posedge clock) begin
    if (reset) begin // @[NCO.scala 18:22]
      phase <= 32'h0; // @[NCO.scala 18:22]
    end else if (io_reset) begin // @[NCO.scala 20:18]
      phase <= 32'h0; // @[NCO.scala 21:11]
    end else if (io_enable) begin // @[NCO.scala 22:25]
      phase <= _phase_T_1; // @[NCO.scala 23:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  phase = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IQDemodulator(
  input         clock,
  input         reset,
  output        io_iqIn_ready,
  input         io_iqIn_valid,
  input  [15:0] io_iqIn_bits_i,
  input  [15:0] io_iqIn_bits_q,
  input  [15:0] io_sampleIndex,
  input  [31:0] io_omega,
  input  [15:0] io_windowStart,
  input  [15:0] io_windowLen,
  input         io_enable,
  input         io_reset,
  output [47:0] io_demodI,
  output [47:0] io_demodQ,
  output        io_demodValid,
  output [7:0]  io_trajLen,
  output        io_trajValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  nco_clock; // @[IQDemodulator.scala 32:19]
  wire  nco_reset; // @[IQDemodulator.scala 32:19]
  wire [31:0] nco_io_omega; // @[IQDemodulator.scala 32:19]
  wire  nco_io_enable; // @[IQDemodulator.scala 32:19]
  wire  nco_io_reset; // @[IQDemodulator.scala 32:19]
  wire [15:0] nco_io_cosOut; // @[IQDemodulator.scala 32:19]
  wire [15:0] nco_io_sinOut; // @[IQDemodulator.scala 32:19]
  wire [15:0] _inWindow_T_2 = io_windowStart + io_windowLen; // @[IQDemodulator.scala 39:51]
  wire  _inWindow_T_3 = io_sampleIndex < _inWindow_T_2; // @[IQDemodulator.scala 39:34]
  wire  inWindow = io_sampleIndex >= io_windowStart & _inWindow_T_3; // @[IQDemodulator.scala 38:53]
  wire [31:0] _mixI_T = $signed(io_iqIn_bits_i) * $signed(nco_io_cosOut); // @[IQDemodulator.scala 47:27]
  wire [31:0] _mixI_T_1 = $signed(io_iqIn_bits_q) * $signed(nco_io_sinOut); // @[IQDemodulator.scala 47:62]
  wire [31:0] mixI = $signed(_mixI_T) + $signed(_mixI_T_1); // @[IQDemodulator.scala 47:44]
  wire [31:0] _mixQ_T = $signed(io_iqIn_bits_q) * $signed(nco_io_cosOut); // @[IQDemodulator.scala 48:27]
  wire [31:0] _mixQ_T_1 = $signed(io_iqIn_bits_i) * $signed(nco_io_sinOut); // @[IQDemodulator.scala 48:62]
  wire [31:0] mixQ = $signed(_mixQ_T) - $signed(_mixQ_T_1); // @[IQDemodulator.scala 48:44]
  reg [47:0] accumI; // @[IQDemodulator.scala 51:23]
  reg [47:0] accumQ; // @[IQDemodulator.scala 52:23]
  wire  _T = io_iqIn_valid & inWindow; // @[IQDemodulator.scala 57:28]
  wire [47:0] _GEN_647 = {{16{mixI[31]}},mixI}; // @[IQDemodulator.scala 58:22]
  wire [47:0] _accumI_T_2 = $signed(accumI) + $signed(_GEN_647); // @[IQDemodulator.scala 58:22]
  wire [47:0] _GEN_648 = {{16{mixQ[31]}},mixQ}; // @[IQDemodulator.scala 59:22]
  wire [47:0] _accumQ_T_2 = $signed(accumQ) + $signed(_GEN_648); // @[IQDemodulator.scala 59:22]
  reg [7:0] trajIdx; // @[IQDemodulator.scala 64:24]
  wire [15:0] relativeIdx = io_sampleIndex - io_windowStart; // @[IQDemodulator.scala 69:38]
  wire [15:0] _GEN_0 = relativeIdx % 16'h19; // @[IQDemodulator.scala 70:22]
  wire [4:0] _T_2 = _GEN_0[4:0]; // @[IQDemodulator.scala 70:22]
  wire [7:0] _trajIdx_T_1 = trajIdx + 8'h1; // @[IQDemodulator.scala 73:26]
  wire [15:0] _demodDone_T_3 = _inWindow_T_2 - 16'h1; // @[IQDemodulator.scala 78:69]
  wire  windowStartSample = io_iqIn_valid & (io_sampleIndex == io_windowStart); // clear accumulators at each network-fed window
  NCO nco ( // @[IQDemodulator.scala 32:19]
    .clock(nco_clock),
    .reset(nco_reset),
    .io_omega(nco_io_omega),
    .io_enable(nco_io_enable),
    .io_reset(nco_io_reset),
    .io_cosOut(nco_io_cosOut),
    .io_sinOut(nco_io_sinOut)
  );
  assign io_iqIn_ready = io_enable; // @[IQDemodulator.scala 89:17]
  assign io_demodI = accumI; // @[IQDemodulator.scala 80:13]
  assign io_demodQ = accumQ; // @[IQDemodulator.scala 81:13]
  assign io_demodValid = io_sampleIndex == _demodDone_T_3 & io_iqIn_valid; // @[IQDemodulator.scala 78:76]
  assign io_trajLen = trajIdx; // @[IQDemodulator.scala 85:14]
  assign io_trajValid = io_sampleIndex == _demodDone_T_3 & io_iqIn_valid; // @[IQDemodulator.scala 78:76]
  assign nco_clock = clock;
  assign nco_reset = reset;
  assign nco_io_omega = io_omega; // @[IQDemodulator.scala 33:16]
  assign nco_io_enable = io_iqIn_valid & io_enable; // @[IQDemodulator.scala 34:34]
  assign nco_io_reset = io_reset; // @[IQDemodulator.scala 35:16]
  always @(posedge clock) begin
    if (reset) begin // @[IQDemodulator.scala 51:23]
      accumI <= 48'sh0; // @[IQDemodulator.scala 51:23]
    end else if (io_reset) begin // @[IQDemodulator.scala 54:18]
      accumI <= 48'sh0; // @[IQDemodulator.scala 55:12]
    end else if (windowStartSample) begin
      accumI <= _GEN_647;
    end else if (io_iqIn_valid & inWindow) begin // @[IQDemodulator.scala 57:41]
      accumI <= _accumI_T_2; // @[IQDemodulator.scala 58:12]
    end
    if (reset) begin // @[IQDemodulator.scala 52:23]
      accumQ <= 48'sh0; // @[IQDemodulator.scala 52:23]
    end else if (io_reset) begin // @[IQDemodulator.scala 54:18]
      accumQ <= 48'sh0; // @[IQDemodulator.scala 56:12]
    end else if (windowStartSample) begin
      accumQ <= _GEN_648;
    end else if (io_iqIn_valid & inWindow) begin // @[IQDemodulator.scala 57:41]
      accumQ <= _accumQ_T_2; // @[IQDemodulator.scala 59:12]
    end
    if (reset) begin // @[IQDemodulator.scala 64:24]
      trajIdx <= 8'h0; // @[IQDemodulator.scala 64:24]
    end else if (io_reset) begin // @[IQDemodulator.scala 66:18]
      trajIdx <= 8'h0; // @[IQDemodulator.scala 67:13]
    end else if (windowStartSample) begin
      trajIdx <= 8'h1;
    end else if (_T) begin // @[IQDemodulator.scala 68:41]
      if (_T_2 == 5'h0) begin // @[IQDemodulator.scala 70:51]
        trajIdx <= _trajIdx_T_1; // @[IQDemodulator.scala 73:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  accumI = _RAND_0[47:0];
  _RAND_1 = {2{`RANDOM}};
  accumQ = _RAND_1[47:0];
  _RAND_2 = {1{`RANDOM}};
  trajIdx = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TrajectoryAnalyzer(
  input   clock,
  input   io_trajValid,
  output  io_seqValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  io_seqValid_REG; // @[TrajectoryAnalyzer.scala 62:25]
  assign io_seqValid = io_seqValid_REG; // @[TrajectoryAnalyzer.scala 62:15]
  always @(posedge clock) begin
    io_seqValid_REG <= io_trajValid; // @[TrajectoryAnalyzer.scala 62:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_seqValid_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BranchHistoryTable(
  input         clock,
  input         reset,
  input         io_update_valid,
  input         io_update_state,
  output [15:0] io_query_probOne
);
  reg [15:0] count0;
  reg [15:0] count1;
  assign io_query_probOne = count1 > count0 ? 16'hc000 : (count1 < count0 ? 16'h4000 : 16'h8000);
  always @(posedge clock) begin
    if (reset) begin
      count0 <= 16'd1;
      count1 <= 16'd1;
    end else if (io_update_valid) begin
      if (io_update_state) begin
        if (count1 != 16'hffff) count1 <= count1 + 16'd1;
      end else begin
        if (count0 != 16'hffff) count0 <= count0 + 16'd1;
      end
    end
  end
endmodule
module BayesianPredictor(
  input         clock,
  input         reset,
  input  [7:0]  io_seqLen,
  input         io_seqValid,
  input  [15:0] io_bhtProb,
  input  [15:0] io_priorProb,
  input  [15:0] io_threshold,
  output [15:0] io_predictProb,
  output [7:0]  io_triggerTime
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT

  // 扩展状态机：将原来的 state 2 拆分成 5 个子状态
  // 0: IDLE
  // 1: WAIT_FOR_BHT
  // 2: CALC_MULT1 - 计算 numerator = io_bhtProb * currentProb
  // 3: CALC_MULT2 - 计算 term2 = oneMinusPobs * oneMinusPprior
  // 4: CALC_ADD - 计算 denominator = numerator + term2
  // 5: CALC_DIV - 计算 currentProb = numerator / denominator
  // 6: CHECK_THRESHOLD
  // 7: DONE
  reg [2:0] state;
  reg [7:0] timeStep;
  reg [15:0] currentProb;
  reg  triggered;
  reg [7:0] triggerTimeReg;

  // 流水线寄存器用于多周期计算
  reg [16:0] oneMinusPobs_reg;
  reg [16:0] oneMinusPprior_reg;
  reg [31:0] numerator_mult_reg;
  reg [15:0] numerator_reg;
  reg [33:0] term2_mult_reg;
  reg [17:0] term2_reg;
  reg [17:0] denominator_reg;

  // 除法器 IP 核信号
  wire        div_tvalid;
  wire        div_tready;
  wire [47:0] div_tdata;
  reg         div_start;
  reg  [31:0] div_dividend;
  reg  [17:0] div_divisor;

  // 除法器 IP 核实例
  divider_32_18 divider_inst (
    .aclk(clock),
    .s_axis_dividend_tvalid(div_start),
    .s_axis_dividend_tready(),
    .s_axis_dividend_tdata(div_dividend),
    .s_axis_divisor_tvalid(div_start),
    .s_axis_divisor_tready(),
    .s_axis_divisor_tdata(div_divisor),
    .m_axis_dout_tvalid(div_tvalid),
    .m_axis_dout_tdata(div_tdata)
  );

  // 提取除法结果（商在高 32 位）
  wire [31:0] div_quotient = div_tdata[47:16];

  wire  _T = 3'h0 == state;
  wire [15:0] _GEN_2 = io_seqValid ? io_priorProb : currentProb;
  wire  _T_1 = 3'h1 == state;
  wire [7:0] _bhtPattern_T_8 = timeStep + 8'h1;
  wire  _T_2 = 3'h2 == state;
  wire  _T_3 = 3'h3 == state;
  wire  _T_4 = 3'h4 == state;
  wire  _T_5 = 3'h5 == state;
  wire  _T_6 = 3'h6 == state;

  // 计算 1.0 - x (使用定点数，1.0 = 0x10000)
  wire [16:0] _GEN_1320 = {{1'd0}, io_bhtProb};
  wire [16:0] oneMinusPobs = 17'h10000 - _GEN_1320;
  wire [16:0] _GEN_1322 = {{1'd0}, currentProb};
  wire [16:0] oneMinusPprior = 17'h10000 - _GEN_1322;

  // 阶段 1: 乘法 numerator = io_bhtProb * currentProb
  wire [31:0] numerator_mult = io_bhtProb * currentProb;

  // 阶段 2: 乘法 term2 = oneMinusPobs * oneMinusPprior
  wire [33:0] term2_mult = oneMinusPobs_reg * oneMinusPprior_reg;

  // 阶段 3: 提取高位
  wire [15:0] numerator = numerator_mult_reg[31:16];
  wire [17:0] term2 = term2_mult_reg[33:16];

  // 阶段 4: 加法
  wire [17:0] _GEN_1323 = {{2'd0}, numerator_reg};
  wire [17:0] denominator = _GEN_1323 + term2_reg;

  // 阶段 5: 除法 - 使用 IP 核，不再是组合逻辑
  wire [31:0] _currentProb_T_1 = {numerator_reg, 16'h0};
  wire [31:0] new_prob_from_div = div_quotient[15:0] == 16'h0 ? currentProb : div_quotient[15:0];
  wire [31:0] new_prob = io_bhtProb == 16'h0 | _GEN_1320 == 17'h10000 ? {{16'd0}, io_bhtProb} : {{16'd0}, new_prob_from_div};

  // 置信度计算
  wire [16:0] conf = currentProb > 16'h8000 ? {{1'd0}, currentProb} : oneMinusPprior;
  wire [16:0] _GEN_1325 = {{1'd0}, io_threshold};
  wire [7:0] _T_11 = io_seqLen - 8'h8;

  wire  _T_13 = 3'h7 == state;

  assign io_predictProb = currentProb;
  assign io_triggerTime = triggerTimeReg;

  always @(posedge clock) begin
    if (reset) begin
      state <= 3'h0;
      timeStep <= 8'h0;
      currentProb <= 16'h0;
      triggered <= 1'h0;
      triggerTimeReg <= 8'h0;
      oneMinusPobs_reg <= 17'h0;
      oneMinusPprior_reg <= 17'h0;
      numerator_mult_reg <= 32'h0;
      numerator_reg <= 16'h0;
      term2_mult_reg <= 34'h0;
      term2_reg <= 18'h0;
      denominator_reg <= 18'h0;
      div_start <= 1'b0;
      div_dividend <= 32'h0;
      div_divisor <= 18'h0;
    end else begin
      div_start <= 1'b0; // 默认不启动除法器

      case (state)
        3'h0: begin // IDLE
          if (io_seqValid) begin
            state <= 3'h1;
            timeStep <= 8'h0;
            currentProb <= io_priorProb;
            triggered <= 1'h0;
            triggerTimeReg <= 8'h0;
          end
        end

        3'h1: begin // WAIT_FOR_BHT
          state <= 3'h2;
          // 保存 1-P 的值
          oneMinusPobs_reg <= oneMinusPobs;
          oneMinusPprior_reg <= oneMinusPprior;
        end

        3'h2: begin // CALC_MULT1 - 计算第一个乘法
          state <= 3'h3;
          numerator_mult_reg <= numerator_mult;
        end

        3'h3: begin // CALC_MULT2 - 计算第二个乘法
          state <= 3'h4;
          numerator_reg <= numerator;
          term2_mult_reg <= term2_mult;
        end

        3'h4: begin // CALC_ADD - 计算加法并启动除法器
          term2_reg <= term2;
          denominator_reg <= denominator;

          // 启动除法器
          if (denominator != 18'h0) begin
            div_start <= 1'b1;
            div_dividend <= _currentProb_T_1;
            div_divisor <= denominator;
            state <= 3'h5;
          end else begin
            // 除数为 0，跳过除法
            state <= 3'h6;
          end
        end

        3'h5: begin // CALC_DIV - 等待除法器完成
          if (div_tvalid) begin
            currentProb <= new_prob[15:0];
            state <= 3'h6;
          end
          // 否则继续等待
        end

        3'h6: begin // CHECK_THRESHOLD - 检查阈值
          // 检查是否触发
          if (~triggered && conf > _GEN_1325) begin
            triggered <= 1'h1;
            triggerTimeReg <= timeStep;
            state <= 3'h7;
          end else if (timeStep >= _T_11) begin
            state <= 3'h7;
          end else begin
            timeStep <= timeStep + 8'h1;
            state <= 3'h1; // 回到 WAIT_FOR_BHT，继续下一次迭代
          end
        end

        3'h7: begin // DONE
          state <= 3'h0;
        end

        default: begin
          state <= 3'h0;
        end
      endcase
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  timeStep = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  currentProb = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  triggered = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  triggerTimeReg = _RAND_4[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module StateClassifier(
  input         clock,
  input  [47:0] io_demodI,
  input  [47:0] io_demodQ,
  input         io_demodValid,
  input  [31:0] io_centerZeroI,
  input  [31:0] io_centerZeroQ,
  input  [31:0] io_centerOneI,
  input  [31:0] io_centerOneQ,
  output        io_state,
  output        io_stateValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [47:0] _GEN_0 = {{16{io_centerZeroI[31]}},io_centerZeroI}; // @[StateClassifier.scala 26:33]
  wire [47:0] diffI0 = $signed(io_demodI) - $signed(_GEN_0); // @[StateClassifier.scala 26:33]
  wire [47:0] _GEN_1 = {{16{io_centerZeroQ[31]}},io_centerZeroQ}; // @[StateClassifier.scala 27:33]
  wire [47:0] diffQ0 = $signed(io_demodQ) - $signed(_GEN_1); // @[StateClassifier.scala 27:33]
  wire [95:0] _dist0Sq_T = $signed(diffI0) * $signed(diffI0); // @[StateClassifier.scala 28:25]
  wire [95:0] _dist0Sq_T_1 = $signed(diffQ0) * $signed(diffQ0); // @[StateClassifier.scala 28:45]
  wire [95:0] dist0Sq = $signed(_dist0Sq_T) + $signed(_dist0Sq_T_1); // @[StateClassifier.scala 28:35]
  wire [47:0] _GEN_2 = {{16{io_centerOneI[31]}},io_centerOneI}; // @[StateClassifier.scala 30:33]
  wire [47:0] diffI1 = $signed(io_demodI) - $signed(_GEN_2); // @[StateClassifier.scala 30:33]
  wire [47:0] _GEN_3 = {{16{io_centerOneQ[31]}},io_centerOneQ}; // @[StateClassifier.scala 31:33]
  wire [47:0] diffQ1 = $signed(io_demodQ) - $signed(_GEN_3); // @[StateClassifier.scala 31:33]
  wire [95:0] _dist1Sq_T = $signed(diffI1) * $signed(diffI1); // @[StateClassifier.scala 32:25]
  wire [95:0] _dist1Sq_T_1 = $signed(diffQ1) * $signed(diffQ1); // @[StateClassifier.scala 32:45]
  wire [95:0] dist1Sq = $signed(_dist1Sq_T) + $signed(_dist1Sq_T_1); // @[StateClassifier.scala 32:35]
  wire centersEqual = (io_centerZeroI == io_centerOneI) & (io_centerZeroQ == io_centerOneQ);
  wire stateBySign = $signed(io_demodI) >= 48'sh0;
  reg  io_stateValid_REG; // @[StateClassifier.scala 36:27]
  assign io_state = centersEqual ? stateBySign : ($signed(dist0Sq) < $signed(dist1Sq) ? 1'h0 : 1'h1); // @[StateClassifier.scala 35:18]
  assign io_stateValid = io_stateValid_REG; // @[StateClassifier.scala 36:17]
  always @(posedge clock) begin
    io_stateValid_REG <= io_demodValid; // @[StateClassifier.scala 36:27]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_stateValid_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PerformanceCounter(
  input         clock,
  input         reset,
  input         io_predictState,
  input         io_actualState,
  input         io_valid,
  input         io_reset,
  output [31:0] io_totalShots,
  output [31:0] io_correctPreds,
  output [15:0] io_accuracy
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] totalCnt; // @[StateClassifier.scala 51:25]
  reg [31:0] correctCnt; // @[StateClassifier.scala 52:27]
  wire [31:0] _totalCnt_T_1 = totalCnt + 32'h1; // @[StateClassifier.scala 58:26]
  wire [31:0] _correctCnt_T_1 = correctCnt + 32'h1; // @[StateClassifier.scala 60:32]
  wire [47:0] _io_accuracy_T_1 = {correctCnt, 16'h0}; // @[StateClassifier.scala 70:17]
  wire [47:0] _io_accuracy_T_2 = _io_accuracy_T_1 / totalCnt; // @[StateClassifier.scala 70:38]
  wire [47:0] _io_accuracy_T_3 = totalCnt == 32'h0 ? 48'h0 : _io_accuracy_T_2; // @[StateClassifier.scala 68:21]
  assign io_totalShots = totalCnt; // @[StateClassifier.scala 64:17]
  assign io_correctPreds = correctCnt; // @[StateClassifier.scala 65:19]
  assign io_accuracy = _io_accuracy_T_3[15:0]; // @[StateClassifier.scala 68:15]
  always @(posedge clock) begin
    if (reset) begin // @[StateClassifier.scala 51:25]
      totalCnt <= 32'h0; // @[StateClassifier.scala 51:25]
    end else if (io_reset) begin // @[StateClassifier.scala 54:18]
      totalCnt <= 32'h0; // @[StateClassifier.scala 55:14]
    end else if (io_valid) begin // @[StateClassifier.scala 57:24]
      totalCnt <= _totalCnt_T_1; // @[StateClassifier.scala 58:14]
    end
    if (reset) begin // @[StateClassifier.scala 52:27]
      correctCnt <= 32'h0; // @[StateClassifier.scala 52:27]
    end else if (io_reset) begin // @[StateClassifier.scala 54:18]
      correctCnt <= 32'h0; // @[StateClassifier.scala 56:16]
    end else if (io_valid) begin // @[StateClassifier.scala 57:24]
      if (io_predictState == io_actualState) begin // @[StateClassifier.scala 59:46]
        correctCnt <= _correctCnt_T_1; // @[StateClassifier.scala 60:18]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  totalCnt = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  correctCnt = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ARTERYCore(
  input         clock,
  input         reset,
  output        io_iqIn_ready,
  input         io_iqIn_valid,
  input  [15:0] io_iqIn_bits_i,
  input  [15:0] io_iqIn_bits_q,
  input  [15:0] io_sampleIndex,
  input  [31:0] io_config_omega,
  input  [15:0] io_config_windowStart,
  input  [15:0] io_config_windowLen,
  input  [31:0] io_config_centerZeroI,
  input  [31:0] io_config_centerZeroQ,
  input  [31:0] io_config_centerOneI,
  input  [31:0] io_config_centerOneQ,
  input  [15:0] io_config_priorProb,
  input  [15:0] io_config_threshold,
  input         io_config_enable,
  input         io_config_reset,
  output [15:0] io_status_predictProb,
  output        io_status_predictState,
  output [15:0] io_status_triggerTime,
  output        io_status_actualState,
  output        io_status_predCorrect,
  output [31:0] io_status_totalShots,
  output [31:0] io_status_correctPreds,
  output [15:0] io_status_accuracy,
  output [15:0] io_status_predLatency,
  output [15:0] io_status_totalLatency,
  output        io_status_done
);
  wire  demod_clock; // @[ARTERYCore.scala 26:21]
  wire  demod_reset; // @[ARTERYCore.scala 26:21]
  wire  demod_io_iqIn_ready; // @[ARTERYCore.scala 26:21]
  wire  demod_io_iqIn_valid; // @[ARTERYCore.scala 26:21]
  wire [15:0] demod_io_iqIn_bits_i; // @[ARTERYCore.scala 26:21]
  wire [15:0] demod_io_iqIn_bits_q; // @[ARTERYCore.scala 26:21]
  wire [15:0] demod_io_sampleIndex; // @[ARTERYCore.scala 26:21]
  wire [31:0] demod_io_omega; // @[ARTERYCore.scala 26:21]
  wire [15:0] demod_io_windowStart; // @[ARTERYCore.scala 26:21]
  wire [15:0] demod_io_windowLen; // @[ARTERYCore.scala 26:21]
  wire  demod_io_enable; // @[ARTERYCore.scala 26:21]
  wire  demod_io_reset; // @[ARTERYCore.scala 26:21]
  wire [47:0] demod_io_demodI; // @[ARTERYCore.scala 26:21]
  wire [47:0] demod_io_demodQ; // @[ARTERYCore.scala 26:21]
  wire  demod_io_demodValid; // @[ARTERYCore.scala 26:21]
  wire [7:0] demod_io_trajLen; // @[ARTERYCore.scala 26:21]
  wire  demod_io_trajValid; // @[ARTERYCore.scala 26:21]
  wire  trajAnalyzer_clock; // @[ARTERYCore.scala 36:28]
  wire  trajAnalyzer_io_trajValid; // @[ARTERYCore.scala 36:28]
  wire  trajAnalyzer_io_seqValid; // @[ARTERYCore.scala 36:28]
  wire  bht_clock; // @[ARTERYCore.scala 46:19]
  wire [15:0] bht_io_query_probOne; // @[ARTERYCore.scala 46:19]
  wire  hht_clock; // @[ARTERYCore.scala 47:19]
  wire [15:0] hht_io_query_probOne; // @[ARTERYCore.scala 47:19]
  wire  predictor_clock; // @[ARTERYCore.scala 48:25]
  wire  predictor_reset; // @[ARTERYCore.scala 48:25]
  wire [7:0] predictor_io_seqLen; // @[ARTERYCore.scala 48:25]
  wire  predictor_io_seqValid; // @[ARTERYCore.scala 48:25]
  wire [15:0] predictor_io_bhtProb; // @[ARTERYCore.scala 48:25]
  wire [15:0] predictor_io_priorProb; // @[ARTERYCore.scala 48:25]
  wire [15:0] predictor_io_threshold; // @[ARTERYCore.scala 48:25]
  wire [15:0] predictor_io_predictProb; // @[ARTERYCore.scala 48:25]
  wire [7:0] predictor_io_triggerTime; // @[ARTERYCore.scala 48:25]
  wire  classifier_clock; // @[ARTERYCore.scala 84:26]
  wire [47:0] classifier_io_demodI; // @[ARTERYCore.scala 84:26]
  wire [47:0] classifier_io_demodQ; // @[ARTERYCore.scala 84:26]
  wire  classifier_io_demodValid; // @[ARTERYCore.scala 84:26]
  wire [31:0] classifier_io_centerZeroI; // @[ARTERYCore.scala 84:26]
  wire [31:0] classifier_io_centerZeroQ; // @[ARTERYCore.scala 84:26]
  wire [31:0] classifier_io_centerOneI; // @[ARTERYCore.scala 84:26]
  wire [31:0] classifier_io_centerOneQ; // @[ARTERYCore.scala 84:26]
  wire  classifier_io_state; // @[ARTERYCore.scala 84:26]
  wire  classifier_io_stateValid; // @[ARTERYCore.scala 84:26]
  wire  perfCounter_clock; // @[ARTERYCore.scala 94:27]
  wire  perfCounter_reset; // @[ARTERYCore.scala 94:27]
  wire  perfCounter_io_predictState; // @[ARTERYCore.scala 94:27]
  wire  perfCounter_io_actualState; // @[ARTERYCore.scala 94:27]
  wire  perfCounter_io_valid; // @[ARTERYCore.scala 94:27]
  wire  perfCounter_io_reset; // @[ARTERYCore.scala 94:27]
  wire [31:0] perfCounter_io_totalShots; // @[ARTERYCore.scala 94:27]
  wire [31:0] perfCounter_io_correctPreds; // @[ARTERYCore.scala 94:27]
  wire [15:0] perfCounter_io_accuracy; // @[ARTERYCore.scala 94:27]
  wire  predictState = predictor_io_predictProb > 16'h8000; // @[ARTERYCore.scala 95:51]
  wire [12:0] _io_status_predLatency_T = predictor_io_triggerTime * 5'h19; // @[ARTERYCore.scala 114:53]
  reg [15:0] status_predict_prob;
  reg        status_predict_state;
  reg        status_actual_state;
  reg        status_pred_correct;
  reg        status_done;
  reg        predict_state_for_window;
  IQDemodulator demod ( // @[ARTERYCore.scala 26:21]
    .clock(demod_clock),
    .reset(demod_reset),
    .io_iqIn_ready(demod_io_iqIn_ready),
    .io_iqIn_valid(demod_io_iqIn_valid),
    .io_iqIn_bits_i(demod_io_iqIn_bits_i),
    .io_iqIn_bits_q(demod_io_iqIn_bits_q),
    .io_sampleIndex(demod_io_sampleIndex),
    .io_omega(demod_io_omega),
    .io_windowStart(demod_io_windowStart),
    .io_windowLen(demod_io_windowLen),
    .io_enable(demod_io_enable),
    .io_reset(demod_io_reset),
    .io_demodI(demod_io_demodI),
    .io_demodQ(demod_io_demodQ),
    .io_demodValid(demod_io_demodValid),
    .io_trajLen(demod_io_trajLen),
    .io_trajValid(demod_io_trajValid)
  );
  TrajectoryAnalyzer trajAnalyzer ( // @[ARTERYCore.scala 36:28]
    .clock(trajAnalyzer_clock),
    .io_trajValid(trajAnalyzer_io_trajValid),
    .io_seqValid(trajAnalyzer_io_seqValid)
  );
  BranchHistoryTable bht ( // @[ARTERYCore.scala 46:19]
    .clock(bht_clock),
    .reset(reset),
    .io_update_valid(classifier_io_stateValid),
    .io_update_state(classifier_io_state),
    .io_query_probOne(bht_io_query_probOne)
  );
  BranchHistoryTable hht ( // @[ARTERYCore.scala 47:19]
    .clock(hht_clock),
    .reset(reset),
    .io_update_valid(classifier_io_stateValid),
    .io_update_state(classifier_io_state),
    .io_query_probOne(hht_io_query_probOne)
  );
  BayesianPredictor predictor ( // @[ARTERYCore.scala 48:25]
    .clock(predictor_clock),
    .reset(predictor_reset),
    .io_seqLen(predictor_io_seqLen),
    .io_seqValid(predictor_io_seqValid),
    .io_bhtProb(predictor_io_bhtProb),
    .io_priorProb(predictor_io_priorProb),
    .io_threshold(predictor_io_threshold),
    .io_predictProb(predictor_io_predictProb),
    .io_triggerTime(predictor_io_triggerTime)
  );
  StateClassifier classifier ( // @[ARTERYCore.scala 84:26]
    .clock(classifier_clock),
    .io_demodI(classifier_io_demodI),
    .io_demodQ(classifier_io_demodQ),
    .io_demodValid(classifier_io_demodValid),
    .io_centerZeroI(classifier_io_centerZeroI),
    .io_centerZeroQ(classifier_io_centerZeroQ),
    .io_centerOneI(classifier_io_centerOneI),
    .io_centerOneQ(classifier_io_centerOneQ),
    .io_state(classifier_io_state),
    .io_stateValid(classifier_io_stateValid)
  );
  PerformanceCounter perfCounter ( // @[ARTERYCore.scala 94:27]
    .clock(perfCounter_clock),
    .reset(perfCounter_reset),
    .io_predictState(perfCounter_io_predictState),
    .io_actualState(perfCounter_io_actualState),
    .io_valid(perfCounter_io_valid),
    .io_reset(perfCounter_io_reset),
    .io_totalShots(perfCounter_io_totalShots),
    .io_correctPreds(perfCounter_io_correctPreds),
    .io_accuracy(perfCounter_io_accuracy)
  );
  assign io_iqIn_ready = demod_io_iqIn_ready; // @[ARTERYCore.scala 27:17]
  assign io_status_predictProb = status_predict_prob; // @[ARTERYCore.scala 102:25]
  assign io_status_predictState = status_predict_state; // @[ARTERYCore.scala 95:51]
  assign io_status_triggerTime = {{8'd0}, predictor_io_triggerTime}; // @[ARTERYCore.scala 105:25]
  assign io_status_actualState = status_actual_state; // @[ARTERYCore.scala 107:25]
  assign io_status_predCorrect = status_pred_correct; // @[ARTERYCore.scala 108:67]
  assign io_status_totalShots = perfCounter_io_totalShots; // @[ARTERYCore.scala 110:24]
  assign io_status_correctPreds = perfCounter_io_correctPreds; // @[ARTERYCore.scala 111:26]
  assign io_status_accuracy = perfCounter_io_accuracy; // @[ARTERYCore.scala 112:22]
  assign io_status_predLatency = {{3'd0}, _io_status_predLatency_T}; // @[ARTERYCore.scala 114:53]
  assign io_status_totalLatency = io_config_windowLen; // @[ARTERYCore.scala 115:26]
  assign io_status_done = status_done; // @[ARTERYCore.scala 118:18]
  assign demod_clock = clock;
  assign demod_reset = reset;
  assign demod_io_iqIn_valid = io_iqIn_valid; // @[ARTERYCore.scala 27:17]
  assign demod_io_iqIn_bits_i = io_iqIn_bits_i; // @[ARTERYCore.scala 27:17]
  assign demod_io_iqIn_bits_q = io_iqIn_bits_q; // @[ARTERYCore.scala 27:17]
  assign demod_io_sampleIndex = io_sampleIndex; // @[ARTERYCore.scala 28:24]
  assign demod_io_omega = io_config_omega; // @[ARTERYCore.scala 29:18]
  assign demod_io_windowStart = io_config_windowStart; // @[ARTERYCore.scala 30:24]
  assign demod_io_windowLen = io_config_windowLen; // @[ARTERYCore.scala 31:22]
  assign demod_io_enable = io_config_enable; // @[ARTERYCore.scala 32:19]
  assign demod_io_reset = io_config_reset; // @[ARTERYCore.scala 33:18]
  assign trajAnalyzer_clock = clock;
  assign trajAnalyzer_io_trajValid = demod_io_trajValid; // @[ARTERYCore.scala 39:29]
  assign bht_clock = clock;
  assign hht_clock = clock;
  assign predictor_clock = clock;
  assign predictor_reset = reset;
  assign predictor_io_seqLen = demod_io_trajLen; // @[ARTERYCore.scala 62:23]
  assign predictor_io_seqValid = trajAnalyzer_io_seqValid; // @[ARTERYCore.scala 63:25]
  assign predictor_io_bhtProb = bht_io_query_probOne; // @[ARTERYCore.scala 69:24]
  assign predictor_io_priorProb = io_config_priorProb; // @[ARTERYCore.scala 64:26]
  assign predictor_io_threshold = io_config_threshold; // @[ARTERYCore.scala 65:26]
  assign classifier_clock = clock;
  assign classifier_io_demodI = demod_io_demodI; // @[ARTERYCore.scala 85:24]
  assign classifier_io_demodQ = demod_io_demodQ; // @[ARTERYCore.scala 86:24]
  assign classifier_io_demodValid = demod_io_demodValid; // @[ARTERYCore.scala 87:28]
  assign classifier_io_centerZeroI = io_config_centerZeroI; // @[ARTERYCore.scala 88:29]
  assign classifier_io_centerZeroQ = io_config_centerZeroQ; // @[ARTERYCore.scala 89:29]
  assign classifier_io_centerOneI = io_config_centerOneI; // @[ARTERYCore.scala 90:28]
  assign classifier_io_centerOneQ = io_config_centerOneQ; // @[ARTERYCore.scala 91:28]
  assign perfCounter_clock = clock;
  assign perfCounter_reset = reset;
  assign perfCounter_io_predictState = predict_state_for_window; // @[ARTERYCore.scala 95:51]
  assign perfCounter_io_actualState = classifier_io_state; // @[ARTERYCore.scala 97:30]
  assign perfCounter_io_valid = classifier_io_stateValid; // @[ARTERYCore.scala 98:24]
  assign perfCounter_io_reset = io_config_reset; // @[ARTERYCore.scala 99:24]
  always @(posedge clock) begin
    if (reset | io_config_reset) begin
      status_predict_prob <= 16'h0;
      status_predict_state <= 1'b0;
      status_actual_state <= 1'b0;
      status_pred_correct <= 1'b0;
      status_done <= 1'b0;
      predict_state_for_window <= 1'b0;
    end else begin
      status_done <= 1'b0;
      if (trajAnalyzer_io_seqValid) begin
        predict_state_for_window <= predictState;
      end
      if (classifier_io_stateValid) begin
        status_predict_prob <= predictor_io_predictProb;
        status_predict_state <= predict_state_for_window;
        status_actual_state <= classifier_io_state;
        status_pred_correct <= predict_state_for_window == classifier_io_state;
        status_done <= 1'b1;
      end
    end
  end
endmodule
module ARTERYTop(
  input         clock,
  input         reset,
  input  [31:0] io_config_omega,
  input  [15:0] io_config_windowStart,
  input  [15:0] io_config_windowLen,
  input  [31:0] io_config_centerZeroI,
  input  [31:0] io_config_centerZeroQ,
  input  [31:0] io_config_centerOneI,
  input  [31:0] io_config_centerOneQ,
  input  [15:0] io_config_priorProb,
  input  [15:0] io_config_threshold,
  input  [15:0] io_config_shotIndex,
  input         io_config_stateSelect,
  input         io_config_enable,
  input         io_config_trigger,
  input         io_config_reset,
  output [15:0] io_status_predictProb,
  output        io_status_predictState,
  output [15:0] io_status_confidence,
  output [15:0] io_status_triggerTime,
  output        io_status_actualState,
  output        io_status_predCorrect,
  output [31:0] io_status_totalShots,
  output [31:0] io_status_correctPreds,
  output [15:0] io_status_accuracy,
  output [15:0] io_status_predLatency,
  output [15:0] io_status_totalLatency,
  output        io_status_busy,
  output        io_status_done,
  output        io_status_error
);
  wire  ddrPlayer_clock; // @[ARTERYTop.scala 18:25]
  wire  ddrPlayer_reset; // @[ARTERYTop.scala 18:25]
  wire  ddrPlayer_io_trigger; // @[ARTERYTop.scala 18:25]
  wire  ddrPlayer_io_iqOut_ready; // @[ARTERYTop.scala 18:25]
  wire  ddrPlayer_io_iqOut_valid; // @[ARTERYTop.scala 18:25]
  wire [15:0] ddrPlayer_io_iqOut_bits_i; // @[ARTERYTop.scala 18:25]
  wire [15:0] ddrPlayer_io_iqOut_bits_q; // @[ARTERYTop.scala 18:25]
  wire [15:0] ddrPlayer_io_sampleIndex; // @[ARTERYTop.scala 18:25]
  wire  core_clock; // @[ARTERYTop.scala 24:20]
  wire  core_reset; // @[ARTERYTop.scala 24:20]
  wire  core_io_iqIn_ready; // @[ARTERYTop.scala 24:20]
  wire  core_io_iqIn_valid; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_iqIn_bits_i; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_iqIn_bits_q; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_sampleIndex; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_config_omega; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_config_windowStart; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_config_windowLen; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_config_centerZeroI; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_config_centerZeroQ; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_config_centerOneI; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_config_centerOneQ; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_config_priorProb; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_config_threshold; // @[ARTERYTop.scala 24:20]
  wire  core_io_config_enable; // @[ARTERYTop.scala 24:20]
  wire  core_io_config_reset; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_status_predictProb; // @[ARTERYTop.scala 24:20]
  wire  core_io_status_predictState; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_status_triggerTime; // @[ARTERYTop.scala 24:20]
  wire  core_io_status_actualState; // @[ARTERYTop.scala 24:20]
  wire  core_io_status_predCorrect; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_status_totalShots; // @[ARTERYTop.scala 24:20]
  wire [31:0] core_io_status_correctPreds; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_status_accuracy; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_status_predLatency; // @[ARTERYTop.scala 24:20]
  wire [15:0] core_io_status_totalLatency; // @[ARTERYTop.scala 24:20]
  wire  core_io_status_done; // @[ARTERYTop.scala 24:20]
  DDRDataPlayer ddrPlayer ( // @[ARTERYTop.scala 18:25]
    .clock(ddrPlayer_clock),
    .reset(ddrPlayer_reset),
    .io_trigger(ddrPlayer_io_trigger),
    .io_iqOut_ready(ddrPlayer_io_iqOut_ready),
    .io_iqOut_valid(ddrPlayer_io_iqOut_valid),
    .io_iqOut_bits_i(ddrPlayer_io_iqOut_bits_i),
    .io_iqOut_bits_q(ddrPlayer_io_iqOut_bits_q),
    .io_sampleIndex(ddrPlayer_io_sampleIndex)
  );
  ARTERYCore core ( // @[ARTERYTop.scala 24:20]
    .clock(core_clock),
    .reset(core_reset),
    .io_iqIn_ready(core_io_iqIn_ready),
    .io_iqIn_valid(core_io_iqIn_valid),
    .io_iqIn_bits_i(core_io_iqIn_bits_i),
    .io_iqIn_bits_q(core_io_iqIn_bits_q),
    .io_sampleIndex(core_io_sampleIndex),
    .io_config_omega(core_io_config_omega),
    .io_config_windowStart(core_io_config_windowStart),
    .io_config_windowLen(core_io_config_windowLen),
    .io_config_centerZeroI(core_io_config_centerZeroI),
    .io_config_centerZeroQ(core_io_config_centerZeroQ),
    .io_config_centerOneI(core_io_config_centerOneI),
    .io_config_centerOneQ(core_io_config_centerOneQ),
    .io_config_priorProb(core_io_config_priorProb),
    .io_config_threshold(core_io_config_threshold),
    .io_config_enable(core_io_config_enable),
    .io_config_reset(core_io_config_reset),
    .io_status_predictProb(core_io_status_predictProb),
    .io_status_predictState(core_io_status_predictState),
    .io_status_triggerTime(core_io_status_triggerTime),
    .io_status_actualState(core_io_status_actualState),
    .io_status_predCorrect(core_io_status_predCorrect),
    .io_status_totalShots(core_io_status_totalShots),
    .io_status_correctPreds(core_io_status_correctPreds),
    .io_status_accuracy(core_io_status_accuracy),
    .io_status_predLatency(core_io_status_predLatency),
    .io_status_totalLatency(core_io_status_totalLatency),
    .io_status_done(core_io_status_done)
  );
  assign io_status_predictProb = core_io_status_predictProb; // @[ARTERYTop.scala 30:13]
  assign io_status_predictState = core_io_status_predictState; // @[ARTERYTop.scala 30:13]
  assign io_status_confidence = 16'h0; // @[ARTERYTop.scala 30:13]
  assign io_status_triggerTime = core_io_status_triggerTime; // @[ARTERYTop.scala 30:13]
  assign io_status_actualState = core_io_status_actualState; // @[ARTERYTop.scala 30:13]
  assign io_status_predCorrect = core_io_status_predCorrect; // @[ARTERYTop.scala 30:13]
  assign io_status_totalShots = core_io_status_totalShots; // @[ARTERYTop.scala 30:13]
  assign io_status_correctPreds = core_io_status_correctPreds; // @[ARTERYTop.scala 30:13]
  assign io_status_accuracy = core_io_status_accuracy; // @[ARTERYTop.scala 30:13]
  assign io_status_predLatency = core_io_status_predLatency; // @[ARTERYTop.scala 30:13]
  assign io_status_totalLatency = core_io_status_totalLatency; // @[ARTERYTop.scala 30:13]
  assign io_status_busy = 1'h1; // @[ARTERYTop.scala 30:13]
  assign io_status_done = core_io_status_done; // @[ARTERYTop.scala 30:13]
  assign io_status_error = 1'h0; // @[ARTERYTop.scala 30:13]
  assign ddrPlayer_clock = clock;
  assign ddrPlayer_reset = reset;
  assign ddrPlayer_io_trigger = io_config_trigger; // @[ARTERYTop.scala 19:24]
  assign ddrPlayer_io_iqOut_ready = core_io_iqIn_ready; // @[ARTERYTop.scala 25:16]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_iqIn_valid = ddrPlayer_io_iqOut_valid; // @[ARTERYTop.scala 25:16]
  assign core_io_iqIn_bits_i = ddrPlayer_io_iqOut_bits_i; // @[ARTERYTop.scala 25:16]
  assign core_io_iqIn_bits_q = ddrPlayer_io_iqOut_bits_q; // @[ARTERYTop.scala 25:16]
  assign core_io_sampleIndex = ddrPlayer_io_sampleIndex; // @[ARTERYTop.scala 26:23]
  assign core_io_config_omega = io_config_omega; // @[ARTERYTop.scala 27:18]
  assign core_io_config_windowStart = io_config_windowStart; // @[ARTERYTop.scala 27:18]
  assign core_io_config_windowLen = io_config_windowLen; // @[ARTERYTop.scala 27:18]
  assign core_io_config_centerZeroI = io_config_centerZeroI; // @[ARTERYTop.scala 27:18]
  assign core_io_config_centerZeroQ = io_config_centerZeroQ; // @[ARTERYTop.scala 27:18]
  assign core_io_config_centerOneI = io_config_centerOneI; // @[ARTERYTop.scala 27:18]
  assign core_io_config_centerOneQ = io_config_centerOneQ; // @[ARTERYTop.scala 27:18]
  assign core_io_config_priorProb = io_config_priorProb; // @[ARTERYTop.scala 27:18]
  assign core_io_config_threshold = io_config_threshold; // @[ARTERYTop.scala 27:18]
  assign core_io_config_enable = io_config_enable; // @[ARTERYTop.scala 27:18]
  assign core_io_config_reset = io_config_reset; // @[ARTERYTop.scala 27:18]
endmodule
