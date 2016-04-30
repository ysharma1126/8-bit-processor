module ALUControl(li,lw,sw,addi,beq,slti,add,jump,lireg,ALUCon);
input li,lw,sw,addi,beq,slti,add,jump;
input lireg;
output[1:0] ALUCon;

reg[1:0] ALUCon;

always@(li or lw or sw or addi or beq or slti or add or jump)
begin
	if(li && lireg) begin
		ALUCon = 2'b11;
	end
	else if (li) begin
		ALUCon = 2'b00;
	end
	else if (lw) begin
		ALUCon = 2'b00;
	end
	else if (sw) begin
		ALUCon = 2'b00;
	end
	else if (addi) begin
		ALUCon = 2'b00;
	end
	else if (beq) begin
		ALUCon = 2'b01;
	end
	else if (slti) begin
		ALUCon = 2'b10;
	end
	else if (add) begin
		ALUCon = 2'b00;
	end
	else begin
		ALUCon = 2'bzz;
	end
end

endmodule
