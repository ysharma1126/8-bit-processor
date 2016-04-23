module IM(CSB,WRB,ABUS,DATABUS);

  parameter DELAY_T = 10;

  parameter IM_DATA_W_m1 = 7;
  parameter IM_ADDR_W_m1 = 7;
  parameter IM_ADDR_MAX_m1 = 255;
  parameter IM_DATA_Z = 8'bzzzzzzzz;

  input CSB;                        // active low chip select
  input WRB;                        // active low write control
  input [IM_ADDR_W_m1:0] ABUS;      // address bus
  inout [IM_DATA_W_m1:0] DATABUS;   // data bus

  //** internal signals
  reg   [IM_DATA_W_m1:0] DATABUS_driver;
  wire  [IM_DATA_W_m1:0] DATABUS = DATABUS_driver;
  reg   [IM_DATA_W_m1:0] ram[0:IM_ADDR_MAX_m1];            // memory cells

  integer i;

  initial     //initialize all RAM cells to 0 at startup
    begin
    DATABUS_driver = IM_DATA_Z;
    $display($time," Reading MIPS program");   
    $readmemh("mem.txt", ram);
    end
    
    
  always @(CSB or WRB or ABUS)
    begin
      if (CSB == 1'b0)
        begin
        if (WRB == 1'b1) //Reading from sram (data becomes valid after 10ns)
          begin
          #10 DATABUS_driver =  ram[ABUS];
          $display($time," Reading %m ABUS=%b DATA=%b",ABUS,DATABUS_driver);
          end
        end
      else //sram unselected, stop driving bus after 10ns
        begin
        DATABUS_driver <=  #DELAY_T IM_DATA_Z;
        end
    end
endmodule