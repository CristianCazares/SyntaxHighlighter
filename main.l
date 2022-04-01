/*
Author: Cristian Javier Cázares Molina
Date: March 28th 2022
Description:
    Syntax highlighter HTML + CSS
    Tokens identified using C++ and Flex (from GNU)
*/

%{
#include <iostream>
#include <fstream>
using namespace std;
extern int yylex();

string content;
string genDiv(string, string);
string genDiv(string, char);
string genDivBreak();
string TYPE;
string strTEXT;
string charTEXT;

void writeHTML();
void showToken(string, char);
void showToken(string, string);

%}
REAL            [-]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
QUOTATION       (\"(.*?)\")|(\'(.*?)\')
IMPORT          "import"|"#include"
COMMENT         (\/\/)(.*)|#[^"include"].*
ALPHA           [A-Za-z]+

%option noyywrap
%%
"\t"                        { showToken("identation", "\\t"); content += "\t"; }
{QUOTATION}+                { content += genDiv("quotation", yytext); }
{COMMENT}+                  { content += genDiv("comment", yytext); }
"+"|"-"|"*"|"/"|"%"|"^"|"<"|">"     { content += genDiv("operator", yytext[0]); }
"("|")"     { content += genDiv("parenthesis", yytext[0]); }
"{"|"}"     { content += genDiv("brace", yytext[0]); }
"["|"]"     { content += genDiv("bracket", yytext[0]); }
"="         { content += genDiv("assignation", yytext[0]); }
";"         { content += genDiv("semicolon", yytext[0]); }
{REAL}+     { content += genDiv("real", yytext); }
"int"       { content += genDiv("int", yytext); }
"char"      { content += genDiv("char", yytext); }
"string"    { content += genDiv("string", yytext); }
"float"     { content += genDiv("float", yytext); }
"double"    { content += genDiv("double", yytext); }
"bool"      { content += genDiv("bool", yytext); }
"vector"    { content += genDiv("vector", yytext); }
"false"|"False" { content += genDiv("false", yytext); }
"true"|"True"   { content += genDiv("true", yytext); }
"break"     { content += genDiv("break", yytext); }
"if"        { content += genDiv("if", yytext); }
"else"      { content += genDiv("else", yytext); } 
"not"       { content += genDiv("not", yytext); }
"and"       { content += genDiv("not", yytext); }
"continue"  { content += genDiv("continue", yytext); }
"try"       { content += genDiv("try", yytext); }
"except"    { content += genDiv("except", yytext); }
{IMPORT}+   { content += genDiv("import", yytext); }
"return"    { content += genDiv("return", yytext); }
"for"       { content += genDiv("for", yytext); }
"while"     { content += genDiv("while", yytext); }
"def"       { content += genDiv("def", yytext); }
"void"      { content += genDiv("void", yytext); }
"function"  { content += genDiv("function", yytext); }
"None"      { content += genDiv("none", yytext); }



"\n"        { content += "\n"; cout << "\n";}
{ALPHA}+    { content += genDiv("alpha", yytext); }
.           { content += genDiv("default", yytext); }
%%

const char *fileName = "input.txt";
int main(int argc, char** argv){

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

    //write html
    writeHTML();
    return 0;
}

//________________________________________________________________________
/*This section generates a HTML DIV given a {token} and a {text}
    Template: <div class="noBreak {token}">{text}<div>>
*/
string defaultDivOpener = "<div class=\"noBreak ";

//The token is the "string type" argument, which will represent a CSS class.
string genDiv(string type, string text){
    showToken(type, text);
    return defaultDivOpener + type + "\">" + text + "</div>";
}

//Overload. The value of yytext can be either string or char
string genDiv(string type, char text){
    showToken(type, text);
    return defaultDivOpener + type + "\">" + text + "</div>";
}



//________________________________________________________________________
/*Creates/overwrites a HTML file.
The content is a string that has been modified through all the code*/
void writeHTML(){
    ofstream HTMLFile("index.html");
    string HTML = "";

    HTML += "<!DOCTYPE html>\n";
    HTML += "<html lang=\"en\">\n";
    HTML += "<head>\n";
    HTML += "    <meta charset=\"UTF-8\">\n";
    HTML += "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n";
    HTML += "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n";
    HTML += "    <title>LEXER C++</title>\n";
    HTML += "<link rel=\"stylesheet\" href=\"style.css\">\n";
    HTML += "</head>\n";
    HTML += "<body>\n";
    HTML += "<pre>";

    //INSERTS GENERATED DIV TAGS
    HTML += content;
    //

    HTML += "\n";
    HTML += "</pre>\n";
    HTML += "</body>\n";
    HTML += "</html>\n";

    //writes on HTML file
    HTMLFile << HTML;
    HTMLFile.close();

    cout << endl << endl << endl << "\t\tHTML GENERATED! (index.html)" << endl << endl << endl;
}


//Show token in format "text -> token". Overload to admit both chars and strings
void showToken(string type, char text){
    cout << "\t\"" << text << "\" -> " << type << endl;
}
void showToken(string type, string text){
    cout << "\t\"" << text << "\" -> " << type << endl;
}