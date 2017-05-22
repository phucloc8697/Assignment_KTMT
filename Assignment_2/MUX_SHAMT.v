module MUX_SHAMT(	
	read_data_reg,
	op,
	shamt,
	out
);
	input [31:0] read_data_reg;
	input [5:0] op;
	input [4:0] shamt;
	output [31:0] out;
	
	assign out = (op ==6'd0 && shamt !=0)?{27'd0,shamt[4:0]}:read_data_reg[31:0];
	
endmodule 