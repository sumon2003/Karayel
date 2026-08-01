%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h"
%}

%option noyywrap

%%



%%

int yywrap(void)
{
    return 1;
}