# Karayel Grammar Specification

> **Language:** Karayel
> **Version:** 1.0

---

# Table of Contents

1. Introduction
2. Grammar Notation
3. Lexical Tokens
4. Program Structure
5. Statements
6. Variable Declaration
7. Variable Assignment
8. Expressions
9. Conditions
10. Show Statement
11. Scan Statement
12. If Statement
13. While Statement
14. For Statement
15. Function Definition
16. Function Call
17. Return Statement
18. Complete Grammar

# 1. Introduction

This document defines the formal grammar of the Karayel Programming Language.

The grammar is written using **Backus-Naur Form (BNF)** and is intended to serve as the blueprint for implementing the parser using **GNU Bison**.

Every valid Karayel program must follow the grammar rules described in this document.

The purpose of this grammar is to describe the syntactic structure of the language, ensuring that every program written in Karayel follows a consistent and valid format.

# 2. Grammar Notation

Karayel uses **Backus-Naur Form (BNF)** to describe its syntax.

The following notation is used throughout this document.

| Symbol | Meaning |
|---------|---------|
| `< >` | Non-terminal |
| `::=` | Definition |
| `\|` | Alternative |
| `ε` | Empty Production |

Example:

```bnf
<statement> ::= <declaration>
              | <assignment>
```

In this document:

- Terminal symbols represent actual keywords, identifiers, operators, and punctuation.
- Non-terminal symbols represent grammatical structures.
```

# 3. Program Structure

A Karayel program consists of zero or more statements.

### Grammar

```bnf
<program> ::= ε

            | <program> <statement>
```

### Description

A program may be empty or may contain one or more valid statements.

# 4. Statement

A statement represents a complete executable instruction.

### Grammar

```bnf
<statement> ::= <declaration>

              | <assignment>

              | <increment_statement>

              | <show_statement>

              | <if_statement>

              | <while_statement>

              | <for_statement>

              | <function_definition>

              | <return_statement>
```

### Description

Every executable instruction in Karayel is considered a statement.

# 5. Variable Declaration

Variables in Karayel must be declared using the **KL** keyword.

Every variable must be initialized at the time of declaration.

### Grammar

```bnf
<declaration> ::= KL IDENTIFIER '=' <expression> NEWLINE
```

### Example

```kl
KL age = 20

KL name = "Sumon"

KL cgpa = 3.90

KL passed = True
```

### Invalid Example

```kl
KL age
```

Reason:

Variables must be initialized when declared.

---

# 6. Variable Assignment

A previously declared variable may receive a new value.

### Grammar

```bnf
<assignment> ::= IDENTIFIER '=' <expression> NEWLINE

               | IDENTIFIER '+=' <expression> NEWLINE

               | IDENTIFIER '-=' <expression> NEWLINE

               | IDENTIFIER '*=' <expression> NEWLINE

               | IDENTIFIER '/=' <expression> NEWLINE
```

### Examples

```kl
age = 21

age += 5

age -= 2

age *= 3

age /= 2

name = "Karayel"

cgpa = Scan()
```
---

# 7. Increment Statement

Karayel supports postfix increment and decrement operators.

### Grammar

```bnf
<increment_statement> ::= IDENTIFIER '++' NEWLINE

                        | IDENTIFIER '--' NEWLINE
```

### Examples

```kl
count++

count--
```

---

# 7. Expressions

An expression produces a value.

Expressions may consist of:

- Literals
- Variables
- Arithmetic expressions
- Logical expressions
- Comparison expressions
- Parenthesized expressions

Expressions are used in:

- Variable declarations
- Assignments
- Conditions
- Show statements
- Return statements

---

### Grammar

```bnf
<expression> ::= <expression> '+' <term>

               | <expression> '-' <term>

               | <term>
```

### Grammar

```bnf
<term> ::= <term> '*' <factor>

         | <term> '/' <factor>

         | <term> '%' <factor>

         | <factor>
```

### Grammar

```bnf
<factor> ::= NUMBER

           | FLOAT

           | STRING

           | CHARACTER

           | TRUE

           | FALSE

           | IDENTIFIER

           | '(' <expression> ')'
```

# 8. Primary Expression

A primary expression represents the most basic unit of an expression.

### Grammar

```bnf
<primary> ::= NUMBER

            | FLOAT

            | STRING

            | CHARACTER

            | TRUE

            | FALSE

            | IDENTIFIER

            | SCAN '(' ')'

            | '(' <expression> ')'
```

### Examples

```kl
10

3.14

"Karayel"

'A'

True

False

age

(a + b)
```

---

# 9. Unary Expression

Unary expressions operate on a single operand.

### Grammar

```bnf
<unary> ::= '!' <unary>

          | '-' <unary>

          | <primary>
```

### Examples

```kl
!True

-value

-(a+b)
```

---

# 10. Multiplicative Expression

Multiplication, division and modulus have higher precedence than addition and subtraction.

### Grammar

```bnf
<multiplicative> ::= <multiplicative> '*' <unary>

                   | <multiplicative> '/' <unary>

                   | <multiplicative> '%' <unary>

                   | <unary>
```

### Examples

```kl
a * b

a / b

a % b

a * b / c
```

---

# 11. Additive Expression

Addition and subtraction are evaluated after multiplicative expressions.

### Grammar

```bnf
<additive> ::= <additive> '+' <multiplicative>

             | <additive> '-' <multiplicative>

             | <multiplicative>
```

### Examples

```kl
a + b

a - b

a + b - c
```

---

# 12. Relational Expression

Relational expressions compare two values.

### Grammar

```bnf
<relational> ::= <additive> '>' <additive>

               | <additive> '<' <additive>

               | <additive> '>=' <additive>

               | <additive> '<=' <additive>

               | <additive>
```

### Examples

```kl
age > 18

salary >= 50000

a < b
```

---

# 13. Equality Expression

Equality expressions compare whether two values are equal.

### Grammar

```bnf
<equality> ::= <relational> '==' <relational>

             | <relational> '!=' <relational>

             | <relational>
```

### Examples

```kl
a == b

a != b
```

---

# 14. Logical AND Expression

Logical AND combines two boolean expressions.

### Grammar

```bnf
<logical_and> ::= <logical_and> '&&' <equality>

                | <equality>
```

### Examples

```kl
age > 18 && passed == True
```

---

# 15. Logical OR Expression

Logical OR combines two boolean expressions.

### Grammar

```bnf
<logical_or> ::= <logical_or> '||' <logical_and>

               | <logical_and>
```

### Examples

```kl
age > 18 || isAdmin == True
```

---

# 16. Expression

The highest level expression in Karayel.

### Grammar

```bnf
<expression> ::= <logical_or>
```

This rule makes logical OR the top-level expression while preserving operator precedence through the grammar hierarchy.

---

# 17. Show Statement

The `Show` statement is used to display values on the screen.

### Grammar

```bnf
<show_statement> ::= SHOW '(' <expression> ')' NEWLINE
```

### Examples

```kl
Show("Hello")

Show(age)

Show(a + b)
```

---

# 19. If Statement

The `If` statement executes a block when a condition evaluates to True.

### Grammar

```bnf
<if_statement> ::= IF '(' <expression> ')' <block>

                 | IF '(' <expression> ')' <block> ELSE <block>

                 | IF '(' <expression> ')' <block>
                   <elif_list>
                   ELSE <block>
```

---

# 20. Elif Statement

The `Elif` statement allows multiple conditions.

### Grammar

```bnf
<elif_list> ::= ELIF '(' <expression> ')' <block>

              | ELIF '(' <expression> ')' <block> <elif_list>
```

---

# 21. While Statement

The `While` loop repeatedly executes a block while the condition is True.

### Grammar

```bnf
<while_statement> ::= WHILE '(' <expression> ')' <block>
```

---

# 22. For Statement

The `For` loop executes a block with initialization, condition and update.

### Grammar

```bnf
<for_statement> ::= FOR '('
                    <declaration>
                    <expression>
                    <assignment>
                    ')'
                    <block>
```

---

# 23. Block

A block is a sequence of one or more statements enclosed by braces.

### Grammar

```bnf
<block> ::= '{' <statement_list> '}'
```

---

# 24. Function Definition

Functions are declared using the `Task` keyword.

### Grammar

```bnf
<function_definition> ::= TASK IDENTIFIER '(' ')' <block>
```

---

# 25. Function Call

Functions are called using their name followed by parentheses.

### Grammar

```bnf
<function_call> ::= IDENTIFIER '(' ')'
```

---

# 26. Return Statement

The `Give` statement returns a value from a function.

### Grammar

```bnf
<return_statement> ::= GIVE <expression> NEWLINE
```

---

# 27. Complete Program

```bnf
<program>
        ↓
<statement_list>
        ↓
<statement>
        ↓
------------------------------------
| Declaration                     |
| Assignment                      |
| Show                            |
| Scan                            |
| If                              |
| While                           |
| For                             |
| Function Definition             |
| Return                          |
------------------------------------
```

---

# Conclusion

This grammar defines the complete syntax of Karayel Programming Language Version 1.0.

It serves as the reference for implementing the parser using GNU Bison.