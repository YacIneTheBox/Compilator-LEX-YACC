%{
#include "y.tab.h"
%}
%%

[0-9]+	{yylval = atoi(yytext); return NUMBER;}
[\t ]+	;
\n	{return EOL;}
"+"	{return PLUS;}
"-"	{return MINUS;}
"*"	{return MUL;}
"/" {return DIV;}
"("	{return LPAREN;}
")"	{return RPAREN;}
"somme" {return SOMME;}
"," {return COMMA;}
.	{return yytext[0];}

%%

int yywrap() { return 1;}
