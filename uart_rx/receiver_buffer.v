module receiver_buffer(clk, baud, count, rx, rx_flag, baud_count, frame);
	input clk;            // 系统时钟，50MHz
	input baud;
	input count;
	input rx;	// UART传输线
	output reg rx_flag;
	output reg baud_count;
	output reg [10:0] frame;

	reg [2:0] state = 3'b001;
	reg [10:0] buffer = 11'b11111111111;
	
	always @(posedge clk)
		begin
        case (state)
				3'b001: 
					begin // 等待起始位
						 if(!rx) 
							 begin
								 state <= 3'b010;
								 rx_flag <= 1'b1;
							end
						 else
							begin
								state <= 3'b001;
								rx_flag <= 1'b0;
							end
					end
            3'b010: 
					begin // 等待起始位
						rx_flag <= 1'b0;
						if(count)
							begin
								frame <= buffer[10:0];
								state <= 3'b100;
								baud_count = 1'b0;
							end
						else if (baud) 
							begin
								buffer[10:0] <= {buffer[9:0], rx};
								baud_count = 1'b1; 
							end
						else
							begin
								state <= 3'b010;
								baud_count = 1'b0;
							end
					end
            3'b100: 
					begin // 接收数据位
						if(baud)
							begin
								buffer <= 11'b11111111111;
								state <= 3'b001;
							end
						else
							begin
								state <= 3'b100;
							end
					end					
        endcase			
		end
		
endmodule
