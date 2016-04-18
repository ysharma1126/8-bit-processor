module STwoToOne (sel, in0, in1, out);
  input sel;
  input [7:0] in0, in1;
  output reg [7:0] out;

	always @(sel, in0, in1)
		if (sel == 0)
			out <= in0;
		else
			out <= in1;	  
endmodule