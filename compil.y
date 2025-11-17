%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(char *s);
%}

%token NUMBER
%token PLUS MUL MINUS
%token LPAREN RPAREN
%token EOL

%%
input:
     | input line
;

line:
    expr EOL {printf("Expression Correct!\n");}
    | EOL
;

expr:
	expr PLUS term
    |	expr MINUS term
    |	term
;

term:
    term MUL factor
    | factor
;

factor:
      NUMBER
      |	LPAREN expr RPAREN
;

%%

void yyerror(char *s){
    printf("Expression Fausse !\n");
}

int main(){
    printf("Enter Something : \n");
    yyparse();
    return 0;
}
