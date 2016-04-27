module ZeroExtend_2 (in, out);
  input [2:0] in;
  output [7:0] out;

  assign out = {5'b0000,in};
endmodule