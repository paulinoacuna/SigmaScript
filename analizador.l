%{

#undef yywrap
#define yywrap() 1 
#include <stdio.h>
#include <string.h>

void print(char *value, char *category);

%}
 
KEYWORDS fun|cat|if|else|while|model|set|with|return|model
DIGIT [0-9]
NUMBER ({DIGIT}+(\.{DIGIT}+)?)
VARIABLE [a-zA-Z][a-zA-Z0-9]*
space [" "]*
number_or_letter ({NUMBER}|{VARIABLE})
ARRAY \[({number_or_letter},{space})*{number_or_letter}\]
MATRIX \[({ARRAY},{space})*{ARRAY}\]
data_type {NUMBER}|{VARIABLE}|{ARRAY}|{MATRIX}
GROUP "("|")"
BLOK "{"|"}"

COMPARISON_OPERATOR (==|!=|<=|>=|<|>)
ARITHMETIC_OPERATOR [*/+-]
LOGICAL_OPERATOR &&|\|\|
ASSIGNMENT_OPERATOR =

CHAIN \"[a-z]*\"

COMPARISON_OPERATION {number_or_letter}{space}{COMPARISON_OPERATOR}{space}{number_or_letter}
LOGICAL_OPERATION {number_or_letter}{space}{LOGICAL_OPERATOR}{space}{number_or_letter} 
comparation {COMPARISON_OPERATION}|{LOGICAL_OPERATION}

FUNCTION_CALL {VARIABLE}\(((({number_or_letter}),{space})*({number_or_letter}))?\)
FUNCTION "fun "{FUNCTION_CALL} 

ALLOCATION {VARIABLE}{space}={space}{data_type} 
CONTROL ("if"{space}\({comparation}\))|("else if"{space}\({comparation}\))|("else"{space})
ITERATION ("while"{space}\({comparation}\))

%%

{ITERATION} {
    print(yytext, "ITERATION");
}

{CONTROL} {
    print(yytext, "CONTROL");
}

{ALLOCATION} {
    print(yytext, "ALLOCATION");
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

{KEYWORDS} {
    print(yytext,"KEYWORD");
}

{VARIABLE} {
    print(yytext,"VARIABLE");
}
 

{GROUP} {
    print(yytext,"GROUP");
}

{BLOK} {
    print(yytext,"BLOK");
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
 
 
%%
 
main()
{
 yylex();
}
 
//function that recives the lexical category and its value and prints it
void print(char *value, char *category)
{
    if(strcmp(value, ";") == 1)
    {
        printf("\n");
    }

    
    printf( "( %s , %s ) ", value, category );
}
