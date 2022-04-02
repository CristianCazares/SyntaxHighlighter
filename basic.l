%{
#include<iostream>
using namespace std;
extern int yylex();

%}
ALPHA	[A-Za-z]+

%option noyywrap
%%
{ALPHA}+	cout << "Alphabetical\n";
"+"		cout << "Plus\n";
.		cout << "Unknown token\n";
%%

const  char  *fileName =  "input.txt";
int  main(int  argc, char**  argv){
	//Read file
	FILE *inputFile = fopen(fileName, "r");
	if(!inputFile){
		cout << "THE FILE " << fileName << " could not be opened!";
		return 0;
	}
	//Send file to flex
	yyin = inputFile;
	while(yylex());
	fclose(inputFile);
	return 0;
}