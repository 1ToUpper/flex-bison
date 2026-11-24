%option noyywrap

%x COMMENT  

%{
    #include <stdio.h>
    int comment_depth = 0;
%}

%% 

"/*" { comment_depth = 1; BEGIN(COMMENT); }
<COMMENT>"/*" { comment_depth++; }
<COMMENT>"*/" { comment_depth--; if (comment_depth == 0) BEGIN(INITIAL); }

<COMMENT>.|\n { /* Ignore all other characters inside comments */ }
<COMMENT><<EOF>> { fprintf(stderr, "Error: Unmatched comment start\n"); exit(1); }
[0-9]+ { printf("INT: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("ID: %s\n", yytext); }
[ \t\n]+ { /* Ignore whitespace */ }
. { printf("SYMBOL: %s\n", yytext); }

%%

int main(void)  
{
    yylex();
    return 0;
}