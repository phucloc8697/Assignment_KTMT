module REG_MEM_WB (
	CLK,
	
	control_wb_in,
	read_data_in,
	ALU_result_in,
	reg_dst_address_in,
	
	control_wb_out,
	read_data_out,
	ALU_result_out,
	reg_dst_address_out
);

	input CLK;
	input [1:0] control_wb_in;
	input [31:0] read_data_in, ALU_result_in, reg_dst_address_in;

	output  [1:0] control_wb_out;
	output  [31:0] read_data_out, ALU_result_out, reg_dst_address_out;

	reg [1:0] control_wb;
	reg [31:0] read_data, ALU_result, reg_dst_address;

	always @(posedge CLK) begin
		control_wb <= control_wb_in;
		read_data <= read_data_in;
		ALU_result <= ALU_result_in;
		reg_dst_address <= reg_dst_address_in;
	end
	assign control_wb_out = control_wb;
	assign read_data_out = read_data;
	assign ALU_result_out = ALU_result;
	assign reg_dst_address_out = reg_dst_address;

endmodule
