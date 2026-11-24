第一个最小demo

1、执行方法：
  bison -d parser.y  //生成parser.tab.c、parser.tab.h	生成语法分析器，-d 表示同时生成头文件
  flex scanner.l  //生成lex.yy.c	生成词法分析器
  gcc parser.tab.c lex.yy.c -o calc  //生成calc    把两者链接成可执行文件

2、运行./calc 输入 1+2 输出 3

3、语法说明
%token NUMBER：声明一个终结符，Bison 会为它分配一个整数编号，并写进 parser.tab.h。
%left '+' '-'：告诉 Bison + 和 - 是左结合，用来消除 1-2-3 这类表达式的移进/归约冲突。
expr: NUMBER { $$ = $1; }：$$ 是左部 expr 的语义值，$1 是右部第一个符号的值。
yylval = atoi(yytext); return NUMBER;：Flex 匹配到数字后，把数值放进 yylval，再把 token 编号 NUMBER 返回给 Bison。
yyparse() 内部反复调用 yylex()，根据解析表决定移进还是归约，归约时执行 { ... } 里的语义动作。