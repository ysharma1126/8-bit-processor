#include "fileparser.h"
using namespace std;

class Data{
public:
	string name; //holds name of data
	int value;//holds value of data
	int address;//holds address of data
	Data(string n, int v, int a){
		name=n;
		value=v;
		int address;
	}
};

//checks if a file exists in program directory
bool checkFileExists(string file_name){
	ifstream file_tester("program/" + file_name);
	return file_tester.good();
}

//accepts strings for the filenames
//handles labels and data in the .data field
void labelToBinary(string assembly_name, string machine_name){
	ifstream assembly_file;
	ofstream machine_file;
	string instruction; //holds lines read in from assembly_file
	string label; //holds label read from assembly_file
	string binary; //holds binary immediate
	int format; //holds format type
	assembly_file.open("program/" + assembly_name);
	machine_file.open("program/" + machine_name);
	while( getline(assembly_file,instruction) && instruction != ".data"){
		//do nothing
	}
	while( getline(assembly_file,instruction)){
		format = getFormat(&instruction);
		if(format == 1){ //if format is M
		}
		else if(format == 2){ //if format is I
		}
		else{ //format is J
		}
	}
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
	while(getline(assembly_file,instruction) && instruction != ".text"){
		//do nothing
	}
	while( getline(assembly_file,instruction)){
		format = getFormat(&instruction);
		binary = binary + getOpcode(&instruction);
		if(format == 1 || format == 2){ //if format is M or I
			binary = binary + getRegisters(&instruction,format,&binary);
		}
		binary = binary + getImmediate(&instruction,format);
		machine_file << binary << "\n";
		binary = "";
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
string getRegisters(string * instruction, int format, string * command){
	string reg1, reg2;
	int dollarsign1; //stores location of first dollar sign
	int dollarsign2; //stores location of second dollar sign
	int comma1; //stores location of first comma
	int comma2; //stores location of second comma
	dollarsign1 = instruction->find("$");
	comma1 = instruction->find(",");
	reg1 = instruction->substr(dollarsign1+1,comma1-dollarsign1-1);
	try {
		if (!(reg1 == "0" || reg1 == "1")){
			throw reg1;
		}
	}
	catch (string e){
		cout << "Error: Could not find register $" << e << endl;
	}
	if (format == 1){ //M formats only have one register
		return reg1;
	}
	dollarsign2 = instruction->find("$",dollarsign1+1);
	comma2 = instruction->find(",",dollarsign2);
	if(*command == "001" || *command =="010"){ //if sw or lw
		int para2 = instruction->find(")");
		reg2 = instruction->substr(dollarsign2+1,para2-dollarsign2-1);
	}
	else{
		reg2 = instruction->substr(dollarsign2+1,comma2-dollarsign2-1);
	}
	try {
		if (!(reg2 == "0" || reg2 == "1")){
			throw reg1;
		}
	}
	catch (string e){
		cout << "Error: Could not find register $" << e << endl;
	}
	return reg2+reg1;
}

string getImmediate(string * instruction, int format){
	string immediate;
	int comma1; //stores location of first comma
	int comma2; //stores location of second comma
	int space; //stores location of first space
	space = instruction->find(" ");
	comma1 = instruction->find(",");
	comma2 = instruction->find(",",comma1+1);
	string command = instruction->substr(0,space);
	if(format == 1){
		immediate = instruction->substr(comma1+1,4);
	}
	else if(format == 2){
		if( command=="add" ){
			immediate = "000";
		}
		else if(command =="lw" || command == "sw"){
			int para1 = instruction->find("(");
			immediate = instruction->substr(comma1+1, para1-comma1-1);
		}
		else{
			immediate = instruction->substr(comma2+1,3);
		}
	}
	else if(format == 3){
		immediate = instruction->substr(space+1,5);
	}
	return immediate;
}
