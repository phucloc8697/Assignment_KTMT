module REG (
	CLK,
	REG_address1,  // thanh ghi rs
	REG_address2, // thanh ghi rt
	REG_address_wr, // thanh ghi rd
	REG_write_1,  // tin hieu control write
	REG_data_wb_in1,
	REG_data_out1,
	REG_data_out2
);

input CLK, REG_write_1;
input	[4:0] REG_address1;
input [4:0] REG_address2;
input [4:0] REG_address_wr;
input	[31:0] REG_data_wb_in1;

output reg [31:0]	REG_data_out1;
output reg [31:0]	REG_data_out2;

reg [31:0] register [31:0];

always@(posedge CLK) begin

	REG_data_out1 <= register[REG_address1];
	REG_data_out2 <= register[REG_address2];
	
	if (REG_write_1) begin
		register[REG_address_wr] <= REG_data_wb_in1;
	end else begin
		register[REG_address_wr] <= register[REG_address_wr];
	end
	
end

endmodule
