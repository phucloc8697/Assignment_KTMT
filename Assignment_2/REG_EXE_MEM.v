module REG_EXE_MEM (
	CLK,
	RESET,
	exception_disable,

	control_mem_in,
	control_wb_in,
	branch_address_in,
	ALU_status_in,
	ALU_result_in,
	read_data_2_in,
	reg_dst_address_in,
	control_datamem_in,
	
	control_mem_out,
	control_wb_out,
	branch_address_out,
	ALU_status_out,
	ALU_result_out,
	read_data_2_out,
	reg_dst_address_out,
	control_datamem_out
);

input CLK, exception_disable,RESET;
input [7:0] ALU_status_in;
input [2:0] control_mem_in;
input [1:0] control_wb_in,control_datamem_in;
input [31:0] branch_address_in, ALU_result_in, read_data_2_in, reg_dst_address_in;

output reg [7:0] ALU_status_out;
output reg [2:0] control_mem_out;
output reg [1:0] control_wb_out,control_datamem_out;
output reg [31:0] branch_address_out, ALU_result_out, read_data_2_out, reg_dst_address_out;

reg check;
always@(posedge CLK or negedge RESET) begin
	if(!RESET) begin
		control_mem_out <= 0;
		control_wb_out <= 0;
		branch_address_out <=0;
		ALU_result_out <=0;
		ALU_status_out <=0;
		read_data_2_out <=0;
		reg_dst_address_out <=0;
		control_datamem_out <= 0;
	end
	else begin 
		if(check) control_mem_out <= 3'd0;
		else if (exception_disable) control_mem_out <= 3'd0;
		else 	control_mem_out <= control_mem_in;
		control_wb_out <= control_wb_in;
		branch_address_out <= branch_address_in;
		ALU_result_out <= ALU_result_in;
		ALU_status_out <= ALU_status_in;
		read_data_2_out <= read_data_2_in;
		reg_dst_address_out <= reg_dst_address_in;
		control_datamem_out <= control_datamem_in;
	end
end

always @(negedge CLK or negedge RESET) begin
	if(!RESET)
		check <= 0;
	else if( exception_disable)
		check <= 1;
	else check <= check;
end


endmodule
