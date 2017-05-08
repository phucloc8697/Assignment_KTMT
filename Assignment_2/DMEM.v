module DMEM(
	CLK,
	DMEM_address,
	DMEM_data_in,
	DMEM_mem_write,
	DMEM_mem_read,
	DMEM_data_out
);

input CLK, DMEM_mem_write, DMEM_mem_read;
input [31:0] DMEM_address, DMEM_data_in;

output reg [31:0] DMEM_data_out;

reg [31:0] memory [255:0];

always@(posedge CLK) begin

	if (DMEM_mem_read) DMEM_data_out <= memory[DMEM_address];
	else DMEM_data_out <= 32'dx;
	
	if (DMEM_mem_write) memory[DMEM_address] <= DMEM_data_in;
	else memory[DMEM_address] <= memory[DMEM_address];

end

endmodule
