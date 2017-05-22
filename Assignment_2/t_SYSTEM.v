`timescale 1ns/1ns
module t_SYSTEM;
	reg clk,rst,load,CLK_50;
	reg [7:0] pc;
	reg [7:0] sel;
	wire [27:0] led;
	wire [7:0] w_inst_address,w_alu_status,w_alu_status_mem,w_inst_address_mem,w_inst_address_exe,w_inst_adder0
					,w_mux1,w_mux0;
	wire [31:0] w_inst_val,w_inst_val_id,w_read_data1,w_read_data2,w_sign_extend,w_read_data1_exe,w_read_data2_exe,w_sign_extend_exe,w_alu_result,w_mux2,
					w_alu_result_mem,w_read_data2_mem,w_mem_data,w_mem_data_wb,w_alu_result_wb,w_mux4,w_read_data1_shamt;
	wire [3:0] w_control_exe,w_control_exe_exe,w_alu_control,w_regDest_wb;
	wire [2:0] w_control_mem,w_control_mem_exe,w_control_mem_mem;
	wire [1:0] w_control_wb,w_control_wb_exe,w_control_wb_mem,w_control_wb_wb;
	wire [5:0] w_alu_op_exe;
	wire [4:0] w_rt_exe,w_rd_exe,w_regDest_mem;
	wire w_exception;
	
	SYSTEM f(
	.SYS_clk(clk),
	.CLK_50 (CLK_50),
	.SYS_reset(rst),
	.SYS_load(load),
	.SYS_pc_val(pc),
	.SYS_output_sel(sel),
	.SYS_leds(led),
	.w_inst_adder0(w_inst_adder0),
	
	.w_inst_address(w_inst_address),
	.w_inst_val(w_inst_val),
	.w_inst_val_id(w_inst_val_id),
	.w_read_data1(w_read_data1),
	.w_read_data2(w_read_data2),
	.w_sign_extend(w_sign_extend),
	
	.w_control_exe(w_control_exe),
	.w_control_mem(w_control_mem),
	.w_control_wb(w_control_wb),
	
	.w_control_exe_exe(w_control_exe_exe),
	.w_control_mem_exe(w_control_mem_exe),
	.w_control_wb_exe(w_control_wb_exe),
	.w_alu_op_exe(w_alu_op_exe),
	.w_read_data1_exe(w_read_data1_exe),
	.w_read_data2_exe(w_read_data2_exe),
	.w_sign_extend_exe(w_sign_extend_exe),
	.w_rt_exe(w_rt_exe),
	.w_rd_exe(w_rd_exe),
	.w_inst_address_exe(w_inst_address_exe),
	
	.w_alu_result(w_alu_result),
	.w_alu_status(w_alu_status),
	.w_alu_control(w_alu_control),
	.w_mux2(w_mux2),
	.w_mux1(w_mux1),
	.w_mux0(w_mux0),
	.w_mux4(w_mux4),
	
	.w_control_mem_mem(w_control_mem_mem),
	.w_control_wb_mem(w_control_wb_mem),
	.w_inst_address_mem(w_inst_address_mem),
	.w_alu_status_mem(w_alu_status_mem),
	.w_alu_result_mem(w_alu_result_mem),
	.w_read_data2_mem(w_read_data2_mem),
	.w_regDest_mem(w_regDest_mem),
	
	.w_mem_data(w_mem_data),
	
	.w_control_wb_wb(w_control_wb_wb),
	.w_mem_data_wb(w_mem_data_wb),
	.w_alu_result_wb(w_alu_result_wb),
	.w_regDest_wb(w_regDest_wb),
	
	.w_exception(w_exception),
	.w_control_exception(w_control_exception),
	.w_read_data1_shamt(w_read_data1_shamt)
);
	initial begin
		#50
		clk=0;
		forever #20 clk=~clk;
	end
	initial begin
		CLK_50=0;
		forever #1 CLK_50=~CLK_50;
	end
	initial begin
		rst=1;
		pc=8'd0;
		#5 rst=0;
		#5 rst=1;
		#5 load = 1;
		#5	load = 0;
		#1000 $stop;
		
	end
endmodule 
