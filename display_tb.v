`timescale 1ns / 1ps

module display_tb;

	reg clk;
	reg rst;
	reg [7:0] in_3x3_11, in_3x3_12, in_3x3_21, in_3x3_22;
	reg [7:0] in_2x2_11, in_2x2_12, in_2x2_21, in_2x2_22;

	wire [7:0] digit_select;
	wire [7:0] segment_output;

	display uut (
		.clk(clk),
		.rst(rst), 
		.sa_3x3_11(in_3x3_11), .sa_3x3_12(in_3x3_12),
		.sa_3x3_21(in_3x3_21), .sa_3x3_22(in_3x3_22),
		.sa_2x2_11(in_2x2_11), .sa_2x2_12(in_2x2_12),
		.sa_2x2_21(in_2x2_21), .sa_2x2_22(in_2x2_22),
		.digit_select(digit_select),
		.segment_output(segment_output)
	);

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1;
		in_3x3_11 = 8'd0;
		in_3x3_12 = 8'd0;
		in_3x3_21 = 8'd0;
		in_3x3_22 = 8'd0;
		in_2x2_11 = 8'd0;
		in_2x2_12 = 8'd0;
		in_2x2_21 = 8'd0;
		in_2x2_22 = 8'd0;

		#20 rst = 0;

		#10;
		in_3x3_11 = 8'd12;
		in_3x3_12 = 8'd24;
		in_3x3_21 = 8'd35;
		in_3x3_22 = 8'd42;
		in_2x2_11 = 8'd53;
		in_2x2_12 = 8'd65;
		in_2x2_21 = 8'd78;
		in_2x2_22 = 8'd84;

		#20000;

		#10000;

		in_3x3_11 = 8'd102;
		in_3x3_12 = 8'd113;
		in_3x3_21 = 8'd124;
		in_3x3_22 = 8'd135;
		in_2x2_11 = 8'd146;
		in_2x2_12 = 8'd157;
		in_2x2_21 = 8'd168;
		in_2x2_22 = 8'd179;

		#20000;

		$stop;
	end

endmodule
