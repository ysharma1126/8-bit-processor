#include <iostream>
#include "fileparser.h"
using namespace std;

int main() {
	string assembly_name,machine_name;
	cout << "Enter the name of the input assembly file: ";
	getline(cin, assembly_name);
	while(!checkFileExists(assembly_name)){
		cout << "File does not exist!" << endl;
		cout << "Enter the name of the assembly file: ";
		getline(cin, assembly_name);
	}
	cout << "Enter the name of the output machine code file: ";
	getline(cin, machine_name);
	assemblyToBinary(assembly_name,machine_name);
}
