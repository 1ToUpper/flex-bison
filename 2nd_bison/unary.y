%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>

    int yylex(void);
    void yyerror(const char *s);
%}

%union
{
    int num;
};

%token <num> NUMBER
%type <num> expr

/* 从高到低声明优先级 */
%left '+' '-'
%left '*' '/'
%precedence NEG /*一元负号的优先级高于乘除法*/
%right '^'

%%


input:
    |input expr '\n' {printf("Result: %d\n", $2);}

expr:
    NUMBER                  { $$ = $1; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { $$ = $1 / $3; }
    | '-' expr %prec NEG    { $$ = -$2; }
    | expr '^' expr         { $$ = (int)pow($1, $3); }
    | '(' expr ')'          { $$ = $2; }
    ;

%%


void yyerror(const char *s)
{
    fprintf(stderr, "error: %s\n", s);
}

int main(void)
{
    return yyparse();
}