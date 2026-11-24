%option noyywrap

%{
    #include "unary.tab.h"
    #include <string.h>
%}

%%


[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
"+" {return '+';}
"-" {return '-';}
"*" {return '*';}
"/" {return '/';}
"^" {return '^';}
"(" {return '(';}
")" {return ')';}
[ \t]+ { /* Ignore whitespace */ }  
\n      { return '\n'; }
.   { return yytext[0]; }

%%