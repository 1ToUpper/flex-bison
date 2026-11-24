%option noyywrap

%{
    #include "dangling.tab.h"
    #include <string.h>
%}

%%


"if" { return IF; }
"else" { return ELSE; }
"(" { return '('; }
")" { return ')'; }
"=" { return '='; }
";" { return ';'; }
[0-9]+ { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
[ \t]+ { /* Ignore whitespace */ }
\n { return '\n'; } 
. { return yytext[0]; }

%%