module REG_IF_ID (
	CLK,
	RESET,
	pc_address_in,
	instruction_in,
	pc_address_out,
	instruction_out
);

input CLK,RESET;
input [31:0] pc_address_in, instruction_in;
output reg [31:0] pc_address_out, instruction_out;


always @(posedge CLK or negedge RESET) begin
	if(!RESET) begin
		instruction_out <= 32'dx;
		pc_address_out <= 32'dx;
	end
	else begin	
		instruction_out <= instruction_in;
		pc_address_out <= pc_address_in;
	end
end




endmodule
