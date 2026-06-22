`timescale 1ns / 1ps

module axis_128_to_256_packer (
    input  wire         clk,
    input  wire         rst_n,

    input  wire [127:0] s_axis_tdata,
    input  wire         s_axis_tvalid,
    output wire         s_axis_tready,

    output wire [255:0] m_axis_tdata,
    output wire         m_axis_tvalid,
    input  wire         m_axis_tready
);

  reg [127:0] first_half;
  reg         have_first;
  reg [255:0] out_data;
  reg         out_valid;

  assign s_axis_tready = !out_valid || m_axis_tready;
  assign m_axis_tdata  = out_data;
  assign m_axis_tvalid = out_valid;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      first_half <= 128'd0;
      have_first <= 1'b0;
      out_data <= 256'd0;
      out_valid <= 1'b0;
    end else begin
      if (out_valid && m_axis_tready)
        out_valid <= 1'b0;

      if (s_axis_tvalid && s_axis_tready) begin
        if (!have_first) begin
          first_half <= s_axis_tdata;
          have_first <= 1'b1;
        end else begin
          out_data <= {s_axis_tdata, first_half};
          out_valid <= 1'b1;
          have_first <= 1'b0;
        end
      end
    end
  end

endmodule
