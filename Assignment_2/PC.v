module PC ( CLK, RESET, LOAD, PC_val, PC_in, PC_out);
	input CLK,RESET, LOAD;
	input [7:0] PC_in,PC_val;
	output reg [7:0] PC_out;
	reg check;
	reg [7:0] PC;
	
	always @(posedge LOAD or posedge CLK) begin
		if(LOAD)
			check <= 1;
		else check <=0;
	end
	
	always @(posedge CLK or negedge RESET) begin
		if(!RESET)
			PC_out <= 8'd0;
	   else if(check)
			PC_out <= PC_val;
		else PC_out <= PC_in;
	end

endmodule 