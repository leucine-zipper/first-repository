`timescale 1ns/1ns

module tb_controller;
  
  // Clock
  reg CLK;
  
  // Inputs
  reg RESET;
  reg [2:0] MODE_NUM;
  
  // Outputs
  wire enable_memory;
  wire enable_singlePE;
  wire enable_SA3x3;
  wire enable_SA2x2;
  wire enable_display;

  // Instantiate the controller
  controller controller (
    .rst(RESET),
    .clk(CLK),
    .mode_num(MODE_NUM),
    .enable_memory(enable_memory),
    .enable_singlePE(enable_singlePE),
    .enable_SA3x3(enable_SA3x3),
    .enable_SA2x2(enable_SA2x2),
    .enable_display(enable_display)
  );
  
  // Clock generation (20ns period)
  initial begin
    CLK = 0;
    forever #10 CLK = ~CLK;
  end

  // Initial conditions & test pattern
  initial begin
    // Initial state
    RESET = 1;
    MODE_NUM = 3'b000;

    // Observe reset behavior
    #30 RESET = 0;  // Release reset

    // Sequentially test state transitions
    #50 MODE_NUM = 3'b001; // Memory done ? Single PE
    #100 MODE_NUM = 3'b010; // Single PE done ? SA3x3
    #100 MODE_NUM = 3'b011; // SA3x3 done ? SA2x2
    #100 MODE_NUM = 3'b100; // SA2x2 done ? Display

    // Edge case: keep MOD_NUM constant (no transition)
    #100 MODE_NUM = 3'b100;

    // Reapply reset
    #50 RESET = 1;
    #30 RESET = 0;
  end
endmodule

