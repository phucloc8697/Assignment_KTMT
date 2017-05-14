`timescale 1ns/1ns
module t_IMEM;
	reg CLK;
	reg [7:0] MEM_PC;
	wire [31:0] IMEM_instruction;
	IMEM IMEM(
	 .CLK(CLK),
	 .MEM_PC(MEM_PC),
	 .IMEM_instruction(IMEM_instruction)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		MEM_PC = 4'd0;
		#20 MEM_PC = 4'd4;
		#20 MEM_PC = 4'd8;
		#20 MEM_PC = 4'd12;
	end
	
endmodule 