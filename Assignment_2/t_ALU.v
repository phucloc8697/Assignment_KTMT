`timescale 1ns/1ns
module t_ALU;
	reg clk,RESET;
	reg [3:0] ALU_control;
	reg [31:0] ALU_operand_1,ALU_operand_2;
	wire [31:0] ALU_result;
	wire [7:0] ALU_status;
	
	ALU ALU(
	.RESET(RESET),
	.ALU_control(ALU_control),
	.ALU_operand_1(ALU_operand_1),
	.ALU_operand_2(ALU_operand_2),
	.ALU_result(ALU_result),
	.ALU_status(ALU_status)
	);
	
	initial begin
		clk=0;
		forever #10 clk=~clk;
	end
	
	initial begin
		RESET = 0;
		#10 RESET =1;
			ALU_control = 4'b0010;
			ALU_operand_1 = 32'hffff0000;
			ALU_operand_2 = 32'h00000fff;
		#10 
			ALU_operand_1 = 32'h7fff0000;
			ALU_operand_2 = 32'h6000ffff;
		#10 
			ALU_operand_1 = 32'h7fff0000;
			ALU_operand_2 = 32'h6000ffff;
		#10 
			ALU_operand_1 = 32'h0fff0000;
			ALU_operand_2 = 32'h0f000000;
		#10 
			ALU_operand_1 = 32'h80000000;
			ALU_operand_2 = 32'hf0000000;
		#10 ALU_control=4'b0110;
			ALU_operand_1=32'h0fff0000;
			ALU_operand_2=32'h00f00000;
		#10 ALU_operand_1=32'h0fff0000;
			ALU_operand_2=32'h80000000;
		#10 ALU_control=4'b1000;
			ALU_operand_1=32'd123;
			ALU_operand_2=32'd2;
		#10 ALU_operand_2=32'd1;
		#10 ALU_control=4'b1001;
			ALU_operand_2=32'd10;
		#10 ALU_operand_2=32'd3;
		#10 ALU_control=4'b1010;
			ALU_operand_1=32'h00000100;
			ALU_operand_2=32'd0;
		#10 ALU_operand_2=32'd1;
		#10 ALU_operand_2=32'd3;
		#10 ALU_operand_1=32'd1;
			ALU_operand_2=32'd32;
		#10 ALU_operand_2=32'd31;
		#10 ALU_control=4'b1011;
			ALU_operand_1=32'h00000100;
			ALU_operand_2=32'd0;
		#10 ALU_operand_2=32'd1;
		#10 ALU_operand_2=32'd3;
		#10 ALU_operand_1=32'd1;
			ALU_operand_2=32'd32;
		#10 ALU_operand_2=32'd31;
		#10 ALU_control=4'b0100;
			ALU_operand_1=32'h00000100;
			ALU_operand_2=32'd0;
		#10 ALU_operand_2=32'd1;
		#10 ALU_operand_2=32'd3;
	end
endmodule 
			
	
	