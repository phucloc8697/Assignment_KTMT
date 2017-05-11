module f_div(clk_in,reset,div_val,clk_out);
	input clk_in,reset;
	input [3:0] div_val;
	output reg clk_out;
	reg [3:0] count;
	
	always @(posedge clk_in or negedge reset) begin
		if(!reset)
			count <= 4'd0;
		else if( count==div_val)
			count<=4'd0;
		else count <= count+1;
	end
	
	always @(posedge clk_in or negedge reset) begin
		if(!reset) 
			clk_out <= 0;
		else if(count==div_val)
			clk_out <= ~clk_out;
		else clk_out <= clk_out;
	end

endmodule 