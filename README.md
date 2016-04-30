# 8-bit-processor

Built an 8-bit Single-cycle Processor (Data and Address are both 8 bits) capable of executing nested procedures, leaf procedures, signed addition, loops, and recursion. Tested by running both the Fibonacci and Factorial Algorithms. 

Datapath.jpg=Block Diagram of Datapath+ISA+Control Table

assembler.cpp= Utilizes file_parser.cpp, through 2 standard passes, to assemble an assembly program under our ISA (Demonstration programs are a factorial and fibonacci procedure) 

The outputted machine code is then read into memory, which is done by one of the many processor components coded in Verilog 

test_bench.v instantiates the modules in such a way to transform the individual processor components into the envisioned datapath

All of this is executed through the Makefile. 

Further work: 

1) Employ caching and pipelining (forwarding+stalling)
