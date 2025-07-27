`timescale 1ns/1ps

module seven_segment (
	input wire clk,
	input wire rst,
	input wire [7:0] value,
	output reg [7:0] digit_select,
	output reg [7:0] segment_output
);

	wire slow_clk_1;
	reg [3:0] digit_arr [2:0]; //digit_arr[2] = hundreds, [1] = tens, [0] = ones
	reg [3:0] current_digit;
	
	clock_divider #(4) clk_div_1 (.clk_in(clk), .rst(rst), .clk_out(slow_clk_1)); //99999 for FPGA

	always @(*) begin
		digit_arr[2] = value / 100;
		digit_arr[1] = (value % 100) / 10;
		digit_arr[0] = value % 10;
	end

	always @(posedge slow_clk_1 or posedge rst) begin
		if (rst)
			digit_select <= 8'b0000_0100;
		else begin
			case (digit_select)
				8'b0000_0100: digit_select <= 8'b0000_0010;
				8'b0000_0010: digit_select <= 8'b0000_0001;
				8'b0000_0001: digit_select <= 8'b0000_0100;
				default:      digit_select <= 8'b0000_0100;
			endcase
		end
	end

	always @(*) begin
		if (rst)
			current_digit = 4'd0;
		else begin
			case (digit_select)
				8'b0000_0100: current_digit = digit_arr[2];
				8'b0000_0010: current_digit = digit_arr[1];
				8'b0000_0001: current_digit = digit_arr[0];
				default:      current_digit = 4'd0;
			endcase
		end
	end

	always @(*) begin
		if (rst)
			segment_output = 8'd0;
		else begin
			case (current_digit)
				4'd0: segment_output = 8'b1111_1100;
				4'd1: segment_output = 8'b0110_0000;
				4'd2: segment_output = 8'b1101_1010;
				4'd3: segment_output = 8'b1111_0010;
				4'd4: segment_output = 8'b0110_0110;
				4'd5: segment_output = 8'b1011_0110;
				4'd6: segment_output = 8'b1011_1110;
				4'd7: segment_output = 8'b1110_0100;
				4'd8: segment_output = 8'b1111_1110;
				4'd9: segment_output = 8'b1111_0110;
				default: segment_output = 8'b0000_0000;
			endcase
		end
	end

endmodule
