#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"

extern FILE *yyin;
extern int yyparse(void);

int main(int argc, char *argv[])
{
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Usage: %s <filename.kl>\n", argv[0]);
        return 1;
    }

    initSymbolTable();

    printf("=========================================\n");
    printf("     Karayel Programming Language        \n");
    printf("          Compiler Started               \n");
    printf("=========================================\n\n");

    int parseResult = yyparse();

    if (parseResult == 0) {
        printf("\nParsing Finished Successfully.\n");
        printSymbolTable();
    } else {
        printf("\nParsing Failed due to Syntax Error.\n");
    }

    fclose(yyin);
    return 0;
}