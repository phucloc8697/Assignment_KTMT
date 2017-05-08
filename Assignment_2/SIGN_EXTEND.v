module SIGN_EXTEND (
	in,
	out
);

input [15:0] in;
output [31:0] out;

assign out = $Signed(in);

endmodule
