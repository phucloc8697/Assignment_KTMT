module REG_MEM_WB (
	CLK,
	RESET,
	control_wb_in,
	read_data_in,
	ALU_result_in,
	reg_dst_address_in,
	
	control_wb_out,
	read_data_out,
	ALU_result_out,
	reg_dst_address_out
);

	input CLK,RESET;
	input [1:0] control_wb_in;
	input [31:0] read_data_in, ALU_result_in, reg_dst_address_in;

	output reg [1:0] control_wb_out;
	output reg [31:0] read_data_out, ALU_result_out, reg_dst_address_out;

	reg [1:0] control_wb;
	reg [31:0] read_data, ALU_result, reg_dst_address;

	always @(posedge CLK or negedge RESET) begin
		if(!RESET) begin
			control_wb_out <= 0;
			read_data_out <= 0;
			ALU_result_out <= 0;
			reg_dst_address_out <= 0;
		end
		else begin
			control_wb_out <= control_wb_in;
			read_data_out <= read_data_in;
			ALU_result_out <= ALU_result_in;
			reg_dst_address_out <= reg_dst_address_in;
		end
		
	end


endmodule
