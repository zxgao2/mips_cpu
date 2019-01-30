
module gpr(regwr,busw,rw,ra,rb,rst,clk,busa,busb);
  input                   regwr;
  input       [31:0]      busw;
  input       [4:0]       rw;
  input       [4:0]       ra;
  input       [4:0]       rb;
  input                   rst;
  input                   clk;
  
  output      [31:0]      busa;
  output      [31:0]      busb;
  
  reg         [31:0]      regfile [31:0];
 
  integer                  i;
  
  
  assign busa = regfile[ra];
  assign busb = regfile[rb];
  
  
   always @ (posedge clk or posedge rst)
     if (rst) for(i=0;i<=31;i = i+1) regfile[i] <= 0;
     else 
       if (regwr)
         regfile[rw] <= busw;
endmodule 