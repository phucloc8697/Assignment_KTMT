`timescale 1ns/1ns
module t_SYSTEM;

	reg clk,rst,load,CLK_50;
	reg [7:0] pc;
	reg [7:0] sel;
	wire [26:0] led;
	wire [6:0] hex1, hex2;	
	
	SYSTEM f(
		.SYS_clk(clk),
		.CLK_50 (CLK_50),
		.SYS_reset(rst),
		.SYS_load(load),
		.SYS_pc_val(pc),
		.SYS_output_sel(sel),
		.SYS_leds(led),
		.hex1(hex1),
		.hex2(hex2)
	);
	initial begin
		#50
		clk=0;
		forever #20 clk=~clk;
	end
	initial begin
		CLK_50=0;
		forever #1 CLK_50=~CLK_50;
	end
	initial begin
		sel = 8'b00000100;
		rst=1;
		pc=8'd0;
		#5 rst=0;
		#5 rst=1;
		#5 load = 1;
		#5	load = 0;
		#1000 $stop;
		
	end
endmodule 
