.PHONY: assembler
compile-assembler: assembler/*.cpp assembler/*.h
	@echo "Compiling assembler"
	@g++ -std=c++11 assembler/fileparser.cpp assembler/assembler.cpp -o assembler/assembler.out
run-assembler: assembler/assembler.out
	@echo "Running assembler"
	@./assembler/assembler.out
assemble: compile-assembler run-assembler
assemble-debug: assembler/*
	@g++ -std=c++11 -g assembler/fileparser.cpp assembler/assembler.cpp -o assembler/assembler.out
	@gdb assembler/assembler.out
compile-single: processor_single_cycle/*.v
	@echo "Compiling Single Cycle Processor"
	@iverilog -o processor_single_cycle/my_design processor_single_cycle/*.v
run-single: processor_single_cycle/my_design
	@echo "Running Single Cycle Processor"
	@vvp processor_single_cycle/my_design
single: compile-single run-single
all: assemble single
