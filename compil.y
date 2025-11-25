%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/* Structure pour gérer les arguments de moyenne */
typedef struct {
    double sum;
    int count;
} AvgData;

typedef struct {
    double sum;
    double sum_of_squares;
    int count;
}VarianceData;

int yylex();
void yyerror(char *s);

%}

/* Union pour stocker les types */
%union {
    double val;       // pour expr, term, factor
    AvgData avg;   // pour moyenne
    VarianceData var;
}

/* Déclaration des tokens */
%token <val> NUMBER
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN
%token SOMME MOYENNE
%token PRODUIT VARIANCE ECART_TYPE
%token COMMA
%token EOL

/* Déclaration des types des règles */
%type <val> expr term factor function_somme function_moyenne function_produit
function_variance function_ecart_type
%type <avg> argument_list_avg
%type <val> argument_list_sum  argument_list_prod
%type <var> argument_list_var


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
    | term DIV factor    { $$ = $1 / $3; }
    | factor
;

factor:
      NUMBER                   { $$ = $1; }
    | LPAREN expr RPAREN       { $$ = $2; }
    | function_somme
    | function_moyenne
    | function_produit
    | function_variance
    | function_ecart_type
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


/************   Fonction variance(...)   ************/
function_variance:
      VARIANCE LPAREN argument_list_var RPAREN
      {
          if ($3.count == 0){
              yyerror("Pas d'arguments dans variance()");
              $$ = 0;
          }else {
              double mean = $3.sum / $3.count;
              $$ = ($3.sum_of_squares / $3.count) - (mean * mean);
          }
      }
;

argument_list_var:
      expr
      {
          $$.sum = $1;
          $$.sum_of_squares = $1 * $1;
          $$.count = 1;
      }
      | argument_list_var COMMA expr
      {
          $$.sum = $1.sum + $3;
          $$.sum_of_squares = $1.sum_of_squares + ($3 * $3);
          $$.count = $1.count + 1;
      }
;


/************   Fonction ecart_type(...)   ************/

function_ecart_type:
      ECART_TYPE LPAREN argument_list_var RPAREN
      {
          if ($3.count == 0){
              yyerror("Pas d'argument dans ecart_type");
              $$ = 0;
          } else {
              double mean = $3.sum / $3.count;
              double variance = ($3.sum_of_squares / $3.count) - (mean * mean);
              $$ = sqrt(variance);
          }
      }
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

