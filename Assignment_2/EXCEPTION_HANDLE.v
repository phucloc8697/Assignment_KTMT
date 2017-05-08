module EXCEPTION_HANDLE (
	control_exception,
	ALU_status,
	disable_out
);

input control_exception;
input [2:0] ALU_status;

output disable_out;

assign disable_out = control_exception | ALU_status;

endmodule
