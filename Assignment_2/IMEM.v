module IMEM (
	input CLK,
	input [7:0] MEM_PC,
	output reg [31:0] IMEM_instruction
);
	wire [7:0] register [0:1024];
	
	assign	register[0] = 8'h20;
	assign	register[1] = 8'h09;
	assign	register[2] = 8'h00;
	assign	register[3] = 8'h04;
		
	assign	register[4] = 8'h20;
	assign	register[5] = 8'h0a;
	assign	register[6] = 8'h00;
	assign	register[7] = 8'h05;
		
	assign	register[8] = 8'h20;
	assign	register[9] = 8'h0b;
	assign	register[10] = 8'h00;
	assign	register[11] = 8'h06;
	
	assign	register[12] = 8'h01;
	assign	register[13] = 8'h29;
	assign	register[14] = 8'h48;
	assign	register[15] = 8'h20;
	
	always @(posedge CLK) begin
		IMEM_instruction[31:24] <= register[MEM_PC];
		IMEM_instruction[23:16] <= register[MEM_PC+1];
		IMEM_instruction[15:8]  <= register[MEM_PC+2];
		IMEM_instruction[7:0]   <= register[MEM_PC+3];
	end
/*IMEM_BRAM RAM1 (.address(MEM_PC),   .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [31:24]));
IMEM_BRAM RAM2 (.address(MEM_PC+1), .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [23:16]));
IMEM_BRAM RAM3 (.address(MEM_PC+2), .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [15:8]));
IMEM_BRAM RAM4 (.address(MEM_PC+3), .clock(CLK), .data(0), .wren(0), .q(IMEM_instruction [7:0]));*/

endmodule
