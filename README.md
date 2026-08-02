<div align="center">

# 🌪️ Karayel Programming Language
**A Lightweight, Custom-Built Compiled Language Built with Flex, Bison, and C**

![C Language](https://img.shields.io/badge/Language-C-blue.svg)
![Flex](https://img.shields.io/badge/Lexer-Flex-orange.svg)
![Bison](https://img.shields.io/badge/Parser-Bison-green.svg)
![License](https://img.shields.io/badge/License-MIT-brightgreen.svg)

</div>

---

## 📌 Project Overview
**Karayel** is an imperative programming language engineered from scratch to demonstrate compiler construction concepts. It translates high-level source code into an **Abstract Syntax Tree (AST)** and evaluates it in real-time with an integrated runtime environment and symbol table manager.

Designed with clean syntax and native math/statistical utilities, Karayel simplifies logic building, state management, and algorithmic evaluations.

---

## ✨ Key Features

* **Variables & Dynamic State Management:** Declared via `KL` keyword with integrated symbol table tracking.
* **Control Flow Operations:** Native support for `IF`, `ELIF`, `ELSE` conditional structures, `WHILE` loops, and `FOR` loops.
* **Custom I/O Engine:** 
  * `SHOW(...)`: Variadic, auto-casting print system capable of concatenating strings, integers, floats, and variable values dynamically.
  * `SCAN(...)`: Runtime interactive input extraction.
* **Built-in Math & Statistical Suite:**
  * `FACTORIAL(n)` — Computes factorial values.
  * `IS_PRIME(n)` — Checks prime number validity (returns `1` or `0`).
  * `FIBO(n)` — Returns the n-th Fibonacci sequence value.
  * `MAX(...)`, `MIN(...)`, `AVG(...)` — Evaluates variadic parameter sets dynamically.
* **Modular Code Execution:** Modular function definitions using `TASK` and `GIVE` keywords.

---

## 🏗️ Technical Architecture & How It Was Built

The compiler is structured into four distinct modular pipeline stages:

+------------------+     +------------------+     +--------------------+     +---------------------+
|  Source Code     | --> |   Lexer (Flex)   | --> |   Parser (Bison)   | --> | AST Execution /     |
|   (*.kl File)    |     | Token Generation |     | Syntax Validation  |     | Symbol Table Engine |
+------------------+     +------------------+     +--------------------+     +---------------------+

1. **Lexical Analysis (`lexer.l`):** Tokenizes input files, filters out whitespace/comments, tracks line numbers (`yylineno`), and maps string patterns to defined tokens.
2. **Parsing & Syntax Validation (`parser.y`):** Uses Context-Free Grammar (CFG) rules in Bison to build structural relationships, handle operator precedence, and generate AST nodes.
3. **Symbol Table (`symbol_table.c` / `symbol_table.h`):** Manages variable declarations, type checking, memory allocation, and runtime value mutation.
4. **AST Execution (`ast.c` / `ast.h`):** Traverses the created AST nodes recursively, evaluates binary/unary arithmetic operations, and executes control flows directly.

---

## ⚙️ Challenges Faced & Solutions

Building a functional language compiler required solving several core parsing and execution bottlenecks:

### 1. Shift/Reduce Conflicts in Grammar Analysis
* **Challenge:** Integrating variadic expressions (`SHOW`, `MAX`, `MIN`) alongside complex mathematical nesting created grammar ambiguities in Bison.
* **Solution:** Explicitly defined left/right precedence rules (`%left`, `%right`) and isolated argument parsing through unified compound list nodes.

### 2. Auto-Casting in Variadic Output Parsing
* **Challenge:** Printing mixed data types (e.g., `SHOW("Factorial of ", x, " is ", FACTORIAL(x))`) in standard C required dynamic type deduction.
* **Solution:** Engineered a robust `printValue()` function within `ast.c` that evaluates node data types recursively and automatically casts integers, string primitives, and identifiers seamlessly.

### 3. Symbol Table Memory & Scope Synchronization
* **Challenge:** Preventing identifier collisions and handling assignment updates cleanly across AST executions.
* **Solution:** Implemented dynamic lookups via standard string comparison algorithms with automated symbol insertion and value buffer synchronization.

---

## 🚀 Quick Start Guide

### Prerequisites
Ensure you have the following packages installed on your Linux system:
* `gcc` (GNU Compiler Collection)
* `flex` (Fast Lexical Analyzer Generator)
* `bison` (Yacc-compatible Parser Generator)
* `make` (Build Automation Tool)

### Compilation & Execution

1. **Clone & Compile:**
   ```bash
   make clean && make

2. **Run a Sample Script:**
   ```Bash
   ./karayel examples/test.kl

### 📂 Project Structure

Karayel/
├── lexer.l             # Lexical rules & token patterns
├── parser.y            # Grammar rules & Bison configurations
├── ast.h / ast.c       # AST node constructors & evaluation engine
├── symbol_table.h/.c   # Variable scope & symbol storage logic
├── keyword_table.h/.c  # Keyword lookup configurations
├── Makefile            # Build automation script
└── README.md           # Project documentation