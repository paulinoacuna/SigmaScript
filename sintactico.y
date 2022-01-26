%{ 
#include <stdio.h>
#include "header.h"    
%}




%union {
    int entero;
    float real;

    bool booleano;

    char *cadena;
    char caracter;

    int arreglo[10];
    
    
}


%token <caracter> SYMBOL

%token <cadena> CHAIN

token <cadena> VARIABLE

%token <entero> NUMBER

%token ARITHMETIC_OPERATOR



%%
//en %union se definen los tipos de datos, se pueden usar objetos
//por defecto estos tokens son de tipo int
//tokens del lexico, mantener nombre
//%type <real> expresion para devolver info semantica, en este caso retorna de tipo real.

//%token <real> NUMBERREAL


//reglas gramaticales



expr : expr ARITHMETIC_OPERATOR expr { $$ = $1 + $3; }
;





%%
//codigo de usuario
