`include "src\\head.v"
module npc(npc_op,pc,imm26,zero,pc_reg,pc_4,npc,epc);
  input     [3:0]         npc_op;
  input     [31:2]        pc;
  input     [31:2]        epc;
  input     [25:0]        imm26;
  input     [31:0]        zero;
  input     [31:0]        pc_reg;
  output    [31:2]        pc_4;
  output    [31:2]        npc;
  //
  wire       [15:0]        imm16;
  wire                    zero2;
  wire                    zero3;
  
  assign pc_4 = pc + 1;
  assign imm16 = imm26[15:0];
  assign zero2 = |zero;
  assign zero3 = |pc_reg;
  
  assign npc = (npc_op == `PC_J)?        {{pc[31:28]},{imm26[25:0]}}:
               (npc_op == `PC_JAL)?      {{pc[31:28]},{imm26[25:0]}}:
               (npc_op == `PC_BEQ)?      (zero2 == 0)?    pc+imm16:pc:
               (npc_op == `PC_BLEZ)?     ((pc_reg[31] == 1)||(zero3 == 0))? pc+imm16:pc:
               (npc_op == `PC_BGEZ)?     (pc_reg[31] == 0)? pc+imm16:pc:
               (npc_op == `PC_BGTZ)?     ((pc_reg[31] == 0)&&(zero3 == 1))? pc+imm16:pc:
               (npc_op == `PC_BLTZ)?     (pc_reg[31] == 1)? pc+imm16:pc:
               (npc_op == `PC_BNE)?      (zero2 == 1)?    pc+imm16:pc:
               (npc_op == `PC_JALR)?       pc_reg[31:2]:
               (npc_op == `PC_ERET)?       epc:
               (npc_op == `PC_BREAK)?       'b100000110000000:
               (npc_op == `PC_JR)?       pc_reg[31:2]:  pc+1;
  
  
 endmodule
  
  
  