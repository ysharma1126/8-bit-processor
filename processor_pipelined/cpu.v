module cpu();

reg clock;

initial begin
	$monitor ("Time: %d, PC: %b, Instruction: %b, Reg0: %b, Reg1: %b, Data: %b, LI: %b",$time, pc, IFinst, reg0, reg1, MEMReadData,lireg);
	clock = 1;
end

always begin
	clock=~clock;
	#25;
	end

reg[7:0] cycle;

wire[7:0] nextpc,IFpc_plus_1,IFinst;
reg [7:0] pc;

wire PCSrc;
wire [0:0] IDRegRs, IDRegRt;
wire [7:0]  IDpc_plus_1,IDinst;
wire [7:0] IDRegAout, IDRegBout,reg0,reg1;
wire [7:0] IDimm_valueLI,IDimm_valueBranch,IDimm_valueI,IDimm_value,BranchAddr,PCMuxOut,JumpTarget; 

wire PCWrite, IFIDWrite,HazMuxCon,li,lw,sw,addi,beq,slti,add,jump;
wire [5:0] IDcontrol,ConOut;

wire [1:0] EXWB,ForwardA,ForwardB,ALUctrl;
wire [1:0] EXM;
wire [1:0] EXEX;
wire [0:0] EXRegRs,EXRegRt, EXRegRd, regtopass;
wire [7:0] EXRegAout,EXRegBout,EXimm_value,b_value;
wire [7:0] EXALUOut,ALUSrcA,ALUSrcB;

wire [1:0] MEMWB;
wire [1:0] MEMM;
wire [0:0] MEMRegRd; 
wire [7:0] MEMALUOut,MEMWriteData,MEMReadData; 

wire [1:0] WBWB;
wire [0:0] WBRegRd;
wire [7:0] datatowrite, WBReadData, WBALUOut;

initial begin
	pc = 0;
	cycle = 0;
end 

always@(posedge clock) 
begin
	cycle=cycle+1;
end


//IF


assign PCSrc = ((IDRegAout == IDRegBout) & beq);
assign IFFlush = PCSrc | jump;
assign IFpc_plus_1 = pc+1;

assign nextpc = PCSrc ? BranchAddr : PCMuxOut;

always @ (posedge clock) begin
if(PCWrite) 
begin
	pc = nextpc;
	//$display("PC: %d",pc);
end
//else
	//$display("Skipped writing to PC - nop");
end

InstructMem IM(pc,IFinst);

IFID IFIDreg(IFFlush,clock,IFIDWrite,IFpc_plus_1,IFinst,IDinst,IDpc_plus_1);



//ID



assign IDRegRs[0:0]=IDinst[4:4];
assign IDRegRt[0:0]=IDinst[3:3];
assign IDimm_valueI = {IDinst[2],IDinst[2],IDinst[2],IDinst[2],IDinst[2],IDinst[2:0]};
assign IDimm_valueLI = {4'b0000,IDinst[3:0]};
assign IDimm_valueBranch = {5'b00000,IDinst[2:0]};
assign BranchAddr = IDimm_valueBranch+IDpc_plus_1;
assign JumpTarget[7:5] = IFpc_plus_1[7:5];
assign JumpTarget[4:0] = IDinst[4:0];

assign IDimm_value = li ? IDimm_valueLI : IDimm_valueI;

assign IDcontrol = HazMuxCon ? ConOut : 0;
assign PCMuxOut = jump ? JumpTarget : IFpc_plus_1;

HazardUnit HU(IDRegRs,IDRegRt,EXRegRt,EXM[1],PCWrite,IFIDWrite,HazMuxCon);
Control thecontrol(IDinst[7:5],ConOut,li,lw,sw,addi,beq,slti,add,jump);



Registers piperegs(clock,WBWB[0],datatowrite,WBRegRd,IDRegRs,IDRegRt,IDRegAout,IDRegBout,reg0,reg1);

IDEX IDEXreg(clock,IDcontrol[5:4],IDcontrol[3:2],IDcontrol[1:0],IDRegAout,IDRegBout,IDimm_value,IDRegRs,IDRegRt,EXWB,EXM,EXEX,EXRegAout,EXRegBout,EXimm_value,EXRegRs,EXRegRt);




//EX




assign regtopass = EXEX[0] ? EXRegRs : EXRegRt; 
assign b_value = EXEX[1]  ? EXimm_value : EXRegBout;

ForwardingMux MUX0(ForwardA,EXRegAout,datatowrite,MEMALUOut,8'b00000000,ALUSrcA);
ForwardingMux MUX1(ForwardB,b_value,datatowrite,MEMALUOut,8'b00000000,ALUSrcB);
ForwardUnit FU(MEMRegRd,WBRegRd,EXRegRs,EXRegRt,MEMWB[0],WBWB[0],ForwardA,ForwardB);

lireg LI(clock,EXEX[1], lireg);

ALUControl ALUcontrol(li,lw,sw,addi,beq,slti,add,jump,lireg,ALUctrl);
ALU theALU(ALUctrl,ALUSrcA,ALUSrcB,EXALUOut);

EXMEM EXMEMreg(clock,EXWB,EXM,EXALUOut,regtopass,EXRegBout,MEMM,MEMWB,MEMALUOut,MEMRegRd,MEMWriteData);







//MEM



DATAMEM DM(MEMM[0],MEMM[1],MEMALUOut,MEMWriteData,MEMReadData);

MEMWB MEMWBreg(clock,MEMWB,MEMReadData,MEMALUOut,MEMRegRd,WBWB,WBReadData,WBALUOut,WBRegRd);






//WB



assign datatowrite = WBWB[1] ? WBReadData : WBALUOut;




endmodule





