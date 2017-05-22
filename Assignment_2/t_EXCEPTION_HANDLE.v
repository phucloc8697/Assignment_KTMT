module t_EXCEPTION_HANDLE;
	reg control_exception;
	reg [7:0] ALU_status;
	wire disable_out;
	reg CLK;
	
	EXCEPTION_HANDLE EXCEPTION_HANDLE(
		.control_exception(control_exception),
		.ALU_status(ALU_status),
		.disable_out(disable_out)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		control_exception = 0;
		ALU_status = 8'b000000xx;
		#10 ALU_status = 8'b100100xx;
			control_exception = 1;
		#10 ALU_status = 8'b010000xx;
			control_exception = 0;
		#10 ALU_status = 8'b100100xx;
		#10 ALU_status = 8'b000010xx;
		#10 ALU_status = 8'b100100xx;
		#10 ALU_status = 8'b000001xx;
	end
endmodule 