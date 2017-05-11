module PC ( CLK, RESET, PC_val, PC_in, PC_out);
	input CLK,RESET;
	input [7:0] PC_in,PC_val;
	output reg [7:0] PC_out;
	reg [7:0] PC;
	
	always @(posedge CLK or negedge RESET) begin
		if(!RESET) begin
			PC <= PC_val;
			PC_out <= 8'dx;
		end
		else begin
			PC <= PC_in;
			PC_out <= PC;
		end
		
	end

endmodule 