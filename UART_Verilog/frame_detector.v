module frame_detector(
	input clk, // 50 Mhz clock
	input rst, // reset signal
	input [10:0] data_frame, // data buffer (data_frame)
	output reg parity_error, // use to display parity_error
	output reg frame_error, // use to display frame_error
	output reg [3:0] highbits, // high bits of data frame
	output reg [3:0] lowbits // low bits of data frame
);

	always @(posedge clk)
		begin
			if(!rst) // reset all registers
				begin
					parity_error <= 1'b0;
					frame_error <= 1'b0;
					lowbits <= 4'b0000;
					highbits <= 4'b0000;
				end
			else
				begin
					if(data_frame[0]== 1'b1) // use to detecte frame_error at buffer[0](stop bit should be 1)
						begin
							frame_error = 1'b0;
							if(data_frame[1] == ^data_frame[9:2]) // parity check for data bits [9:2]
								begin // for 7 seg display decoder
									highbits = {data_frame[2], data_frame[3], data_frame[4], data_frame[5]};
									lowbits = {data_frame[6], data_frame[7], data_frame[8], data_frame[9]};
									parity_error = 1'b0;
								end
							else
								begin // parity error
									lowbits = 4'b0000;
									highbits = 4'b0000;
									parity_error = 1'b1;
								end
						end
					else
						begin // frame error (stop bit = 0)
							frame_error = 1'b1;
							lowbits = 4'b0000;
							highbits = 4'b0000;
						end
				end
		end
endmodule
