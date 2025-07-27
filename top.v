module Top(rst,clk, digit, segment_data);
  
  //input
  input rst, clk;
  
  //output (display, segment wire)
  output wire [7:0] digit;
  output wire [7:0] segment_data;

  // mode number and worked number
  reg [2:0] MODE_NUM;
  wire done_memory, done_single, done_3_3, done_2_2;
  
  //Controller input, output  
  wire enable_memory;
  wire enable_singlePE;
  wire enable_SA3x3;
  wire enable_SA2x2;
  wire enable_display;

  
  //Memory input, output(modules input)
  reg [7:0] Input_1, Input_2, Input_3, Input_4, Input_5, Input_6, Input_7, Input_8;
  reg [7:0] Input_9, Input_10, Input_11, Input_12, Input_13, Input_14, Input_15, Input_16;
  reg [7:0] Filter_1, Filter_2, Filter_3, Filter_4, Filter_5, Filter_6, Filter_7, Filter_8, Filter_9;
  
  wire [7:0] Input_Out_1, Input_Out_2, Input_Out_3, Input_Out_4, Input_Out_5, Input_Out_6, Input_Out_7, Input_Out_8;
  wire [7:0] Input_Out_9, Input_Out_10, Input_Out_11, Input_Out_12, Input_Out_13, Input_Out_14, Input_Out_15, Input_Out_16;
  wire [7:0] Filter_Out_1, Filter_Out_2, Filter_Out_3, Filter_Out_4, Filter_Out_5, Filter_Out_6, Filter_Out_7, Filter_Out_8, Filter_Out_9;
  
  //single PE output
  wire [7:0] PE_OUT;
  wire [7:0] C11_single, C12_single, C21_single, C22_single;
 
  //3*3 systoric array output
  wire [7:0] RESULT;
  wire [7:0] C11_3_3, C12_3_3, C21_3_3, C22_3_3;
  
  //2*2 systoric array output
  wire [7:0] C11_2_2, C12_2_2, C21_2_2, C22_2_2;  
  
  initial begin
    Input_1   = 8'b00000001;
    Input_2   = 8'b00000100;
    Input_3   = 8'b00000111;
    Input_4   = 8'b00000101;
    Input_5   = 8'b00000000;
    Input_6   = 8'b00001000;
    Input_7   = 8'b00000110;
    Input_8   = 8'b00000011;
    Input_9   = 8'b00000101;
    Input_10  = 8'b00001010;
    Input_11  = 8'b00000100;
    Input_12  = 8'b00000010;
    Input_13  = 8'b00000011;
    Input_14  = 8'b00000110;
    Input_15  = 8'b00001001;
    Input_16  = 8'b00000111;

    Filter_1  = 8'b00000011;
    Filter_2  = 8'b00000000;
    Filter_3  = 8'b00000010;
    Filter_4  = 8'b00000001;
    Filter_5  = 8'b00000001;
    Filter_6  = 8'b00000000;
    Filter_7  = 8'b00000010;
    Filter_8  = 8'b00000010;
    Filter_9  = 8'b00000001;

  end
  
// Controller module 
  controller controller(.rst(rst), .clk(clk), .mode_num(MODE_NUM), 
  .enable_memory(enable_memory), .enable_singlePE(enable_singlePE), 
  .enable_SA3x3(enable_SA3x3), .enable_SA2x2(enable_SA2x2), .enable_display(enable_display));
  
  // Memory module 
  memory memory(
  .clk(clk), .rst(enable_memory),
  .in_1(Input_1), .in_2(Input_2), .in_3(Input_3), .in_4(Input_4), 
  .in_5(Input_5), .in_6(Input_6), .in_7(Input_7), .in_8(Input_8), 
  .in_9(Input_9), .in_10(Input_10), .in_11(Input_11), .in_12(Input_12), 
  .in_13(Input_13), .in_14(Input_14), .in_15(Input_15), .in_16(Input_16),
  .f_1(Filter_1), .f_2(Filter_2), .f_3(Filter_3), 
  .f_4(Filter_4), .f_5(Filter_5), .f_6(Filter_6), 
  .f_7(Filter_7), .f_8(Filter_8), .f_9(Filter_9),
  .out_in_1(Input_Out_1), .out_in_2(Input_Out_2), .out_in_3(Input_Out_3), .out_in_4(Input_Out_4), 
  .out_in_5(Input_Out_5), .out_in_6(Input_Out_6), .out_in_7(Input_Out_7), .out_in_8(Input_Out_8), 
  .out_in_9(Input_Out_9), .out_in_10(Input_Out_10), .out_in_11(Input_Out_11), .out_in_12(Input_Out_12), 
  .out_in_13(Input_Out_13), .out_in_14(Input_Out_14), .out_in_15(Input_Out_15), .out_in_16(Input_Out_16),
  .out_f_1(Filter_Out_1), .out_f_2(Filter_Out_2), .out_f_3(Filter_Out_3), 
  .out_f_4(Filter_Out_4), .out_f_5(Filter_Out_5), .out_f_6(Filter_Out_6), 
  .out_f_7(Filter_Out_7), .out_f_8(Filter_Out_8), .out_f_9(Filter_Out_9), .done_memory(done_memory)); 
  
  
  //single PE module 
  single_pe_module single_PE(
  .mat_in_11(Input_Out_1), .mat_in_12(Input_Out_2), .mat_in_13(Input_Out_3), .mat_in_14(Input_Out_4), 
  .mat_in_21(Input_Out_5), .mat_in_22(Input_Out_6), .mat_in_23(Input_Out_7), .mat_in_24(Input_Out_8), 
  .mat_in_31(Input_Out_9), .mat_in_32(Input_Out_10), .mat_in_33(Input_Out_11), .mat_in_34(Input_Out_12), 
  .mat_in_41(Input_Out_13), .mat_in_42(Input_Out_14), .mat_in_43(Input_Out_15), .mat_in_44(Input_Out_16),
  .kernel_11(Filter_Out_1), .kernel_12(Filter_Out_2), .kernel_13(Filter_Out_3), 
  .kernel_21(Filter_Out_4), .kernel_22(Filter_Out_5), .kernel_23(Filter_Out_6), 
  .kernel_31(Filter_Out_7), .kernel_32(Filter_Out_8), .kernel_33(Filter_Out_9),
  .clk(clk), .rst(enable_singlePE),
  .conv_out_11(C11_single), .conv_out_12(C12_single), .conv_out_21(C21_single), .conv_out_22(C22_single), .done_single(done_single));
  
  //3*3 systoric array module 
  systolic_array_3by3_module s_a_3_3(
  .mat_input11(Input_Out_1), .mat_input12(Input_Out_2), .mat_input13(Input_Out_3), .mat_input14(Input_Out_4),
  .mat_input21(Input_Out_5), .mat_input22(Input_Out_6), .mat_input23(Input_Out_7), .mat_input24(Input_Out_8),
  .mat_input31(Input_Out_9), .mat_input32(Input_Out_10), .mat_input33(Input_Out_11), .mat_input34(Input_Out_12),
  .mat_input41(Input_Out_13), .mat_input42(Input_Out_14), .mat_input43(Input_Out_15), .mat_input44(Input_Out_16),   
  .filter11(Filter_Out_1), .filter12(Filter_Out_2), .filter13(Filter_Out_3), 
  .filter21(Filter_Out_4), .filter22(Filter_Out_5), .filter23(Filter_Out_6), 
  .filter31(Filter_Out_7), .filter32(Filter_Out_8), .filter33(Filter_Out_9), 
  .result11(C11_3_3), .result12(C12_3_3), .result21(C21_3_3), .result22(C22_3_3),
  .done_3_3(done_3_3), .clk(clk), .rst(enable_SA3x3));
  
  //2*2 systoric array module (rst_4) 
  systolic_array_2by2_module s_a_2_2(
  .mat_input11(Input_Out_1), .mat_input12(Input_Out_2), .mat_input13(Input_Out_3), .mat_input14(Input_Out_4),
  .mat_input21(Input_Out_5), .mat_input22(Input_Out_6), .mat_input23(Input_Out_7), .mat_input24(Input_Out_8),
  .mat_input31(Input_Out_9), .mat_input32(Input_Out_10), .mat_input33(Input_Out_11), .mat_input34(Input_Out_12),
  .mat_input41(Input_Out_13), .mat_input42(Input_Out_14), .mat_input43(Input_Out_15), .mat_input44(Input_Out_16),   
  .filter11(Filter_Out_1), .filter12(Filter_Out_2), .filter13(Filter_Out_3), 
  .filter21(Filter_Out_4), .filter22(Filter_Out_5), .filter23(Filter_Out_6), 
  .filter31(Filter_Out_7), .filter32(Filter_Out_8), .filter33(Filter_Out_9), 
  .result11(C11_2_2), .result12(C12_2_2), .result21(C21_2_2), .result22(C22_2_2),
  .done_2_2(done_2_2), .clk(clk), .rst(enable_SA2x2));
  
  
  //disp, 7 seg module
  display display(.clk(clk), .rst(enable_display), 
  .sa_3x3_11(C11_3_3), .sa_3x3_12(C12_3_3), .sa_3x3_21(C21_3_3), .sa_3x3_22(C22_3_3), 
  .sa_2x2_11(C11_2_2), .sa_2x2_12(C12_2_2), .sa_2x2_21(C21_2_2), .sa_2x2_22(C22_2_2), 
  .digit_select(digit), .segment_output(segment_data));

  // initial value
  initial 
  begin
    MODE_NUM = 3'b000; 
  end
  
  //control all module
  always @ (posedge clk) begin
    case (MODE_NUM)
      0: if (done_memory == 1'b1) MODE_NUM <= MODE_NUM + 1; 
      1: if (done_single == 1'b1) MODE_NUM <= MODE_NUM + 1; 
      2: if (done_3_3 == 1'b1) MODE_NUM <= MODE_NUM + 1; 
      3: if (done_2_2 == 1'b1) MODE_NUM <= MODE_NUM + 1; 
      4: MODE_NUM <= 3'b100; // ? Stay in display mode forever
      default: MODE_NUM <= 3'b100;
    endcase
  end 
endmodule

