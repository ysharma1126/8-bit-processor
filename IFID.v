module IFID(flush,clock,IFIDWrite,PC_Plus1,Inst,InstReg,PC_Plus1Reg);
	input [7:0] PC_Plus1,Inst;
	input clock,IFIDWrite,flush;
	output [7:0] InstReg, PC_Plus1Reg;

	reg [7:0] InstReg, PC_Plus1Reg;

	initial begin
		InstReg = 0;
		PC_Plus1Reg = 0;
	end

	always@(posedge clock) 
	begin
		if(flush) 
		begin
			InstReg <= 0;
			PC_Plus1Reg <= 0;
		end

		else if(IFIDWrite) 
		begin
			InstReg <= Inst;
			PC_Plus1Reg <= PC_Plus1;
		end
	end
endmodule