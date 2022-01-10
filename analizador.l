%{

#define yywrap() 1
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
FILE *yyin;

void print(char *value, char *category);

%}
/* KEYWORDS */
FUN                     fun
CAT                     cat
IF                      if
ELSE                    else
WHILE                   while
MODEL                   model
SET                     set
WITH                    with
RETURN                  return
REAL_SET                real_set
INT_SET                 int_set
NOT                     not
BOOLEAN                 True|False

DIGIT                   [0-9]
SYMBOL                  [a-z]
VARIABLE                [a-zA-Z]+_[a-zA-Z0-9]+
VARIABLE_MID_SYMBOL     _
space                   [" "]*
GROUP                   "("|")"
BLOCK                   "{"|"}"
ARRAY_ALPHABET          "["|"]"

COMPARISON_OPERATOR     (==|!=|<=|>=|<|>)
ARITHMETIC_OPERATOR     [*/+-]
LOGICAL_OPERATOR        &&|\|\|
ASSIGNMENT_OPERATOR     =
CHAIN                   \"

SYMBOL_CHAIN            \"{SYMBOL}+\"
NUMBER                  ({DIGIT}+(\.{DIGIT}+)?)

CATEGORY_ALPHABET       \[(({SYMBOL},{space})*{SYMBOL})?\]

number_or_letter        ({NUMBER}|{VARIABLE})
ARRAY                   \[({number_or_letter},{space})*{number_or_letter}\]
MATRIX                  \[({ARRAY},{space})*{ARRAY}\]
data_type               {NUMBER}|{VARIABLE}|{ARRAY}|{MATRIX}

COMPARISON_OPERATION    {number_or_letter}{space}{COMPARISON_OPERATOR}{space}{number_or_letter}
LOGICAL_OPERATION       {number_or_letter}{space}{LOGICAL_OPERATOR}{space}{number_or_letter} 
comparation             {COMPARISON_OPERATION}|{LOGICAL_OPERATION}

FUNCTION_CALL           {VARIABLE}\(((({number_or_letter}),{space})*({number_or_letter}))?\)
FUNCTION                "fun "{FUNCTION_CALL}


/*ALLOCATION              {VARIABLE}{space}={space}{data_type} */
CONTROL                 ("if"{space}\({comparation}\))|("else if"{space}\({comparation}\))|("else"{space})
ITERATION               ("while"{space}\({comparation}\))

%%
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

{BOOLEAN} {
    print(yytext, "BOOLEAN");
}

{ARRAY_ALPHABET} {
    print(yytext, "ARRAY_SYMBOL");
}

{SYMBOL} {
    print(yytext, "SYMBOL");
}

{SYMBOL_CHAIN} {
    print(yytext, "SYMBOL_CHAIN");
}

{CATEGORY_ALPHABET} {
    print(yytext, "CATEGORY_ALPHABET");
}

{ITERATION} {
    print(yytext, "ITERATION");
}

{CONTROL} {
    print(yytext, "CONTROL");
}

{FUNCTION} {
    print(yytext, "FUNCTION");
}

{FUNCTION_CALL} {
    print(yytext, "FUNCTION_CALL");
}

{LOGICAL_OPERATION} {
    print(yytext, "LOGICAL_OPERATION");
}

{COMPARISON_OPERATION} {
    print(yytext, "COMPARISON_OPERATION");
}

{ARRAY} {
    print(yytext,"ARRAY");
}

{MATRIX} {
    print(yytext,"MATRIX");
}

{NUMBER} {
    print(yytext,"NUMBER");
}

{VARIABLE} {
    print(yytext,"VARIABLE");
}
 
{VARIABLE_MID_SYMBOL} {
    print(yytext, "VARIABLE_MID_SYMBOL");
}

{GROUP} {
    print(yytext,"GROUP");
}

{BLOCK} {
    print(yytext,"BLOCK");
}

{COMPARISON_OPERATOR} {
    print(yytext,"COMPARISON_OPERATOR");
}

{ARITHMETIC_OPERATOR} {
    print(yytext,"ARITHMETIC_OPERATOR");
}

{LOGICAL_OPERATOR} {
    print(yytext,"LOGICAL_OPERATOR");
}

{ASSIGNMENT_OPERATOR} {
    print(yytext,"ASSIGNMENT_OPERATOR");
}

{CHAIN} {
    print(yytext,"CHAIN");
}

{space} {

}

. {
    printf("\nCaracter invalido: %s", yytext);
}
 
%%
/*
int main()
{
    yylex();
}
*/
int main (int argc, char *argv[]){
    argv[1] = "test01.txt";
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
 
//function that recives the lexical category and its value and prints it
void print(char *value, char *category)
{   
    printf("\n( %s , %s ) ", value, category );
}