module bridge(praddr,prrd,prwd,cpu_we,dev1_addr,dev1_we,dev1_wd,dev1_rd);
  input     [31:0]     praddr,prwd,dev1_rd;
  input                cpu_we;
  output    [31:0]     dev1_wd,prrd;
  output    [3:2]      dev1_addr;
  output               dev1_we;
  wire                 hit1;
   
  assign  hit1 = (praddr >= 'h7f00)&&(praddr <= 'h7f0b);
  assign  dev1_we = cpu_we&&hit1;
  
  assign dev1_addr = praddr[3:2];
  assign dev1_wd = prwd;
   
  assign prrd = (hit1)?     dev1_rd:'h12061161;
  
endmodule 