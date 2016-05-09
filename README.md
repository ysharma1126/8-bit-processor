# 8-bit-processor

## Description
Built an 8-bit Single-cycle Processor (Data and Address are both 8 bits) capable of executing nested procedures, leaf procedures, signed addition, loops, and recursion.

## How to Use it
Programs are stored in the program/ directory. The assembler will prompt the user for the name of the assembly program file and it will output the machine code in a file named "output.bin" which is also stored in the /program directory. The processor verilog code will then read the machine code from "output.bin" and output the time, program counter, instruction, register values, and any written data to standard output. After you have written a program open a terminal in the root directory and run:
```bash
make all
```
This will compile/run the assembler and immediately compile/run the processor.

## Overview
### Root
+ SharmaPatelCavallaroDocumentationFinal.pdf : Documentation of Project, contains all information on processor
