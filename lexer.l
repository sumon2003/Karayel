%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h"
#include "keyword_table.h"
%}

%option noyywrap
%option yylineno
%option nounput noinput

%x COMMENT

LETTER          [A-Za-z]
DIGIT           [0-9]

ID              {LETTER}({LETTER}|{DIGIT}|_)*

FLOAT_LITERAL   {DIGIT}+"."{DIGIT}+
INT_LITERAL     {DIGIT}+

STRING_LITERAL  \"([^\\\"\n]|\\.)*\"
CHAR_LITERAL    \'([^\\\'\n]|\\.)\'

WHITESPACE      [ \t\r]+

%%

":::" {
    BEGIN(COMMENT);
}

<COMMENT>":::" {
    BEGIN(INITIAL);
}

<COMMENT>.|\n {
}

"::"[^\n]* {
}

{WHITESPACE} {
}

"FACTORIAL" { return FACTORIAL; }
"MAX"       { return MAX; }
"MIN"       { return MIN; }
"AVG"       { return AVG; }
"IS_PRIME"  { return IS_PRIME; }
"FIBO"      { return FIBO; }

{FLOAT_LITERAL} {
    yylval.string = strdup(yytext);
    return FLOAT;
}

{INT_LITERAL} {
    yylval.number = atoi(yytext);
    return INTEGER;
}

{STRING_LITERAL} {
    yylval.string = strdup(yytext);
    return STRING;
}

{CHAR_LITERAL} {
    yylval.string = strdup(yytext);
    return CHARACTER;
}

{ID} {
    int tok = checkKeyword(yytext);
    if (tok == IDENTIFIER) {
        yylval.string = strdup(yytext);
    }
    return tok;
}

"+=" { return PLUS_ASSIGN; }
"-=" { return MINUS_ASSIGN; }
"*=" { return MULTIPLY_ASSIGN; }
"/=" { return DIVIDE_ASSIGN; }
"++" { return INCREMENT; }
"--" { return DECREMENT; }
"==" { return EQUAL; }
"!=" { return NOT_EQUAL; }
">=" { return GREATER_EQUAL; }
"<=" { return LESS_EQUAL; }
"&&" { return AND; }
"||" { return OR; }
"="  { return ASSIGN; }
">"  { return GREATER; }
"<"  { return LESS; }
"!"  { return NOT; }
"+"  { return PLUS; }
"-"  { return MINUS; }
"*"  { return MULTIPLY; }
"/"  { return DIVIDE; }
"%"  { return MODULUS; }
"("  { return LPAREN; }
")"  { return RPAREN; }
"{"  { return LBRACE; }
"}"  { return RBRACE; }
","  { return COMMA; }
";"  { return SEMICOLON; }

\n {
    return NEWLINE;
}

. {
    printf("Lexical Error: Unknown Character '%c' at line %d\n", yytext[0], yylineno);
}

%%