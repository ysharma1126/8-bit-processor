`timescale 1s/1s

module MIPSCtrl (instr, lireg, ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, branch, M, jump, ALUCtrl);

input [7:0] instr;
input lireg;
output reg ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, branch, M, jump;
output reg [1:0] ALUCtrl;

always @(instr) //reevaluate if these change
if (instr[7:5] == 3'b000 && lireg==1'b0) //li (lui)
  begin
    ALUSrc <= 1;
    MemToReg <= 1;
    RegWrite <= 1;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 1;
    ALUCtrl <= 2'b11;
  end
else if(instr[7:5] == 3'b000 && lireg==1'b1) //li (lli)
 begin
    ALUSrc <= 1;
    MemToReg <= 1;
    RegWrite <= 1;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 1;
    ALUCtrl <= 2'b00;
  end
else if (instr[7:5] == 3'b001) // lw
  begin
    ALUSrc <= 1;
    MemToReg <= 1;
    RegWrite <= 1;
    MemWrite <= 0;
    MemRead <= 1;
    branch <= 0;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b00;
  end
else if (instr[7:5] == 3'b010) // sw
  begin
    ALUSrc <= 1;
    MemToReg <= 1'bz;
    RegWrite <= 0;
    MemWrite <= 1;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b00;
  end
else if (instr[7:5] == 3'b011) //addi
  begin
    ALUSrc <= 1;
    MemToReg <= 0;
    RegWrite <= 1;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b00;
  end
else if (instr[7:5] == 3'b100) //beq
  begin
    ALUSrc <= 0;
    MemToReg <= 1'bz;
    RegWrite <= 0;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 1;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b01;
  end
else if (instr[7:5] == 3'b101) //slti
  begin
    ALUSrc <= 1;
    MemToReg <= 0;
    RegWrite <= 1;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b10;
  end
else if (instr[7:5] == 3'b110) 
  begin
    ALUSrc <= 0;
    MemToReg <= 0;
    RegWrite <= 1;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b00;
  end
else if (instr[7:5] == 3'b111) //j
 begin
    ALUSrc <= 1'bz;
    MemToReg <= 1'bz;
    RegWrite <= 0;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 1'bz;
    jump <= 1;
    M <= 1'bz;
    ALUCtrl <= 2'bzz;
 end
else
  begin
    ALUSrc <= 0;
    MemToReg <= 0;
    RegWrite <= 0;
    MemWrite <= 0;
    MemRead <= 0;
    branch <= 0;
    jump <= 0;
    M <= 0;
    ALUCtrl <= 2'b00;
  end
endmodule