module pe_module(
    input  wire [7:0] in1, in2,      // Matrix and filter inputs
    input  wire       clk, rst,      // Clock and reset
    output wire [7:0] pass_right, pass_down, // Propagate inputs to neighbor PEs
    output reg  [7:0] result          // Accumulated output
);

    wire [7:0] mul_out; // Multiplier output
    wire [7:0] add_out; // Adder output

    // Relay: propagate in1 to right PE, in2 to bottom PE
    eight_bit_register_behavioral_module relay_reg1(.in(in1), .clk(clk), .rst(rst), .out(pass_right));
    eight_bit_register_behavioral_module relay_reg2(.in(in2), .clk(clk), .rst(rst), .out(pass_down));

    // Multiplier: combinational
    multiplier_module multiplier (.a(in1), .b(in2), .outC(mul_out));

    // Adder: combinational
    eight_bit_adder_module adder (.a(mul_out), .b(result), .cin(1'b0), .sum(add_out), .cout());

    // Accumulator register: updates on each clock
    always @(posedge clk or posedge rst) begin
        if (rst)
            result <= 8'b0;   // Reset accumulated result
        else
            result <= add_out; // Accumulate
    end

endmodule
