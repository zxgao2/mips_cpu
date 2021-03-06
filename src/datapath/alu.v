`include "src\\head.v"
module alu(alu_op,num1,num2,sa,out);
  input [10:6]       sa;
  input [3:0]        alu_op;
  input [31:0]       num1;
  input [31:0]       num2;
  output [31:0]      out;
  wire   [31:0]      t;
  wire   [63:0]      t2;
  wire   [63:0]      t_sra;
  wire   [63:0]      t_srav;
  
  assign t =  num1-num2;
  assign t2 = {{32{num2[31]}},num2};
  assign t_sra = t2>>sa;
  assign t_srav = t2>>num1; 
  
  assign out =  (alu_op == `ALU_ADD)?     num1+num2:
                (alu_op == `ALU_SUB)?     num1-num2:
                (alu_op == `ALU_OR)?     num1|num2:
                (alu_op == `ALU_XOR)?     num1^num2:
                (alu_op == `ALU_AND)?     num1&num2:
                (alu_op == `ALU_NOR)?     ~(num1|num2):
                (alu_op == `ALU_SLTU)?    (num1<num2)? 1:0:
                (alu_op == `ALU_SLL)?     num2<<sa:
                (alu_op == `ALU_SRL)?     num2>>sa:
                (alu_op == `ALU_SRA)?     t_sra[31:0]:
                (alu_op == `ALU_SRAV)?     t_srav[31:0]:
                
                (alu_op == `ALU_SRLV)?     num2>>num1:
                (alu_op == `ALU_SLLV)?     num2<<num1:
                (alu_op == `ALU_SLT)?      t[31]:0;
                
                

    
endmodule    