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
				string num("");
				num.push_back(stringBuffer[i]);

				while(isdigit(stringBuffer[i+1])){
					num.push_back(stringBuffer[i+1]);
					i++;
				}

				char* temp = (char*)malloc(sizeof(char) * 10);
				memset(temp, 0, 10);
				sprintf(temp, "(num %s)", num.c_str());

				string str(temp);
				abstract_syntax.append(str);
				free(temp);
			}
			else{
				perror("bad syntax");
				exit(1);
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
		cout << "[Concreat] " << input << "\n";
		string temp;
		temp = parse(input);
		cout << "[Abstract] " << temp << "\n";
	}
	else{
		cout << "[Concreat] " << input << "\n";
		string temp;
		temp = parse(input);
		cout << "[Abstract] " << temp << "\n";
		string result;
		result = parse(temp);
		cout << "[Result] " << result << "\n";
	}

}
