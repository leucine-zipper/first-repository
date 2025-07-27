`timescale 1ns/1ns

module Top_tb;

    reg clk, rst;
    wire [7:0] digit;
    wire [7:0] segment_data;

    Top uut (
        .rst(rst),
        .clk(clk),
        .digit(digit),
        .segment_data(segment_data)
    );

    // Generate clock: 20ns period
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Apply reset and let simulation run
    initial begin
        rst = 1; // Hold reset
        #20 rst = 0; // Release reset at 20ns

        // Simulate enough time for all states to execute
        #10000 $stop;
    end

    // Print only when MOD_NUM changes
    always @(uut.MODE_NUM) begin
      $display("==== MOD_NUM=%b ====", uut.MODE_NUM);
      $display("MEM=%b PE=%b SA3x3=%b SA2x2=%b DISP=%b", 
              uut.enable_memory, uut.enable_singlePE,
              uut.enable_SA3x3, uut.enable_SA2x2, uut.enable_display);
      $display("C11_single=%b C12_single=%b C21_single=%b C22_single=%b",
              uut.C11_single, uut.C12_single, uut.C21_single, uut.C22_single);
      $display("C11_3_3=%b C12_3_3=%b C21_3_3=%b C22_3_3=%b",
              uut.C11_3_3, uut.C12_3_3, uut.C21_3_3, uut.C22_3_3);
      $display("C11_2_2=%b C12_2_2=%b C21_2_2=%b C22_2_2=%b",             
              uut.C11_2_2, uut.C12_2_2, uut.C21_2_2, uut.C22_2_2);
    end

endmodule
