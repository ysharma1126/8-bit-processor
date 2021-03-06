module ALU(ALUctl, A, B, ALUOut, Zero);
input [1:0] ALUctl;
input [7:0] A,B;
output reg [7:0] ALUOut;
output Zero;  
assign Zero = (ALUOut==0); //Zero is true if ALUOut is 0; goes anywhere
always @(ALUctl, A, B) //reevaluate if these change
begin
case (ALUctl)
0: ALUOut <= A + B;
1: ALUOut <= A - B;
2: ALUOut <= {A[7],A} < {B[7],B};
3: ALUOut <= B << 4;
default: ALUOut <= 0; //default to 0, should not happen;
endcase
//$display($time," ALU: %b",ALUOut);
//$display($time, " Zero: %b", (ALUOut==0));
end
endmodule