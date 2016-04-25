`timescale 1s/1s

module ZeroExtend (in, out);
  input [3:0] in;
  output [7:0] out;

  assign out[3:0] = in[3:0];
  assign out[7:4] = 0;
endmodule