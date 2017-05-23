module PC ( CLK, RESET, LOAD, PC_val, PC_in, PC_out);
	input CLK,RESET, LOAD;
	input [7:0] PC_in,PC_val;
	output reg [7:0] PC_out;
	reg check;
	reg [7:0] PC;
	reg [7:0] temp;
	always @(posedge CLK or negedge RESET) begin
		if(!RESET)
			check <= 0;
		else check <= 1;
	end
	
	always @(posedge LOAD or negedge RESET) begin
		if(!RESET)
			temp <= 8'd0;
		else if(LOAD&&!check)
			temp <= PC_val;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if(!RESET)
			PC_out <= 8'dx;
	   else if(!check)
			PC_out <= temp;
		else PC_out <= PC_in;
	end

endmodule 