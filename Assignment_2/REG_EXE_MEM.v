module REG_EXE_MEM (
	CLK,
	exception_disable,

	control_mem_in,
	control_wb_in,
	branch_address_in,
	ALU_status_in,
	ALU_result_in,
	read_data_2_in,
	reg_dst_address_in,
	
	control_mem_out,
	control_wb_out,
	branch_address_out,
	ALU_status_out,
	ALU_result_out,
	read_data_2_out,
	reg_dst_address_out
);

input CLK, exception_disable;
input [7:0] ALU_status_in;
input [2:0] control_mem_in;
input [1:0] control_wb_in;
input [31:0] branch_address_in, ALU_result_in, read_data_2_in, reg_dst_address_in;

output reg [7:0] ALU_status_out;
output reg [2:0] control_mem_out;
output reg [1:0] control_wb_out;
output reg [31:0] branch_address_out, ALU_result_out, read_data_2_out, reg_dst_address_out;

reg [7:0] ALU_status;
reg [2:0] control_mem;
reg [1:0] control_wb;
reg [31:0] branch_address, ALU_result, read_data_2, reg_dst_address;

always@(negedge CLK or posedge exception_disable) begin
	control_mem <= control_mem_in;
	control_wb <= control_wb_in;
	branch_address <= branch_address_in;
	ALU_result <= ALU_result_in;
	ALU_status <= ALU_status_in;
	read_data_2 <= read_data_2_in;
	reg_dst_address <= reg_dst_address_in;
end

always @(posedge CLK) begin
	if (exception_disable) begin
		control_mem_out <= 0;
		control_wb_out <= 0;
	end
	else begin
		control_mem_out <= control_mem;
		control_wb_out <= control_wb;
	end
	
	branch_address_out <= branch_address;
	ALU_result_out <= ALU_result;
	ALU_status_out <= ALU_status;
	read_data_2_out <= read_data_2;
	reg_dst_address_out <= reg_dst_address;
end

endmodule
