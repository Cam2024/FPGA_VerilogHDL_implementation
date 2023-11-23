module frame_generator(data_high, data_low, data_out);
	input [3:0] data_high;	
	input [3:0] data_low;
	output [10:0] data_out; 
	
	localparam START_BIT = 1'b0;
	localparam STOP_BITS = 1'b1;   
	wire parity_bit;  

	assign parity_bit = ^{data_high, data_low};  

	assign data_out = {STOP_BITS, parity_bit, data_high, data_low, START_BIT};

endmodule
