module SYSTEM (
	SYS_clk,
	CLK_50,
	SYS_reset,
	SYS_load,
	SYS_pc_val,
	SYS_output_sel,
	SYS_leds,
	hex1,
	hex2
);

input SYS_clk, SYS_reset, SYS_load,CLK_50;
input [7:0] SYS_pc_val, SYS_output_sel;

output reg [26:0] SYS_leds;
output [6:0] hex1, hex2;

// Khoi IF
wire  [31:0] w_inst_val;
wire  [7:0] 	w_inst_address;
wire  [7:0]		w_inst_adder0;
reg [7:0] w_mux1_or_val_in;
// Khoi ID
wire [31:0] w_inst_val_id,
				w_read_data1,
				w_read_data2,
				w_sign_extend;
wire [7:0] 	w_inst_address_id,w_inst_adder0_check;
wire [4:0]	w_rt,
				w_rd;
wire [2:0] 	w_control_mem;
wire [3:0] w_control_exe;
wire [1:0] 	w_control_wb;
wire 			w_control_jump;
wire 				w_control_exception;
wire [1:0] w_control_datamem, w_control_out_reg2;
wire [31:0] w_out_sel_read_data2;
// Khoi EXE
wire [31:0] w_regDest,
			//	w_read_data1_exe,
			//	w_read_data2_exe,
			//	w_sign_extend_exe,
				w_shift_left1;
wire[31:0]				w_mux2;
wire [31:0]				w_alu_result;
wire [31:0] w_read_data1_exe,
					w_read_data2_exe,
					w_sign_extend_exe;
wire [7:0]				w_inst_adder1;
wire [7:0] w_inst_address_exe;
wire [7:0]		w_alu_status;
wire [5:0]	w_alu_op_exe;
wire [4:0]	w_rt_exe,
				w_rd_exe;
wire [3:0] 	w_control_exe_exe;
wire	[3:0]			w_alu_control;
wire [2:0] 	w_control_mem_exe;
wire [1:0] 	w_control_wb_exe;
wire 			w_alu_exception;
wire		w_exception;
wire [1:0] w_control_datamem_exe;
// Khoi MEM
wire  [31:0] w_read_data2_mem;
wire [31:0]				w_mem_data;
wire [31:0] w_alu_result_mem;
wire [7:0] 	w_alu_status_mem;
wire [7:0]				w_ins_address_mem;
wire [4:0]	w_regDest_mem;
wire  [2:0]	w_control_mem_mem;
wire [1:0]	w_control_wb_mem;
wire [7:0] w_inst_address_mem;
wire			w_branch;
wire [31:0] w_mem_datasel;
wire [1:0] w_control_datamem_mem;
// Khoi WB
wire  [31:0] w_alu_result_wb;
wire [31:0]		w_mux4;
wire [31:0] w_mem_data_wb;
wire  [4:0]	w_regDest_wb;
wire [1:0] 	w_control_wb_wb;
//	Other
wire [7:0] w_adder_jump;
wire [31:0] w_read_data1_shamt;
wire [7:0]				w_mux0;
wire [31:0] w_shift_left0;
wire [7:0]	w_mux1;
wire w_control_exception_exe;


PC PC( 	
	.CLK(SYS_clk),
	.RESET(SYS_reset),
	.LOAD(SYS_load),
	.PC_val(SYS_pc_val), 
	.PC_in(w_mux0), 
	.PC_out(w_inst_address)
);
IMEM IMEM (
	.CLK(CLK_50), 
	.MEM_PC(w_inst_address), 
	.IMEM_instruction(w_inst_val)
);
REG REG (
	.CLK(CLK_50),
	.RESET(SYS_reset),
	.REG_address1(w_inst_val_id[25:21]),
	.REG_address2(w_inst_val_id[20:16]),
	.REG_address_wr(w_regDest_wb),
	.REG_write_1(w_control_wb_wb[0]),
	.REG_data_wb_in1(w_mux4),
	.REG_data_out1(w_read_data1),
	.REG_data_out2(w_read_data2)
);
DMEM DMEM (
	.CLK(CLK_50),
	.DMEM_address(w_alu_result_mem),
	.DMEM_data_in(w_read_data2_mem),
	.DMEM_mem_write(w_control_mem_mem[1]),
	.DMEM_mem_read(w_control_mem_mem[0]),
	.DMEM_data_out(w_mem_data)
);
DATA_SEL DATA_SEL(
	.datamem_in(w_mem_data),
	.control_datamem(w_control_datamem_mem),
	.datamem_out(w_mem_datasel)
);
CONTROL CONTROL (
	.opcode(w_inst_val_id),
	.control_exe(w_control_exe),
	.control_mem(w_control_mem),
	.control_wb(w_control_wb),
	.control_jump(w_control_jump),
	.control_exception(w_control_exception),
	.control_out_datamem(w_control_datamem),
	.control_out_reg2(w_control_out_reg2)
);
DATA_SEL_REG2 DATA_SEL_REG2(
	.data_in(w_read_data2),
	.data_sel(w_control_out_reg2),
	.data_out(w_out_sel_read_data2)
);
SIGN_EXTEND SIGN_EXTEND(
	.in(w_inst_val_id[15:0]),
	.out(w_sign_extend)
);
ALU ALU (
	.ALU_control(w_alu_control),
	.ALU_operand_1(w_read_data1_exe),
	.ALU_operand_2(w_mux2),
	.ALU_result(w_alu_result),
	.ALU_status(w_alu_status)
);
ALU_CONTROL ALU_CONTROL(
	.ALU_op(w_control_exe_exe[3:2]),
	.Funct(w_alu_op_exe),
	.ALU_control(w_alu_control)
);

REG_IF_ID REG_IF_ID(
	.CLK(SYS_clk),
	.RESET(SYS_reset),
	.pc_address_in(w_inst_adder0),
	.instruction_in(w_inst_val),
	.pc_address_out(w_inst_address_id),
	.instruction_out(w_inst_val_id)
);
REG_ID_EXE REG_ID_EXE(
	.CLK(SYS_clk),
	.RESET(SYS_reset),
	.control_exe_in(w_control_exe),
	.control_mem_in(w_control_mem),
	.control_wb_in(w_control_wb),
	.control_exception_in(w_control_exception),
	.control_datamem_in(w_control_datamem),
	.alu_op_in(w_inst_val_id[31:26]),

	.read_data_1_in(w_read_data1_shamt),
	.read_data_2_in(w_read_data2),
	.sign_extend_in(w_sign_extend),
	.rt_in(w_inst_val_id[20:16]),
	.rd_in(w_inst_val_id[15:11]),
	.pc_in(w_inst_address_id),
	
	.control_exe_out(w_control_exe_exe),
	.control_mem_out(w_control_mem_exe),
	.control_wb_out(w_control_wb_exe),
	.control_datamem_out(w_control_datamem_exe),
	.alu_op_out(w_alu_op_exe),
	.control_exception_out(w_control_exception_exe),
	.pc_out(w_inst_address_exe),
	
	.read_data_1_out(w_read_data1_exe),
	.read_data_2_out(w_read_data2_exe),
	.sign_extend_out(w_sign_extend_exe),
	.rt_out(w_rt_exe),
	.rd_out(w_rd_exe)
);
REG_EXE_MEM REG_EXE_MEM (
	.CLK(SYS_clk),
	.RESET(SYS_reset),
	.exception_disable(w_exception),

	.control_mem_in(w_control_mem_exe),
	.control_wb_in(w_control_wb_exe),
	.branch_address_in(w_inst_adder1),
	.ALU_status_in(w_alu_status),
	.ALU_result_in(w_alu_result),
	.read_data_2_in(w_read_data2_exe),
	.reg_dst_address_in(w_regDest),
	.control_datamem_in(w_control_datamem_exe),
	
	.control_mem_out(w_control_mem_mem),
	.control_wb_out(w_control_wb_mem),
	.branch_address_out(w_inst_address_mem),
	.ALU_status_out(w_alu_status_mem),
	.ALU_result_out(w_alu_result_mem),
	.read_data_2_out(w_read_data2_mem),
	.reg_dst_address_out(w_regDest_mem),
	.control_datamem_out(w_control_datamem_mem)
);
REG_MEM_WB REG_MEM_WB (
	.CLK(SYS_clk),
	.RESET(SYS_reset),
	.control_wb_in(w_control_wb_mem),
	.read_data_in(w_mem_datasel),
	.ALU_result_in(w_alu_result_mem),
	.reg_dst_address_in(w_regDest_mem),
	
	.control_wb_out(w_control_wb_wb),
	.read_data_out(w_mem_data_wb),
	.ALU_result_out(w_alu_result_wb),
	.reg_dst_address_out(w_regDest_wb)
);

EXCEPTION_HANDLE EXCEPTION_HANDLE(
	.control_exception(w_control_exception_exe),
	.ALU_status(w_alu_status),
	.disable_out(w_exception)
);
MUX_8 MUX_0 (
	.in0(w_mux1),
	.in1(w_adder_jump),
	.sel(w_control_jump),
	.out(w_mux0)
);
MUX_8 MUX_1 (
	.in0(w_inst_adder0),
	.in1(w_inst_address_mem),
	.sel(w_branch),
	.out(w_mux1)
);
MUX MUX_2 (
	.in0(w_read_data2_exe),
	.in1(w_sign_extend_exe),
	.sel(w_control_exe_exe[1]),
	.out(w_mux2)
);
MUX MUX_3 (
	.in0(w_rt_exe),
	.in1(w_rd_exe),
	.sel(w_control_exe_exe[0]),
	.out(w_regDest)
);
MUX MUX_4 (
	.in0(w_mem_data_wb),
	.in1(w_alu_result_wb),
	.sel(w_control_wb_wb[1]),
	.out(w_mux4)
);
MUX_SHAMT MUX_SHAMT(	
	.read_data_reg(w_read_data1),
	.op(w_inst_val_id[31:26]),
	.shamt(w_inst_val_id[10:6]),
	.out(w_read_data1_shamt)
);

SHIFT_LEFT_2 SL_0 (
	.in(w_inst_val_id),
	.out(w_shift_left0)
);
SHIFT_LEFT_2 SL_1 (
	.in(w_sign_extend_exe),
	.out(w_shift_left1)
);

ADDER ADDER_0 (
	.in0(w_inst_address),
	.in1(8'd4),
	.out(w_inst_adder0)
);

ADDER ADDER_JUMP (
	.in0(0),
	.in1(w_shift_left0[7:0]),
	.out(w_adder_jump)
);
ADDER ADDER_1 (
	.in0(w_shift_left1[7:0]),
	.in1(w_inst_address_exe),
	.out(w_inst_adder1)
);
AND_BRANCH AND_BRANCH (
	.ALU_status(w_alu_status_mem),
	.control_branch(w_control_mem_mem[2]),
	.out(w_branch)
);
EPC EPC(
	.in(w_inst_adder0),
	.reset(SYS_reset),
	.out1(hex1),
	.out2(hex2)
);
always @(*) begin
	case(SYS_output_sel[7:0])
		8'b00000001: SYS_leds = w_inst_val	;
		8'b00000010: SYS_leds = w_read_data1;
		8'b00010010: SYS_leds = w_read_data2;
		8'b00000100: SYS_leds = w_alu_result;
		8'b00001000: SYS_leds = w_alu_status;
		8'b00010000: SYS_leds = w_mem_data;
		8'b00100000: SYS_leds = {	16'd0,
											w_control_jump,
											w_control_mem[2],
											w_control_mem[0],
											w_control_mem[1],
											w_control_wb[1],
											w_control_exe[3:2],
											w_control_exception,
											w_control_exe[1],
											w_control_wb[0],
											w_control_exe[0]};		
		8'b01000000: SYS_leds = w_alu_control;
		8'b10000000: SYS_leds = w_inst_adder0;
		default : SYS_leds = 27'd0;
	endcase
end
		
endmodule
