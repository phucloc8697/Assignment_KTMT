`timescale 1ns/1ns
module t_DMEM;
	reg CLK,DMEM_mem_read,DMEM_mem_write;
	reg [31:0] DMEM_address,DMEM_data_in;
	wire [31:0] DMEM_data_out;
	
	DMEM DMEM(
	.CLK(CLK),
	.DMEM_address(DMEM_address),
	.DMEM_data_in(DMEM_data_in),
	.DMEM_mem_write(DMEM_mem_write),
	.DMEM_mem_read(DMEM_mem_read),
	.DMEM_data_out(DMEM_data_out)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		DMEM_address = 4;
		DMEM_data_in = 32'd5;
		DMEM_mem_read = 0;
		DMEM_mem_write = 0;
		#10 DMEM_mem_read = 1;
		#20 DMEM_mem_write = 1;
		#10 DMEM_mem_write =0;
	end
endmodule 
		