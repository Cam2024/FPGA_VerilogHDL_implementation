module baud_rate_generator(clk, reset, baud_pulse);
  input clk;            // 系统时钟，50MHz
  input reset;
  output reg baud_pulse;            // UART传输线
  
  
  reg [15:0] count = 16'h0;  // 计数器，用于分频
  // 38400波特率所需的分频值
  localparam DIVIDER = 16'h515; // (50000000 / 38400) - 1 = hex: 515

  always @(posedge clk) 
	  begin
		if(reset)
			begin
				count <= 16'h28A;
			end
		 else if (count == DIVIDER) 
			 begin
				baud_pulse <= 1'b1; // UART发送位的起始位
				count <= 16'h0;
			 end
		 else if (count < DIVIDER) 
			 begin
				count <= count + 1'b1;
				baud_pulse <= 1'b0; // 保持低电平，发送位数据位
			 end 
	  end
endmodule
