# Karayel Development Log & Changelog

> **Language:** Karayel  
> **Version:** 1.0  
> **Status:** Completed / Stable  

---

# Table of Contents

1. Project Initialization & Architecture Design
2. Phase 1: Lexical Analyzer (Flex) Implementation
3. Phase 2: Syntax Parser (Bison) & CFG Definition
4. Phase 3: Dynamic Symbol Table Engine
5. Phase 4: AST Construction & Real-Time Evaluator
6. Phase 5: Built-in Math & Statistical Suite Integration
7. Phase 6: Variadic I/O & Custom Syntax Refinement
8. Key Bug Fixes & Optimization Log
9. Project Completion & Final Release Notes

---

# 1. Project Initialization & Architecture Design

- Established core goal: Design a custom compiled, dynamically-evaluated domain-specific language using C, Flex, and Bison.
- Selected `.kl` as the official file extension for source scripts.
- Architecture mapped into 4 distinct execution pipelines:
  1. Lexical Tokenization (`lexer.l`)
  2. Syntactic Parsing (`parser.y`)
  3. Dynamic Symbol & Scope Management (`symbol_table.c/.h`)
  4. AST-based Runtime Evaluation (`ast.c/.h`)

---

# 2. Phase 1: Lexical Analyzer (Flex) Implementation

- Constructed token definitions for basic keywords (`KL`, `SHOW`, `SCAN`, `IF`, `ELSE`, `WHILE`, `FOR`, `TASK`, `GIVE`).
- Configured regular expressions for literal data types:
  - Integer literals: `[0-9]+`
  - Floating-point literals: `[0-9]+\.[0-9]+`
  - String primitives: `"([^"\\]|\\.)*"`
- Added tracking for line numbers (`yylineno`) to handle error reporting accurately.
- Implemented comment filters:
  - Single-line comments (`::`)
  - Multi-line comments (`:::` ... `:::`)

---

# 3. Phase 2: Syntax Parser (Bison) & CFG Definition

- Designed Context-Free Grammar (CFG) rules in `parser.y`.
- Resolved operator precedence and ambiguity bottlenecks:
  - Configured `%left` precedence for arithmetic (`+`, `-`, `*`, `/`, `%`) and logical operators (`&&`, `||`).
  - Solved `dangling-else` shift/reduce conflicts by defining explicit `IF-ELIF-ELSE` grammar chains.
- Structured statement blocks enclosed in curly braces (`{}`).

---

# 4. Phase 3: Dynamic Symbol Table Engine

- Created `symbol_table.c` and `symbol_table.h` to manage memory allocation and variable states.
- Implemented lookup and update functions:
  - `set_symbol_value()`: Dynamically inserts new identifiers or mutates existing values.
  - `get_symbol_value()`: Retrieves values during expression parsing and runtime execution.
- Configured automatic runtime error handling for undeclared variable access.

---

# 5. Phase 4: AST Construction & Real-Time Evaluator

- Engineered node structures in `ast.h` to represent code components as hierarchical syntax trees.
- Implemented node factory constructors for:
  - Binary/Unary arithmetic and comparison operations.
  - Variable declarations (`KL`) and assignments (`=`, `+=`, `-=`).
  - Control flow trees (`IF`, `WHILE`, `FOR`).
- Built the recursive evaluator in `ast.c` (`eval_ast()`) to traverse and execute code trees directly from memory.

---

# 6. Phase 5: Built-in Math & Statistical Suite Integration

- Expanded the compiler runtime to natively evaluate advanced mathematical/statistical functions:
  - `FACTORIAL(n)`: Iterative factorial calculation logic.
  - `IS_PRIME(n)`: Optimized primality validation returning binary boolean state (`1` / `0`).
  - `FIBO(n)`: Dynamic Fibonacci calculation.
  - `MAX(...)`, `MIN(...)`, `AVG(...)`: Variadic argument processing through compound list nodes.

---

# 7. Phase 6: Variadic I/O & Custom Syntax Refinement

- Replaced single-expression printing with a custom variadic `SHOW(...)` system capable of concatenating strings, variable identifiers, and calculated expressions dynamically.
- Implemented auto-casting in `ast.c` (`printValue()`) to seamlessly print integers, floats, and string primitive literals on standard output.
- Enhanced `SCAN(...)` to support interactive prompt strings directly passed during invocation.

---

# 8. Key Bug Fixes & Optimization Log

### Issue 1: Shift/Reduce Conflicts in Variadic Functions
- **Problem:** Ambiguity in Bison parser when parsing lists of mixed arguments inside `SHOW()` and statistical functions.
- **Fix:** Refactored argument list grammar into explicit recursive non-terminal chains (`<argument_list>`).

### Issue 2: String Formatting Artifacts
- **Problem:** Printed string primitives retained opening and closing quotation marks during runtime evaluation.
- **Fix:** Added a slice mechanism in `printValue()` to strip surrounding double quotes before streaming text to stdout.

### Issue 3: Memory Collisions in Loop Variables
- **Problem:** Variable values in `FOR` loop step updates failed to update properly in symbol table references.
- **Fix:** Synchronized symbol re-assignment nodes inside the AST loop execution loop.

---

# 9. Project Completion & Final Release Notes

- **Version 1.0 Milestone Reached:**
  - Full support for variables, arithmetic/logical operations, and dynamic typing.
  - Complete control flow implementation (`IF`, `ELIF`, `ELSE`, `WHILE`, `FOR`).
  - Full native math suite and variadic I/O system.
- Build system fully automated via `Makefile`.
- Documentation completed: `README.md`, `Language_Manual.txt`, `01.Language_specification.md`, `02.Grammar.md`, `03.token_design.md`, and `04.Development_log.md`.