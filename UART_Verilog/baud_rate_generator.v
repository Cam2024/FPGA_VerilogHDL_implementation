module baud_rate_generator(
	input clk,   // 50MHz system clock
	input rst,
	input enable,
	output reg baud_pulse   // UART transmitter
);
	reg [10:0] count = 11'h0;  // counter for counting baud rate
	
	// 38400 baud rate needed count (11 bits here: 101 0001 0101)
	localparam DIVIDER = 11'h515; // where baud rate is 38400, hex515 = (50000000 / 38400) - 1	
	parameter counter_logic = 11'h28A; 
	// counter locgic '28A' midpoint sampling for receiver and counter logic'1' for receiver
	// use 'parameter' for the transmitter to change value to 1 externally
	
	always @(posedge clk) 
		begin
			if(!rst)
				begin
					count <= 11'h0; // reset counter
				end
			else
				begin
					if(enable) // from controller to enable baud rate generate
						begin
							if(count < DIVIDER) // count baud rate
								begin
									count <= count + 1'b1;
								end
							else
								begin
									count <= 11'h0;
								end
						end
					else
						count <= 11'h0;
				end
		end
		
	always @(count) 
	// Use another always to control the combinatorial logic of the output to avoid the extra d type
		begin
			if (count == counter_logic) 
				begin
					baud_pulse = 1'b1; // baud pulse
				end 
			else 
				begin
					baud_pulse = 1'b0; // keep low
				end
		end

endmodule
