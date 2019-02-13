/**
 * SPDX-License-Identifier: Apache-2.0
 *
 * Copyright 2016 by the authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
