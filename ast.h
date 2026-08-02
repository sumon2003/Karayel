#ifndef AST_H
#define AST_H

#include "symbol_table.h"

// AST Node Types
typedef enum {
    NODE_NUMBER,
    NODE_FLOAT,
    NODE_STRING,
    NODE_IDENTIFIER,
    NODE_DECLARATION,
    NODE_ASSIGNMENT,
    NODE_BINARY_OP,
    NODE_UNARY_OP,
    NODE_SHOW,
    NODE_SCAN,
    NODE_IF,
    NODE_WHILE,
    NODE_FOR,
    NODE_TASK,
    NODE_CALL,
    NODE_RETURN,
    NODE_COMPOUND
} NodeType;

// AST Node Structure
typedef struct ASTNode {
    NodeType type;
    
    // Literals & Identifiers
    char* string_val;
    int int_val;
    double float_val;
    
    // Operators
    char* op;
    
    // Child Pointers
    struct ASTNode* left;
    struct ASTNode* right;
    struct ASTNode* else_body;
    
    // For Loops
    struct ASTNode* init;
    struct ASTNode* cond;
    struct ASTNode* step;
    struct ASTNode* body;
    
    // Statements / Arguments List
    struct ASTNode** statements;
    int statement_count;
} ASTNode;

// Function Declarations
ASTNode* createNumNode(int val);
ASTNode* createFloatNode(char* val);
ASTNode* createStringNode(char* val);
ASTNode* createIdNode(char* name);
ASTNode* createDeclNode(char* name, ASTNode* expr);
ASTNode* createAssignNode(char* name, ASTNode* expr);
ASTNode* createBinOpNode(char* op, ASTNode* left, ASTNode* right);
ASTNode* createUnOpNode(char* op, ASTNode* left);
ASTNode* createShowNode(ASTNode* args);
ASTNode* createScanNode(char* prompt);
ASTNode* createIfNode(ASTNode* cond, ASTNode* body, ASTNode* else_body);
ASTNode* createWhileNode(ASTNode* cond, ASTNode* body);
ASTNode* createForNode(ASTNode* init, ASTNode* cond, ASTNode* step, ASTNode* body);
ASTNode* createTaskNode(char* name, ASTNode* params, ASTNode* body);
ASTNode* createCallNode(char* name, ASTNode* args);
ASTNode* createReturnNode(ASTNode* expr);
ASTNode* createCompoundNode();
void appendStatement(ASTNode* compound, ASTNode* stmt);

// Evaluation / Execution
int evalExpr(ASTNode* node);
void executeAST(ASTNode* node);

#endif