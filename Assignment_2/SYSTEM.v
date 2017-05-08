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

wire [7:0] 	inst_address,
				inst_adder1, 
				inst_address_if_id, 
				inst_address_id_exe;
				
wire [31:0] inst_val,
				inst_val_if_id, 
				read_data1,
				read_data2,
				sign_extend,
				rt, rd;

IMEM IMEM (
	.CLK(), 
	.MEM_PC(), 
	.IMEM_instruction()
);
REG REG (
	.CLK(),
	.REG_address1(),
	.REG_address2(),
	.REG_address_wr(),
	.REG_write_1(),
	.REG_data_wb_in1(),
	.REG_data_out1(),
	.REG_data_out2()
);
DMEM DMEM (
	.CLK(),
	.DMEM_address(),
	.DMEM_data_in(),
	.DMEM_mem_write(),
	.DMEM_mem_readI(),
	.DMEM_data_out()
);
CONTROL CONTROL (
	.opcode(),
	.control_exe(),
	.control_mem(),
	.control_wb(),
	.control_jump(),
	.control_exception()
);

REG_IF_ID (
	.CLK(),
	.pc_address_in(),
	.instruction_in(),
	.pc_address_out(),
	.instruction_out()
);
REG_ID_EXE (
	.CLK(),
	
	.control_exe_in(),
	.control_mem_in(),
	.control_wb_in(),

	.read_data_1_in(),
	.read_data_2_in(),
	.sign_extend_in(),
	.rt_in(),
	.rd_in(),
	
	.control_exe_out(),
	.control_mem_out(),
	.control_wb_out(),

	.read_data_1_out(),
	.read_data_2_out(),
	.sign_extend_out(),
	.rt_out(),
	.rd_out(),
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
	.in0(),
	.in1(),
	.out()
);
ADDER ADDER_1 (
	.in0(),
	.in1(),
	.out()
);

endmodule
