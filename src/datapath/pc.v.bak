`include "src\\head.v"
module pc (npc,clk,rst,pc,we);
  input      [31:2]        npc;
  input                    clk;
  input                    rst;
  input                    we;
  output     [31:2]        pc;
  
  reg        [31:2]        pc2;
  
  wire [31:0]  pc_test;
  
  assign pc = pc2;
  assign pc_test = {pc,2'b00};
  always @(posedge clk or posedge rst)
      if (rst)  pc2 <= 'b000000000000000000110000000000;
      else 
        if (we)
          pc2 <= npc;
endmodule 