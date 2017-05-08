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
wire [63:0] mul_result;
output reg [7:0] ALU_status;

wire sign;
wire [31:0] temp1,temp2,temp3,temp_addsub,a1,a2,ALU_operand_2sub,temp2_sub,a2_sub,shift_result;
wire [63:0] temp_mul,a3;
wire [32:0] temp_add;
wire [16:0] check_carry;
wire [32:0] check_addsub;
//wire [32:0] shift_value[1:31];

//assign shift_value[1]=32'd2;
/*generate
genvar i;
	for(i=2;i<=31;i=i+1) begin: shiftvalue							// cac gia tri shift
		assign shift_value[i]=2*shift_value[i-1];
	end
endgenerate*/
//assign shift_result=(ALU_operand_2>=32'd1&&ALU_operand_2<=32'd31)?(shift_value[ALU_operand_2[4:0]])*ALU_operand_1:32'd0;

assign shift_result=(ALU_control==4'b1010)?ALU_operand_1<<ALU_operand_2:ALU_operand_1>>ALU_operand_2;
assign sign=ALU_operand_1[31]^ALU_operand_2[31];	//dau cua ket qua (nhan,cong)

assign a1=(ALU_operand_1[31])?32'hffffffff:32'd0;
assign a2=(ALU_operand_2[31])?32'hffffffff:32'd0;	// chon thanh phan xor 
assign a3=(sign)?64'hffffffffffffffff:64'd0;
assign a2_sub=(ALU_operand_2sub[31])?32'hffffffff:32'd0;

assign temp1=ALU_operand_1^a1+ALU_operand_1[31];	//lay tri tuyet doi
assign temp2=ALU_operand_2^a2+ALU_operand_2[31];

assign ALU_operand_2sub=~(ALU_operand_2[31:0])+1'b1;
assign temp2_sub=ALU_operand_2sub^a2_sub+ALU_operand_2sub[31];	// lay toan tu 2 bu 2 neu phep tinh la tru

assign temp_mul=temp1*temp2;	

assign temp3=(ALU_control==4'b0110)?ALU_operand_2sub:ALU_operand_2;
assign temp_add=ALU_operand_1+temp3;	

assign temp_addsub=(ALU_control==4'b0110)?temp2_sub:temp2;
assign check_addsub =temp1+temp_addsub;

assign mul_result=temp_mul^a3+sign; 

assign check_carry=temp1[15:0]+temp_addsub[15:0];


////////////////////////////////////////////////
always @(*) begin
	/*if(temp_mul>32'h7fffffff&&ALU_control==4'b0011)		// tran so phep nhan
		ALU_status[6]=1;
	else*/ if(ALU_control==4'b0010) begin
		if(temp_add[31]==1&&ALU_operand_1[31]==0&&ALU_operand_2[31]==0)	
			ALU_status[6]=1;																									// tran so phep cong 
		else if(temp_add[31]==0&&ALU_operand_1[31]==1&&ALU_operand_2[31]==1)
			ALU_status[6]=1;
		//else if(ALU_operand_1[31]==ALU_operand_2[31]&&check_addsub>32'h7fffffff)
		//	ALU_status[6]=1;
		else ALU_status[6]=0;
	end
	else if(ALU_control==4'b0110) begin
		if(temp_add[31]==1&&ALU_operand_1[31]==0&&ALU_operand_2sub[31]==0)									// tran so phep  tru
			ALU_status[6]=1;
		else if(temp_add[31]==0&&ALU_operand_1[31]==1&&ALU_operand_2sub[31]==1)
			ALU_status[6]=1;
	//	else if(ALU_operand_1[31]!=ALU_operand_2sub[31]&&check_addsub>32'h7fffffff)
	//		ALU_status[6]=1;
		else ALU_status[6]=0;
	end
	else ALU_status[6]=0;
end

always @(*) begin
	if(ALU_result==32'd0)
		ALU_status[7]=1;				// zero tich cuc khi ket qua la 0
	else ALU_status[7]=0;
end

always @(*) begin
	if(ALU_control==4'b0100&&ALU_operand_2==32'd0)
		ALU_status[2]=1;
	else ALU_status[2]=0;				// tich cuc khi chia cho zero
end

always @(*) begin
	if(ALU_result[31])				// negative tich cuc khi kq la so am
		ALU_status[4]=1;
	else ALU_status[4]=0;
end

always @(*) begin
	if(ALU_control==4'b1000&&temp_add%4!=0)
		ALU_status[3]=1;
	else if(ALU_control==4'b1001&&temp_add%2!=0)		// inv_addr tich cuc khi dia chi ko thich hop
		ALU_status[3]=1;
	else ALU_status[3]=0;
end

always @(*) begin
	if((ALU_control==4'b0010||ALU_control==4'b1000||ALU_control==4'b1001||ALU_control==4'b0110)&&temp_add[32]&&!ALU_status[6]&&!ALU_status[3])
		ALU_status[5]=1;								// co nho carry 
	else ALU_status[5]=0;
end

/////////////////////////
always @(*) begin
	if(ALU_control==4'b0010||ALU_control==4'b0110) begin	// phep cong tru lw sw lh sh
		if(!ALU_status[6])
			ALU_result=temp_add;
		else ALU_result=32'dx;
	end
	else if(ALU_control==4'b1000||ALU_control==4'b1001) begin
		if(!ALU_status[3])
			ALU_result=temp_add;
		else ALU_result=32'dx;
	end
	else if(ALU_control==4'b0011) begin			// phep nhan
		//if(!ALU_status[6])
			ALU_result=mul_result[31:0];
		//else ALU_result=32'dx;
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
		if(ALU_operand_1[31]==0&&ALU_operand_2[31]==0) begin
			if(ALU_operand_1<ALU_operand_2)
				ALU_result=32'd1;
			else ALU_result=32'd0;
		end
		else if(ALU_operand_1[31]==1&&ALU_operand_2[31]==1) begin
			if(temp1>temp2)
				ALU_result=32'd1;
			else ALU_result=32'd0;
		end
		else if(ALU_operand_1[31]==0&&ALU_operand_2[31]==1) 
			ALU_result=32'd0;
		else if(ALU_operand_1[31]==1&&ALU_operand_2[31]==0)
			ALU_result=32'd1;
	end
	else if(ALU_control==4'b1100) begin
		ALU_result=~(ALU_operand_1|ALU_operand_2);		// phep nor
	end
	else if(ALU_control==4'b1010||ALU_control==4'b1011) begin		// phep dich bit
		ALU_result=shift_result;
	end
	else ALU_result =32'dx;
end
	
endmodule 