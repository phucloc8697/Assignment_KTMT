`timescale 1ns/1ns
module t_SIGN_EXTEND;
	reg CLK;
	reg [15:0] in;
	wire [31:0] out;
	SIGN_EXTEND SIGN_EXTEND(
	.in(in),
	.out(out)
	);
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		in = 16'h00ff;
		#10 in = 16'h8000;
	end
endmodule 