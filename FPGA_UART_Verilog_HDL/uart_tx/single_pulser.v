module single_pulser(clk, button, pulse);
	input clk;
	input button;
	output reg pulse;

	localparam s0 = 3'b100;
	localparam s1 = 3'b010;
	localparam s2 = 3'b001;

	reg[2:0] current_state;
	reg[2:0] next_state;

	always @(posedge clk)
		begin
			current_state <= next_state;
		end

	always @(current_state, button)
		begin
			pulse = 1'b0;

			case (current_state)

			s0:
				begin
					if (!button)
						begin
							next_state = s1;
						end
					else
						begin
							next_state = s0;
						end
				end

			s1:
				begin
					pulse = 1'b1;
					if (!button)
						begin
							next_state = s2;
						end
					else
						begin
							next_state = s0;
						end
				end

			s2:
				begin
					if (!button)
						begin
							next_state = s2;
						end
					else
						begin
							next_state = s0;
						end
				end
			endcase
			
		end
	
endmodule
