module ALU(ALUCon,DataA,DataB,Result);

	input [1:0] ALUCon;
	input [7:0] DataA,DataB;
	output [7:0] Result;

	reg [7:0] Result; 

	initial begin
		Result = 8'b00000000;
	end

	always@(ALUCon,DataA,DataB)
	begin
		case(ALUCon)
			2'b00:
				Result <=DataA+DataB;
			2'b01:
				Result <= DataA-DataB;
			2'b10:
				Result <= {DataA[7],DataA} < {DataB[7],DataB};
			2'b11:
				Result <= DataB << 4;
			default:
			begin
				//$display("ALUERROR");
				Result = 0;
			end
		endcase
	end
endmodule