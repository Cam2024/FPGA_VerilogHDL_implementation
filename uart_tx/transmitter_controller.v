module transmitter_controller(clk, send_key, reset_key, send_pulse, reset_pulse);
	input clk;
	input send_key;
	input reset_key;
	output reg send_pulse; 
	output reg reset_pulse;
	
	localparam initial_state = 4'b1000;
	localparam reset_state = 4'b0100;
	localparam send_state = 4'b0010;
	localparam hold_state = 4'b0001;

	reg[3:0] current_state;
	reg[3:0] next_state;

	initial begin
    current_state = initial_state;
	end
	
	always @(posedge clk)
		begin
			current_state <= next_state;
		end

	always @(current_state, send_key, reset_key)
		begin
			send_pulse = 1'b0;
			reset_pulse = 1'b0;
			case (current_state)			
			initial_state:
				begin
					if (reset_key)
						next_state = reset_state;
					else if(send_key)
						next_state = send_state;
					else
						next_state = initial_state;
				end

			reset_state:
				begin
					reset_pulse = 1'b1;
					next_state = hold_state;
				end

			send_state:
				begin
					send_pulse = 1'b1;
					next_state = hold_state;
				end
			hold_state:
				begin
					if(reset_key || send_key)
						begin
							send_pulse = 1'b0;
							reset_pulse = 1'b0;
							next_state = hold_state;
						end
					else
						begin
							next_state = initial_state;
						end
				end
			endcase
			
		end

endmodule