
%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
input:
    | input line
    ;

line:
    '\n'
    | exp '\n' { printf("%d\n", $1); }

exp:
    NUMBER
    | exp '+' exp { $$ = $1 + $3; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '/' exp { $$ = $1 / $3; }
    ;

%%

void yyerror(const char *s) 
{
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) 
{
    printf("Enter expressions (Ctrl+D to exit):\n");
    return yyparse();
}
