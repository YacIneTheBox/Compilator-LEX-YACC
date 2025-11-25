%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/* Structure pour gérer les arguments de moyenne */
typedef struct {
    double sum;
    int count;
} AvgData;

int yylex();
void yyerror(char *s);

%}

/* Union pour stocker les types */
%union {
    double val;       // pour expr, term, factor
    AvgData avg;   // pour moyenne
}

/* Déclaration des tokens */
%token <val> NUMBER
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN
%token SOMME MOYENNE
%token PRODUIT VARIANCE
%token COMMA
%token EOL

/* Déclaration des types des règles */
%type <val> expr term factor function_somme function_moyenne function_produit
%type <avg> argument_list_avg
%type <val> argument_list_sum  argument_list_prod


%%

/************   Règle principale   ************/
input:
      /* vide */
    | input line
;

line:
      expr EOL      { printf("= %f\n", $1); }
    | EOL
;

/************   Expressions   ************/

expr:
      expr PLUS term     { $$ = $1 + $3; }
    | expr MINUS term    { $$ = $1 - $3; }
    | term
;

term:
      term MUL factor    { $$ = $1 * $3; }
    | factor
;

factor:
      NUMBER                   { $$ = $1; }
    | LPAREN expr RPAREN       { $$ = $2; }
    | function_somme
    | function_moyenne
    | function_produit
;

/************   Fonction somme(...)   ************/

function_somme:
      SOMME LPAREN argument_list_sum RPAREN   { $$ = $3; }
;

argument_list_sum:
      expr                        { $$ = $1; }
    | argument_list_sum COMMA expr { $$ = $1 + $3; }
;

/************   Fonction moyenne(...)   ************/

function_moyenne:
      MOYENNE LPAREN argument_list_avg RPAREN
      {
          if ($3.count == 0) {
              yyerror("Division par zero dans moyenne()");
              $$ = 0;
          } else {
              $$ = $3.sum / $3.count;
          }
      }
;

/* liste d'arguments pour moyenne */
argument_list_avg:
      expr
      {
          $$.sum = $1;
          $$.count = 1;
      }
    | argument_list_avg COMMA expr
      {
          $$.sum = $1.sum + $3;
          $$.count = $1.count + 1;
      }
;

/************   Fonction produit(...)   ************/
function_produit:
      PRODUIT LPAREN argument_list_prod RPAREN { $$ = $3; } 
;

argument_list_prod:
      expr      { $$ = $1;}
    | argument_list_prod COMMA expr  { $$ = $1 * $3;}
;


%%



/************   Gestion des erreurs   ************/
void yyerror(char *s) {
    printf("Erreur syntaxique: %s\n", s);
}

int main() {
    printf("Entrez une expression:\n");
    yyparse();
    return 0;
}

