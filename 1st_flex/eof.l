%option noyywrap

%x STR
%x COMMENT

%%

\" { BEGIN(STR); }
<STR>\" { BEGIN(INITIAL); printf("STRING: OK\n"); }
<STR>.|\n { /* Ignore characters inside string */ }

"/*" { BEGIN(COMMENT); }
<COMMENT>"*/" { BEGIN(INITIAL); printf("COMMENT: OK\n"); }
<COMMENT>.|\n { /* Ignore characters inside comment */ }

<STR><<EOF>> { printf("ERROR: Unterminated string\n"); exit(1); }
<<EOF>> { printf("EOF reached\n"); exit(0); }

[\t\n]+ { /* Ignore whitespace */ }
. { printf("SYMBOL: %s\n", yytext); }

%%

int main(void) 
{
    yylex();
    return 0;
}
 
