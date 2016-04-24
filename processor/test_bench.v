`timescale 1s/1s

module test_bench ();

//---------------------------
reg osc;
initial begin
	//$monitor("clock = %b Addr:%b Data:%b REG0:%b REG1:%b",clk, iABUS, iDATABUS, ,output1,output2);
	osc = 0;
end


always begin
#100 osc = ~osc;
end
wire clk;
assign clk = osc; 
//---------------------------
parameter DM_DATA_W_m1 = 7;
parameter DM_ADDR_W_m1 = 7;

parameter IM_DATA_W_m1 = 7;
parameter IM_ADDR_W_m1 = 7;
//---------------------------

wire ALUSrc;
wire MemToReg;
wire RegWrite;
wire MemWrite;
wire MemRead;
wire branch, PCSrc;
wire [1:0] ALUCtrlSig;
wire li;

wire [IM_ADDR_W_m1:0] newIADDR, iABUS;
MIPSPC PC(clk, newIADDR, iABUS);

wire [IM_DATA_W_m1:0] iDATABUS;
IM instMem(iABUS, iDATABUS);

wire [0:0] RFWriteAddr;
wire [7:0] ReadData1, ReadData2, WriteData, output1, output2;
MIPSREG RegFile(clk, RegWrite, iDATABUS[4:4], iDATABUS[3:3], iDATABUS[3:3], ReadData1, ReadData2, WriteData,output1,output2);

wire [7:0] ALUSndInput1, ALUSndInput2, ALUOut;
wire Zero;
MIPSALU ALU(ALUCtrlSig, ALUSndInput2, ALUSndInput1, ALUOut, Zero);

wire [DM_DATA_W_m1:0] dDATABUS;
DM dataMem(MemRead, MemWrite, ALUOut, ReadData2, dDATABUS);

wire [7:0] extended8_1, extended8_2, extended8;
SignExtend SignExt(iDATABUS[2:0], extended8_1[7:0]);
ZeroExtend ZeroExt(iDATABUS[3:0], extended8_2[7:0]);

assign PCSrc = Zero & branch;
getNextPC NextPC(PCSrc, iDATABUS, jump, iABUS, extended8, newIADDR);

lireg LI(clk, iDATABUS, li);

STwoToOne TwoToOne_1(ALUSrc, ReadData2, extended8, ALUSndInput1); 
STwoToOne TwoToOne_2(MemToReg, ALUOut, dDATABUS, WriteData); 
STwoToOne TwoToOne_3(li, ReadData1,8'b00000000, ALUSndInput2);
STwoToOne TwoToOne_4(M, extended8_1, extended8_2, extended8);

MIPSCtrl Control(iDATABUS, li, ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, branch, M, jump, ALUCtrlSig);

endmodule

