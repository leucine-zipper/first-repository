`timescale 1ns / 1ps

module seven_segment_tb;
	
	reg clk;
	reg rst;
	reg [7:0] value;

	wire [7:0] digit_select;
	wire [7:0] segment_output;

	seven_segment uut (
		.clk(clk),
		.rst(rst),
		.value(value),
		.digit_select(digit_select),
		.segment_output(segment_output)
	);

	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end

	initial begin
		rst = 1;
		value = 8'd0;

		#30;
		rst = 0;
		
		value = 8'd0;
		#600;

		value = 8'd37;
		#600;
	
		value = 8'd128;
		#600;

		value = 8'd255;
		#600;

		rst = 1;
		#50;
		rst = 0;

		value = 8'd64;
		#600;

		$finish;  
	end

endmodule
	 

