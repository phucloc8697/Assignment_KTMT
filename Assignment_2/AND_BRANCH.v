module AND_BRANCH (
	ALU_status,
	control_branch,
	out
);

input [7:0] ALU_status;
input control_branch;
output out;

assign out = (ALU_status[7] && control_branch) ? 1'b1 : 1'b0;

endmodule
