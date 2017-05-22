`timescale 1ns/1ns
module t_CONTROL;
	reg CLK;
	reg [31:0] opcode;
	wire [3:0] control_exe;
	wire [2:0] control_mem;
	wire [1:0] control_wb; 
	wire control_exception;
	
	CONTROL CONTROL(
		.opcode(opcode),
		.control_exe(control_exe),
		.control_mem(control_mem),
		.control_wb(control_wb),
		.control_jump(control_jump),
		.control_exception(control_exception)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		opcode = 32'h20090001;
		#10 opcode = 32'h01294820;
		#10 opcode = 32'h21200005;
	end
endmodule 