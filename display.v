`timescale 1ns / 1ps

module display (
	input clk,
	input rst,
	input [7:0] sa_3x3_11, sa_3x3_12, sa_3x3_21, sa_3x3_22,
	input [7:0] sa_2x2_11, sa_2x2_12, sa_2x2_21, sa_2x2_22,

	output [7:0] digit_select,
	output [7:0] segment_output
);
	
	wire slow_clk_2;
	clock_divider #(12500) clk_div_2 (.clk_in(clk), .rst(rst),.clk_out(slow_clk_2)); //49999999 for FPGA

	wire [7:0] result_data [0:7];
	assign result_data[0] = sa_3x3_11;
	assign result_data[1] = sa_3x3_12;
	assign result_data[2] = sa_3x3_21;
	assign result_data[3] = sa_3x3_22;
	assign result_data[4] = sa_2x2_11;
	assign result_data[5] = sa_2x2_12;
	assign result_data[6] = sa_2x2_21;
	assign result_data[7] = sa_2x2_22;

	reg [2:0] idx;
	
	always @(posedge slow_clk_2 or posedge rst) begin
		if (rst)
			idx <= 3'd0;
		else
			idx <= (idx == 3'd7) ? 3'd0 : idx + 1;
	end

	seven_segment segment_driver (
		.clk(clk),
		.rst(rst),
		.value(result_data[idx]),
		.digit_select(digit_select),
		.segment_output(segment_output)
	);

endmodule


