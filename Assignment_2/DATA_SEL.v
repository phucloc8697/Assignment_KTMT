module DATA_SEL (
	datamem_in,
	control_datamem,
	datamem_out
);
	input [31:0] datamem_in;
	input [1:0] control_datamem;
	output reg [31:0] datamem_out;
	
	wire [23:0] sign;
	
	assign sign = (datamem_in[31])? 24'hffffff:24'd0;
	always @(*) begin
		if( control_datamem == 2'd1)
			datamem_out = {sign[23:0], datamem_in[31:24]};
		else if(control_datamem ==2'd2)
			datamem_out = {sign[15:0], datamem_in[31:16]};
		else if(control_datamem ==2'd3)
			datamem_out = datamem_in;
		else datamem_out = 32'dx;
	end

endmodule 