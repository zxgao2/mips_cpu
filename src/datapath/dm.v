
module dm_4k( addr, din, we, clk, dout, be);
  input       [13:2]          addr;
  input       [31:0]          din;
  input                       we;
  input                       clk;
  input       [3:0]           be;
  output      [31:0]          dout;
  
  reg         [31:0]          dm[3072:0];
  
   
  integer                  i;
  initial 
    for(i=0;i<=3072;i = i+1) dm[i] <= 0; 
    
    
  assign dout = dm[addr];
  
  always @(posedge clk)
   if (we)
     begin 
       if (&be == 1) dm[addr] <= din;
     else 
       if (be[0]&&be[1]) dm[addr][15:0] <= din[15:0];
     else 
       if (be[2]&&be[3]) dm[addr][31:16] <= din[15:0]; 
       else 
         begin 
           if (be[0]) dm[addr][7:0] <= din[7:0];
           if (be[1]) dm[addr][15:8] <= din[7:0];
           if (be[2]) dm[addr][23:16] <= din[7:0];
           if (be[3]) dm[addr][31:24] <= din[7:0];
           end
       end
     
endmodule 