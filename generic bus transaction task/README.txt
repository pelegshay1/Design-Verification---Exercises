# 🧪 lab3_generic_task – SystemVerilog Bus Transaction Demo

## 📌 Overview
This module demonstrates a **generic bus transaction task** in SystemVerilog, capable of performing `READ` and `WRITE` operations on a simple memory array. It includes a basic testbench that verifies the correctness of a write-read cycle using assertions.

---

## 🧠 Features
- `typedef enum {READ, WRITE}` – defines transaction types.
- `memory[logic[7:0]]` – 256-entry memory with 32-bit data width.
- `bus_transaction` task – performs read/write operations with timing delays.
- Assertion-based verification to ensure data integrity.

---

## 🧪 Simulation Flow
1. **Write** value `0x0000ABCD` to address `0x1B`.
2. **Read** back from the same address.
3. **Assert** that the read value matches the written value.
4. **Display success or fatal error** based on result.

---

## 🛠️ How to Run
To simulate this module:
```bash
vlog lab3_generic_task.sv
vsim lab3_generic_task
