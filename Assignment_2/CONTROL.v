module CONTROL (
	opcode,
	control_exe,
	control_mem,
	control_wb,
	control_jump,
	control_exception,
	control_out_datamem,
	control_out_reg2
);

input [31:0] opcode;
output [3:0] control_exe;
output [2:0] control_mem;
output [1:0] control_wb;
output control_jump, control_exception;
output [1:0] control_out_datamem,control_out_reg2;

reg RegDst, RegWrite, ALUsrc, Exception, Mem2Reg, MemWrite, MemRead, Branch, Jump;
reg [1:0] ALUop;
reg [1:0] data_mem,reg2;
assign control_exe[0] = RegDst;
assign control_exe[1] = ALUsrc;
assign control_exe[3:2] = ALUop;

assign control_mem[0] = MemRead;
assign control_mem[1] = MemWrite;
assign control_mem[2] = Branch;

assign control_wb[0] = RegWrite;
assign control_wb[1] = Mem2Reg;
assign control_jump = Jump;

assign control_exception = Exception;

assign control_out_datamem = data_mem;
assign control_out_reg2 = reg2;

always@(*) begin

	case (opcode[31:26])

		// Lenh R
		6'd0: begin
			RegDst = 1;
			RegWrite = 1;
			ALUsrc = 0;
			ALUop = 2'b10;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			if( opcode[15:11] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// addi
		6'd8: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			ALUop = 2'b10;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			if( opcode[20:16] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// addi
		6'd28: begin
			RegDst = 1;
			RegWrite = 1;
			ALUsrc = 0;
			ALUop = 2'b10;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			if( opcode[15:11] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// lbu
		6'd36: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b00;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 1;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// lb
		6'd32: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			ALUop = 2'b00;
			Mem2Reg = 0;
			MemWrite = 0;
			MemRead = 1;
			Branch = 0;
			Jump = 0;
			if( opcode[20:16] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd1;
			reg2 = 2'd3;
		end
		// lw
		6'd35: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			ALUop = 2'b00;
			Mem2Reg = 0;
			MemWrite = 0;
			MemRead = 1;
			Branch = 0;
			Jump = 0;
			if( opcode[20:16] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd3;
			reg2 = 2'd3;
		end
		// sb
		6'd40: begin
			RegDst = 1'bx;
			RegWrite = 0;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b00;
			Mem2Reg = 1'bx;
			MemWrite = 1;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd1;
		end
		// slti
		6'd10: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b10;
			Mem2Reg = 0;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// andi
		6'd12: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			ALUop = 2'b10;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			if( opcode[20:16] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// beq
		6'd4: begin
			RegDst = 1'bx;
			RegWrite = 0;
			ALUsrc = 0;
			Exception = 0;
			ALUop = 2'b01;
			Mem2Reg = 2'bx;
			MemWrite = 0;
			MemRead = 0;
			Branch = 1;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// lhu
		6'd37: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b00;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 1;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// lh
		6'd33: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b00;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 1;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd2;
			reg2 = 2'd3;
		end
		// sw
		6'd43: begin
			RegDst = 1'bx;
			RegWrite = 0;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b00;
			Mem2Reg = 1'bx;
			MemWrite = 1;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// sh
		6'd41: begin
			RegDst = 1'bx;
			RegWrite = 0;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b00;
			Mem2Reg = 1'bx;
			MemWrite = 1;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd2;
		end
		// sltiu
		6'd11: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b10;
			Mem2Reg = 0;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// ori
		6'd13: begin
			RegDst = 0;
			RegWrite = 1;
			ALUsrc = 1;
			ALUop = 2'b10;
			Mem2Reg = 1;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 0;
			if( opcode[20:16] ==5'd0)
				Exception = 1;
			else Exception = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// bne
		6'd5: begin
			RegDst = 1'bx;
			RegWrite = 0;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'b01;
			Mem2Reg = 1'bx;
			MemWrite = 0;
			MemRead = 0;
			Branch = 1;
			Jump = 0;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		// jump
		6'h02: begin
			RegDst = 1'bx;
			RegWrite = 0;
			ALUsrc = 1;
			Exception = 0;
			ALUop = 2'bxx;
			Mem2Reg = 1'bx;
			MemWrite = 0;
			MemRead = 0;
			Branch = 0;
			Jump = 1;
			data_mem = 2'd0;
			reg2 = 2'd3;
		end
		
		default: begin
			Exception = 1;
		end
			
	endcase

end

endmodule
