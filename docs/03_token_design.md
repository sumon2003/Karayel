# Karayel Token Design

1. Introduction

2. Reserved Keywords

3. Literals

4. Identifiers

5. Operators

6. Delimiters

7. Comments

8. Whitespace

9. Token Summary

# Karayel Token Design

> Language: Karayel
>
> Version: 1.0

---

# 1. Introduction

This document defines the lexical tokens of the Karayel Programming Language.

During lexical analysis, the source code is scanned character by character and converted into a sequence of tokens.

These tokens are later used by the parser to validate the program according to the language grammar.

---

# 2. Reserved Keywords

The following words are reserved by the Karayel language and cannot be used as identifiers.

| Keyword | Token |
|----------|-------|
| KL | KL |
| Show | SHOW |
| Scan | SCAN |
| Task | TASK |
| Give | GIVE |
| If | IF |
| Elif | ELIF |
| Else | ELSE |
| While | WHILE |
| For | FOR |
| True | TRUE |
| False | FALSE |

Reserved keywords are **case-insensitive**.

Examples:

```kl
KL age = 20

Show(age)

If(age > 18){

    Show("Adult")

}
```

The following declaration is invalid.

```kl
KL If = 20
```

Reason:

`If` is a reserved keyword and cannot be used as a variable name.

---

# 3. Literals

Literals represent constant values in Karayel.

| Literal Type | Token | Example |
|--------------|-------|---------|
| Integer | INTEGER | `25` |
| Float | FLOAT | `3.14` |
| String | STRING | `"Hello"` |
| Character | CHARACTER | `'A'` |
| Boolean | TRUE / FALSE | `True`, `False` |

### Examples

```kl
KL age = 25

KL cgpa = 3.75

KL grade = 'A'

KL name = "Sumon"

KL passed = True
```

---

# 4. Identifiers

Identifiers are user-defined names used for variables and functions.

### Rules

- Must begin with a letter (`A-Z` or `a-z`) or underscore (`_`).
- May contain letters, digits and underscores.
- Cannot begin with a digit.
- Cannot be a reserved keyword.
- Identifiers are **case-sensitive**.

### Valid Examples

```kl
age

studentName

_total

CGPA

number1
```

### Invalid Examples

```kl
1age

If

Show

KL

student-name
```

---

# 5. Operators

Karayel uses standard C-style operators.

## Arithmetic Operators

| Operator | Meaning |
|----------|---------|
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus |

---

## Assignment Operator

| Operator | Meaning |
|----------|---------|
| = | Assignment |

---

## Comparison Operators

| Operator | Meaning |
|----------|---------|
| == | Equal |
| != | Not Equal |
| > | Greater Than |
| < | Less Than |
| >= | Greater Than or Equal |
| <= | Less Than or Equal |

---

## Logical Operators

| Operator | Meaning |
|----------|---------|
| && | Logical AND |
| \|\| | Logical OR |
| ! | Logical NOT |

---

# 6. Delimiters

Delimiters are symbols used to separate different parts of a program.

| Symbol | Token | Description |
|--------|-------|-------------|
| ( | LPAREN | Left Parenthesis |
| ) | RPAREN | Right Parenthesis |
| { | LBRACE | Left Brace |
| } | RBRACE | Right Brace |
| , | COMMA | Separator |
| NEWLINE | NEWLINE | End of Statement |

### Example

```kl
Task Main(){

    KL age = Scan()

    Show(age)

}
```

---

# 7. Comments

Comments are ignored by the compiler.

## Single-Line Comment

A single-line comment starts with `::` and continues until the end of the current line.

### Example

```kl
:: This is a single-line comment

KL age = 20
```

---

## Multi-Line Comment

A multi-line comment begins with `::` and ends with another `::`.

Everything between the opening and closing symbols is ignored.

### Example

```kl
::
This is a
multi-line
comment.
::

KL age = 20
```

---

# 8. Whitespace

Karayel ignores unnecessary whitespace characters except for **NEWLINE**.

The following characters are ignored during lexical analysis:

- Space
- Tab
- Carriage Return (`\r`)

A **NEWLINE** is treated as a token because Karayel uses a new line to terminate statements.

### Example

The following two statements are equivalent.

```kl
KL age=20
```

```kl
KL     age     =     20
```

---

# 9. Token Summary

## Keywords

```

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
TRUE
FALSE

```

## Literals

```

INTEGER
FLOAT
STRING
CHARACTER

```

## Identifier

```

IDENTIFIER

```

## Operators

```

PLUS (+)
MINUS (-)
MULTIPLY (*)
DIVIDE (/)
MODULUS (%)

ASSIGN (=)
PLUS_ASSIGN (+=)
MINUS_ASSIGN (-=)
MULTIPLY_ASSIGN (*=)
DIVIDE_ASSIGN (/=)

INCREMENT (++)
DECREMENT (--)

EQUAL (==)
NOT_EQUAL (!=)

GREATER (>)
LESS (<)

GREATER_EQUAL (>=)
LESS_EQUAL (<=)

AND (&&)
OR (||)
NOT (!)

```

## Delimiters

```

LPAREN
RPAREN

LBRACE
RBRACE

COMMA

NEWLINE

```

## End of File

```

EOF

```

---

This document defines every lexical token used in Karayel Programming Language Version 1.0.