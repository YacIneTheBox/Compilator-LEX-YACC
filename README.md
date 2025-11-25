# Arithmetic Expression Evaluator with Statistical Functions

A compiler project implementing a mathematical expression parser and evaluator using **LEX** (Flex) and **YACC** (Bison). This tool parses and evaluates arithmetic expressions with support for statistical functions including sum, average, product, variance, and standard deviation.

## 📋 Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation & Compilation](#installation--compilation)
- [Usage](#usage)
- [Technical Implementation](#technical-implementation)
- [Examples](#examples)
- [Potential Improvements](#potential-improvements)
- [Known Limitations](#known-limitations)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

- **Basic arithmetic operations**: Addition (`+`), Subtraction (`-`), Multiplication (`*`), Division (`/`)
- **Floating-point support**: Handles both integer and decimal numbers
- **Nested expressions**: Full support for parentheses and complex expressions
- **Statistical functions**:
  - `somme(...)` - Sum of values
  - `moyenne(...)` - Average/mean
  - `produit(...)` - Product of values
  - `variance(...)` - Statistical variance
  - `ecart_type(...)` - Standard deviation
- **Function nesting**: Functions can be nested within each other
- **Error handling**: Meaningful error messages for syntax errors and division by zero

## 📁 Project Structure
```bash
.
├── compil.y # YACC grammar definition
├── compil.l # LEX lexical analyzer
├── y.tab.c # Generated parser (auto-generated)
├── y.tab.h # Generated header (auto-generated)
├── lex.yy.c # Generated lexer (auto-generated)
└── calc # Compiled executable
```

## 🛠 Prerequisites

You need the following tools installed:

- **GCC** (GNU Compiler Collection)
- **YACC** (Bison) - Parser generator
- **LEX** (Flex) - Lexical analyzer generator


## 🚀 Installation & Compilation

### Step 1: Clone the Repository
```bash
git clone https://github.com/YacIneTheBox/Compilator-LEX-YACC.git
cd arithmetic-evaluator
```

### Step 2: Compile the Project

#### Manual Compilation

1. **Generate the parser from YACC file:**
```bash
yacc -d compil.y
```
2. **Generate the lexer from LEX file:**
```bash
lex compil.l
```
3. **Compile all files together:**
```bash
gcc y.tab.c lex.yy.c -o calc -lm
```

> **Important**: The `-lm` flag is required to link the math library for the `sqrt()` function.


## 💡 Usage

Run the compiled program:

```bash
./calc
```

The program will prompt you to enter expressions. Type your expression and press Enter to see the result.

To exit, press `Ctrl+D` (Linux/Mac) or `Ctrl+Z` then Enter (Windows).

## 📚 Examples
```bash
Entrez une expression:
5 + 3 * 2
= 11.000000

somme(1, 2, 3, 4, 5)
= 15.000000

moyenne(10, 20, 30)
= 20.000000

produit(2, 3, 4)
= 24.000000

variance(1, 2, 3, 4, 5)
= 2.000000

ecart_type(2, 4, 6, 8)
= 2.236068

somme(5, moyenne(2, 4, 6))
= 9.000000

(10 + 20) / moyenne(2, 3, 5)
= 9.000000
```
## 🚀 Potential Improvements

### Short-term Enhancements

- [ ] **Additional mathematical functions**: `sin`, `cos`, `tan`, `log`, `exp`, `pow`
- [ ] **Extended statistical functions**: median, mode, min, max, range
- [ ] **Variable assignment**: Store and reuse values
- [ ] **Better error recovery**: Continue parsing after syntax errors
- [ ] **File input support**: Read expressions from files
- [ ] **Batch processing mode**: Process multiple expressions at once
- [ ] **Comments support**: Allow inline documentation in expressions

### Long-term Enhancements

- [ ] **Type system**: Support for integers, floats, complex numbers
- [ ] **Matrix operations**: Basic linear algebra support
- [ ] **Programming constructs**: if-then-else, loops, user-defined functions
- [ ] **Optimization**: Constant folding, expression simplification
- [ ] **Interactive features**: Command history, auto-completion
- [ ] **GUI version**: Graphical interface with visualization
- [ ] **Testing suite**: Comprehensive unit and integration tests
- [ ] **Scientific notation**: Support for `1.5e10` format
- [ ] **Multiple number bases**: Binary, octal, hexadecimal support

## ⚠️ Known Limitations

- Division by zero in basic operations is not currently checked (only in `moyenne()`)
- No support for scientific notation (e.g., `1.5e10`)
- Limited error messages for lexical errors
- No support for Unicode mathematical symbols
- No operator precedence customization

