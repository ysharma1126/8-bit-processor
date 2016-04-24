#include "fileparser.h"
using namespace std;

//checks if a file exists in program directory
bool checkFileExists(string file_name){
	ifstream file_tester("program/" + file_name);
	return file_tester.good();
}

//accepts strings for the filenames
void assemblyToBinary(string assembly_name, string machine_name){
	ifstream assembly_file;
	ofstream machine_file;
	string instruction; //holds lines read in from assembly_file
	string binary=""; //holds binary instruction
	int format; //holds format type
	assembly_file.open("program/" + assembly_name);
	machine_file.open("program/" + machine_name);
	while( getline(assembly_file,instruction)){
		format = getFormat(&instruction);
		binary = binary + getOpcode(&instruction);
	}
}

//takes the instruction and returns the opcode 
string getOpcode(string * instruction){
	string command; //holds the actual command from the instruction
	command=instruction->substr(0,instruction->find(" "));
	try{
		if(command == "li"){
			return "000";
		}
		else if(command == "lw"){
			return "001";
		}
		else if(command == "sw"){
			return "010";
		}
		else if(command == "addi"){
			return "011";
		}
		else if(command == "beq"){
			return "100";
		}
		else if(command == "slti"){
			return "101";
		}
		else if(command == "add"){
			return "110";
		}
		else if(command == "j"){
			return "111";
		}
		else{
			throw command; 
		}
	}
	catch (string e){
		cout << "Error: " << e << " is not a valid instruction" << endl;
	}
}

//takes the instruction and returns the format
//1 is M-format, 2 is I-format, 3 is J-format 
int getFormat(string * instruction){
	string command; //holds the actual command from the instruction
	command=instruction->substr(0,instruction->find(" "));
	try {
		if(command == "li"){
			return 1;
		}
		else if (command == "add" || command == "addi" || command == "sw" 
			|| command == "lw" || command == "beq" || command == "slti"){
			return 2;
		}
		else if (command == "j"){
			return 3;
		}
		else{
			throw command;
		}
	}
	catch (string e){
		cout << "Error: " << e << " is not a valid instruction" << endl;
	}
}

//takes the instruction and returns the registers in the correct format
string getRegisters(string * instruction){
	string regs; // holds the output
}
