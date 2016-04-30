#ifndef FILE_PARSER
#define FILE_PARSER

#include <iostream>
#include <fstream>
#include <sstream>

bool checkFileExists(std::string file_name);
void labelToBinary(std::string input_file, std::string output_file);
void assemblyToBinary(std::string input_file, std::string output_file);
std::string getOpcode(std::string * instruction);
int getFormat(std::string * instruction);
std::string getRegisters(std::string * instruction,int format, std::string * command);
std::string getImmediate(std::string * instruction,int format);

#endif
