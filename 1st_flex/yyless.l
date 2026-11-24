%option noyywrap

%%

[0-9]+".."  { 
                yyless (yyleng - 2);
                printf("RANGE: %s\n", yytext);
            }
".."        {  
                printf("RANGE: %s\n", yytext);
            }
[0-9]+      { printf("INT: %s\n", yytext); }
[ \t\n]+     { /* Ignore whitespace */ }
.           { printf("SYMBOL: %s\n", yytext); }

%% 

int main(void)  
{
    yylex();
    return 0;
}