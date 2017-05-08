module ALU_CONTROL(
	ALU_op,
	Funct,
	ALU_control
);

input [1:0] ALU_op;
input [5:0] Funct;
output reg [3:0] ALU_control;

always @(*) begin
	case(ALU_op[1:0])
		2'b00: begin
			if(Funct==6'h23||Funct==6'h2b)	// phep lw sw
				ALU_control=4'b1000;
				
			else if(Funct==6'h20||Funct==6'h28)	// phep lb sb
				ALU_control=4'b0010;
				
			else if(Funct==6'h21||Funct==6'h29)	// phep lh sh
				ALU_control=4'b1001;
				
			else ALU_control=4'dx;
		end
		
		2'b01: begin
			ALU_control=4'b0110;						// lenh re nhanh
		end
		
		2'b10: begin
			if(Funct==6'b100100)						// phep and
				ALU_control=4'd0;
				
			else if(Funct==6'b100101)				// phep or
				ALU_control=4'b0001;
				
			else if(Funct==6'b100000)				// phep cong
				ALU_control=4'b0010;
				
			else if(Funct==6'b100010)				// phep tru
				ALU_control=4'b0110;
				
			else if(Funct==6'b101010)				// phep so sanh
				ALU_control=4'b0111;
				
			else if(Funct==6'b100111)				// phep nor
				ALU_control=4'b1100;
				
			else if(Funct==6'h1C)					// phep nhan
				ALU_control=4'b0011;
				
			//else if(Funct==6'bxxxx)				// phep chia
			//	ALU_control=4'b0100;
			
			else if(Funct==6'h00)					// dich trai
				ALU_control=4'b1010;
			
			else if(Funct==6'h02)					// dich phai 
				ALU_control=4'b1011;
			
			else ALU_control=4'dx;					// truong hop ko xac dinh
		end
		default: ALU_control=4'dx;
	endcase
end

endmodule 
	
	