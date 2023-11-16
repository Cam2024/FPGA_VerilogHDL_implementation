module transmitter_controller(clk, baud_clk, send_key, reset_key, count, shift, count_pulse, load_pulse, reset_pulse);
	input clk;
	input baud_clk;
	input send_key;
	input reset_key;
	input count;
	output reg shift;
	output reg count_pulse;
	output reg load_pulse; 
	output reg reset_pulse;

	reg count_en = 1'b0;
	
	always @(posedge clk)
		begin
			load_pulse <= send_key;
			reset_pulse <= reset_key;
			if(reset_key)
				begin
					count_en <= 1'b0;
				end
			else if(send_key)
				begin
					count_en <= 1'b1;
				end
			else
				begin
					if(count)
						begin
							count_en <= 1'b0;
						end
					else if(count_en)
						begin
							count_pulse <= baud_clk;
							shift <= 1'b1;
						end
					else
						begin
							count_pulse <= 1'b0;
							shift <= 1'b0;
						end
				end
		end

endmodule
