module shift_register(clk, baud_clk, data_frame, send_pulse, reset_pulse, output_bit, output_flag);
	input clk;
	input baud_clk;
	input [10:0] data_frame;
	input send_pulse; 
	input reset_pulse;
	output reg output_bit;
	output output_flag;
	
	reg [10:0] data;
	reg [3:0] state; // 4 states for sending 11 bits
	reg shift_en;    // Enable data shifting

  always @(posedge clk) 
  begin
    if (reset_pulse) 
		 begin
			// Reset the state machine and data
			state <= 4'b0000;
			data <= 11'b11111111111;
			shift_en <= 1'b0;
			output_bit <= 1'b1;
		 end 
	 else if (send_pulse) 
		 begin
			// Start sending data
			state <= 4'b0001;
			data <= data_frame;
			shift_en <= 1'b1;
		 end 
	 else if (shift_en) 
		 begin
			// Shift data and update state
			if(baud_clk) 
				begin
					case(state)
					  4'b0001: output_bit <= data[10];
					  4'b0010: output_bit <= data[9];
					  4'b0011: output_bit <= data[8];
					  4'b0100: output_bit <= data[7];
					  4'b0101: output_bit <= data[6];
					  4'b0110: output_bit <= data[5];
					  4'b0111: output_bit <= data[4];
					  4'b1000: output_bit <= data[3];
					  4'b1001: output_bit <= data[2];
					  4'b1010: output_bit <= data[1];
					  4'b1011: output_bit <= data[0];
					  4'b1100:
							begin
								data <= 11'b11111111111;
								shift_en <= 1'b0;
							end
					  default: begin
						 // Shouldn't reach here
						 data <= 11'b11111111111;
						 shift_en <= 1'b0;
					  end
					endcase
					state <= state + 1;
				end
		 end
	 else
		begin
			output_bit <= 1'b1;
		end
  end

  assign output_flag = shift_en;
  
endmodule
	