`timescale 1s/1s

module DM(MemRead, MemWrite, ABUS, DIN, DATABUS);

  parameter DELAY_T = 10;

  parameter DM_DATA_W_m1 = 7;
  parameter DM_ADDR_W_m1 = 7;
  parameter DM_ADDR_MAX_m1 = 255;
  parameter DM_DATA_Z = 8'bzzzzzzzz;
                   
  input MemRead;
  input MemWrite;                      
  input [DM_ADDR_W_m1:0] ABUS;      // address bus
  input [DM_DATA_W_m1:0] DIN;       // data in bus
  output [DM_DATA_W_m1:0] DATABUS;   // data out bus
  

  //** internal signals
  reg   [DM_DATA_W_m1:0] DATABUS_driver;
  wire  [DM_DATA_W_m1:0] DATABUS = DATABUS_driver;
  reg   [DM_DATA_W_m1:0] ram[0:DM_ADDR_MAX_m1];            // memory cells

  integer i;

  initial     //initialize all RAM cells to 0 at startup
    begin
    DATABUS_driver = 0;
    for (i=0; i <= DM_ADDR_MAX_m1; i = i + 1)
       ram[i] = 0;
    end

  always @(MemRead or MemWrite or ABUS or DIN)
    begin
      #DELAY_T DATABUS_driver =  ram[ABUS];
      if (MemWrite == 1'b1)
      begin
      #30
      if (MemWrite == 1'b1)
        ram[ABUS] = DIN;
    end
  end
endmodule