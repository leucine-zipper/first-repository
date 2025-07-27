
module single_pe_module(mat_in_11, mat_in_12, mat_in_13, mat_in_14, 
  mat_in_21, mat_in_22, mat_in_23, mat_in_24, 
  mat_in_31, mat_in_32, mat_in_33, mat_in_34, 
  mat_in_41, mat_in_42, mat_in_43, mat_in_44,
  kernel_11, kernel_12, kernel_13, 
  kernel_21, kernel_22, kernel_23, 
  kernel_31, kernel_32, kernel_33, clk, rst,
  conv_out_11, conv_out_12, conv_out_21, conv_out_22, done_single);


 input[7:0] mat_in_11, mat_in_12, mat_in_13, mat_in_14, 
  mat_in_21, mat_in_22, mat_in_23, mat_in_24, 
  mat_in_31, mat_in_32, mat_in_33, mat_in_34, 
  mat_in_41, mat_in_42, mat_in_43, mat_in_44,
  kernel_11, kernel_12, kernel_13, 
  kernel_21, kernel_22, kernel_23, 
  kernel_31, kernel_32, kernel_33;

  input clk, rst;
  output reg [7:0] conv_out_11, conv_out_12, conv_out_21, conv_out_22;
  output reg done_single;

  reg pe_rst;
  reg [1:0] pe_delay;
  

  wire [7:0] f[2:0][2:0];
  wire [7:0] in[0:3][0:3];
  reg [7:0] pe_input, pe_filter;
  wire [7:0] out;

  assign {in[0][0], in[0][1], in[0][2], in[0][3]} = {mat_in_11, mat_in_12, mat_in_13, mat_in_14};
  assign {in[1][0], in[1][1], in[1][2], in[1][3]} = {mat_in_21, mat_in_22, mat_in_23, mat_in_24};
  assign {in[2][0], in[2][1], in[2][2], in[2][3]} = {mat_in_31, mat_in_32, mat_in_33, mat_in_34};
  assign {in[3][0], in[3][1], in[3][2], in[3][3]} = {mat_in_41, mat_in_42, mat_in_43, mat_in_44};

  assign {f[2][2], f[2][1], f[2][0]} = {kernel_11, kernel_12, kernel_13};
  assign {f[1][2], f[1][1], f[1][0]} = {kernel_21, kernel_22, kernel_23};
  assign {f[0][2], f[0][1], f[0][0]} = {kernel_31, kernel_32, kernel_33};
  
  
  integer count;
  
  pe_module single_pe(.in1(pe_input), .in2(pe_filter), .clk(clk), .rst(pe_rst), .pass_right(), .pass_down(), .result(out));
  
  initial done_single <= 0;

  always @(posedge clk, posedge rst)
  begin
    if(rst == 1'b1)
      begin
        pe_rst <= 1'b1;
        count <= 10'd0;
        conv_out_11 <= 10'd0; conv_out_12 <= 10'd0; conv_out_21 <=10'd0; conv_out_22 <= 10'd0;
        pe_input <= 8'd0; pe_filter<= 8'd0;
        pe_delay <= 2'b00;
      end
    else
      begin
      if (pe_delay == 2'b10)
        pe_delay = pe_delay -1;
      else if(pe_delay == 2'b01)
        begin
            case(count/9)
              1: conv_out_11 = out;
              2: conv_out_12 = out;
              3: conv_out_21 = out;
              4: conv_out_22 = out;
            endcase
            pe_input=8'd0; pe_filter= 8'd0;
            pe_rst = 1'b1;
            pe_delay = pe_delay-1;
        end
      else if(pe_rst== 1'b1)
          pe_rst = 1'b0;
      else
        begin
          case(count)
          0:
            begin
              pe_input = in[0][0]; 
              pe_filter = f[0][0];
            end
          1:
            begin
              pe_input = in[0][1]; 
              pe_filter = f[0][1];
            end
          2:
            begin
              pe_input = in[0][2]; 
              pe_filter = f[0][2];
            end
          3:
            begin
              pe_input = in[1][0]; 
              pe_filter = f[1][0];
            end
          4:
            begin
              pe_input = in[1][1]; 
              pe_filter = f[1][1];
            end
          5:
            begin
              pe_input = in[1][2]; 
              pe_filter = f[1][2];
            end
          6:
            begin
              pe_input = in[2][0]; 
              pe_filter = f[2][0];
            end
          7:
            begin
              pe_input = in[2][1]; 
              pe_filter = f[2][1];
            end
          8:
            begin
             pe_input = in[2][2]; 
              pe_filter = f[2][2]; //conv_out_11
            end
          9:
            begin
             pe_input = in[0][1]; 
              pe_filter = f[0][0];
            end
          10:
            begin
              pe_input = in[0][2]; 
              pe_filter = f[0][1];
            end
          11:
            begin
              pe_input = in[0][3]; 
              pe_filter = f[0][2];
            end
          12:
            begin
              pe_input = in[1][1]; 
              pe_filter = f[1][0];
            end
          13:
            begin
              pe_input = in[1][2]; 
              pe_filter = f[1][1];
            end
          14:
            begin
              pe_input = in[1][3]; 
              pe_filter = f[1][2];
            end
          15:
            begin
              pe_input = in[2][1]; 
              pe_filter = f[2][0];
            end
          16:
            begin
              pe_input = in[2][2]; 
              pe_filter = f[2][1];
            end
          17:
            begin
              pe_input = in[2][3]; 
              pe_filter = f[2][2]; //conv_out_12
            end
          18:
            begin
              pe_input = in[1][0]; 
              pe_filter = f[0][0];
            end
          19:
            begin
              pe_input = in[1][1]; 
              pe_filter = f[0][1];
            end
          20:
            begin
              pe_input = in[1][2]; 
              pe_filter = f[0][2];
            end
          21:
            begin
              pe_input = in[2][0]; 
              pe_filter = f[1][0];
            end
          22:
            begin
              pe_input = in[2][1]; 
              pe_filter = f[1][1];
            end
          23:
            begin
              pe_input = in[2][2]; 
              pe_filter = f[1][2];
            end
          24:
            begin
              pe_input = in[3][0]; 
              pe_filter = f[2][0];
            end
          25:
            begin
              pe_input = in[3][1]; 
              pe_filter = f[2][1];
            end
          26:
            begin
              pe_input = in[3][2]; 
              pe_filter = f[2][2]; //conv_out_21
            end
          27:
            begin
              pe_input = in[1][1]; 
              pe_filter = f[0][0];
            end
          28:
            begin
              pe_input = in[1][2]; 
              pe_filter = f[0][1];
            end
          29:
            begin
              pe_input = in[1][3]; 
              pe_filter = f[0][2];
            end
          30:
            begin
              pe_input = in[2][1]; 
              pe_filter = f[1][0];
            end
          31:
            begin
              pe_input = in[2][2]; 
              pe_filter = f[1][1];
            end
          32:
            begin
              pe_input = in[2][3]; 
              pe_filter = f[1][2];
            end
          33:
            begin
              pe_input = in[3][1]; 
              pe_filter = f[2][0];
            end
          34:
            begin
              pe_input = in[3][2]; 
              pe_filter = f[2][1];
            end
          35:
            begin
              pe_input = in[3][3]; 
              pe_filter = f[2][2]; //conv_out_22
            end
	  36:
	    begin
	      done_single <=1 ;
	    end
          endcase     
         count = count + 1;
         if (count != 1'b0 && count % 9 == 0)
           pe_delay <= 2'b10;
        end   
      end
    end

endmodule
