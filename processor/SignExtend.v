module SignExtend (in, out);
  input [2:0] in;
  output [7:0] out;

  assign out = {{5{in[2]}},in};
endmodule
