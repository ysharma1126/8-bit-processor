`timescale 1s/1s

module IM(ABUS,DATABUS);

  parameter DELAY_T = 10;

  parameter IM_DATA_W_m1 = 7;
  parameter IM_ADDR_W_m1 = 7;
  parameter IM_ADDR_MAX_m1 = 255;
  parameter IM_DATA_Z = 8'bzzzzzzzz;

  input [IM_ADDR_W_m1:0] ABUS;      // address bus
  inout [IM_DATA_W_m1:0] DATABUS;   // data bus

  //** internal signals
  reg   [IM_DATA_W_m1:0] DATABUS_driver;
  wire  [IM_DATA_W_m1:0] DATABUS = DATABUS_driver;
  reg   [IM_DATA_W_m1:0] ram[0:IM_ADDR_MAX_m1];            // memory cells

  integer i;

  initial 
    begin
    DATABUS_driver = IM_DATA_Z;  
    $readmemb("mem.txt", ram);
    $display($time," Mem: %b",ram[0]);
    end
    
    
  always @(ABUS)
          #10 DATABUS_driver =  ram[ABUS];
endmodule