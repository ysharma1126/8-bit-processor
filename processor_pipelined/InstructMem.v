module InstructMem(PC,Inst);
	input [7:0] PC;
	output [7:0] Inst;

	reg [7:0] regfile [0:255];

	initial begin 
	$readmemb("memp.txt", regfile);
	end

	assign Inst  = regfile[PC];
endmodule