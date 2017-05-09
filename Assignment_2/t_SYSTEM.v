`timescale 1ns/1ns
module t_SYSTEM;
	reg clk,rst,load;
	reg [7:0] pc;
	reg [7:0] sel;
	wire [27:0] led;
	SYSTEM f(
	.SYS_clk(clk),
	.SYS_reset(rst),
	.SYS_load(load),
	.SYS_pc_val(pc),
	.SYS_output_sel(sel),
	.SYS_leds(led)
	);
	initial begin
		clk=0;
		forever #10 clk=~clk;
	end
	initial begin
	
	end
endmodule 
