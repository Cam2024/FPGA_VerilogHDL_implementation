module rx_controller(
	input clk, // system clock
	input rst,  // reset pulse from single pulser
	input baud_clk,  // baud pulse
	input rx,
	input count_done,  // count done for data bits
	output reg baud_en, // generate baud pulse
	output shift_pulse, // shift pulse
	output done_pulse // load pulse
);
	
	reg [1:0] current_state = 2'b00; // current state
	reg [1:0] next_state = 2'b00;  //next state
	reg shift_en = 1'b0;  // shift signal
	reg done_en = 1'b0;  // done signal
	localparam wait_state = 2'b00; // wait for send
	localparam shift_state = 2'b01; // state for shift data
	localparam done_state = 2'b11; // state for shift data
	
	always @(posedge clk) // poseedge clock and reset key
		begin
			if(!rst)
				begin
					current_state <= wait_state; // reset state
				end
			else
				begin
					current_state <= next_state; // update state
				end
		end
	
	always @(current_state, rx, baud_clk, count_done) // trigger condition
		begin
			shift_en = 1'b0;
			done_en = 1'b0;
			case (current_state) // Selection state
			wait_state:
				begin
					baud_en = 1'b0;
					if (rx) // when receive
						begin
							next_state = wait_state; // keep state
						end
					else
						begin
							next_state = shift_state; // next state
						end
				end
				
			shift_state:
				begin
					baud_en = 1'b1; // enable baud pulse generate
					if (count_done) // count done signal from bit count
						begin							
							next_state = done_state; // next state
						end
					else
						begin
							if(baud_clk) // when baud pulse
								begin
									shift_en = 1'b1; // shift signal
								end
							next_state = shift_state; // keep state
						end
				end
			
			done_state:
				begin
					baud_en = 1'b0; // stop generate baud_clk
					done_en = 1'b1; // shift done signal
					next_state = wait_state;
				end
			
			default: 
				begin
					next_state = wait_state;
				end
			endcase
		end
		
	assign shift_pulse = shift_en;
	assign done_pulse = done_en;
	
endmodule
