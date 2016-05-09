# 8-bit-processor

##Description
Built an 8-bit Single-cycle Processor (Data and Address are both 8 bits) capable of executing nested procedures, leaf procedures, signed addition, loops, and recursion.

##How to Use it
Programs are stored in the program/ directory. The assembler will prompt the user for the name of the assembly program file and it will output the machine code in a file named "output.bin" which is also stored in the /program directory. The processor verilog code will then read the machine code from "output.bin" and output the time, program counter, instruction, register values, and any written data to standard output. After you have written a program open a terminal in the root directory and run:
```bash
make all
```
This will compile/run the assembler and immediately compile/run the processor.

## Overview
###Root
+ Datapath.jpg : Block Diagram of Datapath and Table of Control Values
###Assembler
The Assembler utilizes three passes to convert the assembly code to machine code. On the first pass, it stores data and indexes all the labels used. On the second pass, it replaces labels on jump and branch-if-equal commands with the appropriate binary values.
+ fileparser.cpp : Contains functions used to parse assembly code and convert to machine code.
+ assembler.cpp  : Main assembler function that invokes appropriate functions from fileparser.cpp 
###Processor Single Cycled
The proccessor is completely made in verilog. There is a separate module for every component of the datapath and controlpath.
+ test_bench.v : Instantiates the modules in such a way to transform the individual processor components into the envisioned datapath.
