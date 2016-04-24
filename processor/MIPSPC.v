`timescale 1s/1s

module MIPSPC(clk, newPC, PC);

parameter DELAY_T = 10;  
parameter MIPS_PC_WIDTH_m1 = 7;  
  
input clk;
input [MIPS_PC_WIDTH_m1:0] newPC;  
output [MIPS_PC_WIDTH_m1:0] PC;  

reg [MIPS_PC_WIDTH_m1:0] currPC;

initial begin
currPC = 0;
end

always @(posedge clk) begin
  #DELAY_T 
  currPC = newPC;
end

assign PC = currPC;
endmodule