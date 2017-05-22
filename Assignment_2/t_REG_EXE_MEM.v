`timescale 1ns/1ns
module t_REG_EXE_MEM;
	reg CLK, RESET, exception_disable;
	reg [2:0] control_mem_in;
	wire [2:0] control_mem_out;
	REG_EXE_MEM REG_EXE_MEM(
		.CLK(CLK),
		.RESET(RESET),
		.exception_disable(exception_disable),
		.control_mem_in(control_mem_in),
		.control_mem_out(control_mem_out)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		RESET =0;
		exception_disable =0;
		control_mem_in = 3'd0;
		#5 RESET = 1;
		#10 control_mem_in = 3'b010;
		#10 exception_disable = 1;
		#15 exception_disable = 0;
		#10 RESET = 0;
		#5 RESET = 1;
		
	end
	
endmodule 
	