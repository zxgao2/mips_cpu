module mul_2_32(op,num1,num2,out);
  input              op;
  input   [31:0]     num1;
  input   [31:0]     num2;
  output  [31:0]     out;
  
  assign out = (op=='b0)?   num1:num2;
endmodule 

module mul_6_32(op,num1,num2,num3,num4,num5,num6,out);
  input      [2:0]            op;
  input      [31:0]       num1,num2,num3,num4,num5,num6;
  output     [31:0]       out;
  
  
  assign out = (op == 3'b000)? num1:
               (op == 3'b001)? num2:
               (op == 3'b010)? num3:
               (op == 3'b011)? num4:
               (op == 3'b100)? num5:
               (op == 3'b101)? num6:num6;

endmodule 
      

module mul_3_5(op,num1,num2,num3,out);
  input      [1:0]            op;
  input      [4:0]       num1,num2,num3;
  output     [4:0]       out;

  
  assign out = (op == 2'b00)? num1:
               (op == 2'b01)? num2:
               (op == 2'b10)? num3:num3;

    
endmodule 