module lireg(clk, li, lireg);

input clk;
input li;
output reg lireg;

initial 
begin
lireg=0;
end 

always@(posedge clk) begin
	if(li)
	begin
	lireg<=lireg+1;
	end
end

endmodule