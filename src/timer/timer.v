module timer(clk,rst,addr,we,din,dout,irq);
  input                clk,rst,we;
  input     [31:0]     din;
  input     [3:2]      addr;
  output    [31:0]     dout;
  output               irq;
  
  reg       [31:0]     ctrl,preset,count;
  reg                  count_en;
  
  wire                 im,enable;
  wire      [2:1]      mode;
  
  assign     im        = ctrl[3:3];
  assign     enable    = ctrl[0:0];
  assign     mode      = ctrl[2:1];
  
  assign     irq       = (count == 0)&&(mode == 0)&&(im == 1) ;
  assign     dout      = (addr == 2'b00)?        ctrl:
                         (addr == 2'b01)?        preset:
                         (addr == 2'b10)?        count:count;
  
  always @ (posedge clk)
    if (rst) begin ctrl <= 0;preset <= 0;count <= 0; end
    else 
      if (enable) 
        if (count == 0)
          case (mode)
            2'b00       :  if (count_en) count <= preset;
            2'b01       :  count <= preset;
            default     :  count <= 0;
          endcase
        else count <= count -1;

  always @ (posedge clk)
        if (we) 
          case (addr)
            2'b00   :   ctrl <= din;
            2'b01   :   begin count_en <= 1;preset <= din;end
            default :   ctrl <= ctrl;
          endcase
        else count_en <=0;
  
endmodule