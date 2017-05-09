module IMEM (
	input CLK,
	input [7:0] MEM_PC,
	output [31:0] IMEM_instruction
);

IMEM_BRAM RAM1 (.address(MEM_PC),   .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [31:24]));
IMEM_BRAM RAM2 (.address(MEM_PC+1), .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [23:16]));
IMEM_BRAM RAM3 (.address(MEM_PC+2), .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [15:8]));
IMEM_BRAM RAM4 (.address(MEM_PC+3), .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [7:0]));

endmodule
