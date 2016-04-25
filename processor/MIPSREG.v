`timescale 1s/1s

module MIPSREG(clk, RegWrite, ReadAddr1, ReadAddr2, WriteAddr, ReadData1, ReadData2, WriteData, output1, output2);

parameter DELAY_T = 10;  
parameter MIPS_REG_ADDR_W_m1 = 0;  
parameter MIPS_REG_DATA_W_m1 = 7;  
parameter MIPS_REG_NUM_m1 = 1;  
  
input clk, RegWrite;
input [MIPS_REG_ADDR_W_m1:0] ReadAddr1, ReadAddr2, WriteAddr;  
input [MIPS_REG_DATA_W_m1:0] WriteData;  
output [MIPS_REG_DATA_W_m1:0] ReadData1, ReadData2;
output [MIPS_REG_DATA_W_m1:0] output1, output2;

reg [MIPS_REG_DATA_W_m1:0] regs [0:MIPS_REG_NUM_m1];
wire [MIPS_REG_DATA_W_m1:0] output1 = regs[0];
wire [MIPS_REG_DATA_W_m1:0] output2 = regs[1];


integer i;

initial     //initialize all RAM cells to 0 at startup
  begin
  for (i=0; i <= MIPS_REG_NUM_m1; i = i + 1)
    regs[i] = 0;
  end

always @(posedge clk) begin
  if (RegWrite == 1'b1)
    begin
    #DELAY_T 
    regs[WriteAddr] = WriteData;
    end
end

assign ReadData1 = regs[ReadAddr1];
assign ReadData2 = regs[ReadAddr2];

endmodule