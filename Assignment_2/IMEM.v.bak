module IMEM (
	input CLK,
	input [7:0] MEM_PC,
	output [31:0] IMEM_instruction
);

IMEM_RAM RAM (.address(MEM_PC), .clock(CLK), .q(IMEM_instruction));

endmodule
