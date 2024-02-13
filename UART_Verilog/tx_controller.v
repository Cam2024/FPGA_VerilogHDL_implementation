module tx_controller(
	input clk, // system clock
	input rst,  // reset pulse from single pulser
	input baud_clk,  // baud pulse
	input send,  // send pulse from single pulser
	input count_done,  // count done for data bits
	output reg baud_en, // generate baud pulse
	output load_pulse, // load pulse
	output shift_pulse // shift pulse
);
	
	reg [1:0] current_state = 2'b00; // current state
	reg [1:0] next_state = 2'b00;  //next state
	reg shift_en = 1'b0;  // shift signal
	reg load_en = 1'b0;  // load signal
	localparam wait_state = 2'b00; // wait for send
	localparam load_state = 2'b01; // load state
	localparam shift_state = 2'b11; // state for shift data
	
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
	
	always @(current_state, send, baud_clk, count_done) // trigger condition
		begin
			shift_en = 1'b0;
			load_en = 1'b0;
			case (current_state) // Selection state
			wait_state:
				begin
					baud_en = 1'b0;
					if (send) // when send
						begin
							next_state = load_state; // next state
						end
					else
						begin
							next_state = wait_state; // keep state
						end
				end
				
			load_state:
				begin
					load_en = 1'b1; // load signal to load data from frame generator
					baud_en = 1'b1; // enable baud pulse generator to generate baud pulse
					next_state = shift_state;
				end
				
			shift_state:
				begin
					baud_en = 1'b1;
					if (count_done) // count done signal from bit count
						begin
							next_state = wait_state; // next state
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
				
			default: 
				begin
					next_state = wait_state;
				end
			endcase
		end
	
	assign load_pulse = load_en; // load signal from single pulser
	assign shift_pulse = shift_en; // shift signal from state machine
	
endmodule
