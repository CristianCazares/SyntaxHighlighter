![](Aspose.Words.eea4a2ed-b365-47c8-bee2-44560137d1cb.001.png)


|<p>**Nombre**:</p><p>Cristian Javier Cázares Molina</p>|<p>**Matrícula:**</p><p>A01741952</p>|
| :- | :- |
|<p>**TC20037:**</p><p>Implementación de Métodos Computacionales</p>|<p>**Nombre del profesor:**</p><p>M.C. Luis Ricardo Peña Llamas</p>|
|<p>**Actividad 2:**</p><p>Instalación del simulador de red.</p>|<p>**Fecha:**</p><p>15/02/2021</p>|
||

# **Contenido**
[Lenguajes seleccionados	3](#_Toc99554412)

[Expresiones regulares formuladas	4](#_Toc99554413)

[Prerrequisitos	5](#_Toc99554414)

[Flex (Fast Lexical Analyzer Generator) / Lex & Yacc	5](#_Toc99554415)

[MinGW-w64	5](#_Toc99554416)

[GnuWin32	5](#_Toc99554417)

[Desarrollo del código	6](#_Toc99554418)

[C++	6](#_Toc99554419)

[HTML + CSS	7](#_Toc99554420)

[Compilación	8](#_Toc99554421)

[Comandos en consola para la compilación	8](#_Toc99554422)

[Ejecución	8](#_Toc99554423)


# Lenguajes seleccionados
**C++, Python y Matlab.**

Durante la selección de los lenguajes quise asegurarme de elegir diferentes familias con las que esté relacionado. Las diferencias entre Python y C++ abundan, pero en el caso particular de MatLab, tiene muchas extensiones basadas en C, no obstante también tiene diferencias muy puntuales (como “function” para declarar funciones).

Tokens a identificar

De forma que en la siguiente table ilustro las categorías de tokens principales que se identifican, además incluyo una columna para otros tokens que se identifican de manera extra para que el resaltador cobre más sentido. 

|**#**|**Token**|**Contenido**|**Extras**|
| - | - | - | - |
|**1**|**import**||**#include**|
|**2**|**def**||**function, void**|
|**3**|**if**||**else, for, while**|
|**4**|**Números reales**|**1, -1, 1.2, -1.2, 1.2E3, -1.2E-3**|**1.2E3, -1.2e-3**|
|**5**|**True/False**|||
|**6**|**+ - \* \ % < >**||**not**|
|**7**|**Tipos de variables** |**int, string, bool, float, vector, char**|**None**|
|**8**|**Asignación**|**=**||
|**9**|**() [] {}**|||
|**10**|**return**|||
|**12**|**;**|||
|**12**|**break**|||
|**13**|**try**|**exception**||
|**14**|**“comillas dobles”**||**‘sencillas’**|
|**15**|**Comentarios**|**//C++ #Python**||
|**16**|**Sin identificar**|||
(Todos son tokens individuales a excepción de las categorías de **operadores, comentarios**, **comillas** e **import**)
# Expresiones regulares formuladas
Algunos de los tokens únicamente demandan expresiones regulares simples, pues únicamente se identifica un carácter o una cadena de caracteres. De manera que a continuación enlisto las expresiones regulares más elaboradas.

|**Token**|**Expresión regular**|
| :- | :- |
|**Números reales**|[-]?[0-9]\*\.?[0-9]+([eE][-+]?[0-9]+)?|
|**Comillas**|(\"(.\*?)\")|(\'(.\*?)\')|
|**Comentarios**|(\/\/)(.\*)|#[^include].\*|
|**Operadores**|+|-|\*|/|%|^|<|>|
|**Import**|“import"|"#include"|
|**True**|"false"|"False"|
|**False**|"true"|"True"|
|**Alfabético**|[A-Za-z]+|

En total se identifican 38 tokens diferentes. De los cuales, 30 tienen expresiones regulares simples de forma: “<token>”, y el resto son los expuestos anteriormente.


# Prerrequisitos
## **Flex / Lex & Yacc**
Lo más fundamental para el programa desarrollado, fue el analizador léxico. Si bien se estipuló que se utilizaría Lex y Yacc, este es para sistemas de Unix.

Luego de una investigación, se llegó a la conclusión de que el equivalente para **Windows** es Flex y Bison. Para el alcance del programa únicamente fue necesario Flex.

## **MinGW-w64**
Para desarrollar el código se empleó C++, y para tener acceso al compilador, ya sea gcc o g++ es necesario instalar el “proyecto MinGW-w64”.

## **GnuWin32**
Flex es parte del proyecto GnuWin32, el cual es un conjunto de herramientas de código abierto para C y C++.

Una vez instalados esos prerrequisitos se puede empezar a desarrollar el código.


# Desarrollo del código
## **C++**
Para utilizar Flex es necesario crear un archivo de extensión “.l”, esto nos permite escribir tanto código en C++ como expresiones regulares.

La estructura es parecida a la de Lex:

%{

`	`Declaraciones en C++

%}

TOKEN 	Expresión Regular

%%

Expresión regular/{TOKEN}+		Método en C++

%%

Código regular en C++

La implementación de mi código consiste en a través de distintas funciones, generar un solo string, donde cada token identificado le añade una etiqueta de **HTML** de tipo **<div>**.

Esta etiqueta tiene una **clase** que es designada por el token identificado, y el texto que encapsula es precisamente el **texto que motivó dicho token**. Esta sería la plantilla de dicha etiqueta:

`	`<div class=“token”>CONTENIDO DEL TOKEN</div>

Además, cada token identificado es mostrado en consola.

Al final se crea el archivo **HTML** con el método “**ofstream HTMLFile(…)**”.


## **HTML + CSS**
A este punto, C++ se encargó de crear o sobrescribir un archivo **HTML** y un **string** con todos los **div’s** planteados en la sección anterior. Con esto obtenido se le añade línea por línea lo mínimo de un archivo HTML:

HTML **omite** **sangrías** (identations: \t) y **espacios múltiples.** Algo que es esencial en cualquier lenguaje de programación, principalmente Python.

Para poder hacer uso de dichos elementos, todos los div’s se encapsulan en otra etiqueta llamada **<pre> </pre>**, esta preformatea el contenido que contenga, permitiendo el uso de sangría y espacios múltiples.

De forma que así se ve la estructura del archivo de HTML:

<!DOCTYPE html>

<html lang="en">

<head>

`    `<meta charset="UTF-8">

`    `<meta http-equiv="X-UA-Compatible" content="IE=edge">

`    `<meta name="viewport" content="width=device-width, initial-scale=1.0">

`    `<title>LEXER C++</title>

<link rel="stylesheet" href="style.css">

</head>

**<body>**

**<pre>**

`	`**Div’s de los tokens identificados**	

**</pre>**

**</body>**

</html>

Así mismo, durante la **fase de identificación de palabras claves**, se hizo a manualmente (no por código), un archivo de **CSS** que contiene todas las clases de los diferentes tokens identificados, entre otros misceláneos para estilo en general.
# Compilación
Únicamente para Windows.

Para compilar se utiliza la consola, pero primero es necesario agregar MinGW-64 y Flex a las **variables de entorno**.

Los pasos a seguir con los siguientes:

1. Procesar con flex el archivo “.l”.

Esto generará un archivo de C llamado “lex.yy.c”

1. Utilizar g++ para compilar el archivo “lex.yy.c”

Esto generará el ejecutable como “a.exe”

## **Comandos en consola para la compilación**
flex <file>.l

g++ lex.yy.c

# Ejecución
Para la ejecución se necesitan únicamente dos archivos. Uno de entrada que contenga el texto a resaltar que se debe de llamar “**input.txt**”. Y el ejecutable generado durante la compilación llamado “**a.exe**”.

Los pasos a seguir para la ejecución con los siguientes:

1. Editar “**input.txt**” y guardarlo.
1. Ejecutar en consola “**a.exe**”.

Esto creará o sobrescribirá un archivo llamado “index.html”. Para ver el resultado simplemente es necesario abrir dicho archivo con un navegador de internet actualizado.

Como extra, también se imprime un desglose de todos los tokens generados.


# Reflexión

2

