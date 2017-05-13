module REG_IF_ID (
	CLK,
	pc_address_in,
	instruction_in,
	pc_address_out,
	instruction_out
);

input CLK;
input [31:0] pc_address_in, instruction_in;
output  [31:0] pc_address_out, instruction_out;

reg [31:0] pc_address, instruction;

always @(posedge CLK) begin
	instruction <= instruction_in;
	pc_address <= pc_address_in;
end

assign pc_address_out = pc_address;
assign instruction_out = instruction;


endmodule
