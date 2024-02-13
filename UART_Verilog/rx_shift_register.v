module rx_shift_register(
	input clk, // 50MHz clock
	input preset, // reset pulse
	input shift, // shift pulse
	input rx, // series data in 
	input done,
	output reg [10:0] data_frame // output signal
);
	
	reg [10:0] shift_register = 11'b11111111111; 
	
	always @(posedge clk)
		begin
			if(!preset)
				begin
					shift_register <= 11'b11111111111; // preset the register 
				end
			else
				begin
					if(shift)
						begin
							shift_register <= {shift_register[9:0], rx}; // shift left the shift register
						end
					if(done)
						begin
							data_frame <= shift_register; // output data frame[10:0] 11 bits data
							shift_register <= 11'b11111111111;
						end
				end	
		end
	
endmodule
