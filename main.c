#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"
#include "ast.h"

extern FILE *yyin;
extern int yyparse(void);
extern ASTNode *rootNode;

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
    printf("          Execution Started              \n");
    printf("=========================================\n\n");

    // 1. Parsing Phase (Build AST)
    int parseResult = yyparse();

    if (parseResult == 0 && rootNode != NULL) {
        printf("--- Program Output ---\n");
        
        // 2. Execution Phase (Run Interpreter)
        executeAST(rootNode);

        printf("----------------------\n");
        printf("\nExecution Finished Successfully.\n");
        printSymbolTable();
    } else {
        printf("\nExecution Failed due to Syntax Error.\n");
    }

    fclose(yyin);
    return 0;
}