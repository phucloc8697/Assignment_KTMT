module REG (
	CLK,
	RESET,
	REG_address1,  // thanh ghi rs
	REG_address2, // thanh ghi rt
	REG_address_wr, // thanh ghi rd
	REG_write_1,  // tin hieu control write
	REG_data_wb_in1,
	REG_data_out1,
	REG_data_out2
);

input CLK, RESET, REG_write_1;
input	[4:0] REG_address1;
input [4:0] REG_address2;
input [4:0] REG_address_wr;
input	[31:0] REG_data_wb_in1;

output [31:0]	REG_data_out1;
output [31:0]	REG_data_out2;

reg [31:0] register [0:31];

assign REG_data_out1 = register[REG_address1];
assign REG_data_out2 = register[REG_address2];

always @(posedge REG_write_1 or negedge RESET) begin
	if(!RESET) begin
		register[0]	<= 32'd0;
		register[1]	<= 32'd0;
		register[2] <= 32'd0;
		register[3] <= 32'd0;
		register[4] <= 32'd0;
		register[5] <= 32'd0;
		register[6] <= 32'd0;
		register[7] <= 32'd0;
		register[8] <= 32'd0;
		register[9] <= 32'd0;
		register[10] <= 32'd0;
		register[11] <= 32'd0;
		register[12] <= 32'd0;
		register[13] <= 32'd0;
		register[14] <= 32'd0;
		register[15] <= 32'd0;
		register[16] <= 32'd0;
		register[17] <= 32'd0;
		register[18] <= 32'd0;
		register[19] <= 32'd0;
		register[20] <= 32'd0;
		register[21] <= 32'd0;
		register[22] <= 32'd0;
		register[23] <= 32'd0;
		register[24] <= 32'd0;
		register[25] <= 32'd0;
		register[26] <= 32'd0;
		register[27] <= 32'd0;
		register[28] <= 32'd0;
		register[29] <= 32'd0;
		register[30] <= 32'd0;
		register[31] <= 32'd0;
	end
	else if (REG_write_1) begin
			register[REG_address_wr] <= REG_data_wb_in1;
	end else register[REG_address_wr] <= register[REG_address_wr];
end

endmodule
