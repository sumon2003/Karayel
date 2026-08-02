#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

ASTNode* createNumNode(int val) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_NUMBER;
    node->int_val = val;
    return node;
}

ASTNode* createFloatNode(char* val) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_FLOAT;
    node->float_val = atof(val);
    node->string_val = strdup(val);
    return node;
}

ASTNode* createStringNode(char* val) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_STRING;
    node->string_val = strdup(val);
    return node;
}

ASTNode* createIdNode(char* name) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_IDENTIFIER;
    node->string_val = strdup(name);
    return node;
}

ASTNode* createDeclNode(char* name, ASTNode* expr) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_DECLARATION;
    node->string_val = strdup(name);
    node->left = expr;
    return node;
}

ASTNode* createAssignNode(char* name, ASTNode* expr) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_ASSIGNMENT;
    node->string_val = strdup(name);
    node->left = expr;
    return node;
}

ASTNode* createBinOpNode(char* op, ASTNode* left, ASTNode* right) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_BINARY_OP;
    node->op = strdup(op);
    node->left = left;
    node->right = right;
    return node;
}

ASTNode* createUnOpNode(char* op, ASTNode* left) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_UNARY_OP;
    node->op = strdup(op);
    node->left = left;
    return node;
}

ASTNode* createShowNode(ASTNode* args) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_SHOW;
    node->left = args;
    return node;
}

ASTNode* createScanNode(char* prompt) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_SCAN;
    if (prompt) node->string_val = strdup(prompt);
    return node;
}

ASTNode* createIfNode(ASTNode* cond, ASTNode* body, ASTNode* else_body) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_IF;
    node->cond = cond;
    node->body = body;
    node->else_body = else_body;
    return node;
}

ASTNode* createWhileNode(ASTNode* cond, ASTNode* body) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_WHILE;
    node->cond = cond;
    node->body = body;
    return node;
}

ASTNode* createForNode(ASTNode* init, ASTNode* cond, ASTNode* step, ASTNode* body) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_FOR;
    node->init = init;
    node->cond = cond;
    node->step = step;
    node->body = body;
    return node;
}

ASTNode* createTaskNode(char* name, ASTNode* params, ASTNode* body) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_TASK;
    node->string_val = strdup(name);
    node->left = params;
    node->body = body;
    return node;
}

ASTNode* createCallNode(char* name, ASTNode* args) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_CALL;
    node->string_val = strdup(name);
    node->left = args;
    return node;
}

ASTNode* createReturnNode(ASTNode* expr) {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_RETURN;
    node->left = expr;
    return node;
}

ASTNode* createCompoundNode() {
    ASTNode* node = calloc(1, sizeof(ASTNode));
    node->type = NODE_COMPOUND;
    node->statements = NULL;
    node->statement_count = 0;
    return node;
}

void appendStatement(ASTNode* compound, ASTNode* stmt) {
    if (!stmt) return;
    compound->statement_count++;
    compound->statements = realloc(compound->statements, sizeof(ASTNode*) * compound->statement_count);
    compound->statements[compound->statement_count - 1] = stmt;
}

// Expression Evaluation
int evalExpr(ASTNode* node) {
    if (!node) return 0;

    if (node->type == NODE_NUMBER) return node->int_val;

    // --- SCAN (Runtime Input) Support ---
    if (node->type == NODE_SCAN) {
        if (node->string_val) {
            // যদি SCAN("Enter number: ") এর মতো মেসেজ থাকে
            char* str = node->string_val;
            int len = strlen(str);
            if (len >= 2 && str[0] == '"' && str[len - 1] == '"') {
                for (int i = 1; i < len - 1; i++) putchar(str[i]);
            } else {
                printf("%s", str);
            }
            fflush(stdout);
        }
        int val = 0;
        scanf("%d", &val); // ইউজার থেকে ইনপুট নেওয়া
        return val;
    }
    
    if (node->type == NODE_IDENTIFIER) {
        char* val = getSymbolValue(node->string_val);
        return val ? atoi(val) : 0;
    }
    
    if (node->type == NODE_UNARY_OP) {
        if (strcmp(node->op, "!") == 0) return !evalExpr(node->left);
    }

    if (node->type == NODE_BINARY_OP) {
        int leftVal = evalExpr(node->left);
        int rightVal = evalExpr(node->right);
        
        if (strcmp(node->op, "+") == 0) return leftVal + rightVal;
        if (strcmp(node->op, "-") == 0) return leftVal - rightVal;
        if (strcmp(node->op, "*") == 0) return leftVal * rightVal;
        if (strcmp(node->op, "/") == 0) return rightVal != 0 ? leftVal / rightVal : 0;
        if (strcmp(node->op, "%") == 0) return rightVal != 0 ? leftVal % rightVal : 0;
        if (strcmp(node->op, "<") == 0) return leftVal < rightVal;
        if (strcmp(node->op, ">") == 0) return leftVal > rightVal;
        if (strcmp(node->op, "<=") == 0) return leftVal <= rightVal;
        if (strcmp(node->op, ">=") == 0) return leftVal >= rightVal;
        if (strcmp(node->op, "==") == 0) return leftVal == rightVal;
        if (strcmp(node->op, "!=") == 0) return leftVal != rightVal;
        if (strcmp(node->op, "&&") == 0) return leftVal && rightVal;
        if (strcmp(node->op, "||") == 0) return leftVal || rightVal;
    }
    return 0;
}

// Print single value in SHOW
static void printValue(ASTNode* node) {
    if (!node) return;

    if (node->type == NODE_STRING) {
        char* str = node->string_val;
        int len = strlen(str);
        if (len >= 2 && str[0] == '"' && str[len - 1] == '"') {
            for (int i = 1; i < len - 1; i++) {
                putchar(str[i]);
            }
        } else {
            printf("%s", str);
        }
    } else if (node->type == NODE_NUMBER) {
        printf("%d", node->int_val);
    } else if (node->type == NODE_FLOAT) {
        printf("%f", node->float_val);
    } else if (node->type == NODE_IDENTIFIER) {
        char* val = getSymbolValue(node->string_val);
        if (val) {
            int len = strlen(val);
            if (len >= 2 && val[0] == '"' && val[len - 1] == '"') {
                for (int i = 1; i < len - 1; i++) putchar(val[i]);
            } else {
                printf("%s", val);
            }
        } else {
            printf("nil");
        }
    } else {
        printf("%d", evalExpr(node));
    }
}

// AST Execution
void executeAST(ASTNode* node) {
    if (!node) return;

    switch (node->type) {
        case NODE_COMPOUND: {
            for (int i = 0; i < node->statement_count; i++) {
                executeAST(node->statements[i]);
            }
            break;
        }
        case NODE_SHOW: {
            ASTNode* args = node->left;
            if (args && args->type == NODE_COMPOUND) {
                for (int i = 0; i < args->statement_count; i++) {
                    printValue(args->statements[i]);
                }
            } else if (args) {
                printValue(args);
            }
            printf("\n");
            break;
        }
        case NODE_DECLARATION: {
            insertSymbol(node->string_val, TYPE_INT);
            if (node->left) {
                int val = evalExpr(node->left);
                char buf[32];
                snprintf(buf, sizeof(buf), "%d", val);
                updateSymbolValue(node->string_val, buf, TYPE_INT);
            }
            break;
        }
        case NODE_ASSIGNMENT: {
            int val = evalExpr(node->left);
            char buf[32];
            snprintf(buf, sizeof(buf), "%d", val);
            updateSymbolValue(node->string_val, buf, TYPE_INT);
            break;
        }
        case NODE_IF: {
            if (evalExpr(node->cond)) {
                executeAST(node->body);
            } else if (node->else_body) {
                executeAST(node->else_body);
            }
            break;
        }
        case NODE_WHILE: {
            while (evalExpr(node->cond)) {
                executeAST(node->body);
            }
            break;
        }
        case NODE_FOR: {
            executeAST(node->init);
            while (evalExpr(node->cond)) {
                executeAST(node->body);
                executeAST(node->step);
            }
            break;
        }
        default:
            break;
    }
}