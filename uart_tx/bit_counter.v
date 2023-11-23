module bit_counter(clk, count_flag, count_done);
	input clk;
	input count_flag;
	output reg count_done;
	
	reg [3:0]count = 4'h0;
	
	always @(posedge clk)
		begin
			if(count_flag)
				begin
					count = count + 1'b1;
				end
			if(count == 4'hB)
				begin
					count_done = 1'b1;
					count = 4'h0;
				end
			else
				begin
					count_done = 1'b0;
				end
		end
endmodule
