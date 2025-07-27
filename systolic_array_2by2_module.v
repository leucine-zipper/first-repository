module systolic_array_2by2_module (mat_input11,mat_input12,mat_input13,mat_input14,
                                   mat_input21,mat_input22,mat_input23,mat_input24,
                                   mat_input31,mat_input32,mat_input33,mat_input34,
                                   mat_input41,mat_input42,mat_input43,mat_input44, 
                                        filter11,filter12,filter13,
                                        filter21,filter22,filter23,
                                        filter31,filter32,filter33, 
                               result11,result12,result21,result22,
                               done_2_2,
                                                          clk,rst);
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
    output reg done_2_2;
//

  parameter DUMMY_ZERO = 8'd0;
  parameter DATA_FEED_CYCLES = 4'd14;


  wire [7:0] row_input_1[0:14], row_input_2[0:14], col_input_1[0:14], col_input_2[0:14];
  reg [7:0] row_1, row_2, col_1, col_2; 
  wire [7:0] res_pe_1, res_pe_2, res_pe_3, res_pe_4; 
  wire [7:0] row_pe1, row_pe3, 
             col_pe1, col_pe2; 
  reg [4:0] cnt; 
//
  initial done_2_2 <= 0;

  assign row_input_1[0] = mat_input11; assign row_input_1[1] = mat_input12; assign row_input_1[2] = mat_input13; 
  assign row_input_1[3] = mat_input14; assign row_input_1[4] = mat_input21; assign row_input_1[5] = mat_input22; 
  assign row_input_1[6] = mat_input23; assign row_input_1[7] = mat_input24; assign row_input_1[8] = mat_input31; 
  assign row_input_1[9] = mat_input32; assign row_input_1[10] = mat_input33; assign row_input_1[11] = mat_input34;
  assign row_input_1[12] = DUMMY_ZERO; assign row_input_1[13] = DUMMY_ZERO; assign row_input_1[14] = DUMMY_ZERO;

  assign row_input_2[0] = DUMMY_ZERO; assign row_input_2[1] = mat_input21; assign row_input_2[2] = mat_input22; 
  assign row_input_2[3] = mat_input23; assign row_input_2[4] = mat_input24; assign row_input_2[5] = mat_input31; 
  assign row_input_2[6] = mat_input32; assign row_input_2[7] = mat_input33; assign row_input_2[8] = mat_input34; 
  assign row_input_2[9] = mat_input41; assign row_input_2[10] = mat_input42; assign row_input_2[11] = mat_input43;
  assign row_input_2[12] = mat_input44; assign row_input_2[13] = DUMMY_ZERO; assign row_input_2[14] = DUMMY_ZERO;

  assign col_input_1[0] = filter33; assign col_input_1[1] = filter32; assign col_input_1[2] = filter31; 
  assign col_input_1[3] = DUMMY_ZERO; assign col_input_1[4] = filter23; assign col_input_1[5] = filter22; 
  assign col_input_1[6] = filter21; assign col_input_1[7] = DUMMY_ZERO; assign col_input_1[8] = filter13; 
  assign col_input_1[9] = filter12; assign col_input_1[10] = filter11; assign col_input_1[11] = DUMMY_ZERO; 
  assign col_input_1[12] = DUMMY_ZERO; assign col_input_1[13] = DUMMY_ZERO; assign col_input_1[14] = DUMMY_ZERO;

  assign col_input_2[0] = DUMMY_ZERO; assign col_input_2[1] = DUMMY_ZERO; assign col_input_2[2] = filter33; assign col_input_2[3] = filter32;
  assign col_input_2[4] = filter31; assign col_input_2[5] = DUMMY_ZERO; assign col_input_2[6] = filter23; assign col_input_2[7] = filter22;
  assign col_input_2[8] = filter21; assign col_input_2[9] = DUMMY_ZERO; assign col_input_2[10] = filter13; assign col_input_2[11] = filter12;
  assign col_input_2[12] = filter11; assign col_input_2[13] = DUMMY_ZERO; assign col_input_2[14] = DUMMY_ZERO;

//
pe_module pe_1(.clk(clk), .rst(rst), .in1(row_1), .in2(col_1), .pass_right(row_pe1), .pass_down(col_pe1), .result(res_pe_1));
pe_module pe_2(.clk(clk), .rst(rst), .in1(row_pe1), .in2(col_2), .pass_right(), .pass_down(col_pe2), .result(res_pe_2));
pe_module pe_3(.clk(clk), .rst(rst), .in1(row_2), .in2(col_pe1), .pass_right(row_pe3), .pass_down(), .result(res_pe_3));
pe_module pe_4(.clk(clk), .rst(rst), .in1(row_pe3), .in2(col_pe2), .pass_right(), .pass_down(), .result(res_pe_4));
//

  always @(posedge clk or posedge rst)
  begin
    if(rst)
      begin
        cnt <= 8'd0;
        row_1 <= 8'd0;
        row_2 <= 8'd0;
        col_1 <= 8'd0;
        col_2 <= 8'd0;
        done_2_2 <= 0;
      end
    else
    begin
      if (cnt <= DATA_FEED_CYCLES)
        begin
        cnt <= cnt + 1;
        row_1 <= row_input_1[cnt];
        row_2 <= row_input_2[cnt];
        col_1 <= col_input_1[cnt];
        col_2 <= col_input_2[cnt];
        done_2_2 <= 0;
        end
      
      else if (cnt == DATA_FEED_CYCLES + 1) begin
        //연산 완료 후 한번만 done 신호 올림
        done_2_2 <= 1;
      end
      else begin
        row_1 <= 8'd0;
        row_2 <= 8'd0;
        col_1 <= 8'd0;
        col_2 <= 8'd0;
        done_2_2 <= 0;
        end
    end
  end

  always @(rst or res_pe_1 or res_pe_2 or res_pe_3 or res_pe_4)
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
        result11 <= res_pe_1;
        result12 <= res_pe_2;
        result21 <= res_pe_3;
        result22 <= res_pe_4;
      end
  end
    
endmodule

