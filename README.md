# UART DPI with pseudo-terminal

This module is a SystemVerilog module with a UART interface
(`tx`/`rx`). It used DPI to start a pseudo-terminal (`/dev/pts/<n>`)
that can then be opened with a terminal program.

There can be multiple instances of this module in a design, each with
its own pseudo-terminal.

## Testbench (echo)

### Vivado xsim

    cd tbench/xsim
    make sim
