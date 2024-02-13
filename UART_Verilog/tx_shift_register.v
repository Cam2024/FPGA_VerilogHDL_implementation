module tx_shift_register(
	input clk, // 50MHz clock
	input preset, // reset pulse
	input [11:0] data_frame, // 11 bits data frame 
	input load, // load pulse
	input shift, // shift pulse
	output tx // output signal
);
	
	reg [11:0] shift_register = 12'hFFF; // 12'hFFF = bin 1111 1111 1111
	
	always @(posedge clk)
		begin
			if(!preset)
				begin
					shift_register <= 12'hFFF; // 12'hFFF = bin 1111 1111 1111 preset the register 
				end
			else
				begin
					if(load)
						begin
							shift_register <= data_frame; // load data frame for register
						end
					if(shift)
						begin
							shift_register <= {1'b1, shift_register[11:1]}; // shift right the shift register
						end
				end	
		end
		
	assign tx = shift_register[0]; // output the data signal
	
endmodule
