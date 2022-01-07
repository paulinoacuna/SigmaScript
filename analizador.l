%{
 
 
#undef yywrap
#define yywrap() 1 
#include <stdio.h>
#include <string.h>

void print(char *value, char *category);

%}
 
KEYWORDS fun|cat|if|else|while|model|set|with|return|model
DIGIT [0-9]
NUMBER {DIGIT}+(\.{DIGIT}+)?
VARIABLE [a-zA-Z][a-zA-Z0-9]*
ARRAY "["|"]"
GROUP "("|")"
BLOK "{"|"}"
COMPARISON_OPERATOR ==|!=|<=|>=|<|>
ARITHMETIC_OPERATOR [*/+-]
LOGICAL_OPERATOR &&|\|\|
ASSIGNMENT_OPERATOR =
FUNCTION_CALL {VARIABLE}\({[NUMBER|VARIABLE]*}\)

ARITHMETIC_OPERATION [{NUMBER}\b{ARITHMETIC_OPERATOR}]+{NUMBER}


CHAIN \"[a-z]*\"
 
%%

{FUNCTION_CALL} {
    print(yytext,"FUNCTION_CALL");
}

{ARRAY} {
    print(yytext,"ARRAY");
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

{ARITHMETIC_OPERATION} {
    print(yytext,"ARITHMETIC_OPERATION");
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
    if(strcmp(value,";") == 1)
    {
        printf(" holo \n");
    }

    
    printf( "( %s , %s ) ", value, category );
}
