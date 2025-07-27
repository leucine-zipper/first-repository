module memory(
    input clk,
    input rst,
    input [7:0] in_1, in_2, in_3, in_4,
    input [7:0] in_5, in_6, in_7, in_8, 
    input [7:0] in_9, in_10, in_11, in_12,
    input [7:0] in_13, in_14, in_15, in_16, 
    input [7:0] f_1, f_2, f_3, f_4, f_5, f_6, f_7, f_8, f_9,
    
    output reg [7:0] out_in_1, out_in_2, out_in_3, out_in_4,
    output reg [7:0] out_in_5, out_in_6, out_in_7, out_in_8, out_in_9,
    output reg [7:0] out_in_10, out_in_11, out_in_12, out_in_13, out_in_14,
    output reg [7:0] out_in_15, out_in_16, out_f_1, out_f_2, out_f_3,
    output reg [7:0] out_f_4, out_f_5, out_f_6, out_f_7, out_f_8, out_f_9,
    output reg done_memory
);

    reg [7:0] matrix_in_1, matrix_in_2, matrix_in_3, matrix_in_4;
    reg [7:0] matrix_in_5, matrix_in_6, matrix_in_7, matrix_in_8;
    reg [7:0] matrix_in_9, matrix_in_10, matrix_in_11, matrix_in_12;
    reg [7:0] matrix_in_13, matrix_in_14, matrix_in_15, matrix_in_16;
    reg [7:0] matrix_f_1, matrix_f_2, matrix_f_3, matrix_f_4;
    reg [7:0] matrix_f_5, matrix_f_6, matrix_f_7, matrix_f_8, matrix_f_9;

    reg [1:0] save;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all memory registers to 0
            matrix_in_1 <= 8'b0;  matrix_in_2 <= 8'b0;  matrix_in_3 <= 8'b0;  matrix_in_4 <= 8'b0;
            matrix_in_5 <= 8'b0;  matrix_in_6 <= 8'b0;  matrix_in_7 <= 8'b0;  matrix_in_8 <= 8'b0;
            matrix_in_9 <= 8'b0;  matrix_in_10 <= 8'b0;  matrix_in_11 <= 8'b0;  matrix_in_12 <= 8'b0;
            matrix_in_13 <= 8'b0;  matrix_in_14 <= 8'b0;  matrix_in_15 <= 8'b0;  matrix_in_16 <= 8'b0;
            matrix_f_1 <= 8'b0;  matrix_f_2 <= 8'b0;  matrix_f_3 <= 8'b0;  matrix_f_4 <= 8'b0;
            matrix_f_5 <= 8'b0;  matrix_f_6 <= 8'b0;  matrix_f_7 <= 8'b0;  matrix_f_8 <= 8'b0;
            matrix_f_9 <= 8'b0;

            save <= 2'b01;
            done_memory <= 0;
        end else begin
            case (save)
                2'b01: begin
                    // Store inputs to internal memory registers
                    matrix_in_1 <= in_1;   matrix_in_2 <= in_2;   matrix_in_3 <= in_3;   matrix_in_4 <= in_4;
                    matrix_in_5 <= in_5;   matrix_in_6 <= in_6;   matrix_in_7 <= in_7;   matrix_in_8 <= in_8;
                    matrix_in_9 <= in_9;   matrix_in_10 <= in_10; matrix_in_11 <= in_11; matrix_in_12 <= in_12;
                    matrix_in_13 <= in_13; matrix_in_14 <= in_14; matrix_in_15 <= in_15; matrix_in_16 <= in_16;

                    matrix_f_1 <= f_1;   matrix_f_2 <= f_2;   matrix_f_3 <= f_3;   matrix_f_4 <= f_4;
                    matrix_f_5 <= f_5;   matrix_f_6 <= f_6;   matrix_f_7 <= f_7;   matrix_f_8 <= f_8;
                    matrix_f_9 <= f_9;

                    save <= 2'b00;
                end
                2'b00: begin
                    // Output stored memory values
                    out_in_1 <= matrix_in_1;   out_in_2 <= matrix_in_2;   out_in_3 <= matrix_in_3;   out_in_4 <= matrix_in_4;
                    out_in_5 <= matrix_in_5;   out_in_6 <= matrix_in_6;   out_in_7 <= matrix_in_7;   out_in_8 <= matrix_in_8;
                    out_in_9 <= matrix_in_9;   out_in_10 <= matrix_in_10; out_in_11 <= matrix_in_11; out_in_12 <= matrix_in_12;
                    out_in_13 <= matrix_in_13; out_in_14 <= matrix_in_14; out_in_15 <= matrix_in_15; out_in_16 <= matrix_in_16;

                    out_f_1 <= matrix_f_1;   out_f_2 <= matrix_f_2;   out_f_3 <= matrix_f_3;   out_f_4 <= matrix_f_4;
                    out_f_5 <= matrix_f_5;   out_f_6 <= matrix_f_6;   out_f_7 <= matrix_f_7;   out_f_8 <= matrix_f_8;
                    out_f_9 <= matrix_f_9;

                    done_memory <= 1;
                end
            endcase
        end
    end

endmodule
