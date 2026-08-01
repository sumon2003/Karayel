#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "symbol_table.h"

static Symbol symbolTable[MAX_SYMBOLS];
static int symbolCount = 0;

void initSymbolTable(void)
{
    symbolCount = 0;
}

int searchSymbol(const char *name)
{
    for (int i = 0; i < symbolCount; i++)
    {
        if (strcmp(symbolTable[i].name, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

int insertSymbol(const char *name, DataType type)
{
    if (symbolCount >= MAX_SYMBOLS)
    {
        printf("Semantic Error: Symbol table is full.\n");
        return 0;
    }

    int idx = searchSymbol(name);
    if (idx != -1)
    {
        return 1;
    }

    strcpy(symbolTable[symbolCount].name, name);
    strcpy(symbolTable[symbolCount].value, "nil");
    symbolTable[symbolCount].type = type;
    symbolTable[symbolCount].scope = 0;
    symbolTable[symbolCount].isInitialized = 0;

    symbolCount++;
    return 1;
}

int updateSymbolValue(const char *name, const char *val, DataType type)
{
    int index = searchSymbol(name);

    if (index == -1)
    {
        printf("Semantic Error: Variable '%s' is not declared.\n", name);
        return 0;
    }

    if (val != NULL) {
        strncpy(symbolTable[index].value, val, MAX_VALUE_LENGTH - 1);
        symbolTable[index].value[MAX_VALUE_LENGTH - 1] = '\0';
    }
    symbolTable[index].type = type;
    symbolTable[index].isInitialized = 1;

    return 1;
}

char* getSymbolValue(const char *name)
{
    int index = searchSymbol(name);
    if (index != -1 && symbolTable[index].isInitialized)
    {
        return symbolTable[index].value;
    }
    return NULL;
}

DataType getSymbolType(const char *name)
{
    int index = searchSymbol(name);
    if (index != -1)
    {
        return symbolTable[index].type;
    }
    return TYPE_UNKNOWN;
}

void printSymbolTable(void)
{
    printf("\n=========================================================\n");
    printf("                      SYMBOL TABLE\n");
    printf("=========================================================\n");

    printf("%-5s %-15s %-15s %-10s %-8s %-8s\n",
           "No", "Name", "Value", "Type", "Scope", "Init");

    for (int i = 0; i < symbolCount; i++)
    {
        char typeStr[12];
        switch(symbolTable[i].type) {
            case TYPE_INT: strcpy(typeStr, "INTEGER"); break;
            case TYPE_FLOAT: strcpy(typeStr, "FLOAT"); break;
            case TYPE_STRING: strcpy(typeStr, "STRING"); break;
            case TYPE_BOOL: strcpy(typeStr, "BOOL"); break;
            default: strcpy(typeStr, "UNKNOWN"); break;
        }

        printf("%-5d %-15s %-15s %-10s %-8d %-8s\n",
               i + 1,
               symbolTable[i].name,
               symbolTable[i].value,
               typeStr,
               symbolTable[i].scope,
               symbolTable[i].isInitialized ? "YES" : "NO");
    }

    printf("=========================================================\n");
}