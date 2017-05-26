module ALU (
	ALU_control,
	ALU_operand_1,
	ALU_operand_2,
	ALU_result,
	ALU_status
);
	input [3:0] ALU_control;
	input [31:0] ALU_operand_1,ALU_operand_2;
	output reg [31:0] ALU_result;
	output reg [7:0] ALU_status;
	
	wire [31:0] temp_operand_2,ALU_operand_2sub;
	wire [32:0] add_result;
	wire [63:0] mul_result;
	wire [31:0] shift_result;
	
	assign ALU_operand_2sub = ~(ALU_operand_2[31:0])+1'b1;
	assign temp_operand_2 = (ALU_control==4'b0110)?ALU_operand_2sub:ALU_operand_2;
	assign add_result = ALU_operand_1 + temp_operand_2;
	
	assign mul_result = ALU_operand_1*ALU_operand_2;
	
	assign shift_result=(ALU_control==4'b1010)?(ALU_operand_2<<ALU_operand_1[4:0]):(ALU_operand_2>>ALU_operand_1[4:0]);
	
	always @(*) begin
		if(ALU_control == 4'b0010) begin
			if(add_result[31] == 1&&ALU_operand_1[31] == 0&&ALU_operand_2[31] == 0)	
				ALU_status[6] = 1;																									// tran so phep cong 
			else if(add_result[31] ==0 && ALU_operand_1[31] == 1 && ALU_operand_2[31] == 1)
				ALU_status[6] = 1;
			else ALU_status[6] = 0;
		end 
		else if(ALU_control == 4'b0110) begin
			if(add_result[31] == 1 &&ALU_operand_1[31] == 0 && ALU_operand_2sub[31] == 1)									// tran so phep  tru
				ALU_status[6]=1;
			else if(add_result[31] == 0 && ALU_operand_1[31] == 1 && ALU_operand_2sub[31] ==0)
				ALU_status[6] = 1;
			else ALU_status[6] = 0;
		end
		else ALU_status[6] = 0;
	end
	
	always @(*) begin
		if(ALU_result == 32'd0)
			ALU_status[7] = 1;				// zero tich cuc khi ket qua la 0
		else ALU_status[7] = 0;
	end
	
	always @(*) begin
		if(ALU_control == 4'b0100 && ALU_operand_2 == 32'd0)
			ALU_status[2] = 1;
		else ALU_status[2] = 0;				// tich cuc khi chia cho zero
	end
	
	always @(*) begin
		if(ALU_result[31])				// negative tich cuc khi kq la so am
			ALU_status[4]=1;
		else ALU_status[4]=0;
	end

	always @(*) begin
		if(ALU_control==4'b1000&&add_result%4!=0)
			ALU_status[3]=1;
		else if(ALU_control==4'b1001&&add_result%2!=0)		// inv_addr tich cuc khi dia chi ko thich hop
			ALU_status[3]=1;
		else ALU_status[3]=0;
	end

	always @(*) begin
		if((ALU_control==4'b0010||ALU_control==4'b1000||ALU_control==4'b1001||ALU_control==4'b0110)&&add_result[32]&&!ALU_status[6]&&!ALU_status[3])
			ALU_status[5]=1;								// co nho carry 
		else ALU_status[5]=0;
	end	

	
	
	always @(*) begin
		if(ALU_control==4'b0010||ALU_control==4'b0110||ALU_control==4'b1000||ALU_control==4'b1001) begin	// phep cong tru lw sw lh sh
			if(ALU_status[6]||ALU_status[3])
				ALU_result=32'dx;
			else ALU_result=add_result;
		end
		else if(ALU_control==4'b0011) begin			// phep nhan
				ALU_result=mul_result[31:0];
		end
		else if(ALU_control==4'b0100) begin			// phep chia
			if(!ALU_status[2])
				ALU_result=ALU_operand_1/ALU_operand_2;
			else ALU_result=32'dx;
		end
		else if(ALU_control==4'b0000) begin
			ALU_result=ALU_operand_1&ALU_operand_2;		// phep and
		end
		else if(ALU_control==4'b0001) begin
			ALU_result=ALU_operand_1|ALU_operand_2;		// phep or
		end
		else if(ALU_control==4'b0111) begin												// phep so sanh
			if(ALU_operand_1[31]==1&&ALU_operand_1[2]==1) begin
				if(ALU_operand_1>ALU_operand_2)
					ALU_result = 32'd1;
				else ALU_result = 32'd0;
			end
			else if(ALU_operand_1[31]==0&&ALU_operand_1[2]==0) begin
				if(ALU_operand_1<ALU_operand_2)
					ALU_result = 32'd1;
				else ALU_result = 32'd0;
			end
			else if(ALU_operand_1[31]==0&&ALU_operand_1[2]==1)
				ALU_result = 32'd0;
			else if(ALU_operand_1[31]==1&&ALU_operand_1[2]==0)
				ALU_result = 32'd1;
		end
		else if(ALU_control==4'b1100) begin
			ALU_result=~(ALU_operand_1|ALU_operand_2);		// phep nor
		end
		else if(ALU_control==4'b1010||ALU_control==4'b1011) begin		// phep dich bit
			ALU_result=shift_result;
		end
		else ALU_result =32'd0;
	end 
	
endmodule 