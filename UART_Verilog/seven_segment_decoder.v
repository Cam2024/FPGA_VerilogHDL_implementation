module seven_segment_decoder(
	input [3:0] in, // Input signal, represented as a 4-bit binary number
	output reg [6:0] sevenseg  // Output signal for the seven-segment display, represented as a 7-bit binary number
);
	
	always @(in)
		begin
			case (in)
				//Hexadecimal values					
				4'h0: sevenseg = 7'b1000000; // When input is 4'b0000, display shows the number 0
				4'h1: sevenseg = 7'b1111001;
				4'h2: sevenseg = 7'b0100100;
				4'h3: sevenseg = 7'b0110000;
				4'h4: sevenseg = 7'b0011001;
				4'h5: sevenseg = 7'b0010010;
				4'h6: sevenseg = 7'b0000010;
				4'h7: sevenseg = 7'b1111000;
				4'h8: sevenseg = 7'b0000000;
				4'h9: sevenseg = 7'b0010000;
				4'hA: sevenseg = 7'b0001000;
				4'hB: sevenseg = 7'b0000011;
				4'hC: sevenseg = 7'b1000110;
				4'hD: sevenseg = 7'b0100001;
				4'hE: sevenseg = 7'b0000110;
				4'hF: sevenseg = 7'b0001110; // When input is 4'b1111, display shows the number F
				default: sevenseg = 7'b1111111;  // In the default case, the display is turned off
			endcase
		end		
endmodule
