%{
#include <stdio.h>
#include <stdlib.h>

/* Définir AvgData AVANT d'inclure y.tab.h */
typedef struct {
    double sum;
    int count;
} AvgData;

#include "y.tab.h"
%}

%%

[ \t]                   ; 
[0-9]+\.?[0-9]*         { yylval.val = atof(yytext); return NUMBER; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }
","                     { return COMMA; }
"somme"                 { return SOMME; }
"moyenne"               { return MOYENNE; }
"produit"               { return PRODUIT; }
"variance"              { return VARIANCE; }
\n                      { return EOL; }
.                       { printf("Caractere inconnu: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

