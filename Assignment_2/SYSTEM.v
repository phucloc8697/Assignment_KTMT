module SYSTEM (
	SYS_clk,
	CLK_50,
	SYS_reset,
	SYS_load,
	SYS_pc_val,
	SYS_output_sel,
	SYS_leds,
	w_inst_adder0,
	
	w_inst_address,
	w_inst_val,
	w_inst_val_id,
	w_read_data1,
	w_read_data2,
	w_sign_extend,
	
	w_control_exe,
	w_control_mem,
	w_control_wb,
	
	w_control_exe_exe,
	w_control_mem_exe,
	w_control_wb_exe,
	w_alu_op_exe,
	w_read_data1_exe,
	w_read_data2_exe,
	w_sign_extend_exe,
	w_rt_exe,
	w_rd_exe,
	w_inst_address_exe,
	
	w_alu_result,
	w_alu_status,
	w_alu_control,
	w_mux2,
	w_mux1,
	w_mux0,
	w_mux4,
	
	w_control_mem_mem,
	w_control_wb_mem,
	w_inst_address_mem,
	w_alu_status_mem,
	w_alu_result_mem,
	w_read_data2_mem,
	w_regDest_mem,
	
	w_mem_data,
	
	w_control_wb_wb,
	w_mem_data_wb,
	w_alu_result_wb,
	w_regDest_wb,
	
	w_exception,
	w_control_exception
);

input SYS_clk, SYS_reset, SYS_load,CLK_50;
input [7:0] SYS_pc_val, SYS_output_sel;

output reg [26:0] SYS_leds;


// Khoi IF
output  [31:0] w_inst_val;
output  [7:0] 	w_inst_address;
output  [7:0]		w_inst_adder0;
reg [7:0] w_mux1_or_val_in;
// Khoi ID
output [31:0] w_inst_val_id,
				w_read_data1,
				w_read_data2,
				w_sign_extend;
wire [7:0] 	w_inst_address_id,w_inst_adder0_check;
wire [4:0]	w_rt,
				w_rd;
output [2:0] 	w_control_mem;
output [3:0] w_control_exe;
output [1:0] 	w_control_wb;
wire 			w_control_jump;
output 				w_control_exception;
// Khoi EXE
wire [31:0] w_regDest,
			//	w_read_data1_exe,
			//	w_read_data2_exe,
			//	w_sign_extend_exe,
				w_shift_left1;
output[31:0]				w_mux2;
output [31:0]				w_alu_result;
output [31:0] w_read_data1_exe,
					w_read_data2_exe,
					w_sign_extend_exe;
wire [7:0]				w_inst_adder1;
output [7:0] w_inst_address_exe;
output [7:0]		w_alu_status;
output [5:0]	w_alu_op_exe;
output [4:0]	w_rt_exe,
				w_rd_exe;
output [3:0] 	w_control_exe_exe;
output	[3:0]			w_alu_control;
output [2:0] 	w_control_mem_exe;
output [1:0] 	w_control_wb_exe;
wire 			w_alu_exception;
output		w_exception;
// Khoi MEM
output  [31:0] w_read_data2_mem;
output [31:0]				w_mem_data;
output [31:0] w_alu_result_mem;
output [7:0] 	w_alu_status_mem;
wire [7:0]				w_ins_address_mem;
output [4:0]	w_regDest_mem;
output  [2:0]	w_control_mem_mem;
output [1:0]	w_control_wb_mem;
output [7:0] w_inst_address_mem;
wire			w_branch;
// Khoi WB
output  [31:0] w_alu_result_wb;
output [31:0]		w_mux4;
output [31:0] w_mem_data_wb;
output  [4:0]	w_regDest_wb;
output [1:0] 	w_control_wb_wb;
//	Other
wire [31:0] w_adder_jump;
output [7:0]				w_mux0;
wire [27:0] w_shift_left0;
output [7:0]	w_mux1;
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
CONTROL CONTROL (
	.opcode(w_inst_val_id),
	.control_exe(w_control_exe),
	.control_mem(w_control_mem),
	.control_wb(w_control_wb),
	.control_jump(w_control_jump),
	.control_exception(w_control_exception)
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
	.pc_address_in(w_inst_adder0),
	.instruction_in(w_inst_val),
	.pc_address_out(w_inst_address_id),
	.instruction_out(w_inst_val_id)
);
REG_ID_EXE REG_ID_EXE(
	.CLK(SYS_clk),
	
	.control_exe_in(w_control_exe),
	.control_mem_in(w_control_mem),
	.control_wb_in(w_control_wb),
	.control_exception_in(w_control_exception),
	.alu_op_in(w_inst_val_id[31:26]),

	.read_data_1_in(w_read_data1),
	.read_data_2_in(w_read_data2),
	.sign_extend_in(w_sign_extend),
	.rt_in(w_inst_val_id[20:16]),
	.rd_in(w_inst_val_id[15:11]),
	.pc_in(w_inst_address_id),
	
	.control_exe_out(w_control_exe_exe),
	.control_mem_out(w_control_mem_exe),
	.control_wb_out(w_control_wb_exe),
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
	
	.control_mem_out(w_control_mem_mem),
	.control_wb_out(w_control_wb_mem),
	.branch_address_out(w_inst_address_mem),
	.ALU_status_out(w_alu_status_mem),
	.ALU_result_out(w_alu_result_mem),
	.read_data_2_out(w_read_data2_mem),
	.reg_dst_address_out(w_regDest_mem)
);
REG_MEM_WB REG_MEM_WB (
	.CLK(SYS_clk),
	
	.control_wb_in(w_control_wb_mem),
	.read_data_in(w_mem_data),
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
SHIFT_LEFT_2 SL_0 (
	.in(w_inst_val_id),
	.out(w_shift_left0)
);
SHIFT_LEFT_2 SL_1 (
	.in(w_sign_extend_exe),
	.out(w_shift_left1)
);
ADDER ADDER_01 (
	.in0(w_inst_address),
	.in1(8'd4),
	.out(w_inst_adder0)
);
// Can xem lai cho nay, 1 cai 8 bit 1 cai 32 bit ?
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
		//8'd0: 
		8'd0: SYS_leds = w_inst_val	;
		8'd1: SYS_leds = w_read_data1	;
		8'd8: SYS_leds = w_read_data2	;
		8'd2: SYS_leds = w_alu_result	;
		8'd3: SYS_leds = w_alu_status ;
		8'd4: SYS_leds = w_mem_data	;
		8'd5: SYS_leds = { 16'd0,
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
		8'd6: SYS_leds = w_alu_control;
		8'd7: SYS_leds = w_inst_address;
		//default:
	endcase
end
		
endmodule
