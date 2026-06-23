#Floating Point ALU (Verilog)

A Verilog implementation of a **32-bit IEEE-754 Single Precision Floating Point Arithmetic Logic Unit (ALU)** supporting floating-point addition and multiplication.


---

## Features

### Supported Operations

| Opcode | Operation |
|---------|-----------|
| 0 | Floating Point Addition |
| 1 | Floating Point Multiplication |

### IEEE-754 Support

- Normalized floating-point numbers
- Positive and negative zero
- Positive and negative infinity
- NaN (Not-a-Number)
- Exponent alignment
- Mantissa normalization
- Overflow detection
- Sign handling

---

## Project Structure

```text
├── alu.v
├── adder_32bit.v
├── multiplier_32bit.v
├── compare_shift.v
├── addition.v
├── normalization.v
├── multiplication.v
├── alu_tb.v
└── README.md
```

---

## Module Description

### alu.v

Top-level ALU module that selects between floating-point addition and multiplication based on the opcode.

### adder_32bit.v

Implements IEEE-754 single-precision floating-point addition.

Functions:
- Operand decomposition
- Special-case handling
- Exponent comparison
- Mantissa alignment
- Addition/Subtraction
- Result normalization
- Overflow detection

### compare_shift.v

Aligns mantissas by shifting the operand with the smaller exponent.

### addition.v

Performs mantissa addition or subtraction depending on operand signs.

### normalization.v

Normalizes the mantissa after addition and adjusts the exponent.

### multiplier_32bit.v

Implements IEEE-754 single-precision floating-point multiplication.

Functions:
- Operand decomposition
- Special-case handling
- Sign calculation
- Exponent computation
- Result generation

### multiplication.v

Performs mantissa multiplication, normalization, rounding, and exponent calculation.

### alu_tb.v

Testbench used for functional verification of the ALU.

---

## IEEE-754 Single Precision Format

```text
 -------------------------------------------------
| Sign (1) | Exponent (8) | Fraction/Mantissa (23) |
 -------------------------------------------------
```

The represented value is:

```text
(-1)^Sign × 1.Fraction × 2^(Exponent - 127)
```

---



### Tools Used

- Xilinx Vivado
- Verilog HDL





