
%{
    #include <stdio.h>
    #include <stdlib.h>

    int yylex(void);
    void yyerror(const char *s);
%}

%token NUMBER

%%

input:
    | input expr '\n'  { printf("= %d\n", $2); }
    ;

expr:
      NUMBER            { $$ = $1; }
    | expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     { $$ = $1 / $3; }
    ;

%%

void yyerror(const char *s) 
{
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) 
{
    return yyparse();
}