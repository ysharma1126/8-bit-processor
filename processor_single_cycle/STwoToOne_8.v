module STwoToOne_8 (sel, in0, in1, out);
  input sel;
  input [7:0] in0, in1;
  output reg [7:0] out;

	always @(sel, in0, in1) begin
		if (sel == 0)
		begin
			out <= in0;
		end
		else
		begin
			out <= in1;	  
		end
	//$display($time," MuxOut: %b",out);
	end
endmodule