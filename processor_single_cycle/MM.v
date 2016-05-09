module MM(MMRead, MMWrite, ABUS, CachetoMem, MemtoCache, OldTag, CacheSwap);

  parameter DELAY_T = 10;

  parameter DM_DATA_W_m1 = 7;
  parameter DM_ADDR_W_m1 = 7;
  parameter DM_ADDR_MAX_m1 = 255;
  parameter DM_DATA_Z = 8'bzzzzzzzz;
                   
  input MMRead;
  input MMWrite;                      
  input [DM_ADDR_W_m1:0] ABUS;      // address bus
  input [DM_ADDR_W_m1:0] CachetoMem;
  input [DM_ADDR_W_m1:0] OldTag;
  input CacheSwap;
  output [DM_ADDR_W_m1:0] MemtoCache;


  //** internal signals
  reg [DM_DATA_W_m1:0] Mem_Cache_driver;
  wire [DM_DATA_W_m1:0] MemtoCache = Mem_Cache_driver;
  reg [DM_DATA_W_m1:0] MEM[0:DM_ADDR_MAX_m1];    // memory cell


  integer i;

  initial //initialize all RAM cells to 0 at startup
    begin
    Mem_Cache_driver = 0;
    for (i=0; i <= DM_ADDR_MAX_m1; i = i + 1)
       MEM[i] = 0;
    end


  always @(MMRead or MMWrite or ABUS or CachetoMem or CacheSwap)
    begin
      //#DELAY_T
      #1
      if(MMRead == 1'b1)
      begin
        Mem_Cache_driver = MEM[ABUS];
      end 
      if(MMWrite == 1'b1)
      begin
        if(CacheSwap == 1'b1)
        begin
          MEM[OldTag] = CachetoMem;
        end
        else
        begin
        MEM[ABUS] = CachetoMem;
        end
      end
    end
endmodule