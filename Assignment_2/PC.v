module PC ( CLK, RESET, LOAD, PC_val, PC_in, PC_out);
	input CLK,RESET, LOAD;
	input [7:0] PC_in,PC_val;
	output reg [7:0] PC_out;
	reg [7:0] PC;
	
	always @(posedge CLK or negedge RESET) begin
		if(!RESET) begin
				PC <= PC_val;
		end 
		else begin
			PC <= PC_in;
		end
	end
	
	always @(negedge CLK or posedge LOAD) begin
		if (LOAD) begin
			PC_out <= PC_val;
		end else PC_out <= PC;
	end

endmodule 