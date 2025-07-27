module systolic_array_3by3_module(mat_input11,mat_input12,mat_input13,mat_input14,
                                  mat_input21,mat_input22,mat_input23,mat_input24,
                                  mat_input31,mat_input32,mat_input33,mat_input34,
                                  mat_input41,mat_input42,mat_input43,mat_input44, 
                                                       filter11,filter12,filter13,
                                                       filter21,filter22,filter23,
                                                       filter31,filter32,filter33, 
                                              result11,result12,result21,result22,
                                              done_3_3,
                                                                        clk, rst);

    input clk; 
    input rst;
    input [7:0] mat_input11, mat_input12, mat_input13, mat_input14, 
                mat_input21, mat_input22, mat_input23, mat_input24, 
                mat_input31, mat_input32, mat_input33, mat_input34, 
                mat_input41, mat_input42, mat_input43, mat_input44;
    input [7:0] filter11, filter12, filter13, 
                filter21, filter22, filter23, 
                filter31, filter32, filter33;
    output reg [7:0] result11, result12, result21, result22;
    output reg done_3_3; //

  parameter DUMMY_ZERO = 8'd0; // 8-bit zero decimal or binary
  parameter DATA_FEED_CYCLES = 4'd11; // 12 clock is needed for 2 by 2 systolic array


  wire [7:0] row_input_1[0:11], row_input_2[0:11], row_input_3[0:11], col_input_1[0:11], col_input_2[0:11], col_input_3[0:11]; 
  reg [7:0] row_1, row_2, row_3, col_1, col_2, col_3; // register for entrace of inputs and filters
  wire [7:0] res_pe1, res_pe4, res_pe8, res_pe9; // results of PE calculation(1,4,8,9)
  wire [7:0] row_pe1, row_pe2, row_pe4, row_pe5, row_pe7, row_pe8, // row output from PE
             col_pe1, col_pe2, col_pe3, col_pe4, col_pe5, col_pe6; // col output from PE
  reg [4:0] cnt; // counter for timing prediction

  initial done_3_3 <= 0;

  assign row_input_1[0] = mat_input11; assign row_input_1[1] = mat_input12; assign row_input_1[2] = mat_input13; 
  assign row_input_1[3] = mat_input21; assign row_input_1[4] = mat_input22; assign row_input_1[5] = mat_input23; 
  assign row_input_1[6] = mat_input31; assign row_input_1[7] = mat_input32; assign row_input_1[8] = mat_input33; 
  assign row_input_1[9] = DUMMY_ZERO; assign row_input_1[10] = DUMMY_ZERO; assign row_input_1[11] = DUMMY_ZERO;

  assign row_input_2[0] = DUMMY_ZERO; assign row_input_2[1] = mat_input12; assign row_input_2[2] = mat_input13; 
  assign row_input_2[3] = mat_input14; assign row_input_2[4] = mat_input22; assign row_input_2[5] = mat_input23; 
  assign row_input_2[6] = mat_input24; assign row_input_2[7] = mat_input32; assign row_input_2[8] = mat_input33; 
  assign row_input_2[9] = mat_input34; assign row_input_2[10] = DUMMY_ZERO; assign row_input_2[11] = DUMMY_ZERO; 

  assign row_input_3[0] = DUMMY_ZERO; assign row_input_3[1] = filter33; assign row_input_3[2] = filter32; 
  assign row_input_3[3] = filter31; assign row_input_3[4] = filter23; assign row_input_3[5] = filter22; 
  assign row_input_3[6] = filter21; assign row_input_3[7] = filter13; assign row_input_3[8] = filter12; 
  assign row_input_3[9] = filter11; assign row_input_3[10] = DUMMY_ZERO; assign row_input_3[11] = DUMMY_ZERO; 

  assign col_input_1[0] = filter33; assign col_input_1[1] = filter32; assign col_input_1[2] = filter31; 
  assign col_input_1[3] = filter23; assign col_input_1[4] = filter22; assign col_input_1[5] = filter21; 
  assign col_input_1[6] = filter13; assign col_input_1[7] = filter12; assign col_input_1[8] = filter11; 
  assign col_input_1[9] = DUMMY_ZERO; assign col_input_1[10] = DUMMY_ZERO; assign col_input_1[11] = DUMMY_ZERO;

  assign col_input_2[0] = mat_input21; assign col_input_2[1] = mat_input22; assign col_input_2[2] = mat_input23; 
  assign col_input_2[3] = mat_input31; assign col_input_2[4] = mat_input32; assign col_input_2[5] = mat_input33; 
  assign col_input_2[6] = mat_input41; assign col_input_2[7] = mat_input42; assign col_input_2[8] = mat_input43; 
  assign col_input_2[9] = DUMMY_ZERO; assign col_input_2[10] = DUMMY_ZERO; assign col_input_2[11] = DUMMY_ZERO; 

  assign col_input_3[0] = DUMMY_ZERO; assign col_input_3[1] = mat_input22; assign col_input_3[2] = mat_input23; 
  assign col_input_3[3] = mat_input24; assign col_input_3[4] = mat_input32; assign col_input_3[5] = mat_input33; 
  assign col_input_3[6] = mat_input34; assign col_input_3[7] = mat_input42; assign col_input_3[8] = mat_input43; 
  assign col_input_3[9] = mat_input44; assign col_input_3[10] = DUMMY_ZERO; assign col_input_3[11] = DUMMY_ZERO;  

// PE module로 계산하는 방식 정의
pe_module PE1 (.clk(clk), .rst(rst), .in1(row_1), .in2(col_1), .pass_right(row_pe1), .pass_down(col_pe1), .result(res_pe1));
pe_module PE2 (.clk(clk), .rst(rst), .in1(row_pe1), .in2(col_2), .pass_right(row_pe2), .pass_down(col_pe2), .result());
pe_module PE3 (.clk(clk), .rst(rst), .in1(row_pe2), .in2(col_3), .pass_right(), .pass_down(col_pe3), .result());
pe_module PE4 (.clk(clk), .rst(rst), .in1(row_2), .in2(col_pe1), .pass_right(row_pe4), .pass_down(col_pe4), .result(res_pe4));
pe_module PE5 (.clk(clk), .rst(rst), .in1(row_pe4), .in2(col_pe2), .pass_right(row_pe5), .pass_down(col_pe5), .result());
pe_module PE6 (.clk(clk), .rst(rst), .in1(row_pe5), .in2(col_pe3), .pass_right(), .pass_down(col_pe6), .result());
pe_module PE7 (.clk(clk), .rst(rst), .in1(row_3), .in2(col_pe4), .pass_right(row_pe7), .pass_down(), .result());
pe_module PE8 (.clk(clk), .rst(rst), .in1(row_pe7), .in2(col_pe5), .pass_right(row_pe8), .pass_down(), .result(res_pe8));
pe_module PE9 (.clk(clk), .rst(rst), .in1(row_pe8), .in2(col_pe6), .pass_right(), .pass_down(), .result(res_pe9));

// 입력값과 초기값과 계산 순서를 지정

  always @(posedge clk or posedge rst) 
  begin
    if(rst) 
    begin
        cnt <= 8'd0;
        row_1 <= 8'd0;
        row_2 <= 8'd0;
        row_3 <= 8'd0;
        col_1 <= 8'd0;
        col_2 <= 8'd0;
        col_3 <= 8'd0;
        done_3_3 <= 0;
      end
    else 
    begin
      if (cnt <= DATA_FEED_CYCLES)
        begin
        cnt <= cnt + 1;
        row_1 <= row_input_1[cnt];
        row_2 <= row_input_2[cnt];
        row_3 <= row_input_3[cnt]; 
        col_1 <= col_input_1[cnt];
        col_2 <= col_input_2[cnt];
        col_3 <= col_input_3[cnt];
        done_3_3 <= 0;
        end
      else if (cnt == DATA_FEED_CYCLES + 1 ) begin
        //연산 완료 후 한번만 done 신호 올림
        done_3_3 <= 1;
      end
        else begin
        row_1 <= 8'd0;
        row_2 <= 8'd0;
        row_3 <= 8'd0;
        col_1 <= 8'd0;
        col_2 <= 8'd0;
        col_3 <= 8'd0;
        done_3_3 <= 0;
        end
     end
  end
 // 결과값의 초기값이 무엇인지
  always @(rst or res_pe1 or res_pe4 or res_pe8 or res_pe9) 
  begin
    if(rst) 
    begin
        result11 <= 8'd0;
        result12 <= 8'd0;
        result21 <= 8'd0;
        result22 <= 8'd0;
      end
    else 
    begin
        result11 <= res_pe1;
        result12 <= res_pe4;
        result21 <= res_pe8;
        result22 <= res_pe9;
      end
  end
  
  
endmodule
