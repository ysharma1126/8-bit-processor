module SignExtend (in, out);
  input [2:0] in;
  output [7:0] out;

  assign out[2:0] = in[2:0];
  assign out[7:5] = in[2];
endmodule
