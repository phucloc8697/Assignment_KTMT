module SYSTEM (
	SYS_clk,
	SYS_reset,
	SYS_load,
	SYS_pc_val,
	SYS_output_sel,
	SYS_leds
);

input SYS_clk, SYS_reset, SYS_load;
input [7:0] SYS_pc_val, SYS_output_sel;

output [26:0] SYS_leds;

reg [7:0] PC;

// Khoi IF
wire [31:0] w_inst_val;
wire [7:0] 	w_inst_address,
				w_inst_adder0;
// Khoi ID
wire [31:0] w_inst_val_id,
				w_read_data1,
				w_read_data2,
				w_sign_extend;
wire [7:0] 	w_inst_address_id;
wire [4:0]	w_rt,
				w_rd;
wire [3:0] 	w_control_mem;
wire [2:0] 	w_control_exe;
wire [1:0] 	w_control_wb;
wire 			w_control_jump,
				w_control_exception;
// Khoi EXE
wire [31:0] w_regDest,
				w_read_data1_exe,
				w_read_data2_exe,
				w_sign_extend_exe,
				w_shift_left1,
				w_mux2,
				w_alu_result;
wire [7:0]	w_inst_address_exe,
				w_inst_adder1,
				w_alu_status;
wire [5:0]	w_alu_op_exe;
wire [4:0]	w_rt_exe,
				w_rd_exe;
wire [3:0] 	w_control_exe_exe,
				w_alu_control;
wire [2:0] 	w_control_mem_exe;
wire [1:0] 	w_control_wb_exe;
wire 			w_alu_exception,
				w_exception;
// Khoi MEM
wire [31:0] w_alu_result_mem,
				w_read_data2_mem,
				w_mem_data;
wire [7:0] 	w_alu_status_mem,
				w_ins_address_mem;
wire [4:0]	w_regDest_mem;
wire [2:0]	w_control_mem_mem;
wire [1:0]	w_control_wb_mem;
wire			w_branch;
// Khoi WB
wire [31:0] w_alu_result_wb,
				w_mem_data_wb,
				w_mux4;
wire [4:0]	w_regDest_wb;
wire [1:0] 	w_control_wb_wb;
//	Other
wire [31:0] w_adder_jump,
				w_mux0;
wire [27:0] w_shift_left0;
wire [7:0]	w_mux1;

IMEM IMEM (
	.CLK(SYS_clock), 
	.MEM_PC(w_inst_address), 
	.IMEM_instruction(w_inst_val)
);
REG REG (
	.CLK(SYS_clock),
	.REG_address1(w_inst_val_id[25:21]),
	.REG_address2(w_inst_val_id[20:16]),
	.REG_address_wr(w_regDest_wb),
	.REG_write_1(w_control_wb_wb[0]),
	.REG_data_wb_in1(w_mux4),
	.REG_data_out1(w_read_data1),
	.REG_data_out2(w_read_data2)
);
DMEM DMEM (
	.CLK(SYS_clock),
	.DMEM_address(w_alu_result_mem),
	.DMEM_data_in(w_read_data2_mem),
	.DMEM_mem_write(w_control_mem_mem[1]),
	.DMEM_mem_read(w_control_mem_mem[0]),
	.DMEM_data_out(w_mem_data)
);
CONTROL CONTROL (
	.opcode(w_inst_val_id[31:26]),
	.control_exe(w_control_exe),
	.control_mem(w_control_mem),
	.control_wb(w_control_wb),
	.control_jump(w_control_jump),
	.control_exception(w_control_exception)
);
ALU ALU (
	.ALU_control(w_alu_control),
	.ALU_operand_1(w_read_data1_exe),
	.ALU_operand_2(w_mux2),
	.ALU_result(w_alu_result),
	.ALU_status(w_alu_status)
);
ALU_CONTROL ALU_CONTROL(
	.ALU_op(w_alu_op_exe),
	.Funct(w_sign_extend_exe[5:0]),
	.ALU_control(w_alu_control)
);

REG_IF_ID (
	.CLK(SYS_clock),
	.pc_address_in(w_inst_adder0),
	.instruction_in(w_inst_val),
	.pc_address_out(w_inst_address_id),
	.instruction_out(w_inst_val_id)
);
REG_ID_EXE (
	.CLK(SYS_clock),
	
	.control_exe_in(w_control_exe),
	.control_mem_in(w_control_mem),
	.control_wb_in(w_control_wb),
	.alu_op_in(w_inst_val_id[31:26]),

	.read_data_1_in(w_read_data1),
	.read_data_2_in(w_read_data2),
	.sign_extend_in(w_sign_extend),
	.rt_in(w_inst_val_id[20:16]),
	.rd_in(w_inst_val_id[15:11]),
	
	.control_exe_out(w_control_exe_exe),
	.control_mem_out(w_control_mem_exe),
	.control_wb_out(w_control_wb_exe),
	.alu_op_out(w_alu_op_exe),
	
	.read_data_1_out(w_read_data1_exe),
	.read_data_2_out(w_read_data2_exe),
	.sign_extend_out(w_sign_extend_exe),
	.rt_out(w_rt_exe),
	.rd_out(w_rd_exe),
);
REG_EXE_MEM REG_EXE_MEM (
	.CLK(),
	.exception_disable(),

	.control_mem_in(),
	.control_wb_in(),
	.branch_address_in(),
	.ALU_status_in(),
	.ALU_result_in(),
	.read_data_2_in(),
	.reg_dst_address_in(),
	
	.control_mem_out(),
	.control_wb_out(),
	.branch_address_out(),
	.ALU_status_out(),
	.ALU_result_out(),
	.read_data_2_out(),
	.reg_dst_address_out()
);
REG_MEM_WB REG_MEM_WB (
	.CLK(),
	
	.control_wb_in(),
	.read_data_in(),
	.ALU_result_in(),
	.reg_dst_address_in(),
	
	.control_wb_out(),
	.read_data_out(),
	.ALU_result_out(),
	.reg_dst_address_out()
);

MUX MUX_0 (
	.in0(),
	.in1(),
	.sel(),
	.out()
);
MUX MUX_1 (
	.in0(),
	.in1(),
	.sel(),
	.out()
);
MUX MUX_2 (
	.in0(),
	.in1(),
	.sel(),
	.out()
);
MUX MUX_3 (
	.in0(),
	.in1(),
	.sel(),
	.out()
);
MUX MUX_4 (
	.in0(),
	.in1(),
	.sel(),
	.out()
);
SHIFT_LEFT_2 SL_0 (
	.in(),
	.out()
);
SHIFT_LEFT_2 SL_1 (
	.in(),
	.out()
);
ADDER ADDER_0 (
	.in0(w_inst_address),
	.in1(8'd4),
	.out(w_inst_adder0)
);
ADDER ADDER_1 (
	.in0(),
	.in1(),
	.out()
);
AND_BRANCH AND_BRANCH (
	.ALU_status(),
	.control_branch(),
	.out()
);

endmodule
