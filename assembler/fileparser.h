#ifndef FILE_PARSER
#define FILE_PARSER

#include <iostream>
#include <fstream>
#include <sstream>

bool checkFileExists(std::string file_name);
void assemblyToBinary(std::string input_file, std::string output_file);
std::string getOpcode(std::string * instruction);

#endif
