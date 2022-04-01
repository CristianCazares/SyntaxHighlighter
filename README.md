# Syntax Highlighter C++

## Table of contents

* [Selected languages](#SelectedLanguages)
* [Regular expressions](#RegularExpressions)
* [Target tokens](#TargetTkens)
* [Prerequisites ](#Prerequisites)
	* [Flex / Lex & Yacc](#FlexLexYacc)
	* [MinGW-w64](#MinGW-w64)
	* [GnuWin32](#GnuWin32)
* [Code development](#CodeDevelopment)
	* [C++](#CSS) 
	* [HTML + CSS](#HTMLCSS) 
* [Compiling](#Compiling)
	* [Commands for compiling (Windows CMD)](#CommandsCMD)
* [Execution](#Execution)
* [Testing](#Testing)



## Author: Cristian Javier Cázares Molina

## Selected languages <a name="SelectedLanguages"></a>

**C++, Python y Matlab.**
This highlighter is looking for some keywords that are (kind of) shared between three coding languages from different families.
There is no doubt that Python and C++ are from different families. On the other hand, MatLab has lots of expressions based on C, nevertheless it also has pretty particular differences, such as "function" to declare functions.

## Target tokens <a name="TargetTokens"></a>
After comparing the shared reserved keywords across languages, in the next table I illustrate the principal tokens categories and the highlight color selected.
Also, I include a column for some posible examples and another one for related and/or extra tokens.
![Token table](https://raw.githubusercontent.com/CristianCazares/SyntaxHighlighter/main/TokenTable.png)

## Regular expressions <a name="RegularExpressions"></a>
Some tokens only demand simple expressiones ("token"). In the next table are the more -sort of- complex tokens:
|Token|Regular Expression  |
|--|--|
|Real Numbers|[-]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?|
|Quotations|(\\/\\/)(.*)\|#[^include].\*|
|Imports|“import"\|"#include"|
|Operators|+\|-\|*\|/\|%\|^\|<\|>|
|False|"false"\|"False"|
|True|"true"\|"True"|
|Alphabetical|[A-Za-z]+|	
There is a total of 38 different tokens. Of those, 30 are simple of the form "token".

## Prerequisites <a name="Prerequisites"></a>
### Flex / Lex & Yacc <a name="FlexLexYacc"></a>
### MinGW-w64 <a name="MinGW-w64"></a>
### GnuWin32 <a name="GnuWin32"></a>

## Code development <a name="CodeDevelopment"></a>
### C++ <a name="C++"></a>
### HTML + CSS <a name="HTMLCSS"></a>

## Compiling <a name="Compiling"></a>
### Commands for compiling (Windows CMD) <a name="CommandsCMD"></a>

## Execution <a name="Execution"></a>

## Testing <a name="Testing"></a>
