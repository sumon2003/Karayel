# Karayel Grammar Specification

> **Language:** Karayel  
> **Version:** 1.0  

---

# Table of Contents

1. Introduction
2. Grammar Notation
3. Program Structure
4. Statements
5. Variable Declaration & Assignment
6. Expressions & Precedence Hierarchy
7. Built-in Math & Statistical Expressions
8. Input & Output Statements
9. Conditional Statements
10. Loop Statements
11. Functions (Tasks)
12. Block & Structure Rules
13. Complete Grammar Pipeline

---

# 1. Introduction

This document defines the formal grammar of the **Karayel Programming Language**.

The grammar is written using **Backus-Naur Form (BNF)** and corresponds directly to the parsing pipeline implemented via **GNU Bison** and **Flex**.

---

# 2. Grammar Notation

Karayel uses standard **Backus-Naur Form (BNF)** notation:

| Symbol | Meaning |
| :--- | :--- |
| `< >` | Non-terminal symbol |
| `::=` | Production assignment |
| `\|` | Logical OR (Alternative production) |
| `ε` | Empty rule / Production |

---

# 3. Program Structure

A Karayel program consists of a sequence of statements executed top-to-bottom.

    <program> ::= ε
                | <program> <statement>

---

# 4. Statements

    <statement> ::= <declaration>
                  | <assignment>
                  | <show_statement>
                  | <if_statement>
                  | <while_statement>
                  | <for_statement>
                  | <function_definition>
                  | <return_statement>
                  | <comment_statement>

---

# 5. Variable Declaration & Assignment

Variables are declared using the **`KL`** keyword.

    <declaration> ::= KL IDENTIFIER '=' <expression>

    <assignment>  ::= IDENTIFIER '=' <expression>
                    | IDENTIFIER '+=' <expression>
                    | IDENTIFIER '-=' <expression>
                    | IDENTIFIER '*=' <expression>
                    | IDENTIFIER '/=' <expression>

### Examples
    KL x = 10
    x = x + 5
    x += 2

---

# 6. Expressions & Precedence Hierarchy

Expressions enforce standard mathematical and logical precedence rules.

    <expression> ::= <logical_or>

    <logical_or> ::= <logical_or> '||' <logical_and>
                   | <logical_and>

    <logical_and> ::= <logical_and> '&&' <equality>
                    | <equality>

    <equality> ::= <relational> '==' <relational>
                 | <relational> '!=' <relational>
                 | <relational>

    <relational> ::= <additive> '>' <additive>
                   | <additive> '<' <additive>
                   | <additive> '>=' <additive>
                   | <additive> '<=' <additive>
                   | <additive>

    <additive> ::= <additive> '+' <multiplicative>
                 | <additive> '-' <multiplicative>
                 | <multiplicative>

    <multiplicative> ::= <multiplicative> '*' <unary>
                       | <multiplicative> '/' <unary>
                       | <multiplicative> '%' <unary>
                       | <unary>

    <unary> ::= '!' <unary>
              | '-' <unary>
              | <primary>

    <primary> ::= NUMBER
                | FLOAT
                | STRING
                | IDENTIFIER
                | <scan_expression>
                | <builtin_math_call>
                | '(' <expression> ')'

---

# 7. Built-in Math & Statistical Expressions

Karayel includes native high-level mathematical and statistical grammar elements:

    <builtin_math_call> ::= FACTORIAL '(' <expression> ')'
                          | IS_PRIME '(' <expression> ')'
                          | FIBO '(' <expression> ')'
                          | MAX '(' <argument_list> ')'
                          | MIN '(' <argument_list> ')'
                          | AVG '(' <argument_list> ')'

    <argument_list> ::= <expression>
                      | <argument_list> ',' <expression>

### Examples
    FACTORIAL(5)
    IS_PRIME(17)
    MAX(10, 45, 89, 23)

---

# 8. Input & Output Statements

### SHOW Statement (Variadic Output)
`SHOW` accepts a comma-separated list of expressions and strings.

    <show_statement> ::= SHOW '(' <argument_list> ')'

### SCAN Expression (Interactive Input)
`SCAN` reads input interactively and can accept an optional prompt message string.

    <scan_expression> ::= SCAN '(' ')'
                        | SCAN '(' STRING ')'

### Examples
    SHOW("Value of x: ", x)
    KL age = SCAN("Enter age: ")

---

# 9. Conditional Statements

Conditional blocks support `IF`, `ELIF`, and `ELSE` structures using UPPERCASE keywords.

    <if_statement> ::= IF '(' <expression> ')' <block>
                     | IF '(' <expression> ')' <block> ELSE <block>
                     | IF '(' <expression> ')' <block> <elif_list>
                     | IF '(' <expression> ')' <block> <elif_list> ELSE <block>

    <elif_list> ::= ELIF '(' <expression> ')' <block>
                  | <elif_list> ELIF '(' <expression> ')' <block>

---

# 10. Loop Statements

### WHILE Loop
    <while_statement> ::= WHILE '(' <expression> ')' <block>

### FOR Loop
Karayel `FOR` loops use standard semicolon `;` delimiter syntax.

    <for_statement> ::= FOR '(' <declaration> ';' <expression> ';' <assignment> ')' <block>

### Example
    FOR (KL i = 1; i <= 5; i = i + 1) {
        SHOW("i = ", i)
    }

---

# 11. Functions (Tasks)

Functions are defined using **`TASK`** and return values via **`GIVE`**.

    <function_definition> ::= TASK IDENTIFIER '(' <parameter_list> ')' <block>

    <parameter_list> ::= ε
                       | IDENTIFIER
                       | <parameter_list> ',' IDENTIFIER

    <return_statement> ::= GIVE <expression>

---

# 12. Block & Structure Rules

A statement block is enclosed within standard curly braces `{}`.

    <block> ::= '{' <statement_list> '}'

    <statement_list> ::= ε
                       | <statement_list> <statement>

---

# 13. Complete Grammar Pipeline

```text
[ Source Code (.kl) ]
         │
         ▼
[ Lexer (Flex) Tokenizer ]
         │
         ▼
[ Parser (Bison Grammar) ]
         │
         ├── Declarations / Symbol Table
         ├── Control Flow (IF / WHILE / FOR)
         ├── Built-in Utilities (FACTORIAL / MAX / etc.)
         └── Dynamic I/O (SHOW / SCAN)
         │
         ▼
[ Abstract Syntax Tree (AST) Execution ]