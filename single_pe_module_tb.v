`timescale 1ns/1ns

module single_pe_module_tb;
  // Clock
  reg CLK;
  reg RST;

  reg [7:0] mat_in_11, mat_in_12, mat_in_13, mat_in_14,
            mat_in_21, mat_in_22, mat_in_23, mat_in_24,
            mat_in_31, mat_in_32, mat_in_33, mat_in_34,
            mat_in_41, mat_in_42, mat_in_43, mat_in_44;

  reg [7:0] kernel_11, kernel_12, kernel_13,
            kernel_21, kernel_22, kernel_23,
            kernel_31, kernel_32, kernel_33;

  wire [7:0] conv_out_11, conv_out_12, conv_out_21, conv_out_22;
  wire done_single;

  single_pe_module uut (
    .mat_in_11(mat_in_11), .mat_in_12(mat_in_12), .mat_in_13(mat_in_13), .mat_in_14(mat_in_14),
    .mat_in_21(mat_in_21), .mat_in_22(mat_in_22), .mat_in_23(mat_in_23), .mat_in_24(mat_in_24),
    .mat_in_31(mat_in_31), .mat_in_32(mat_in_32), .mat_in_33(mat_in_33), .mat_in_34(mat_in_34),
    .mat_in_41(mat_in_41), .mat_in_42(mat_in_42), .mat_in_43(mat_in_43), .mat_in_44(mat_in_44),
    .kernel_11(kernel_11), .kernel_12(kernel_12), .kernel_13(kernel_13),
    .kernel_21(kernel_21), .kernel_22(kernel_22), .kernel_23(kernel_23),
    .kernel_31(kernel_31), .kernel_32(kernel_32), .kernel_33(kernel_33),
    .clk(CLK), .rst(RST),
    .conv_out_11(conv_out_11), .conv_out_12(conv_out_12), .conv_out_21(conv_out_21), .conv_out_22(conv_out_22), .done_single(done_single)
  );

  initial begin
    mat_in_11 = 8'd2;  mat_in_12 = 8'd1;  mat_in_13 = 8'd3;  mat_in_14 = 8'd1;
    mat_in_21 = 8'd0;  mat_in_22 = 8'd2;  mat_in_23 = 8'd4;  mat_in_24 = 8'd2;
    mat_in_31 = 8'd1;  mat_in_32 = 8'd3; mat_in_33 = 8'd2; mat_in_34 = 8'd0;
    mat_in_41 = 8'd2; mat_in_42 = 8'd1; mat_in_43 = 8'd0; mat_in_44 = 8'd1;

    kernel_11 = 8'd1; kernel_12 = 8'd0; kernel_13 = 8'd1;
    kernel_21 = 8'd1; kernel_22 = 8'd1; kernel_23 = 8'd0;
    kernel_31 = 8'd0; kernel_32 = 8'd1; kernel_33 = 8'd1;

    RST = 1'b1;
    CLK = 1'b0;
  end

  initial begin
    forever begin
      #10 CLK = ~CLK;
    end
  end

  initial begin
    #10 RST = 1'b0;
    #1000 RST = 1'b1;
    #10 RST = 1'b0;
    #1000 RST = 1'b1;
    #10 RST = 1'b0;
  end

endmodule

