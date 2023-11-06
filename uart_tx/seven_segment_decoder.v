module seven_segment_decoder(in, sevenseg);
	input [3:0] in;
	output reg [6:0] sevenseg;
	
	always @(in)
		begin
			case (in)
				//hex						
				4'h0: sevenseg = 7'b0000001;
				4'h1: sevenseg = 7'b1001111;
				4'h2: sevenseg = 7'b0010010;
				4'h3: sevenseg = 7'b0000110;
				4'h4: sevenseg = 7'b1001100;
				4'h5: sevenseg = 7'b0100100;
				4'h6: sevenseg = 7'b0100000;
				4'h7: sevenseg = 7'b0001111;
				4'h8: sevenseg = 7'b0000000;
				4'h9: sevenseg = 7'b0000100;
				4'hA: sevenseg = 7'b0001000;
				4'hB: sevenseg = 7'b1100000;
				4'hC: sevenseg = 7'b0110001;
				4'hD: sevenseg = 7'b1000010;
				4'hE: sevenseg = 7'b0110000;
				4'hF: sevenseg = 7'b0111000;
				default: sevenseg = 7'b1111111;
			endcase
		end
		
endmodule