
module testbench();
  reg    clk,rst;
  
  
  mips my_mips(clk,rst);
  
  initial 
      begin 
        clk = 0;
        rst = 1;
        # 10 rst = 0;
        #1000000;
        $stop;
      end
      
      always #(10) clk = ~clk ;
    endmodule 