`include "src\\head.v"
module ext(ext_op,num,out);
  input  [1:0]     ext_op;
  input  [15:0]    num;
  output [31:0]    out;
  reg    [31:0]    out2;
  
  assign  out = (ext_op==`ZERO_EXT)?      {{16{1'b0}},num}:
                 (ext_op==`SIGN_EXT)?      {{16{num[15]}},num}:
                  (ext_op==`LUI_EXT)?     {num,{16{1'b0}}}:32'b0;

endmodule