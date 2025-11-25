%{
#include <stdio.h>
#include <stdlib.h>

/* Définir AvgData AVANT d'inclure y.tab.h */
typedef struct {
    double sum;
    int count;
} AvgData;

typedef struct {
    double sum;
    double sum_of_squares;
    int count;
}VarianceData;

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
"ecart_type"            { return ECART_TYPE;}
\n                      { return EOL; }
.                       { printf("Caractere inconnu: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

