%option noyywrap

%{
    #include "expr_noprec.tab.h"
%}

%% 

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
[ \t]       { /* ignore whitespace */ }
\n          { return '\n'; }
.           { return yytext[0]; }

%%
