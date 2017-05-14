`timescale 1ns/1ns
module t_MUX_8;
	reg [7:0] in0,in1;
	reg sel;
	wire [7:0] out;
	reg clk;
	MUX_8 MUX(
	.in0(in0),
	.in1(in1),
	.sel(sel),
	.out(out)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		in0 = 1;
		in1 = 2;
		sel = 1'bx;
		#10 sel = 1;
		
		#10 sel =0;
	end
endmodule 