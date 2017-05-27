module ADDER_JUMP (
	in0,
	in1, // After shift left
	out
);

input [7:0] in0, in1;
output [7:0] out;

assign out = in1;

endmodule
