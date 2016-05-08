module DM(MemRead, MemWrite, ABUS, DIN, MemtoCache, DATABUS, MMRead, MMWrite, CachetoMem);

  parameter DELAY_T = 10;
  parameter DM_DATA_W_m1 = 7; 
  parameter DM_ADDR_W_m1 = 7; 
  parameter DM_ADDR_MAX_m1 = 3; 
  parameter DM_DATA_Z = 8'bzzzzzzzz;
                   
  input MemRead; 
  input MemWrite;  
  output reg MMRead; 
  output reg MMWrite;                
  input [DM_ADDR_W_m1:0] ABUS;  
  input [DM_DATA_W_m1:0] DIN;   
  input [DM_DATA_W_m1:0] MemtoCache;    
  output [DM_DATA_W_m1:0] DATABUS; 
  output [DM_DATA_W_m1:0] CachetoMem;  


  //** internal signals
  reg   [DM_DATA_W_m1:0] DATABUS_driver;
  reg   [DM_DATA_W_m1:0] Cache_Mem_driver;
  wire  [DM_DATA_W_m1:0] DATABUS = DATABUS_driver; 
  wire  [DM_DATA_W_m1:0] CachetoMem = Cache_Mem_driver;
  reg   [DM_DATA_W_m1:0] cacheMem[0:DM_ADDR_MAX_m1];  
  reg   [DM_DATA_W_m1:0] tagMem[0:DM_ADDR_MAX_m1];    

  integer i;
  integer cacheA;
  integer tag;

  initial 
    begin
      DATABUS_driver = 0;  
      Cache_Mem_driver = 0;  
      MMRead = 0; 
      MMWrite = 0;                               
      for (i=0; i <= DM_ADDR_MAX_m1; i = i + 1)
      begin   
        cacheMem[i] = 8'bzzzzzzzz;
      end
      for (i=0; i <= DM_ADDR_MAX_m1; i = i + 1) 
      begin  
        tagMem[i] = 8'bzzzzzzzz;
      end
    end

  always @(MemRead or MemWrite or ABUS or DIN) 
    begin
      #DELAY_T
      cacheA = (ABUS & 8'b00000011);
      tag = (ABUS & 8'b11111100);
      
//Reading

      if(MemRead ==1'b1)
      begin
       
        if(cacheMem[cacheA] !== 8'bzzzzzzzz && tagMem[cacheA] == tag)
        begin
          DATABUS_driver = cacheMem[cacheA];
          $display ("CACHE HIT");

        end
        else
          begin
          $display ("CACHE MISS. Waiting for main memory");
          MMRead = 1;
          #10 // wait for main memory
          cacheMem[cacheA] = MemtoCache;
          tagMem[cacheA] = tag;
          DATABUS_driver = cacheMem[cacheA];
          end 
        end

//Writing

      if(MemWrite ==1'b1)
      begin
        if(cacheMem[cacheA] !== 8'bzzzzzzzz)
        begin
          Cache_Mem_driver = cacheMem[cacheA];
          MMWrite = 1; 
          #10
          if (tagMem[cacheA] + cacheA == ABUS)
          begin
            $display ("OVERWRITTEN");
            cacheMem[cacheA] = DIN;
            tagMem[cacheA] = tag;
          end
          else 
          begin
            $display ("WRITTING BACK");
            cacheMem[cacheA] = DIN;
            tagMem[cacheA] = tag;
          end
        end
        else
        begin
          cacheMem[cacheA] = DIN;
          tagMem[cacheA] = tag;
        end
      end 
    end
endmodule