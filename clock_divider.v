module clock_divider #(parameter DIV = 4)( 
	input wire clk_in,
	input wire rst,
	output reg clk_out
);

	reg [25:0] counter;

	always @(posedge clk_in or posedge rst) begin
		if (rst) begin
			counter <= 0;
			clk_out <= 0;
		end
		else begin
			if (counter >= DIV) begin
				clk_out <= ~clk_out;
				counter <= 0;
			end
			else begin
				counter <= counter + 1;
			end
		end
	end

endmodule
	