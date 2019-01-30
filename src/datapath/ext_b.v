`include "src\\head.v"
module ext_be (op,in,be);
  input   [1:0]      op;
  input   [1:0]      in;
  output  [3:0]      be;
  
  assign be[0] = ((op == `SW) ||((op == `SB)&&(in == 2'b00)) ||((op == `SH)&&(in == 2'b00)));
  assign be[1] = ((op == `SW) ||((op == `SB)&&(in == 2'b01)) ||((op == `SH)&&(in == 2'b00)));
  assign be[2] = ((op == `SW) ||((op == `SB)&&(in == 2'b10)) ||((op == `SH)&&(in == 2'b10)));
  assign be[3] = ((op == `SW) ||((op == `SB)&&(in == 2'b11)) ||((op == `SH)&&(in == 2'b10)));
  
endmodule 