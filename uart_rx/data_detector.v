module data_detector(clk, buffer, lowbits, highbits);
	input clk;
	input [10:0] buffer;
	output reg [3:0] lowbits;
	output reg [3:0] highbits;
	
	reg parity_bit;
	
	always @(posedge clk)
		begin
		parity_bit <= ^buffer[9:2];
			if(buffer[1] == parity_bit) //buffer[0] == 1'b1 && 
				begin
					highbits <= {buffer[6], buffer[7], buffer[8], buffer[9]};
					lowbits <= {buffer[2], buffer[3], buffer[4], buffer[5]};
				end
			else
				begin
					lowbits <= 4'b0000;
					highbits <= 4'b0000;
				end
		end
		
endmodule
