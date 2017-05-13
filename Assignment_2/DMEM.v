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

	output reg  [31:0] DMEM_data_out;

	reg [7:0] memory [255:0];

	always@(posedge CLK) begin
		
		if (DMEM_mem_write) begin
			memory[DMEM_address+3] <= DMEM_data_in[7:0];
			memory[DMEM_address+2] <= DMEM_data_in[15:8];
			memory[DMEM_address+1] <= DMEM_data_in[23:16];
			memory[DMEM_address] <= DMEM_data_in[31:24];
		end	
		else begin
			memory[DMEM_address] <= memory[DMEM_address];
		end

	end

	always @(posedge CLK) begin
		if(DMEM_mem_read) begin
			DMEM_data_out[7:0] <= memory[DMEM_address+3];
			DMEM_data_out[15:8] <=  memory[DMEM_address+2];
			DMEM_data_out[23:16] <=  memory[DMEM_address+1];
			DMEM_data_out[31:24] <=  memory[DMEM_address];
		end
		else begin
			DMEM_data_out <= 32'dx;
		end
	end

endmodule
