%{
 
 
#undef yywrap
#define yywrap() 1 
#include <stdio.h>
#include <string.h>

int f1=0,f2=0;
char oper;
float op1=0,op2=0,ans=0;
void eval();
void print(char *value, char *category);

%}
 
KEYWORDS fun|cat|if|else|while|model|set|with|return 
DIGIT [0-9]
NUMBER {DIGIT}+(\.{DIGIT}+)?
VARIABLE [a-zA-Z][a-zA-Z0-9]*
ARRAY "["|"]"
COMPARISON_OPERATOR ==|!=|<=|>=|<|>
ARITHMETIC_OPERATOR [*/+-]
LOGICAL_OPERATOR ["&&""||"]
ASSIGNMENT_OPERATOR =
CHAIN \[[a-z]*\]


 
%%

{NUMBER} {
    print(yytext,"NUMBER");
} 

{KEYWORDS} {
    print(yytext,"KEYWORD");
}



{VARIABLE} {
    print(yytext,"VARIABLE");
}
 
{ARRAY} {
    print(yytext,"ARRAY");
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
        printf("\n");
    }

    
    printf( "( %s , %s ) ", value, category );
}
