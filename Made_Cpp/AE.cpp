#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <cstring>
#include <sstream>
#include <cctype>

#include <unistd.h>
#include <string.h>
#include <ctype.h>

using namespace std;

int
interp(string abstract_syntax){
	int result = 0;


	return result;
}

bool is_digit(string str){
	return atoi(str.c_str()) != 0 || str.compare("0") == 0;
}

string 
parse(string concrete_syntax){
	string abstract_syntax;

	istringstream ss(concrete_syntax);
	string stringBuffer;
	while(ss >> stringBuffer){
	//	cout << "[DEBUG] buf: " << stringBuffer << " ";
		for(int i=0; i<stringBuffer.length(); i++){
			if(stringBuffer[i] == '{'){
				abstract_syntax.append("(");
			}
			else if(stringBuffer[i] == '}'){
				abstract_syntax.append(")");
			}
			else if(stringBuffer[i] == '+'){
				abstract_syntax.append("add ");
			}
			else if(stringBuffer[i] == '-'){
				abstract_syntax.append("sub ");
			}
			else if(isdigit(stringBuffer[i])){
				string temp;
				temp = "(num 5)";	
				abstract_syntax.append(temp);
			}
		}	
	}

	return abstract_syntax;
}


int main(int argc, char *argv[]){
	cin.tie(0);
	
	char opt;
	int p_option = 0;

	while((opt = getopt(argc, argv, "p")) != -1){
		switch(opt){
			case 'p':
				p_option = 1;
				break;
			default:
				break;
		}
	}
	
	string input;
	getline(cin, input);

	if(p_option){
		printf("Parser\n");	
		cout << "[Concreat] " << input << "\n";
		string t;
		t = parse(input);
		cout << "[Abstract] " << t << "\n";
	}
	else{
		printf("ZZ\n");
		cout << input << "\n";
	}

}
