`timescale 1ns/1ns
module t_EPC;
	reg clk;
	reg [7:0]in;
	reg reset;
	wire [6:0] out1,out2,out3;
	EPC EPC(
	.in(in),
	.reset(reset),
	.out1(out1),
	.out2(out2),
	.out3(out3)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		reset = 0;
		#5 reset =1;
		#10 in = 8'd4;
		#10 in = 8'd8;
		#10 in = 8'd1;
		#10 in = 8'd0;
		#10 in = 8'd3;
	end
endmodule 
	
	