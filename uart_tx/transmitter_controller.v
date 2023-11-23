module transmitter_controller(clk, baud_clk, send_key, reset_key, count_done, reset, load_pulse, shift_pulse);
	input clk;
	input baud_clk;
	input send_key;
	input reset_key;
	input count_done;
	output shift_pulse;
	output load_pulse;
	output reset;
//	reg 
//	parameter IDLE = 3'b001;
//	parameter LOAD = 3'b010;
//	parameter SHIFT = 3'b100;
//	
//	always @(posedge clk)
//		begin
//			
//		end
//	
//	
//	
//endmodule

	reg [1:0] current_state = 2'b01;
	reg [1:0] next_state = 2'b01;
	reg shift_en = 1'b0;
	parameter wait_state = 2'b01;
	parameter shift_state = 2'b10;
	
	assign reset = reset_key;
	assign load_pulse = send_key;
	assign shift_pulse = shift_en;
	always @(posedge clk, posedge reset_key)
		begin
			if(reset_key)
				begin
					current_state <= wait_state;
				end
			else
				begin
					current_state <= next_state;
				end
		end
	
	always @(current_state, send_key, count_done, baud_clk)
		begin
			shift_en = 1'b0;
			case (current_state)
			wait_state:
				begin
					if (send_key)
						begin
							next_state = shift_state;
						end
					else
						begin
							next_state = wait_state;
						end
				end

			shift_state:
				begin
					if (count_done)
						begin
							next_state = wait_state;
						end
					else
						begin
							if(baud_clk)
								begin
									shift_en = 1'b1;
								end
							next_state <= shift_state;
						end
				end
				
			endcase
		end
endmodule
