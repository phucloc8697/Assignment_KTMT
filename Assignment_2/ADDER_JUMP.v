module ADDER_JUMP (
	in0,
	in1,
	out
);

input [31:0] in0, in1;
output [31:0] out;

assign out = {in1[31:28], in0[27:0]};

endmodule
