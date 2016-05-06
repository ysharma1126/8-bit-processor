module Control(Op,Out,li,lw,sw,addi,beq,slti,add,jump);
input [2:0] Op;
output [5:0] Out;
output li,lw,sw,addi,beq,slti,add,jump;

wire alusrc,memtoreg,regwrite,memwrite,memread,branch;

wire li = ~Op[2] & ~Op[1] & ~Op[0];
wire lw = ~Op[2] & ~Op[1] & Op[0];
wire sw = ~Op[2] & Op[1] & ~Op[0];
wire addi = ~Op[2] & Op[1] & Op[0];
wire beq = Op[2] & ~Op[1] & ~Op[0];
wire slti = Op[2] & ~Op[1] & Op[0];
wire add = Op[2] & Op[1] & ~Op[0];
wire jump = Op[2] & Op[1] & Op[0];

wire [1:0] EXE;
wire [2:0] M;
wire [1:0] WB;

assign alusrc = li|lw|sw|addi|slti;
assign memtoreg = lw|sw;
assign regwrite = li|lw|addi|slti|add;
assign memwrite = sw;
assign memread = lw;
assign branch = beq;

assign EXE[1]=alusrc;
assign EXE[0]=li;

assign M[1]=memread;
assign M[0]=memwrite;

assign WB[1]=memtoreg;
assign WB[0]=regwrite;

assign Out[5:4] = WB;
assign Out[3:2] = M;
assign Out[1:0] = EXE;

endmodule
