module REG_ID_EXE (
	CLK,
	RESET,
	control_exe_in,
	control_mem_in,
	control_wb_in,
	control_exception_in,
	control_datamem_in,
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
	control_datamem_out,
	alu_op_out,
	pc_out,

	read_data_1_out,
	read_data_2_out,
	sign_extend_out,
	rt_out,
	rd_out
);

input CLK,RESET;
input control_exception_in;
input [3:0] control_exe_in;
input [2:0]  control_mem_in;
input [5:0] alu_op_in;
input [1:0] control_wb_in,control_datamem_in;
input [31:0] read_data_1_in, read_data_2_in, sign_extend_in;
input [4:0] rt_in, rd_in;
input [7:0] pc_in;

output reg  [3:0] control_exe_out;
output reg  [2:0]  control_mem_out;
output  reg [5:0] alu_op_out;
output  reg [1:0] control_wb_out,control_datamem_out;
output reg [31:0] read_data_1_out, read_data_2_out, sign_extend_out;
output reg [4:0] rt_out, rd_out;
output reg [7:0] pc_out;
output reg control_exception_out;


always@(posedge CLK or negedge RESET) begin
	if(!RESET) begin
		control_exe_out <= 0;
		control_mem_out <= 0;
		control_wb_out <= 0;
		alu_op_out <= 0;
		control_exception_out <= 0;
		pc_out <= 0;
		
		read_data_1_out <= 0;
		read_data_2_out <= 0;
		sign_extend_out <= 0;
		rt_out <= 0;
		rd_out <= 0;
		control_datamem_out <= 0;
	end
	else begin
		control_exe_out <= control_exe_in;
		control_mem_out <= control_mem_in;
		control_wb_out <= control_wb_in;
		if(alu_op_in)
			alu_op_out <= alu_op_in;
		else alu_op_out <= sign_extend_in[5:0];
		control_exception_out <= control_exception_in;
		pc_out <= pc_in;
		
		read_data_1_out <= read_data_1_in;
		read_data_2_out <= read_data_2_in;
		sign_extend_out <= sign_extend_in;
		rt_out <= rt_in;
		rd_out <= rd_in;
		control_datamem_out <= control_datamem_in;
	end
end

	
endmodule
