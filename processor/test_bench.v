module test_bench ();

//---------------------------
reg osc;
initial begin
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
wire branch, PCSrc;
wire [1:0] ALUCtrlSig;
reg lireg;

wire [IM_ADDR_W_m1:0] newIADDR, iABUS;
MIPSPC PC(clk, newIADDR, iABUS);

wire [IM_DATA_W_m1:0] iDATABUS;
IM instMem(1'b0,1'b1, iABUS, iDATABUS);

wire [0:0] RFWriteAddr;
wire [7:0] ReadData1, ReadData2, WriteData;
MIPSREG RegFile(clk, RegWrite, iDATABUS[4:4], iDATABUS[3:3], RFWriteAddr, ReadData1, ReadData2, WriteData);

wire [7:0] ALUSndInput1, ALUSndInput2, ALUOut;
wire Zero;
MIPSALU ALU(ALUCtrlSig, ALUSndInput2, ALUSndInput1, ALUOut, Zero);

wire [DM_DATA_W_m1:0] dDATABUS;
DM dataMem(MemWrite, ALUOut, ReadData2, dDATABUS);

wire [7:0] extended8_1, extended8_2;
SignExtend SignExt(iDATABUS[2:0], extended8_1[7:0]);
ZeroExtend ZeroExt(iDATABUS[3:0], extended8_2[7:0]);

assign PCSrc = Zero & branch;
getNextPC NextPC(PCSrc, iDATABUS, jump, iABUS, extended8, newIADDR);

STwoToOne TwoToOne_1(ALUSrc, ReadData2, extended8, ALUSndInput1); 
STwoToOne TwoToOne_2(MemToReg, ALUOut, dDATABUS, WriteData); 
STwoToOne TwoToOne_3(lireg, ReadData1,8'b00000000, ALUSndInput2);
STwoToOne TwoToOne_4(M, extended8_1, extended8_2, extended8);


MIPSCtrl Control(instr, lireg, ALUSrc, MemToReg, RegWrite, MemWrite, branch, M, jump, ALUCtrl);

endmodule

