module cp0(pc,din,hwint,sel,epc_we,wen,exlset,exlclr,clk,rst,intreq,epc,dout);
  input     [31:2]      pc;
  input     [31:0]      din;
  input     [15:10]     hwint;
  input     [4:0]       sel;
  input                 wen,exlset,exlclr,clk,rst,epc_we;
  output                intreq;
  output    [31:2]      epc;
  output    [31:0]      dout;
  
  reg       [31:2]      epc;
  reg       [31:0]      sr,cause,prid;
  
  assign intreq = |(hwint & sr[15:10]) & !sr[1] & sr[0]  ;
  assign dout = (sel == 12)?       sr:
                (sel == 13)?       cause:
                (sel == 14)?       epc:
                (sel == 15)?       prid:32'b0;
  always @(posedge clk)
     if (rst) 
       begin
           prid <= 'h12061161;
           sr <= {16'b0,6'h3f,8'b0,1'b0,1'b1};
         end
    else
      begin 
        cause <= {16'b0,hwint[15:10],10'b0};
        if (epc_we)epc <= pc;
      end
      
  always  @( posedge clk or posedge exlset or posedge exlclr )
        if(exlset)
          sr[1] <=  1'b1  ;
        else if(exlclr)
          sr[1] <=  1'b0  ;
        else 
          if(wen&&(sel == 12)) sr <= din;
            
endmodule          