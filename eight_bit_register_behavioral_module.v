module eight_bit_register_behavioral_module(
    input  wire [7:0] in,  // Input data
    input  wire       clk, // Clock
    input  wire       rst, // Reset
    output reg  [7:0] out  // Output data
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 8'b0;   // Clear register on reset
        else
            out <= in;     // Pass input to output
    end
endmodule

