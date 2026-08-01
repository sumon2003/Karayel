# Karayel Grammar Specification

> **Language:** Karayel
> **Version:** 1.0

---

# 1. Introduction

This document defines the formal grammar of the Karayel Programming Language.

The grammar is written using **Backus–Naur Form (BNF)** and serves as the blueprint for the parser implementation using GNU Bison.

---

# 2. Grammar Notation

Karayel uses the following notation.

| Symbol | Meaning |
|---------|---------|
| `< >` | Non-terminal |
| `::=` | Definition |
| `|` | Alternative |
| `ε` | Empty production |

Example:

```bnf
<statement> ::= <declaration>
              | <assignment>
```

---

# 3. Program Structure

Every Karayel program is composed of one or more statements.

```bnf
<program> ::= <statement_list>
```

---

# 4. Statement List

A statement list contains one or more statements.

```bnf
<statement_list> ::= <statement>

                   | <statement> <statement_list>
```

---

# 5. Statement

A statement may be one of the following.

```bnf
<statement> ::= <declaration>

              | <assignment>

              | <show_statement>

              | <scan_statement>

              | <if_statement>

              | <while_statement>

              | <for_statement>

              | <function_definition>
```