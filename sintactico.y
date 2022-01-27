%{ 
#include <stdio.h>
#include<stdbool.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

%}




%union {
    int integer;
    float real;

    char *string;
    char character;

    int array[5];
    
    
}

%token <character> SYMBOL

%token VARIABLE

%token <integer> NUMBER

%token TOKEN_MUL TOKEN_DIV TOKEN_SUM TOKEN_DIF

%token TOKEN_EQ TOKEN_NOT_EQ TOKEN_LESS_EQ TOKEN_GREA_EQ TOKEN_LESS TOKEN_GREA   

%token TOKEN_AND TOKEN_OR

%token <string> CHAIN

%type <integer> expr

%%
//el array[5] por defecto crea un array de long 5
//en %union se definen los tipos de datos, se pueden usar objetos
//por defecto estos tokens son de tipo int
//tokens del lexico, mantener nombre
//%type <real> expresion para devolver info semantica, en este caso retorna de tipo real.

//%token <real> NUMBERREAL


//reglas gramaticales



expr : expr TOKEN_SUM expr { $$ = $1 + $3; }
        | expr TOKEN_DIF expr {$$ = $1 - $3; }
        | expr TOKEN_MUL expr {$$ = $1 * $3; }
        | expr TOKEN_DIV expr {$$ = $1 / $3; }
        | NUMBER {$$ = $1; }
;





%%



int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}