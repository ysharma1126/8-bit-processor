#include "fileparser.h"
using namespace std;

vector<Data *> data_list; //holds a list of data in data segment

Data::Data(string n, string v, string a){
	name=n;
	value=v;
	address=a;
}

//checks if a file exists in program directory
bool checkFileExists(string file_name){
	ifstream file_tester("program/" + file_name);
	return file_tester.good();
}

void storeData(string assembly_name){
	ifstream assembly_file;
	assembly_file.open("program/" + assembly_name);
	string data_line;
	while( getline(assembly_file,data_line) && data_line != ".data"){
		//do nothing
	}
	string text;
	string data_name;
	string data_value;
	int i=0;
	while( getline(assembly_file,data_line) && data_line != ".text"){
		stringstream ss(data_line);
		ss >> data_name;
		ss >> data_value;
		Data * data = new Data(data_name,data_value, to_string(i));
		data_list.push_back(data);
	}
}

//useful for debugging
void printDataVector(){
	for(vector<Data *>::iterator it=data_list.begin(); it!=data_list.end();it++){
		cout << "---------" << endl;
		cout << "name: " << (*it)->name << endl;
		cout << "value: " << (*it)->value << endl;
		cout << "address: " << (*it)->address << endl;
	}
}

bool isNumber(string * s){
	for(int i=0; i < s->length(); i++){
		if( !isdigit(s->at(i))){
			return 0;
		}
	}
	return 1;
}

//returns pointer to Data object with specified name
Data * findData(string * name){
	vector<Data *>::iterator it=data_list.begin();
	while(it!=data_list.end()){
		if( (*it)->name == *name){
			break;
		}
		it++;
	}
	return *it;
}

//accepts strings for the filenames
//handles labels and data in the .data field
void labelToBinary(string assembly_name){
	storeData(assembly_name);//first we store all the data in data segment
	ifstream assembly_file;
	ofstream assembly_no_label;
	string instruction; //holds lines read in from assembly_file
	string label; //holds label read from assembly_file
	string binary; //holds binary immediate
	string tmp; //used for pseudoinstructions (li)
	Data * data; //points to data object with the found label
	int format; //holds format type
	assembly_file.open("program/" + assembly_name);
	assembly_no_label.open("program/temporaryfile");
	while( getline(assembly_file,instruction) && instruction != ".text"){
		assembly_no_label << instruction << endl;
	}
	assembly_no_label << instruction << endl;
	while( getline(assembly_file,instruction)){
		format = getFormat(&instruction);
		if(format == 1){ //if format is M
			int comma1 = instruction.find(",");
			label = instruction.substr(comma1+1,instruction.length()-comma1-1);
			if( !isNumber(&label) ){ //if theres a label for li
				data = findData(&label);
				if( (data->value).length() == 8){ //pseudoinstruction for li
					tmp = instruction.substr(0,comma1+1);
					assembly_no_label << tmp << (data->value).substr(0,4) << endl;
					assembly_no_label << tmp << (data->value).substr(4,4) << endl;
				}
				else if( (data->value).length() == 4){
					tmp = instruction.substr(0,comma1+1);
					assembly_no_label << tmp + (data->value) << endl;
				}
				else{
					cout << "Error: Invoking (li) with label of incorrect value length" << endl;
				}
			}
			else { //li is an immediate value
				if(label.length() == 8){
					tmp = instruction.substr(0,comma1+1);
					assembly_no_label << tmp << label.substr(0,4) << endl;
					assembly_no_label << tmp << label.substr(4,4) << endl;
				}
				else if(label.length() ==4){
					assembly_no_label << instruction << endl;
				}
				else{
					cout << "Error: Invoking (li) with immediate of incorrect length" << endl;
				}
			}
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
