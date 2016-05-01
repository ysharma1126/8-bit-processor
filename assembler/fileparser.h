#ifndef FILE_PARSER
#define FILE_PARSER

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <cctype>
#include <bitset>

class Data{
public:
	std::string name; //holds name of data
	std::string value;//holds value of data
	std::string address;//holds address of data
	Data(std::string n, std::string v, std::string a);
};
void storeData(std::string assembly_name);
bool checkFileExists(std::string file_name);
bool isNumber(std::string s);
Data * findData(std::string * name, std::vector<Data *> &v);
void labelToBinary(std::string input_file);
void assemblyToBinary(std::string input_file, std::string output_file);
std::string getOpcode(std::string * instruction);
int getFormat(std::string * instruction);
std::string getRegisters(std::string * instruction,int format, std::string * command);
std::string getImmediate(std::string * instruction,int format);
void printVector(std::vector<Data *> &v);

#endif
