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
6. Variable Declaration
7. Variable Assignment
8. Variable Redeclaration Rule
9. Supported Data Types
10. Identifier Rules
11. Case Sensitivity
12. Operators
13. Statement Termination
14. Block Structure
15. Comments
16. Input Statement
17. Output Statement
18. Conditional Statements
19. Loop Statements
20. Functions
21. Example Program
22. Version Information

---

# 1. Introduction

Karayel is a simple, beginner-friendly programming language developed using **Flex** and **Bison**.

The language is designed to provide a clean, readable, and easy-to-understand syntax while supporting essential programming concepts such as variables, arithmetic operations, logical operations, conditional statements, loops, input/output, and functions.

Karayel uses **automatic type detection (type inference)**, meaning programmers do not need to manually specify variable types.

The primary objective of Karayel is to provide an easy learning experience while demonstrating the core concepts of compiler construction.

---

# 2. Design Goals

The primary goals of Karayel are:

- Simple syntax
- Beginner friendly
- Easy to read
- Easy to learn
- Automatic type detection
- Lightweight implementation
- Clean and consistent syntax
- Easy implementation using Flex and Bison

---

# 3. File Extension

All Karayel source files use the following extension:

```text
.kl
```

Example:

```text
program.kl
student.kl
calculator.kl
```

---

# 4. Reserved Keywords

The following words are reserved by the language and **cannot** be used as identifiers.

| Keyword | Purpose |
|----------|---------|
| KL | Variable declaration |
| Show | Display output |
| Scan | Receive user input |
| Task | Function declaration |
| Give | Return a value |
| If | Conditional statement |
| Elif | Else-if statement |
| Else | Alternative condition |
| While | While loop |
| For | For loop |
| True | Boolean true |
| False | Boolean false |

Example:

```kl
KL Show = 10;     // Error

KL If = 20;       // Error

KL True = False;  // Error
```

---

# 5. Keyword Naming Convention

Karayel follows a consistent keyword naming style.

- Every reserved keyword begins with an uppercase letter.
- The declaration keyword **KL** is written entirely in uppercase.
- Keywords are reserved and cannot be used as variable names.

Examples:

```text
KL

Show
Scan

Task
Give

If
Elif
Else

While
For

True
False
```

---

# 6. Variable Declaration

Variables are declared using the **KL** keyword.

The language automatically determines the variable type based on the assigned value.

Examples:

```kl
KL age = 20;

KL cgpa = 3.90;

KL name = "Sumon";

KL grade = 'A';

KL isStudent = True;
```

---

# 7. Variable Assignment

After declaration, a variable may receive a new value.

Examples:

```kl
age = 21;

cgpa = 3.95;

name = "Karayel";

grade = 'B';

isStudent = False;
```

---

# 8. Variable Redeclaration Rule

A variable may be declared only once within the same scope.

Correct:

```kl
KL age = 20;

age = 25;
```

Incorrect:

```kl
KL age = 20;

KL age = 30;
```

Expected Result:

```text
Error:
Variable 'age' is already declared.
```

---

# 9. Supported Data Types

Karayel supports automatic type detection for the following data types.

| Example | Data Type |
|----------|-----------|
| `10` | Integer |
| `25.75` | Float |
| `"Hello"` | String |
| `'A'` | Character |
| `True` | Boolean |
| `False` | Boolean |

Examples:

```kl
KL age = 20;

KL price = 125.50;

KL name = "Karayel";

KL grade = 'A';

KL passed = True;
```

---

# 10. Identifier Rules

Identifiers are used for naming variables and functions.

A valid identifier:

- Must begin with a letter or underscore (`_`)
- May contain letters
- May contain digits
- May contain underscores (`_`)
- Cannot contain spaces
- Cannot contain special characters
- Cannot be a reserved keyword

Valid Examples:

```text
age

student

studentName

student_name

_total

marks2026
```

Invalid Examples:

```text
2age

student name

my-name

If

Show

True
```

---

# 11. Case Sensitivity

Karayel is a **case-sensitive** programming language.

Examples:

Correct:

```kl
Show("Hello");
```

Incorrect:

```kl
show("Hello");
```

The following keywords are different:

```text
Show      ✓
show      ✗

If        ✓
if        ✗

True      ✓
true      ✗
```

Variables are also case-sensitive.

```text
Age

age

AGE
```

The above identifiers represent three different variables.

---

> **Part 1 Completed**

# 12. Operators

Karayel supports the following operators.

---

## 12.1 Arithmetic Operators

| Operator | Description |
|----------|-------------|
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus |

Example:

```kl
KL a = 20;
KL b = 10;

Show(a + b);
Show(a - b);
Show(a * b);
Show(a / b);
Show(a % b);
```

---

## 12.2 Assignment Operator

| Operator | Description |
|----------|-------------|
| = | Assign value |

Example:

```kl
KL age = 20;

age = 25;
```

---

## 12.3 Comparison Operators

| Operator | Description |
|----------|-------------|
| == | Equal |
| != | Not Equal |
| > | Greater Than |
| < | Less Than |
| >= | Greater Than or Equal |
| <= | Less Than or Equal |

Example:

```kl
If(age >= 18){

    Show("Adult");

}
```

---

## 12.4 Logical Operators

| Operator | Description |
|----------|-------------|
| && | Logical AND |
| \|\| | Logical OR |
| ! | Logical NOT |

Example:

```kl
If(age >= 18 && passed == True){

    Show("Eligible");

}
```

---

# 13. Statement Termination

Every statement in Karayel must end with a semicolon (`;`).

Correct:

```kl
KL age = 20;

Show(age);
```

Incorrect:

```kl
KL age = 20

Show(age)
```

---

# 14. Block Structure

Karayel uses curly braces `{ }` to define a block.

Example:

```kl
If(age >= 18){

    Show("Adult");

}
```

Nested blocks are also supported.

Example:

```kl
If(age >= 18){

    If(age >= 60){

        Show("Senior Citizen");

    }

}
```

---

# 15. Comments

Karayel supports both single-line and multi-line comments.

---

## 15.1 Single-Line Comment

```kl
:: This is a single-line comment
```

---

## 15.2 Multi-Line Comment

```kl
::
This is a
multi-line comment.
::
```

Comments are ignored by the compiler.

---

# 16. Input Statement

Karayel uses the **Scan** keyword to receive input from the user.

Syntax:

```kl
Scan(variable);
```

Example:

```kl
KL age;

Scan(age);

Show(age);
```

---

# 17. Output Statement

Karayel uses the **Show** keyword to display information.

Syntax:

```kl
Show(expression);
```

Examples:

```kl
Show("Welcome");

Show(age);

Show(age + 10);
```

Multiple Show statements are allowed.

Example:

```kl
Show("Name");

Show(name);

Show("Age");

Show(age);
```

---

# 18. Conditional Statements

Karayel supports three conditional statements.

- If
- Elif
- Else

---

## 18.1 If Statement

```kl
If(age >= 18){

    Show("Adult");

}
```

---

## 18.2 If - Else Statement

```kl
If(age >= 18){

    Show("Adult");

}
Else{

    Show("Child");

}
```

---

## 18.3 If - Elif - Else Statement

```kl
If(mark >= 80){

    Show("A+");

}
Elif(mark >= 70){

    Show("A");

}
Elif(mark >= 60){

    Show("A-");

}
Else{

    Show("Fail");

}
```

Only one block is executed based on the first matching condition.

---

# 19. Loop Statements

Karayel supports the following loops.

- While
- For

---

## 19.1 While Loop

Syntax:

```kl
While(condition){

}
```

Example:

```kl
KL i = 1;

While(i <= 5){

    Show(i);

    i = i + 1;

}
```

---

## 19.2 For Loop

Syntax:

```kl
For(initialization; condition; update){

}
```

Example:

```kl
For(KL i = 1; i <= 5; i = i + 1){

    Show(i);

}
```

---

# 20. Functions

Karayel uses the **Task** keyword to declare functions.

The **Give** keyword is used to return a value.

Syntax:

```kl
Task FunctionName(){

    Give value;

}
```

Example:

```kl
Task Square(){

    KL result = 5 * 5;

    Give result;

}
```

Functions improve code reusability and readability.

---

> **Part 2 Completed**

# 21. Function Calling

A function can be called by using its name followed by parentheses.

Syntax:

```kl
FunctionName();
```

Example:

```kl
Task Welcome(){

    Show("Welcome to Karayel");

}

Welcome();
```

Functions may optionally return a value using the **Give** keyword.

Example:

```kl
Task Square(){

    KL number = 5;

    Give number * number;

}
```

---

# 22. Program Structure

A typical Karayel program consists of:

- Variable declarations
- Input statements
- Processing
- Conditional statements
- Loops
- Function definitions
- Output statements

Example:

```text
Variable Declaration
        │
        ▼
Input
        │
        ▼
Processing
        │
        ▼
Decision Making
        │
        ▼
Loop (Optional)
        │
        ▼
Output
```

---

# 23. Complete Example Program

```kl
:: Simple Karayel Program

KL name = "Sumon";
KL age = 22;

Show("Name:");
Show(name);

Show("Age:");
Show(age);

If(age >= 18){

    Show("Adult");

}
Else{

    Show("Child");

}
```

Expected Output:

```text
Name:
Sumon
Age:
22
Adult
```

---

# 24. Language Rules Summary

The following rules must always be followed while writing a Karayel program.

| Rule | Description |
|------|-------------|
| Variable declaration | Use `KL` |
| Output | Use `Show()` |
| Input | Use `Scan()` |
| Function declaration | Use `Task` |
| Return value | Use `Give` |
| Decision | `If`, `Elif`, `Else` |
| Loops | `While`, `For` |
| Boolean values | `True`, `False` |
| Comments | `::` |
| Statement ending | `;` Required |
| Case sensitivity | Case Sensitive |

---

# 25. Language Characteristics

Karayel has the following characteristics.

- Beginner-friendly syntax
- Automatic type detection
- Case-sensitive keywords and identifiers
- Simple function syntax
- Built-in input and output statements
- Structured programming support
- Easy compiler implementation using Flex and Bison

---

# 26. Current Features (Version 1.0)

Karayel Version 1.0 currently supports:

- Variable declaration
- Variable assignment
- Automatic type detection
- Integer values
- Floating-point values
- Character values
- String values
- Boolean values
- Arithmetic operators
- Assignment operator
- Comparison operators
- Logical operators
- Input statement
- Output statement
- If statement
- Elif statement
- Else statement
- While loop
- For loop
- Function declaration
- Return statement
- Single-line comments
- Multi-line comments

---

# 27. Future Improvements

The following features are planned for future versions of Karayel.

- Arrays
- Function parameters
- Recursive functions
- Switch statement
- Break statement
- Continue statement
- Increment (`++`)
- Decrement (`--`)
- File handling
- User-defined data structures

---

# 28. Version Information

| Item | Value |
|------|-------|
| Language | Karayel |
| Version | 1.0 |
| File Extension | `.kl` |
| Compiler Tools | Flex, Bison, GCC |
| Operating System | Ubuntu Linux |

---

# Conclusion

Karayel is a lightweight educational programming language designed to demonstrate the implementation of compiler construction concepts using Flex and Bison.

The language emphasizes readability, simplicity, and automatic type detection while supporting essential programming constructs such as variables, operators, control flow, input/output, and functions.

Version 1.0 provides the core foundation of the language. Future versions will extend Karayel with additional programming features while preserving its clean and beginner-friendly syntax.