module getNextPC (PCSrc, currPC, offset, out);
  parameter MIPS_PC_WIDTH_m1 = 7;  
  input PCSrc;
  input [MIPS_PC_WIDTH_m1:0] offset;
  input [MIPS_PC_WIDTH_m1:0] currPC;
  output reg [MIPS_PC_WIDTH_m1:0] out;

	always @(PCSrc, currPC, offset)
		if (PCSrc == 0)
			out <= currPC + 1;
		else
			out <= currPC + 1 + offset;	  
  endmodule