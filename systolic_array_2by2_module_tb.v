`timescale 1ns/1ns
module systolic_array_2by2_module_tb;
  reg CLK;
  reg RST; 
  reg[7:0] INPUT11, INPUT12, INPUT13, INPUT14, 
            INPUT21, INPUT22, INPUT23, INPUT24, 
            INPUT31, INPUT32, INPUT33, INPUT34, 
            INPUT41, INPUT42, INPUT43, INPUT44;
  reg[7:0]  FILTER11, FILTER12, FILTER13, 
             FILTER21, FILTER22, FILTER23,
             FILTER31, FILTER32, FILTER33;
  wire done_2_2;
  wire [7:0] RESULT11, RESULT12, RESULT21, RESULT22;
  


  systolic_array_2by2_module two_by_two (
    .mat_input11(INPUT11), .mat_input12(INPUT12), .mat_input13(INPUT13), .mat_input14(INPUT14),
    .mat_input21(INPUT21), .mat_input22(INPUT22), .mat_input23(INPUT23), .mat_input24(INPUT24),
    .mat_input31(INPUT31), .mat_input32(INPUT32), .mat_input33(INPUT33), .mat_input34(INPUT34),
    .mat_input41(INPUT41), .mat_input42(INPUT42), .mat_input43(INPUT43), .mat_input44(INPUT44),
    .filter11(FILTER11), .filter12(FILTER12), .filter13(FILTER13),
    .filter21(FILTER21), .filter22(FILTER22), .filter23(FILTER23),
    .filter31(FILTER31), .filter32(FILTER32), .filter33(FILTER33),
    .clk(CLK), .rst(RST),
    .done_2_2(done_2_2),
    .result11(RESULT11), .result12(RESULT12), .result21(RESULT21), .result22(RESULT22)
      );

  initial
  begin
      INPUT11 = 8'd0; INPUT12 = 8'd0; INPUT13 = 8'd0; INPUT14 = 8'd0;
      INPUT21 = 8'd0; INPUT22 = 8'd0; INPUT23 = 8'd0; INPUT24 = 8'd0;
      INPUT31 = 8'd0; INPUT32 = 8'd0; INPUT33 = 8'd0; INPUT34 = 8'd0;
      INPUT41 = 8'd0; INPUT42 = 8'd0; INPUT43 = 8'd0; INPUT44 = 8'd0;
      FILTER11 = 8'd0; FILTER12 = 8'd0; FILTER13 = 8'd0;
      FILTER21 = 8'd0; FILTER22 = 8'd0; FILTER23 = 8'd0;
      FILTER31 = 8'd0; FILTER32 = 8'd0; FILTER33 = 8'd0;
      RST = 1'b1;
      CLK = 1'b0;
  end
  
  initial
  begin
        forever
        begin
          #10 CLK = !CLK;
        end
  end

  initial
  begin
        #10 RST = 1'b1;
        #20 RST = 1'b0;
            INPUT11 = 8'd2;  INPUT12 = 8'd1;  INPUT13 = 8'd3;  INPUT14 = 8'd1;
            INPUT21 = 8'd0;  INPUT22 = 8'd2;  INPUT23 = 8'd4;  INPUT24 = 8'd2;
            INPUT31 = 8'd1;  INPUT32 = 8'd3;  INPUT33 = 8'd2;  INPUT34 = 8'd0;
            INPUT41 = 8'd2;  INPUT42 = 8'd1;  INPUT43 = 8'd0;  INPUT44 = 8'd1;

            FILTER11 = 8'd1;  FILTER12 = 8'd0;  FILTER13 = 8'd1;
            FILTER21 = 8'd1;  FILTER22 = 8'd1;  FILTER23 = 8'd0;
            FILTER31 = 8'd0;  FILTER32 = 8'd1;  FILTER33 = 8'd1;

        #500 RST= 1'b1;


  end

endmodule