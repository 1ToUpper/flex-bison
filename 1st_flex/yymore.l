%option noyywrap

%x STR

%% 

\"              { BEGIN(STR); yymore(); }
<STR>\\\n       { yymore(); }
<STR>\"         {
                    BEGIN(INITIAL);
                    printf("STRING: %s\n", yytext);
                }
<STR>.          { yymore(); }
<STR><<EOF>>    { 
                    fprintf(stderr, "Error: Unmatched string start\n"); 
                    exit(1); 
                }

[\t\n]+         { /* Ignore whitespace */ }
[.]             { printf("OTHER: %s\n", yytext); }

%%

int main(void)  
{
    yylex();
    return 0;
}