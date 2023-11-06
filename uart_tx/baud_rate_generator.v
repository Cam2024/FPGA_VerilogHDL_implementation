module baud_rate_generator(clk, tx);
  input clk;            // 系统时钟，50MHz
  output reg tx;            // UART传输线
  
  
  reg [15:0] count = 16'h0000;  // 计数器，用于分频

  // 38400波特率所需的分频值
  localparam DIVIDER = 1301; // (50000000 / 38400) - 1

  always @(posedge clk) 
	  begin
		 if (count == DIVIDER) 
			 begin
				tx <= 1'b1; // UART发送位的起始位
				count <= 16'h0000;
			 end
		 else if (count < DIVIDER) 
			 begin
				count <= count + 1'b1;
				tx <= 1'b0; // 保持低电平，发送位数据位
			 end 
	  end
endmodule
