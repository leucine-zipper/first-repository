module controller(
    input rst, clk,
    input [2:0] mode_num,
    output reg enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display
);

  //parameter
  parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;

  // reg for state
  reg [2:0] state;


  // State register + next-state logic
  always @(posedge clk or posedge rst) begin
    if (rst)
      state <= S0;
    else begin
      case (state)
        S0 : state <= S1;
        S1 : if (mode_num == 3'b001) state <= S2;
        S2 : if (mode_num == 3'b010) state <= S3;
        S3 : if (mode_num == 3'b011) state <= S4;
        S4 : if (mode_num == 3'b100) state <= S5;
        S5 : state <= S5; //? stay in S5 forever
        default: state <= S0;
      endcase
    end
  end


// Output logic
  always @(state) begin
    {enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display} <= 5'b11111;
    case (state)
      S1: {enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display} <= 5'b01111;
      S2: {enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display} <= 5'b00111; 
      S3: {enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display} <= 5'b00011; 
      S4: {enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display} <= 5'b00001; 
      S5: {enable_memory, enable_singlePE, enable_SA3x3, enable_SA2x2, enable_display} <= 5'b00000; 
    endcase
  end
endmodule
