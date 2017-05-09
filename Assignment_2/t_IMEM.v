`timescale 1ns/1ns
module t_IMEM;
	reg clk;
	reg [7:0] addr;
	wire [31:0] out;
	IMEM f( 	.CLK(clk),
				.MEM_PC(addr),
				.IMEM_instruction(out)
	);
	initial begin
		clk=0;
		forever #10 clk=~clk;
	end
	initial begin
		#5 addr = 8'd10;
		#5 addr = 8'd0;
		#5 addr = 8'd1;
	end
endmodule 