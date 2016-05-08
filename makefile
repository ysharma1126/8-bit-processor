.PHONY:  assembler
compile-assembler: assembler/*.cpp assembler/*.h
	@echo "Compiling assembler"
	@g++ -std=c++11 assembler/fileparser.cpp assembler/assembler.cpp -o assembler/assembler.out
run-assembler: assembler/assembler.out
	@echo "Running assembler"
	@./assembler/assembler.out
assemble: compile-assembler run-assembler
assemble-debug:
	@g++ -std=c++11 -g assembler/fileparser.cpp assembler/assembler.cpp -o assembler/assembler.out
	@gdb assembler/assembler.out
