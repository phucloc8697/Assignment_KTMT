module hexto7segment(
	 input reset,
    input  [3:0]x,
    output reg [6:0]sseg_temp
);
	always @(*) begin
		if(!reset)
			sseg_temp = 7'b0111111;
		else begin
			case (x[3:0])
				4'd0 : sseg_temp = 7'b1000000; //to display 0 0-G
				4'd1 : sseg_temp = 7'b1111001; //to display 1
				4'd2 : sseg_temp = 7'b0100100; //to display 2
				4'd3 : sseg_temp = 7'b0110000; //to display 3 a b c d e f g
				4'd4 : sseg_temp = 7'b0011001; //to display 4 6 5 4 3 2 1 0
				4'd5 : sseg_temp = 7'b0010010; //to display 5
				4'd6 : sseg_temp = 7'b0000010; //to display 6
				4'd7 : sseg_temp = 7'b1111000; //to display 7
				4'd8 : sseg_temp = 7'b0000000; //to display 8
				4'd9 : sseg_temp = 7'b0010000; //to display 9 2-E
				4'd10: sseg_temp=7'b0001000;
				4'd11: sseg_temp=7'b0000011;
				4'd12: sseg_temp=7'b1000110;
				4'd13: sseg_temp=7'b0100001;
				4'd14: sseg_temp=7'b0000110;
				4'd15: sseg_temp=7'b0001110;
			endcase
		end
	end
 
endmodule 