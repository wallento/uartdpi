`timescale 1ps/1ps

module tb_uartdpi;

   logic clk, rst, tx, rx;

   uartdpi
     #(.BAUD(115200), .FREQ(100000000))
     u_uart(.*);

   assign rx = tx;

   initial begin
      clk = 0;
      rst = 1;
      #20000;
      rst = 0;
   end

   always
     #5000 clk = ~clk;

endmodule
