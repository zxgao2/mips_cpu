 `include "src\\head.v"
module reg_1(din,dout,clk);
  input  [31:0]           din;
  input                   clk;
  output [31:0]           dout;

  reg    [31:0]           r;
  
  assign dout = r;
  
  always @(posedge clk)
     r <= din;
endmodule
    
module reg_2(din,dout,we,clk);
  input  [31:0]           din;
  input                   clk;
  input                   we;
  output [31:0]           dout;

  reg    [31:0]           r;
  
  assign dout = r;
  
  always @(posedge clk)
    if (we) r <= din;
endmodule

   
module reg_dm(din,dout,op,in,clk);
  input   [31:0]           din;
  input                    clk;
  output  [31:0]           dout;
  input   [2:0]            op;
  input   [1:0]            in;
  
  reg    [31:0]           r;
  wire   [31:0]           r1;
  assign dout = r;
  assign r1 = (op == `LW)?                         din: 
              ((op == `LB)&&(in == 2'b00))?           {{24{din[7]}},din[7:0]}:
              ((op == `LB)&&(in == 2'b01))?           {{24{din[15]}},din[15:8]}:
              ((op == `LB)&&(in == 2'b10))?           {{24{din[23]}},din[23:16]}:
              ((op == `LB)&&(in == 2'b11))?           {{24{din[31]}},din[31:24]}:
              
              ((op == `LBU)&&(in == 2'b00))?          {{24'b0},din[7:0]}:
              ((op == `LBU)&&(in == 2'b01))?          {{24'b0},din[15:8]}:
              ((op == `LBU)&&(in == 2'b10))?          {{24'b0},din[23:16]}:
              ((op == `LBU)&&(in == 2'b11))?          {{24'b0},din[31:24]}:
              
              ((op == `LH)&&(in == 2'b00))?          {{16{din[15]}},din[15:0]}:
              ((op == `LH)&&(in == 2'b10))?          {{16{din[31]}},din[31:16]}:
              
              ((op == `LHU)&&(in == 2'b00))?          {16'b0,din[15:0]}:
              ((op == `LHU)&&(in == 2'b10))?          {16'b0,din[31:16]}:0;
              
              
  always @ (posedge clk)
    r <= r1;
endmodule    