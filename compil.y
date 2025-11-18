%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char *s);
%}

%token NUMBER
%token PLUS MUL MINUS DIV
%token RPAREN LPAREN
%token EOL
%token SOMME COMMA

%%

input:
    /* vide */
  | input line
;

line:
    expr EOL   { printf("= %d\n", $1); }
  | EOL
;

expr:
    expr PLUS term   { $$ = $1 + $3; }
  |  expr MINUS term  { $$ = $1 - $3; }
  | term
;

term:
    term MUL factor   { $$ = $1 * $3; }
  |  term DIV factor   { $$ = $1 / $3; }
  | factor
;

factor:
    NUMBER
    | LPAREN expr RPAREN { $$ = $2;}
    | function_call
;

function_call:
    SOMME LPAREN argument_list RPAREN { $$ = $3; }
;

argument_list:
    expr  { $$ = $1; }
    | argument_list COMMA expr { $$ = $1 + $3; }
;

%%

void yyerror(char *s) {
    printf("Erreur: %s\n", s);
}

int main() {
    printf("Tapez une expression:\n");
    yyparse();
    return 0;
}

