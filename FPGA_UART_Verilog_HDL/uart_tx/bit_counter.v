module bit_counter(clk, baud_pulse, counter_flag);
	input clk;
	input baud_pulse;
	output reg counter_flag;
	
	reg [3:0]count;
	
	always @(posedge clk)
		begin
			if(baud_pulse)
				begin
					if(count < 4'hC)
						begin
							count <= count + 1'b1;
						end
				end
			else if(count == 4'hC)
				begin
					count <= 4'h0;
					counter_flag <= 1'b1;
				end
			else
				begin
					counter_flag <= 1'b0;
				end
		end
	
endmodule
