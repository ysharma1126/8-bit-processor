module IDEX(clock,WB,M,EX,DataA,DataB,imm_value,RegRs,RegRt,WBreg,Mreg,EXreg,DataAreg,DataBreg,imm_valuereg,RegRsreg,RegRtreg);

	input clock;
	input [1:0] WB;
	input [1:0] M;
	input [1:0] EX;
	input [0:0] RegRs,RegRt;
	input [7:0] DataA,DataB,imm_value;
	output [1:0] WBreg;
	output [1:0] Mreg;
	output [1:0] EXreg;
	output [0:0] RegRsreg,RegRtreg;
	output [7:0] DataAreg,DataBreg,imm_valuereg;

	reg [1:0] WBreg;
	reg [1:0] Mreg;
	reg [1:0] EXreg;
	reg [0:0] RegRsreg,RegRtreg;
	reg [7:0] DataAreg,DataBreg,imm_valuereg;

	initial begin
		WBreg=0;
		Mreg=0;
		EXreg=0;
		DataAreg=0;
		imm_valuereg=0;
		RegRsreg=0;
		RegRtreg=0;
	end

	always@(posedge clock)
	begin
		WBreg<=WB;
		Mreg<=M;
		EXreg<=EX;
		DataAreg<=DataA;
		imm_valuereg<=imm_value;
		RegRsreg<=RegRs;
		RegRtreg<=RegRt;
	end
endmodule

