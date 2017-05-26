module DATA_SEL_REG2 (
	data_in,
	data_sel,
	data_out
);
	input [31:0] data_in;
	input [1:0] data_sel;
	output reg [31:0] data_out;
	
	wire [23:0] sign;
	
	assign sign = (data_in[31])?24'hffffff:24'd0;
	always @(*) begin
		if(data_sel == 2'd1)
			data_out = {sign[23:0],data_in[7:0]};
		else if(data_sel ==2'd2)
			data_out = {sign[15:0],data_in[15:0]};
		else if(data_sel ==2'd3)
			data_out = data_in;
		else data_out = 32'dx;
	end
	
endmodule 