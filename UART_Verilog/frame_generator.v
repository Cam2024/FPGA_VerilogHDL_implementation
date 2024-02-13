module frame_generator(
    input [7:0] data_in,         // Input data
    output reg [11:0] data_out    // Output data frame
);

    // Define control signals
    localparam START_BIT = 1'b0;   // Start bit always low
    localparam STOP_BITS = 1'b1;    // Stop bit always high
    localparam PROTECT_BIT = 1'b1;  // Used to ensure the start bit can be output for one full baud cycle

    // Generate parity bit
    wire parity_bit;
    assign parity_bit = ^data_in;   // Even parity check

    // Combinational logic to generate output data frame
    always @(*) begin
        data_out = {STOP_BITS, parity_bit, data_in, START_BIT, PROTECT_BIT};
    end

endmodule
