%{
/*
=========================================================
    Karayel Programming Language
    Parser (Bison) - Extended with Smart Math & Utilities
=========================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"
#include "ast.h"

void yyerror(const char *message);
int yylex(void);

ASTNode *rootNode = NULL;

%}

%union
{
    char *string;
    int number;
    struct ASTNode *node;
}

%token KL
%token SHOW SCAN
%token IF ELIF ELSE
%token WHILE FOR
%token TASK GIVE
%token TRUE FALSE

/* New Math & Stat Analytics Tokens */
%token FACTORIAL MAX MIN AVG IS_PRIME FIBO

%token <string> IDENTIFIER
%token <string> STRING
%token <string> CHARACTER
%token <number> INTEGER
%token <string> FLOAT

%token PLUS MINUS MULTIPLY DIVIDE MODULUS
%token ASSIGN
%token PLUS_ASSIGN MINUS_ASSIGN MULTIPLY_ASSIGN DIVIDE_ASSIGN
%token INCREMENT DECREMENT
%token EQUAL NOT_EQUAL
%token GREATER LESS
%token GREATER_EQUAL LESS_EQUAL
%token AND OR NOT
%token LPAREN RPAREN
%token LBRACE RBRACE
%token COMMA SEMICOLON
%token NEWLINE

%type <node> program statements statement declaration assignment show_statement 
%type <node> if_statement else_block while_statement for_statement for_init 
%type <node> expression scan_expression block task_definition function_call return_statement argument_list

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
    : statements { rootNode = $1; }
    ;

statements
    : { $$ = createCompoundNode(); }
    | statements statement {
        if ($2 != NULL) {
            appendStatement($1, $2);
        }
        $$ = $1;
    }
    ;

opt_newlines
    :
    | opt_newlines NEWLINE
    ;

opt_semicolon
    :
    | SEMICOLON
    ;

declaration
    : KL IDENTIFIER { 
        $$ = createDeclNode($2, NULL); 
    }
    | KL IDENTIFIER ASSIGN expression { 
        $$ = createDeclNode($2, $4); 
    }
    ;

assignment
    : IDENTIFIER ASSIGN expression { 
        $$ = createAssignNode($1, $3); 
    }
    | IDENTIFIER PLUS_ASSIGN expression {
        $$ = createAssignNode($1, createBinOpNode("+", createIdNode($1), $3));
    }
    | IDENTIFIER MINUS_ASSIGN expression {
        $$ = createAssignNode($1, createBinOpNode("-", createIdNode($1), $3));
    }
    | IDENTIFIER MULTIPLY_ASSIGN expression {
        $$ = createAssignNode($1, createBinOpNode("*", createIdNode($1), $3));
    }
    | IDENTIFIER DIVIDE_ASSIGN expression {
        $$ = createAssignNode($1, createBinOpNode("/", createIdNode($1), $3));
    }
    | IDENTIFIER INCREMENT {
        $$ = createAssignNode($1, createBinOpNode("+", createIdNode($1), createNumNode(1)));
    }
    | IDENTIFIER DECREMENT {
        $$ = createAssignNode($1, createBinOpNode("-", createIdNode($1), createNumNode(1)));
    }
    ;

show_statement
    : SHOW LPAREN argument_list RPAREN { 
        $$ = createShowNode($3); 
    }
    ;

argument_list
    : expression {
        ASTNode* list = createCompoundNode();
        appendStatement(list, $1);
        $$ = list;
    }
    | argument_list COMMA expression {
        appendStatement($1, $3);
        $$ = $1;
    }
    ;

scan_expression
    : SCAN LPAREN RPAREN {
        $$ = createScanNode(NULL);
    }
    | SCAN LPAREN STRING RPAREN {
        $$ = createScanNode($3);
    }
    ;

expression
    : expression PLUS expression { $$ = createBinOpNode("+", $1, $3); }
    | expression MINUS expression { $$ = createBinOpNode("-", $1, $3); }
    | expression MULTIPLY expression { $$ = createBinOpNode("*", $1, $3); }
    | expression DIVIDE expression { $$ = createBinOpNode("/", $1, $3); }
    | expression MODULUS expression { $$ = createBinOpNode("%", $1, $3); }
    | expression GREATER expression { $$ = createBinOpNode(">", $1, $3); }
    | expression LESS expression { $$ = createBinOpNode("<", $1, $3); }
    | expression GREATER_EQUAL expression { $$ = createBinOpNode(">=", $1, $3); }
    | expression LESS_EQUAL expression { $$ = createBinOpNode("<=", $1, $3); }
    | expression EQUAL expression { $$ = createBinOpNode("==", $1, $3); }
    | expression NOT_EQUAL expression { $$ = createBinOpNode("!=", $1, $3); }
    | expression AND expression { $$ = createBinOpNode("&&", $1, $3); }
    | expression OR expression { $$ = createBinOpNode("||", $1, $3); }
    | NOT expression { $$ = createUnOpNode("!", $2); }
    
    /* --- New Built-in Math & Stat Utilities Expressions --- */
    | FACTORIAL LPAREN expression RPAREN { 
        $$ = createUnOpNode("FACTORIAL", $3); 
    }
    | IS_PRIME LPAREN expression RPAREN { 
        $$ = createUnOpNode("IS_PRIME", $3); 
    }
    | FIBO LPAREN expression RPAREN { 
        $$ = createUnOpNode("FIBO", $3); 
    }
    | MAX LPAREN argument_list RPAREN { 
        $$ = createUnOpNode("MAX", $3); 
    }
    | MIN LPAREN argument_list RPAREN { 
        $$ = createUnOpNode("MIN", $3); 
    }
    | AVG LPAREN argument_list RPAREN { 
        $$ = createUnOpNode("AVG", $3); 
    }

    | LPAREN expression RPAREN { $$ = $2; }
    | scan_expression { $$ = $1; }
    | IDENTIFIER { $$ = createIdNode($1); }
    | INTEGER { $$ = createNumNode($1); }
    | FLOAT { $$ = createFloatNode($1); }
    | STRING { $$ = createStringNode($1); }
    | CHARACTER { $$ = createStringNode($1); }
    | TRUE { $$ = createNumNode(1); }
    | FALSE { $$ = createNumNode(0); }
    ;

block
    : LBRACE opt_newlines statements RBRACE { $$ = $3; }
    ;

if_statement
    : IF LPAREN expression RPAREN opt_newlines block opt_newlines else_block {
        $$ = createIfNode($3, $6, $8);
    }
    | IF LPAREN expression RPAREN opt_newlines block {
        $$ = createIfNode($3, $6, NULL);
    }
    ;

else_block
    : ELSE opt_newlines block { $$ = $3; }
    ;

while_statement
    : WHILE LPAREN expression RPAREN opt_newlines block {
        $$ = createWhileNode($3, $6);
    }
    ;

for_init
    : declaration { $$ = $1; }
    | assignment { $$ = $1; }
    ;

for_statement
    : FOR LPAREN for_init SEMICOLON expression SEMICOLON assignment RPAREN opt_newlines block {
        $$ = createForNode($3, $5, $7, $10);
    }
    ;

task_definition
    : TASK IDENTIFIER LPAREN RPAREN opt_newlines block {
        $$ = createTaskNode($2, NULL, $6);
    }
    ;

function_call
    : IDENTIFIER LPAREN RPAREN {
        $$ = createCallNode($1, NULL);
    }
    ;

return_statement
    : GIVE expression {
        $$ = createReturnNode($2);
    }
    ;

statement
    : declaration opt_semicolon opt_newlines { $$ = $1; }
    | assignment opt_semicolon opt_newlines { $$ = $1; }
    | show_statement opt_semicolon opt_newlines { $$ = $1; }
    | if_statement opt_newlines { $$ = $1; }
    | while_statement opt_newlines { $$ = $1; }
    | for_statement opt_newlines { $$ = $1; }
    | task_definition opt_newlines { $$ = $1; }
    | function_call opt_semicolon opt_newlines { $$ = $1; }
    | return_statement opt_semicolon opt_newlines { $$ = $1; }
    | NEWLINE { $$ = NULL; }
    ;

%%

extern int yylineno;

void yyerror(const char *message)
{
    fprintf(stderr, "\nSyntax Error at line %d: %s\n", yylineno, message);
}