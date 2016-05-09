module test_bench ();

//---------------------------
reg osc;
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
PC pc(clk, newIADDR, iABUS);

wire [IM_DATA_W_m1:0] iDATABUS;
IM instMem(iABUS, iDATABUS);

wire [0:0] RFWriteAddr;
wire [7:0] ReadData1, ReadData2, WriteData, output0, output1;
REG RegFile(clk, RegWrite, iDATABUS[4:4], iDATABUS[3:3], RFWriteAddr, ReadData1, ReadData2, WriteData, output0, output1);

wire [7:0] ALUSndInput1, ALUSndInput2, ALUOut;
wire Zero;
ALU Alu(ALUCtrlSig, ALUSndInput1, ALUSndInput2, ALUOut, Zero);

wire [DM_DATA_W_m1:0] dDATABUS;
wire MMRead;
wire MMWrite;
wire [DM_DATA_W_m1:0] CachetoMem;
wire [DM_DATA_W_m1:0] OldTag;
wire CacheSwap;
DM dataMem1(MemRead, MemWrite, ALUOut, ReadData2, MemtoCache, dDATABUS, MMRead, MMWrite, CachetoMem, OldTag, CacheSwap);

wire [DM_DATA_W_m1:0] MemtoCache;
MM dataMem2(MMRead, MMWrite, ALUOut, CachetoMem, MemtoCache, OldTag, CacheSwap);

wire [7:0] extended8_1, extended8_2, extended8_3, extended8_4, extended8;
SignExtend SignExt(iDATABUS[2:0], extended8_1[7:0]);
ZeroExtend_3 ZeroExt1(iDATABUS[3:0], extended8_2[7:0]);
ZeroExtend_2 ZeroExt2(iDATABUS[2:0], extended8_3[7:0]);

assign PCSrc = Zero & branch;
getNextPC NextPC(PCSrc, iDATABUS, jump, iABUS, extended8, newIADDR);

lireg LI(clk, iDATABUS, li);


STwoToOne_1 TwoToOne_6(M, iDATABUS[3:3], iDATABUS[4:4], RFWriteAddr);
STwoToOne_8 TwoToOne_5(branch, extended8_1, extended8_3, extended8_4);
STwoToOne_8 TwoToOne_4(M, extended8_4, extended8_2, extended8);
STwoToOne_8 TwoToOne_3(li, ReadData1,8'b00000000, ALUSndInput1);
STwoToOne_8 TwoToOne_1(ALUSrc, ReadData2, extended8, ALUSndInput2); 
STwoToOne_8 TwoToOne_2(MemToReg, ALUOut, dDATABUS, WriteData); 


Ctrl Control(iDATABUS, li, ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, branch, M, jump, ALUCtrlSig);

initial begin
	$dumpfile("test.vcd");
    $dumpvars(0,test_bench);
    $monitor ("Time: %d, PC: %b, Instruction: %b, Reg0: %b, Reg1: %b, Data: %b",$time, iABUS, iDATABUS, output0, output1, dDATABUS);
	osc = 0;
end

always begin
#100 osc = ~osc;
end

always #12 begin
if (iDATABUS ===8'bxxxxxxxx|| iABUS == 8'b11111111) begin
$finish;
end
end


endmodule

