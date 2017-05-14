module EPC(
	in,
	reset,
	out1,
	out2,
	out3
);
	input reset;
	input [7:0] in;
	output [6:0] out1,out2;
	output reg [6:0] out3;
	
	always @(*) begin
		if(in%4!=0)
			out3 = 7'b0111111;
		else out3 = 7'b1111111;
	end
	
	hexto7segment hex1( reset,in[3:0], out1);
	hexto7segment hex2( reset,in[7:4], out2);
	
endmodule 
	
	
	