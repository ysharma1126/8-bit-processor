module MEMWB(clock,WB,Memout,ALUOut,RegRD,WBreg,Memreg,ALUreg,RegRDreg);

	input clock;
	input [1:0] WB;
	input [0:0] RegRD;
	input [7:0] Memout,ALUOut;
	output [1:0] WBreg;
	output [0:0] RegRDreg;
	output [7:0] Memreg,ALUreg;

	reg [1:0] WBreg;
	reg [0:0] RegRDreg;
	reg [7:0] Memreg,ALUreg;

	initial begin
		WBreg=0;
		RegRDreg=0;
		Memreg=0;
		ALUreg=0;
	end

	always@(posedge clock) 
	begin
		WBreg<=WB;
		Memreg<=Memout;
		ALUreg<=ALUOut;
		RegRDreg<=RegRD;
	end
endmodule