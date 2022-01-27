%{

#define yywrap() 1

#include <stdio.h>
#include <curses.h>
#include <stdlib.h>
#include <stdio.h>
//#include <conio.h>
#include <string.h>

FILE *yyin;

void print(char *value, char *category);

%}

%option yylineno
/* KEYWORDS */
FUN                     fun|FUN
CAT                     cat|CAT
IF                      if|IF
ELSE                    else|ELSE
WHILE                   while|WHILE
FOR                     for|FOR
IN                      in|IN
MODEL                   model|MODEL
SET                     set|SET
WITH                    with|WITH
RETURN                  return|RETURN
REAL_SET                real_set|REAL_SET
INT_SET                 int_set|INT_SET
NOT                     not|NOT
TRUE_BOOLEAN            True|TRUE
FALSE_BOOLEAN           False|FALSE
PRINT                   print|PRINT
STRING                  str|STR
CAT_ALPHA               catAlpha|CATALPHA 

DIGIT                   [0-9]
SYMBOL                  [a-z]
VARIABLE                [a-zA-Z]+(_[a-zA-Z0-9]+)+
VARIABLE_MID_SYMBOL     _

space                   [" "]*
TOKEN_LEFT_PAR          "("
TOKEN_RIGHT_PAR         ")"
TOKEN_LEFT_KEY          "{"
TOKEN_RIGHT_KEY         "}"
TOKEN_LEFT_SQR          "["
TOKEN_RIGHT_SQR         "]"       

TOKEN_EQ                "=="
TOKEN_NOT_EQ            "!="
TOKEN_LESS_EQ           "<="
TOKEN_GREA_EQ           ">="
TOKEN_LESS              "<"
TOKEN_GREA              ">"

TOKEN_MUL               "*"
TOKEN_DIV               "/"
TOKEN_SUM               "+"
TOKEN_DIF               "-"

TOKEN_AND               "&&"
TOKEN_OR                "||"

ASSIGNMENT_OPERATOR     =
CHAIN_SYMBOL            \"
COMA                    \,

TOKEN_CHAIN             {space}*\"{SYMBOL}+\"
TOKEN_INTEGER           {DIGIT}+
TOKEN_FLOAT             {DIGIT}+(\.{DIGIT}+)

PARAMETER_FUNCTION      \.
END_OF_STATEMENT        \;

COMMENT                 #(" ")?.*

%%

{TOKEN_AND} {
    print(yytext, "TOKEN_AND");
}

{TOKEN_OR} {
    print(yytext, "TOKEN_OR");
}

{TOKEN_EQ} {
    print(yytext, "TOKEN_EQ");
}

{TOKEN_NOT_EQ} {
    print(yytext, "TOKEN_NOT_EQ");
}

{TOKEN_LESS_EQ} {
    print(yytext, "TOKEN_LESS_EQ");
}

{TOKEN_GREA_EQ} {
    print(yytext, "TOKEN_GREA_EQ");
}

{TOKEN_LESS} {
    print(yytext, "TOKEN_LESS");
}

{TOKEN_GREA} {
    print(yytext, "TOKEN_GREA");
}

{TOKEN_MUL} {
    print(yytext, "TOKEN_MUL");
}

{TOKEN_DIV} {
    print(yytext, "TOKEN_DIV");
}

{TOKEN_SUM} {
    print(yytext, "TOKEN_SUM");
}

{TOKEN_DIF} {
    print(yytext, "TOKEN_DIF");
}

{CAT_ALPHA} {
    print(yytext, "CAT_ALPHA");
}

{IN} {
    print(yytext, "IN");
}

{STRING} {
    print(yytext, "STRING");
}

{FOR} {
    print(yytext, "FOR");
}

{COMMENT} {
    print(yytext, "COMMENT");
}

{COMA} {
    print(yytext, "COMA");
}

{END_OF_STATEMENT} {
    print(yytext, "END_OF_STATEMENT");
}

{FUN} {
    print(yytext, "FUN_KEYWORD");
}

{CAT} {
    print(yytext, "CAT_KEYWORD");
}

{IF} {
    print(yytext, "IF_KEYWORD");
}

{ELSE} {
    print(yytext, "ELSE_KEYWORD");
}

{WHILE} {
    print(yytext, "WHILE_KEYWORD");
}

{MODEL} {
    print(yytext, "IF_KEYWORD");
}

{SET} {
    print(yytext, "SET_KEYWORD");
}

{WITH} {
    print(yytext, "WITH_KEYWORD");
}

{RETURN} {
    print(yytext, "RETURN_KEYWORD");
}

{REAL_SET} {
    print(yytext, "REAL_SET_KEYWORD");
}

{INT_SET} {
    print(yytext, "INT_SET_KEYWORD");
}

{NOT} {
    print(yytext, "NOT_KEYWORD");
}

{TRUE_BOOLEAN} {
    print(yytext, "TRUE_BOOLEAN");
}

{FALSE_BOOLEAN} {
    print(yytext, "FALSE_BOOLEAN");
}

{PRINT} {
    print(yytext, "PRINT");
}

{SYMBOL} {
    print(yytext, "SYMBOL");
}

{CHAIN_SYMBOL} {
    print(yytext, "CHAIN_SYMBOL");
}

{TOKEN_INTEGER} {
    print(yytext,"TOKEN_INT");
}

{TOKEN_FLOAT} {
    print(yytext,"TOKEN_FLOAT");
}

{VARIABLE} {
    print(yytext,"VARIABLE");
}
 
{VARIABLE_MID_SYMBOL} {
    print(yytext, "VARIABLE_MID_SYMBOL");
}

{TOKEN_LEFT_PAR} {
    print(yytext,"TOKEN_LEFT_PAR");
}

{TOKEN_RIGHT_PAR} {
    print(yytext,"TOKEN_RIGHT_PAR");
}

{TOKEN_LEFT_KEY} {
    print(yytext,"TOKEN_LEFT_KEY");
}

{TOKEN_RIGHT_KEY} {
    print(yytext,"TOKEN_RIGHT_KEY");
}

{TOKEN_LEFT_SQR} {
    print(yytext,"TOKEN_LEFT_SQR");
}

{TOKEN_RIGHT_SQR} {
    print(yytext,"TOKEN_RIGHT_SQR");
}

{ASSIGNMENT_OPERATOR} {
    print(yytext,"ASSIGNMENT_OPERATOR");
}

{PARAMETER_FUNCTION} {
    print(yytext,"PARAMETER_FUNCTION");
}

{TOKEN_CHAIN} {
    print(yytext,"TOKEN_CHAIN");
}

{space} {

}

\t {
    
}

. {
    printf("\n\nCARACTER INVALIDO: Linea %d: %s\n", yylineno, yytext);
    printf("\nCerrando analizador lexico...\n");
    exit(1);
}
 
%%

int main()
{
    yylex();
}


/*
int main (int argc, char *argv[]){
    char file_name[20];
    printf("Inserte el nombre del archivo a ejecutar (con .txt): \n");
    scanf("%s", file_name);
    argv[1] = file_name;
    if ((yyin = fopen(argv[1], "rt")) == NULL) {
        printf("\nNo se pudo leer el archivo: %s\n", argv[1]);
        return 1;
    } else {
        printf("\nEl archivo %s se abrio correctamente\n", argv[1]);
        yylex();
    }
    printf("\nLectura finalizada.");
    fclose(yyin);
    return 0;
}
*/

 
//function that recives the lexical category and its value and prints it
void print(char *value, char *category)
{   
    printf("\n( %s , %s ) ", value, category );
}