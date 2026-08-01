%{
/*
=========================================================
    Karayel Programming Language
    Parser (Bison) - Production Ready & Flexible Newline
=========================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

void yyerror(const char *message);
int yylex(void);

%}

%union
{
    char *string;
    int number;
    struct {
        char *val;
        int type;
    } expr;
}

%token KL
%token SHOW SCAN
%token IF ELIF ELSE
%token WHILE FOR
%token TASK GIVE
%token TRUE FALSE

%token <string> IDENTIFIER
%token <string> STRING
%token <string> CHARACTER
%token <number> INTEGER
%token <string> FLOAT

%type <expr> expression
%type <string> scan_expression

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
%token COMMA
%token NEWLINE

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
    | program statement
    ;

opt_newlines
    :
    | opt_newlines NEWLINE
    ;

declaration
    : KL IDENTIFIER {
        insertSymbol($2, TYPE_UNKNOWN);
    }
    | KL IDENTIFIER ASSIGN expression {
        insertSymbol($2, (DataType)$4.type);
        updateSymbolValue($2, $4.val, (DataType)$4.type);
    }
    ;

assignment
    : IDENTIFIER ASSIGN expression {
        updateSymbolValue($1, $3.val, (DataType)$3.type);
    }
    | IDENTIFIER PLUS_ASSIGN expression
    | IDENTIFIER MINUS_ASSIGN expression
    | IDENTIFIER MULTIPLY_ASSIGN expression
    | IDENTIFIER DIVIDE_ASSIGN expression
    | IDENTIFIER INCREMENT
    | IDENTIFIER DECREMENT
    ;

show_statement
    : SHOW LPAREN expression RPAREN {
        if ($3.val != NULL) {
            if ($3.val[0] == '"') {
                int len = strlen($3.val);
                if (len > 1 && $3.val[len-1] == '"') {
                    $3.val[len-1] = '\0';
                    printf("%s\n", $3.val + 1);
                } else {
                    printf("%s\n", $3.val);
                }
            } else {
                printf("%s\n", $3.val);
            }
        } else {
            printf("nil\n");
        }
    }
    ;

scan_expression
    : SCAN LPAREN RPAREN {
        static char input_buf[256];
        if (fgets(input_buf, sizeof(input_buf), stdin)) {
            input_buf[strcspn(input_buf, "\r\n")] = 0;
        }
        $$ = strdup(input_buf);
    }
    | SCAN LPAREN STRING RPAREN {
        static char input_buf[256];
        if ($3 != NULL) {
            char prompt[256];
            strncpy(prompt, $3, sizeof(prompt));
            int len = strlen(prompt);
            if (len > 1 && prompt[len-1] == '"') prompt[len-1] = '\0';
            if (prompt[0] == '"') printf("%s", prompt + 1);
            else printf("%s", prompt);
            fflush(stdout);
        }
        if (fgets(input_buf, sizeof(input_buf), stdin)) {
            input_buf[strcspn(input_buf, "\r\n")] = 0;
        }
        $$ = strdup(input_buf);
    }
    ;

expression
    : expression PLUS expression { $$.val = $1.val; $$.type = $1.type; }
    | expression MINUS expression { $$.val = $1.val; $$.type = $1.type; }
    | expression MULTIPLY expression { $$.val = $1.val; $$.type = $1.type; }
    | expression DIVIDE expression { $$.val = $1.val; $$.type = $1.type; }
    | expression MODULUS expression { $$.val = $1.val; $$.type = $1.type; }
    | expression GREATER expression { $$.val = "true"; $$.type = TYPE_BOOL; }
    | expression LESS expression { $$.val = "true"; $$.type = TYPE_BOOL; }
    | expression GREATER_EQUAL expression {
        int val1 = atoi($1.val);
        int val2 = atoi($3.val);
        $$.val = (val1 >= val2) ? "true" : "false";
        $$.type = TYPE_BOOL;
    }
    | expression LESS_EQUAL expression { $$.val = "true"; $$.type = TYPE_BOOL; }
    | expression EQUAL expression { $$.val = "true"; $$.type = TYPE_BOOL; }
    | expression NOT_EQUAL expression { $$.val = "false"; $$.type = TYPE_BOOL; }
    | expression AND expression { $$.val = "true"; $$.type = TYPE_BOOL; }
    | expression OR expression { $$.val = "true"; $$.type = TYPE_BOOL; }
    | NOT expression { $$.val = "false"; $$.type = TYPE_BOOL; }
    | LPAREN expression RPAREN { $$ = $2; }
    | scan_expression {
        $$.val = $1;
        $$.type = TYPE_STRING;
    }
    | IDENTIFIER {
        int idx = searchSymbol($1);
        if (idx == -1) {
            printf("Semantic Error: Variable '%s' used before declaration.\n", $1);
            $$.val = "nil";
            $$.type = TYPE_UNKNOWN;
        } else {
            char* val = getSymbolValue($1);
            $$.val = val ? strdup(val) : "nil";
            $$.type = getSymbolType($1);
        }
    }
    | INTEGER {
        char buf[32];
        snprintf(buf, sizeof(buf), "%d", $1);
        $$.val = strdup(buf);
        $$.type = TYPE_INT;
    }
    | FLOAT { 
        $$.val = $1; 
        $$.type = TYPE_FLOAT;
    }
    | STRING { 
        $$.val = $1; 
        $$.type = TYPE_STRING;
    }
    | CHARACTER { 
        $$.val = $1; 
        $$.type = TYPE_STRING;
    }
    | TRUE { $$.val = "true"; $$.type = TYPE_BOOL; }
    | FALSE { $$.val = "false"; $$.type = TYPE_BOOL; }
    ;

block
    : LBRACE opt_newlines statements RBRACE
    ;

statements
    :
    | statements statement
    ;

if_statement
    : IF LPAREN expression RPAREN opt_newlines block opt_newlines else_block
    | IF LPAREN expression RPAREN opt_newlines block
    ;

else_block
    : ELSE opt_newlines block
    ;

while_statement
    : WHILE LPAREN expression RPAREN opt_newlines block
    ;

for_statement
    : FOR LPAREN assignment NEWLINE expression NEWLINE assignment RPAREN opt_newlines block
    ;

task_definition
    : TASK IDENTIFIER LPAREN RPAREN opt_newlines block
    | TASK IDENTIFIER LPAREN parameter_list RPAREN opt_newlines block
    ;

parameter_list
    : IDENTIFIER
    | parameter_list COMMA IDENTIFIER
    ;

function_call
    : IDENTIFIER LPAREN RPAREN
    | IDENTIFIER LPAREN argument_list RPAREN
    ;

argument_list
    : expression
    | argument_list COMMA expression
    ;

return_statement
    : GIVE expression
    ;

statement
    : declaration opt_newlines
    | assignment opt_newlines
    | show_statement opt_newlines
    | if_statement opt_newlines
    | while_statement opt_newlines
    | for_statement opt_newlines
    | task_definition opt_newlines
    | function_call opt_newlines
    | return_statement opt_newlines
    | NEWLINE
    ;

%%

extern int yylineno;

void yyerror(const char *message)
{
    fprintf(stderr, "\nSyntax Error at line %d: %s\n", yylineno, message);
}