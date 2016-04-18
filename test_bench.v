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

wire RegDst;
wire ALUSrc;
wire MemToReg;
wire RegWrite;
wire MemWrite;
wire MemRead;
wire branch, PCSrc;
wire [1:0] ALUCtrlSig;

wire [IM_ADDR_W_m1:0] newIADDR, iABUS;
MIPSPC PC(clk, newIADDR, iABUS);

wire [IM_DATA_W_m1:0] iDATABUS;
IM instMem(1'b0,1'b1, iABUS, iDATABUS);

wire [0:0] RFWriteAddr;
wire [7:0] ReadData1, ReadData2, WriteData;
MIPSREG RegFile(clk, RegWrite, iDATABUS[4:4], iDATABUS[3:3], RFWriteAddr, ReadData1, ReadData2, WriteData);

wire [7:0] ALUSndInput, ALUOut;
wire Zero;
MIPSALU ALU(ALUCtrlSig, ReadData1, ALUSndInput, ALUOut, Zero);

wire [DM_DATA_W_m1:0] dDATABUS;
DM dataMem(MemWrite, ALUOut, ReadData2, dDATABUS);

wire [7:0] extended8;
SignExtend SignExt(iDATABUS[2:0], extended8[7:0]);

assign PCSrc = Zero & branch;
getNextPC NextPC(PCSrc, iABUS, iDATABUS[3:0], newIADDR;

STwoToOne TwoToOne32_1(ALUSrc, ReadData2, extended32, ALUSndInput); 
STwoToOne TwoToOne32_2(MemToReg, ALUOut, dDATABUS, WriteData); 

MIPSCtrl Control(instr, ALUSrc, MemToReg, RegWrite, MemWrite, branch, M, jump, ALUCtrl);

endmodule

