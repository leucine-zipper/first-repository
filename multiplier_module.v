module multiplier_module (a, b, outC);
  input [7:0] a, b;
  
  output [7:0] outC;
  
  wire [15:0] mul_16;
  
  assign mul_16 = a * b;
  assign outC = mul_16[7:0];
  
endmodule



