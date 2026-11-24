
%{
    #include <stdio.h>    
    #include <stdlib.h>
    #include <string.h>

    int yylex(void);
    void yyerror(const char *s);
%}

%union
{
    int num;
    char *str;
}

%token <num> NUMBER
%token <str> ID
%token IF ELSE
%type <str> stmt

/* Define operator precedence and associativity */
%precedence  THEN
%precedence  ELSE

%%

input:
    | input stmt '\n' {printf("%s\n", $2);} 
    ;

stmt:
    ID '=' NUMBER ';'                      { $$ = "assign"; }
    | IF '(' NUMBER ')' stmt %prec THEN {
                                            char *temp = (char *)malloc(strlen($5) + 10);
                                            sprintf(temp, "if (%s) ", $5);
                                            $$ = temp;
                                        }
    | IF '(' NUMBER ')' stmt ELSE stmt  {
                                            char *temp = (char *)malloc(strlen($5) + strlen($7) + 10);
                                            sprintf(temp, "if (%s) else (%s) ", $5, $7);
                                            $$ = temp;
                                        }
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