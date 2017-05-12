module PC ( CLK, RESET, PC_val, PC_in, PC_out);
	input CLK,RESET;
	input [7:0] PC_in,PC_val;
	output reg [7:0] PC_out;
	reg [7:0] PC;
	
	always @(negedge CLK or negedge RESET) begin
		if(!RESET) begin
				PC <= PC_val;
		end 
		else begin
			PC <= PC_in;
		end
	end
	
	always @(posedge CLK) begin
		PC_out <= PC;
	end

endmodule 