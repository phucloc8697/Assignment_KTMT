module ADDER_0 (
	clk,
	in0,
	in1,
	out
);
input clk;
input [7:0] in0, in1;
output reg [7:0] out;

always @(posedge clk) begin
	out <= in0+in1;
end

endmodule 