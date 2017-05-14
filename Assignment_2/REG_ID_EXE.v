module REG_ID_EXE (
	CLK,
	
	control_exe_in,
	control_mem_in,
	control_wb_in,
	control_exception_in,
	alu_op_in,
	pc_in,

	read_data_1_in,
	read_data_2_in,
	sign_extend_in,
	rt_in,
	rd_in,
	
	control_exe_out,
	control_mem_out,
	control_wb_out,
	control_exception_out,
	alu_op_out,
	pc_out,

	read_data_1_out,
	read_data_2_out,
	sign_extend_out,
	rt_out,
	rd_out
);

input CLK;
input control_exception_in;
input [3:0] control_exe_in;
input [2:0]  control_mem_in;
input [5:0] alu_op_in;
input [1:0] control_wb_in;
input [31:0] read_data_1_in, read_data_2_in, sign_extend_in;
input [4:0] rt_in, rd_in;
input [7:0] pc_in;

output  [3:0] control_exe_out;
output  [2:0]  control_mem_out;
output  [5:0] alu_op_out;
output  [1:0] control_wb_out;
output  [31:0] read_data_1_out, read_data_2_out, sign_extend_out;
output  [4:0] rt_out, rd_out;
output  [7:0] pc_out;
output control_exception_out;

reg [3:0] control_exe;
reg [2:0] control_mem;
reg [5:0] alu_op;
reg [1:0] control_wb;
reg [31:0] read_data_1, read_data_2, sign_extend;
reg [4:0] rt, rd;
reg [7:0] pc;
reg control_exception;

always@(posedge CLK) begin
	control_exe <= control_exe_in;
	control_mem <= control_mem_in;
	control_wb <= control_wb_in;
	alu_op <= alu_op_in;
	control_exception <= control_exception_in;
	pc <= pc_in;
	
	read_data_1 <= read_data_1_in;
	read_data_2 <= read_data_2_in;
	sign_extend <= sign_extend_in;
	rt <= rt_in;
	rd <= rd_in;
end

	
assign 	alu_op_out = (alu_op)? alu_op: sign_extend[5:0];

assign	control_exe_out = control_exe;
assign	control_mem_out = control_mem;
assign	control_wb_out = control_wb;
assign	pc_out = pc;

assign	read_data_1_out = read_data_1;
assign	read_data_2_out = read_data_2;
assign	sign_extend_out = sign_extend;
assign	rt_out = rt;
assign	rd_out = rd;
assign   control_exception_out = control_exception;

endmodule
