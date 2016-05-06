module lireg(clk, instr, li);

input clk;
input [7:0] instr;
output reg li;

initial 
begin
li=0;
end 

always@(posedge clk) begin
	if(instr[7:5] == 3'b000)
	begin
	li<=li+1;
	end
	//$display($time," LIReg: %b",li);
end

endmodule

