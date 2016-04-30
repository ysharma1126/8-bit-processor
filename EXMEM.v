module EXMEM(clock,WB,M,ALUOut,RegRD,WriteDataIn,Mreg,WBreg,ALUreg,RegRDreg,WriteDataOut);

	input clock;
	input [1:0] WB;
	input [1:0] M;
	input [0:0] RegRD;
	input [7:0] ALUOut,WriteDataIn;
	output [1:0] WBreg;
	output [1:0] Mreg;
	output [0:0] RegRDreg;
	output [7:0] ALUreg,WriteDataOut;

	reg [1:0] WBreg;
	reg [1:0] Mreg;
	reg [0:0] RegRDreg;
	reg [7:0] ALUreg,WriteDataOut;



	initial begin
		WBreg=0;
		Mreg=0;
		RegRDreg=0;
		ALUreg=0;
		WriteDataOut=0;
	end

	always@(posedge clock) 
	begin
		WBreg<=WB;
		Mreg<=M;
		RegRDreg<=RegRD;
		ALUreg<=ALUOut;
		WriteDataOut<=WriteDataIn;
	end
endmodule