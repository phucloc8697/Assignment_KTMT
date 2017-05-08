module REG_ID_EXE (
	CLK,
	
	control_exe_in,
	control_mem_in,
	control_wb_in,
	alu_op_in,

	read_data_1_in,
	read_data_2_in,
	sign_extend_in,
	rt_in,
	rd_in,
	
	control_exe_out,
	control_mem_out,
	control_wb_out,
	alu_op_out,

	read_data_1_out,
	read_data_2_out,
	sign_extend_out,
	rt_out,
	rd_out,
);

input CLK;

input [2:0] control_exe_in, control_mem_in;
input [5:0] alu_op_in;
input [1:0] control_wb_in;
input [31:0] read_data_1_in, read_data_2_in, sign_extend_in;
input [4:0] rt_in, rd_in;

output reg [2:0] control_exe_out, control_mem_out;
output reg [5:0] alu_op_out;
output reg [1:0] control_wb_out;
output reg [31:0] read_data_1_out, read_data_2_out, sign_extend_out;
output reg [4:0] rt_out, rd_out;

reg [2:0] control_exe, control_mem;
reg [5:0] alu_op;
reg [1:0] control_wb;
reg [31:0] read_data_1, read_data_2, sign_extend;
reg [4:0] rt, rd;

always@(posedge CLK) begin
	control_exe <= control_exe_in;
	control_mem <= control_mem_in;
	control_wb <= control_wb_in;
	alu_op <= alu_op_in;
	
	read_data_1 <= read_data_1_in;
	read_data_2 <= read_data_2_in;
	sign_extend <= sign_extend_in;
	rt <= rt_in;
	rd <= rd_in;
	
	control_exe_out <= control_exe;
	control_mem_out <= control_mem;
	control_wb_out <= control_wb;
	alu_op_out <= alu_op;

	read_data_1_out <= read_data_1;
	read_data_2_out <= read_data_2;
	sign_extend_out <= sign_extend;
	rt_out <= rt;
	rd_out <= rd;
end

endmodule
