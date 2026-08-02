# Karayel Programming Language Specification

> **Version:** 1.0  
> **Language Name:** Karayel  
> **File Extension:** `.kl`

---

# Table of Contents

1. Introduction
2. Design Goals
3. File Extension
4. Reserved Keywords
5. Keyword Naming Convention
6. Variable Declaration & Dynamic Typing
7. Variable Assignment & Scope
8. Supported Data Types
9. Identifier Rules
10. Case Sensitivity
11. Operators
12. Comments
13. Input & Output System
14. Control Flow Constructs
15. Built-in Math & Statistical Suite
16. Functions (Tasks)
17. Full Specification Example
18. Version & Implementation Information

---

# 1. Introduction

Karayel is a custom imperative programming language developed using **C**, **Flex**, and **Bison**.

The language translates source code into an **Abstract Syntax Tree (AST)** and evaluates it in real-time using an integrated runtime environment and symbol table engine. Karayel supports clean syntax, dynamic state management, control flows, functions, and native math/statistical utilities.

---

# 2. Design Goals

- Simple, clean, and modern syntax.
- Lightweight dynamic symbol management.
- Built-in math and statistical evaluation suite.
- Clean AST-based execution pipeline.
- Educational reference for compiler architecture using Flex and Bison.

---

# 3. File Extension

All Karayel source code files use the `.kl` extension.

    program.kl
    demo.kl
    math_test.kl

---

# 4. Reserved Keywords

The following words are reserved by the language engine in **UPPERCASE** and cannot be used as variable or function identifiers:

| Keyword | Purpose |
| :--- | :--- |
| `KL` | Variable declaration |
| `SHOW` | Output printing (variadic & auto-casting) |
| `SCAN` | Interactive input reading |
| `TASK` | Function declaration |
| `GIVE` | Return statement |
| `IF` | Conditional statement |
| `ELIF` | Else-if statement |
| `ELSE` | Else statement |
| `WHILE` | While loop construct |
| `FOR` | For loop construct |
| `FACTORIAL` | Built-in math function |
| `IS_PRIME` | Built-in primality test function |
| `FIBO` | Built-in Fibonacci number generator |
| `MAX` | Variadic max evaluator |
| `MIN` | Variadic min evaluator |
| `AVG` | Variadic average evaluator |

---

# 5. Keyword Naming Convention

- All language keywords must be written in **UPPERCASE** (e.g., `KL`, `SHOW`, `IF`, `WHILE`).
- Lowercase or mixed-case variants (like `show`, `If`, `kl`) are strictly invalid keywords and will result in parsing errors.

---

# 6. Variable Declaration & Dynamic Typing

Variables are declared using the **`KL`** keyword. Karayel dynamically tracks types in the symbol table based on the evaluated expression.

### Syntax
    KL <variable_name> = <expression>

### Examples
    KL age = 20
    KL cgpa = 3.90
    KL name = "Sumon"

---

# 7. Variable Assignment & Scope

After declaration, variables can be reassigned directly without using the `KL` keyword.

    KL count = 10
    count = count + 5

---

# 8. Supported Data Types

| Type | Example |
| :--- | :--- |
| **Integer** | `10`, `-45` |
| **Float** | `3.1416`, `125.50` |
| **String** | `"Hello World"`, `"Karayel"` |

---

# 9. Identifier Rules

Identifiers (variable and task names) must satisfy the following constraints:
- Must begin with a letter or underscore (`_`).
- Can contain alphanumeric characters (`a-z`, `A-Z`, `0-9`) and underscores (`_`).
- Cannot contain spaces or special characters (`@`, `#`, `$`, `-`, etc.).
- Cannot match any reserved uppercase keyword.

---

# 10. Case Sensitivity

Karayel is strictly **case-sensitive**.

    SHOW("Valid")    :: Correct
    show("Invalid")  :: Error

    KL total = 100
    KL Total = 200   :: 'total' and 'Total' are distinct identifiers

---

# 11. Operators

### 11.1 Arithmetic Operators
`+` (Add), `-` (Subtract), `*` (Multiply), `/` (Divide), `%` (Modulo)

### 11.2 Relational Operators
`==` (Equal), `!=` (Not Equal), `>` (Greater Than), `<` (Less Than), `>=` (Greater/Equal), `<=` (Less/Equal)

### 11.3 Logical Operators
`&&` (AND), `||` (OR), `!` (NOT)

---

# 12. Comments

Karayel provides clean syntax for single-line and multi-line comments.

### Single-Line Comment
Starts with `::` and extends to the end of the line.

    :: This is a single-line comment

### Multi-Line Comment
Starts with `:::` and ends with `:::`.

    :::
      This is a multi-line comment
      spanned across multiple lines.
    :::

---

# 13. Input & Output System

### 13.1 `SHOW(...)` - Output Printing
`SHOW` is a variadic function that automatically converts, concatenates, and prints values on stdout, followed by a new line.

    KL x = 10
    SHOW("The value of x is: ", x, " and x + 5 = ", x + 5)

### 13.2 `SCAN(...)` - Input Reading
`SCAN` reads integer values interactively from standard input. An optional string prompt can be supplied.

    KL user_age = SCAN("Enter your age: ")

---

# 14. Control Flow Constructs

### 14.1 Conditional Structures (`IF`, `ELIF`, `ELSE`)
    KL mark = 85

    IF (mark >= 80) {
        SHOW("Grade: A+")
    } ELIF (mark >= 70) {
        SHOW("Grade: A")
    } ELSE {
        SHOW("Grade: Below A")
    }

### 14.2 Loops

#### `WHILE` Loop
    KL i = 1
    WHILE (i <= 5) {
        SHOW("Iteration: ", i)
        i = i + 1
    }

#### `FOR` Loop
    FOR (KL i = 1; i <= 5; i = i + 1) {
        SHOW("Value of i: ", i)
    }

---

# 15. Built-in Math & Statistical Suite

Karayel provides optimized native built-in functions:

| Function | Description | Example |
| :--- | :--- | :--- |
| `FACTORIAL(n)` | Computes factorial | `FACTORIAL(5)` -> `120` |
| `IS_PRIME(n)` | Returns `1` if prime, `0` otherwise | `IS_PRIME(17)` -> `1` |
| `FIBO(n)` | Returns nth Fibonacci number | `FIBO(10)` -> `55` |
| `MAX(...)` | Evaluates max from arguments | `MAX(12, 90, 45)` -> `90` |
| `MIN(...)` | Evaluates min from arguments | `MIN(12, 90, 45)` -> `12` |
| `AVG(...)` | Computes average of arguments | `AVG(10, 20, 30)` -> `20` |

---

# 16. Functions (Tasks)

Functions are defined using the **`TASK`** keyword, and values are returned using **`GIVE`**.

    TASK Square(n) {
        GIVE n * n
    }

---

# 17. Full Specification Example

    :: --- Karayel Language Demonstration ---

    :::
      This script showcases input/output, math suite,
      and loop constructs in Karayel.
    :::

    KL num = 5
    SHOW("Analyzing statistics for number: ", num)

    SHOW("1. Factorial: ", FACTORIAL(num))
    SHOW("2. Is Prime Check: ", IS_PRIME(num))
    SHOW("3. Fibonacci Value: ", FIBO(num))
    SHOW("4. Maximum Value: ", MAX(10, 50, 25))

    SHOW("--- Prime Numbers up to 5 ---")
    FOR (KL i = 1; i <= 5; i = i + 1) {
        IF (IS_PRIME(i) == 1) {
            SHOW("Number ", i, " is Prime")
        }
    }

---

# 18. Version & Implementation Information

| Attribute | Value |
| :--- | :--- |
| **Language Name** | Karayel |
| **Version** | 1.0 |
| **Target Runtime** | C / Custom AST Evaluator |
| **Parsing Tools** | Flex (Lexer), Bison (Parser) |
| **File Extension** | `.kl` |