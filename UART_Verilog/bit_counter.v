module bit_counter(
	input clk, // 50MHz clock
	input rst,
	input count_flag, // count every shift pulse
	output reg count_done // output pulse count done
);

	reg [3:0]count = 4'h0; // counter register
	
	always @(posedge clk)
		begin
			if(!rst)
				begin
					count <= 4'h0;
				end
			else
				begin
					if(count_flag) // from controller to count bit
						begin
							count <= count + 1'b1;
						end
					if(count_done) // from controller to stop count
						begin
							count <= 4'h0;
						end
				end
		end
		
	always @(count) // use another always to output signal to avoid d type
		begin
			if(count == 4'hB) // 8 bits data + start bit + stop bit + parity bit = 11 bits = B
				begin
					count_done = 1'b1; // count done pulse
				end
			else
				begin
					count_done = 1'b0; // reset count done pulse
				end
		end
		
endmodule
