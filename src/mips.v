
module mips(clk,rst,praddr,prdin,prdout,dm_we,hwint);
  input                       clk,rst;
  input        [31:0]         prdin;
  output       [31:0]         praddr,prdout;
  output                      dm_we;
  input        [7:2]          hwint;
  
  
  wire     [31:2]        pc,pc_4;
  wire     [31:0]        dm_out2,instr,hi,lo,instr2,alu_out,alu_out1,busa,busa1,busb1,busb,busw,dm_out1,dm_out,pc_4_32,ext_out,alu_num2;
  wire     [31:2]        npc;
  wire     [1:0]         ext_op;
  wire     [3:0]         alu_op;
  wire                   alu_sel;
  wire     [2:0]         busw_sel;
  wire     [1:0]         rw_sel;
  wire     [3:0]         npc_op;
  wire                   regwr;
  wire     [4:0]         rw;
  wire                   pc_wr;
  wire     [3:0]         be;
  wire      [1:0]         store_op;
  wire     [2:0]         load_op,mult_op;
  wire                   hit_dm,intreq,cp0_we,exlset,exlclr,epc_we;
  
  assign pc_4_32 = {pc_4,2'b00};
  assign praddr = alu_out;
  assign prdout = busb;
  assign hit_dm = (alu_out <'h7f00) ||((alu_out > 'h7f0b)&&(alu_out < 'h2fff));
  
  
  pc                U_PC(npc,clk,rst,pc,pc_wr);
  im_8k             U_IM(pc[12:2], instr2);
  reg_2             irr(instr2,instr,irr_wr,clk);
  control           my_control(instr,ext_op,alu_op,alu_sel,busw_sel,rw_sel,npc_op,regwr,dm_we,load_op,store_op,pc_wr,irr_wr,clk,rst,mult_op,intreq,cp0_we,exlset,exlclr,epc_we);
  npc               my_npc(npc_op,pc,instr[25:0],alu_out1,busa,pc_4,npc,epc);
  gpr               U_RF(regwr,busw,rw,instr[25:21],instr[20:16],rst,clk,busa1,busb1);
  reg_1             a(busa1,busa,clk);
  reg_1             b(busb1,busb,clk);
  mul_3_5           my_rw_mul(rw_sel,instr[20:16],instr[15:11],5'b11111,rw);
  mul_6_32          my_busw_mul(busw_sel,alu_out,dm_out,{pc,2'b00},hi,lo,cp0_out,busw);
  ext               my_ext(ext_op,instr[15:0],ext_out);
  mul_2_32          my_alu_mul(alu_sel,busb,ext_out,alu_num2);
  alu               my_alu(alu_op,busa,alu_num2,instr[10:6],alu_out1);
  reg_1             alu_reg(alu_out1,alu_out,clk);
  ext_be            my_ext_store(store_op,alu_out[1:0],be);
  dm_12k            U_DM( alu_out[13:2], busb, dm_we&&hit_dm, clk, dm_out1,be);
  reg_dm            my_reg_dm(dm_out1,dm_out2,load_op,alu_out[1:0],clk);
  mul_2_32          my_alu_mul2(hit_dm,prdin,dm_out2,dm_out);
  mult              my_mult(mult_op,busa1,busb1,hi,lo);
  cp0               my_cp0(npc,busb,hwint,instr[15:11],epc_we,cp0_we,exlset,exlclr,clk,rst,intreq,epc,cp0_out);
endmodule