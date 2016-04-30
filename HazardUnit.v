module HazardUnit(IDRegRs,IDRegRt,EXRegRt,EXMemRead,PCWrite,IFIDWrite,HazMuxCon);

	input [0:0] IDRegRs,IDRegRt,EXRegRt;
	input EXMemRead;
	output PCWrite,IFIDWrite,HazMuxCon;

	reg PCWrite,IFIDWrite,HazMuxCon;

	always@(IDRegRs,IDRegRt,EXRegRt,EXMemRead)
	begin
		if(EXMemRead&((EXRegRt == IDRegRs)|(EXRegRt == IDRegRt)))
		begin
			PCWrite = 0;
			IFIDWrite = 0;
			HazMuxCon = 1;
		end
		else
		begin
			PCWrite = 1;
			IFIDWrite = 1;
			HazMuxCon = 1;
		end
	end
endmodule


