  `timescale 1ns/1ns
module memory_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg [7:0] in_1, in_2, in_3, in_4;
    reg [7:0] in_5, in_6, in_7, in_8;
    reg [7:0] in_9, in_10, in_11, in_12;
    reg [7:0] in_13, in_14, in_15, in_16;
    reg [7:0] f_1, f_2, f_3, f_4, f_5, f_6, f_7, f_8, f_9;

    wire [7:0] out_in_1, out_in_2, out_in_3, out_in_4;
    wire [7:0] out_in_5, out_in_6, out_in_7, out_in_8, out_in_9;
    wire [7:0] out_in_10, out_in_11, out_in_12, out_in_13, out_in_14;
    wire [7:0] out_in_15, out_in_16, out_f_1, out_f_2, out_f_3;
    wire [7:0] out_f_4, out_f_5, out_f_6, out_f_7, out_f_8, out_f_9;
    wire done_memory;

    // Instantiate the memory module
    memory memory_1 (
        .clk(clk),
        .rst(rst),
        .in_1(in_1), .in_2(in_2), .in_3(in_3), .in_4(in_4),
        .in_5(in_5), .in_6(in_6), .in_7(in_7), .in_8(in_8),
        .in_9(in_9), .in_10(in_10), .in_11(in_11), .in_12(in_12),
        .in_13(in_13), .in_14(in_14), .in_15(in_15), .in_16(in_16),
        .f_1(f_1), .f_2(f_2), .f_3(f_3), .f_4(f_4), .f_5(f_5),
        .f_6(f_6), .f_7(f_7), .f_8(f_8), .f_9(f_9),
        .out_in_1(out_in_1), .out_in_2(out_in_2), .out_in_3(out_in_3), .out_in_4(out_in_4),
        .out_in_5(out_in_5), .out_in_6(out_in_6), .out_in_7(out_in_7), .out_in_8(out_in_8),
        .out_in_9(out_in_9), .out_in_10(out_in_10), .out_in_11(out_in_11), .out_in_12(out_in_12),
        .out_in_13(out_in_13), .out_in_14(out_in_14), .out_in_15(out_in_15), .out_in_16(out_in_16),
        .out_f_1(out_f_1), .out_f_2(out_f_2), .out_f_3(out_f_3), .out_f_4(out_f_4),
        .out_f_5(out_f_5), .out_f_6(out_f_6), .out_f_7(out_f_7), .out_f_8(out_f_8),
        .out_f_9(out_f_9), .done_memory(done_memory)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = 1; // Apply reset
        #10 rst = 0; // Deassert reset after 10ns

        // Assign random binary values to inputs
        in_1 = 8'b11010101; in_2 = 8'b00110111; in_3 = 8'b10101100; in_4 = 8'b01010010;
        in_5 = 8'b01100101; in_6 = 8'b11101010; in_7 = 8'b10010111; in_8 = 8'b00101101;
        in_9 = 8'b11001001; in_10 = 8'b10111000; in_11 = 8'b01111001; in_12 = 8'b00011100;
        in_13 = 8'b01010101; in_14 = 8'b11111111; in_15 = 8'b00000001; in_16 = 8'b10101010;
        f_1 = 8'b00111100; f_2 = 8'b11011011; f_3 = 8'b10100101; f_4 = 8'b01001110; 
        f_5 = 8'b11100011; f_6 = 8'b00010110; f_7 = 8'b01110001; f_8 = 8'b10111001; f_9 = 8'b01010110;
    end

endmodule

