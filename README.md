# dr_quine

This project implements self-replicating quine programs in C, Assembly (Linux only), and JavaScript. Each program outputs its own source code when run.

## Implemented Quines

### Colleen

- Prints its own source code to the standard output.
- Includes a main function, two comments (one inside and one outside the main function), and an additional function.

### Grace

- Writes its source code to a file named Grace_kid.s, compiles it, and then executes it.
- No main function. Includes three #define macros and one comment.

### Sully

- Generates a file named Sully_X.js, where X decreases by 1 with each generated quine. The program stops when X reaches 0.

## Requirements

- Linux for Assembly, or macOS using Docker
- Clang or GCC (C and Assembly)
- NASM (Assembly)
- node (JavaScript)



## How to test

```bash
# In each directory for C, ASM, and JS
make test
```
