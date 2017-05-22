module t_ALU_CONTROL;
	reg [1:0] ALU_op;
	reg [5:0] Funct;
	wire [3:0] ALU_control;
	reg CLK;
	ALU_CONTROL ALU_CONTROL(
	.ALU_op(ALU_op),
	.Funct(Funct),
	.ALU_control(ALU_control)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		ALU_op = 2'd0;
		Funct = 6'h23;
	#10 ALU_op = 2'd1;
		Funct = 6'h23;
	#10 ALU_op = 2'd2;
		Funct = 6'b100101;
	#10 Funct = 6'hf;
	end
endmodule 
	