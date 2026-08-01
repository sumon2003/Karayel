%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *message);
int yylex(void);
%}

/*=====================================================
  Keywords
=====================================================*/

%token KL
%token SHOW
%token SCAN
%token TASK
%token GIVE

%token IF
%token ELIF
%token ELSE
%token WHILE
%token FOR

%token TRUE
%token FALSE

/*=====================================================
  Identifiers & Literals
=====================================================*/

%token IDENTIFIER
%token INTEGER
%token FLOAT
%token STRING
%token CHARACTER

/*=====================================================
  Operators
=====================================================*/

%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token MODULUS

%token ASSIGN

%token PLUS_ASSIGN
%token MINUS_ASSIGN
%token MULTIPLY_ASSIGN
%token DIVIDE_ASSIGN

%token INCREMENT
%token DECREMENT

%token EQUAL
%token NOT_EQUAL

%token GREATER
%token LESS
%token GREATER_EQUAL
%token LESS_EQUAL

%token AND
%token OR
%token NOT

/*=====================================================
  Delimiters
=====================================================*/

%token LPAREN
%token RPAREN

%token LBRACE
%token RBRACE

%token COMMA

%token NEWLINE

/*=====================================================
  Operator Precedence
=====================================================*/

%left OR
%left AND

%left EQUAL NOT_EQUAL

%left GREATER LESS GREATER_EQUAL LESS_EQUAL

%left PLUS MINUS

%left MULTIPLY DIVIDE MODULUS

%right NOT

%start program

%%

program
    :
    ;

%%

void yyerror(const char *message)
{
    fprintf(stderr, "Syntax Error: %s\n", message);
}

int main(void)
{
    return yyparse();
}