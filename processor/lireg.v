`timescale 1s/1s

module lireg(clk, instr, li);

input clk;
input [7:0] instr;
output reg li;

always@(negedge clk) begin
	if(instr[7:5] == 3'b000)
	begin
	li<=li+1;
	end
end

endmodule

