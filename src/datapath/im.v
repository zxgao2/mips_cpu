
module im_4k( addr, dout);
  input         [12:2]       addr;
  output        [31:0]       dout;
  
  reg           [31:0]       im[2047:0];
  
  initial 
   $readmemh("src\\code.txt",im);
   
   assign dout = im[addr];
   
endmodule 
  