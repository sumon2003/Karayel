# Karayel Token Design

> **Language:** Karayel  
> **Version:** 1.0  

---

# Table of Contents

1. Introduction
2. Reserved Keywords
3. Built-in Utility Tokens
4. Literals
5. Identifiers
6. Operators
7. Delimiters
8. Comments & Whitespace
9. Token Summary

---

# 1. Introduction

This document defines the lexical tokens of the **Karayel Programming Language**.

During lexical analysis (`lexer.l`), source code is scanned character-by-character and converted into a sequence of terminal tokens passed to the **GNU Bison** parser.

---

# 2. Reserved Keywords

The following reserved words are recognized by the language engine in **UPPERCASE** and cannot be used as identifiers:

| Keyword | Token | Description |
| :--- | :--- | :--- |
| `KL` | `KL` | Variable declaration |
| `SHOW` | `SHOW` | Variadic output print |
| `SCAN` | `SCAN` | Interactive input reading |
| `TASK` | `TASK` | Function declaration |
| `GIVE` | `GIVE` | Return statement |
| `IF` | `IF` | Conditional IF block |
| `ELIF` | `ELIF` | Conditional ELIF block |
| `ELSE` | `ELSE` | Conditional ELSE block |
| `WHILE` | `WHILE` | WHILE loop structure |
| `FOR` | `FOR` | FOR loop structure |

---

# 3. Built-in Utility Tokens

Karayel includes native tokens mapped to compiler-level mathematical and statistical evaluation functions:

| Keyword | Token | Purpose |
| :--- | :--- | :--- |
| `FACTORIAL` | `FACTORIAL` | Computes factorial of a value |
| `IS_PRIME` | `IS_PRIME` | Checks primality (returns 1 or 0) |
| `FIBO` | `FIBO` | Computes nth Fibonacci number |
| `MAX` | `MAX` | Variadic maximum evaluator |
| `MIN` | `MIN` | Variadic minimum evaluator |
| `AVG` | `AVG` | Variadic average evaluator |

---

# 4. Literals

Literals represent constant atomic values in Karayel.

| Literal Type | Lexical Pattern | Example |
| :--- | :--- | :--- |
| **INTEGER** | `[0-9]+` | `25`, `-10` |
| **FLOAT** | `[0-9]+\.[0-9]+` | `3.1416`, `0.05` |
| **STRING** | `"([^"\\]|\\.)*"` | `"Hello Karayel"` |

---

# 5. Identifiers

Identifiers are user-defined names for variables and tasks.

### Rules
- Must begin with a letter (`A-Z` or `a-z`) or an underscore (`_`).
- May contain alphanumeric characters and underscores.
- Cannot begin with a digit.
- Cannot match reserved UPPERCASE keywords.
- Identifiers are strictly **case-sensitive**.

### Examples
    KL age = 20
    KL student_name = "Sumon"
    KL _total = 100

---

# 6. Operators

Karayel defines standard operators for arithmetic, assignment, relational, and logical evaluation.

### Arithmetic Operators
`+` (PLUS), `-` (MINUS), `*` (MULT), `/` (DIV), `%` (MOD)

### Assignment Operators
`=` (ASSIGN), `+=` (PLUS_ASSIGN), `-=` (MINUS_ASSIGN), `*=` (MULT_ASSIGN), `/=` (DIV_ASSIGN)

### Relational Operators
`==` (EQ), `!=` (NEQ), `>` (GT), `<` (LT), `>=` (GTE), `<=` (LTE)

### Logical Operators
`&&` (AND), `||` (OR), `!` (NOT)

---

# 7. Delimiters

Delimiters separate code constructs, statement blocks, and parameter lists:

| Symbol | Token | Purpose |
| :--- | :--- | :--- |
| `(` | `LPAREN` | Left Parenthesis |
| `)` | `RPAREN` | Right Parenthesis |
| `{` | `LBRACE` | Scope Block Start |
| `}` | `RBRACE` | Scope Block End |
| `,` | `COMMA` | Argument/Parameter Separator |
| `;` | `SEMICOLON` | Loop / Expression Delimiter |

---

# 8. Comments & Whitespace

### Single-Line Comments
Starts with `::` and continues until the end of the line.

    :: This is a single-line comment

### Multi-Line Comments
Enclosed between `:::` and `:::`.

    :::
      Multi-line comment block
      ignored by Flex lexer.
    :::

### Whitespace
Standard whitespace characters (spaces, tabs `\t`, carriage returns `\r`, and newlines `\n`) are skipped automatically by the lexical analyzer.

---

# 9. Token Summary

### Reserved Keywords & Utilities
    KL
    SHOW
    SCAN
    TASK
    GIVE
    IF
    ELIF
    ELSE
    WHILE
    FOR
    FACTORIAL
    IS_PRIME
    FIBO
    MAX
    MIN
    AVG

### Literals & Identifiers
    INTEGER
    FLOAT
    STRING
    IDENTIFIER

### Operators
    +   -   *   /   %
    =   +=  -=  *=  /=
    ==  !=  >   <   >=  <=
    &&  ||  !

### Delimiters
    (   )
    {   }
    ,   ;

### Special Tokens
    YYEOF (End of File)