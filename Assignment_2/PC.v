module PC ( CLK, RESET, LOAD, PC_val, PC_in, PC_out);
	input CLK,RESET, LOAD;
	input [7:0] PC_in,PC_val;
	output reg [7:0] PC_out;
	reg check;
	reg [7:0] PC;
	
	always @(posedge CLK or negedge RESET) begin
		if(!RESET)
			check <= 0;
		else check <= 1;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if(!RESET)
			PC_out <= 8'dx;
	   else if(!check)
			PC_out <= 8'd0;
		else PC_out <= PC_in;
	end

endmodule 