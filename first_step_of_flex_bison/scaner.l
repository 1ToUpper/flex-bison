
%option noyywrap

%{
    #include "parser.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"        { return '+'; }
"-"        { return '-'; }
[ \t]+      { /* ignore whitespace */ }
\n          { return '\n'; }
.           { return yytext[0]; }

%%