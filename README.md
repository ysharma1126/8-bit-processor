# 8-bit-processor

Built an 8-bit Single-cycle Processor (Data and Address are both 8 bits) capable of executing nested procedures, leaf procedures, signed addition, loops, and recursion

Datapath.jpg=Block Diagram of Datapath+ISA+Control Table

assembler.c= Utilizes file_parser.c, which utilizes the hashing header files, to assemble an assembly program under our ISA 

The outputted machine code is then read into memory, which is one of the many processor components coded in Verilog 

test_bench.v instantiates the modules in such a way to transform the individual processor components into the envisioned datapath

Further work: 

1) Burn Verilog into PLD to employ a physical version of our processor

2) Write a compiler which compiles C code down to assembly code which can be assembled by our assembler

3) Rather than the simple implementation of byte-addressable data memory used, employ proper caching and a memory hierarchy

4) PIPELINE IT!
