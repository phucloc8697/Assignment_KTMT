module REG_IF_ID (
	CLK,
	pc_address_in,
	instruction_in,
	pc_address_out,
	instruction_out
);

input CLK;
input [31:0] pc_address_in, instruction_in;
output reg [31:0] pc_address_out, instruction_out;

reg [31:0] pc_address, instruction;

always @(negedge CLK) begin
	instruction <= instruction_in;
	pc_address <= pc_address_in;
end

always @(posedge CLK) begin
	instruction_out <= instruction;
	pc_address_out <= pc_address;
end

endmodule
