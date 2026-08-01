#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#define MAX_SYMBOLS 1000
#define MAX_NAME_LENGTH 100
#define MAX_VALUE_LENGTH 256

typedef enum
{
    TYPE_UNKNOWN = 0,
    TYPE_INT,
    TYPE_FLOAT,
    TYPE_STRING,
    TYPE_BOOL
} DataType;

typedef struct
{
    char name[MAX_NAME_LENGTH];
    char value[MAX_VALUE_LENGTH];
    DataType type;
    int scope;
    int isInitialized;
} Symbol;

void initSymbolTable(void);
int insertSymbol(const char *name, DataType type);
int searchSymbol(const char *name);
int updateSymbolValue(const char *name, const char *val, DataType type);
char* getSymbolValue(const char *name);
DataType getSymbolType(const char *name);
void printSymbolTable(void);

#endif