module shift_register(clk, baud_clk, data_frame, shift, load, reset, tx);
	input clk;
	input baud_clk;
	input [10:0] data_frame;
	input shift;
	input load;
	input reset;
	output tx;
	
	reg [11:0] shift_register = 12'hFFF;
	
  always @(posedge clk) 
  begin
    if (reset) 
		 begin
			// Reset the state machine and data
			shift_register <= 12'hFFF;
		 end 
	 else if (load) 
		 begin
			// Start sending data
			shift_register <= {1'b1, data_frame};
		 end 
	 else if (shift) 
		 begin
			if(baud_clk == 1'b1) 
				begin				
					shift_register <= {shift_register[10:0], 1'b1};			
				end
		 end
	 else
		begin
			shift_register <= 12'hFFF;
		end
  end
  assign tx = shift_register[11];
  
endmodule
	