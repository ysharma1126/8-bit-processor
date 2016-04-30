module DATAMEM(MemWrite,MemRead,Addr,Wdata,Rdata); 

input[7:0] Addr,Wdata;
input MemWrite,MemRead;
output [7:0] Rdata;

reg [7:0] Rdata;
reg [7:0] regfile[0:255];

integer i;

initial begin
for (i=0; i <= 255; i = i + 1)
      regfile[i] = 0;
end

always@(Addr,Wdata,MemWrite,MemRead)
begin
if(MemWrite)
begin
//$display("Writing %d -> Addr: %d",Wdata,Addr);
regfile[Addr]<=Wdata;
end
end

always@(Addr,Wdata,MemWrite,MemRead)
begin
if(MemRead)
	Rdata <= regfile[Addr];
end

endmodule

