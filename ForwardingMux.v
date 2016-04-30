module ForwardingMux(A,X0,X1,X2,X3,Out);
input [1:0] A;
input [7:0] X3,X2,X1,X0;
output [7:0] Out;

reg [7:0] Out;

always@(A,X3,X2,X1,X0)
begin
case(A)
	2'b00:
		Out<=X0;
	2'b01:
		Out<=X1;
	2'b10:
		Out<=X2;
	2'b11:
		Out<=X3;
endcase
end
endmodule