module frame_generator(data_high, data_low, data_out);
	input [3:0] data_high;	
	input [3:0] data_low;
	output [10:0] data_out; 
	
	parameter START_BIT = 1'b0;
	parameter STOP_BITS = 1'b1;   
	wire parity_bit;  

	assign parity_bit = ^{data_high, data_low};  

	assign data_out = {START_BIT, data_low[0], data_low[1], data_low[2], data_low[3], data_high[0], data_high[1], data_high[2], data_high[3], parity_bit, STOP_BITS};

endmodule
