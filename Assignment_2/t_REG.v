`timescale 1ns/1ns
module t_REG;
	reg CLK,RESET;
	reg [4:0] REG_address1,REG_address2,REG_address_wr;
	reg REG_write_1;
	reg [31:0] REG_data_wb_in1;
	wire [31:0] REG_data_out1,REG_data_out2;
	
	
	REG REG(
	.CLK(CLK),
	.RESET(RESET),
	.REG_address1(REG_address1),  // thanh ghi rs
	.REG_address2(REG_address2), // thanh ghi rt
	.REG_address_wr(REG_address_wr), // thanh ghi rd
	.REG_write_1(REG_write_1),  // tin hieu control write
	.REG_data_wb_in1(REG_data_wb_in1),
	.REG_data_out1(REG_data_out1),
	.REG_data_out2(REG_data_out2)
	);
	
	initial begin
		CLK = 0;
		forever #5 CLK = ~CLK;
	end
	
	initial begin
		REG_address1 = 1;
		REG_address2 = 2;
		REG_write_1 = 0;
		RESET = 0;
		#5 RESET = 1;
		#20 REG_data_wb_in1 = 32'd4;
				REG_address_wr = 1;
				REG_write_1 = 1;
		#10 REG_write_1 = 0;
		#20 REG_data_wb_in1 = 32'd8;
				REG_address_wr = 2;
				REG_write_1 = 1;
		#10 REG_write_1 = 0;
	end
endmodule 
