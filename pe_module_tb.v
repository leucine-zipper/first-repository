`timescale 1ns/1ns

module pe_module_tb;

    reg clk, rst;
    reg [7:0] in1, in2;
    wire [7:0] pass_right, pass_down;
    wire [7:0] result;

    pe_module uut (
        .in1(in1), 
        .in2(in2),
        .pass_right(pass_right), 
        .pass_down(pass_down), 
        .result(result),
        .clk(clk), 
        .rst(rst)
    );

    // Clock generation: period = 20ns
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Test stimulus
    initial begin
        rst = 1; in1 = 0; in2 = 0;
        #10 rst = 0; // Release reset

        #15 in1 = 3; in2 = 2; 
        #20 in1 = 1; in2 = 4;
        #20 in1 = 5; in2 = 1;
        #20 in1 = 0; in2 = 7;
        #20 in1 = 2; in2 = 3;
        #20 in1 = 0; in2 = 0;
    end
endmodule
