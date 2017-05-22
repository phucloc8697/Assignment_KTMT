module t_SHIFT_LEFT_2;
	reg CLK;
	reg [31:0] in;
	wire [31:0] out;
	
	SHIFT_LEFT_2 SHIFT_LEFT_2(
		.in(in),
		.out(out)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		in = 32'd4;
	#10 in = 32'd8;
	end
endmodule 
	