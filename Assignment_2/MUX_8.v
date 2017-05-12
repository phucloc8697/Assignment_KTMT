module MUX_8(
	in0,
	in1,
	sel,
	out
);

input [7:0] in0, in1;
input sel;
output reg [7:0] out;

//assign out = (sel) ? in1 : in0;
always @(*) begin
	casex(sel)
		1'b0: out = in0;
		1'b1: out = in1;
		1'bx: out = in0;
	endcase
end
endmodule
