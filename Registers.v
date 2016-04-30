module Registers(clock,WE,InData,WrReg,ReadA,ReadB,OutA,OutB,reg0,reg1);

input [0:0] WrReg,ReadA,ReadB;
input WE,clock;
input [7:0] InData;
output [7:0] OutA,OutB;
output [7:0] reg0,reg1;

reg [7:0] OutA,OutB;
reg [7:0] regfile[0:1];

integer i;

initial begin
	for (i=0; i <= 1; i = i + 1)
    	regfile[i] = 0;
end

initial begin
	OutA = 0;
	OutB = 0;
end

always@(clock,InData,WrReg,WE)
begin
	if(WE && clock)
	begin
		regfile[WrReg]<=InData;
		//$display("Does WrReg: %d Data: %d",WrReg,InData);
	end
end


always@(clock,ReadA,ReadB,WrReg)
begin
	if(~clock)
	begin
		OutA<=regfile[ReadA];
		OutB<=regfile[ReadB];
		//$monitor("R0: %d R1: %d", regfile[0],regfile[1]);
	end
end

assign reg0 = regfile[0];
assign reg1 = regfile[1];

endmodule