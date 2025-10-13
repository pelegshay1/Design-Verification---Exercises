# FIFO Queue Implementation in SystemVerilog

This project implements a simple FIFO (First-In-First-Out) queue using SystemVerilog. It includes a parameterized FIFO module and a testbench that verifies correct push/pop behavior.

## 📦 Module: FIFO_MODULE

A parameterized FIFO queue using a dynamic array.

### 🔧 Parameters and Ports

- `DATA_WIDTH` (default: 32): Width of each data word.
- `clk`: Clock signal.
- `push`: Push flag to insert data.
- `pop`: Pop flag to remove data.
- `data_in`: Input data to be pushed.
- `data_out`: Output data after pop.
- `empty`: Indicates if FIFO is empty.

### ⚙️ Internal Logic

- Uses a dynamic array `fifo_q[$]` to store data.
- On `push`, data is added to the back.
- On `pop`, data is removed from the front.
- `empty` flag is updated based on FIFO size.

## 🧪 Testbench: tb_lab2

Simulates FIFO behavior with predefined data.

### 🧾 Test Flow

1. Push 4 items: `DEADBEEF`, `CAFEBABE`, `FEEDFACE`, `BAADF00D`.
2. Pop each item and compare with expected value.
3. Use assertions to verify correctness.
4. Display results for each item.

### ✅ Example Output
First Item PASSED: DEADBEEF == DEADBEEF First Item PASSED: CAFEBABE == CAFEBABE First Item PASSED: FEEDFACE == FEEDFACE First Item PASSED: BAADF00D == BAADF00D


## 📁 Files

- `FIFO_MODULE.sv`: FIFO module implementation.
- `tb_lab2.sv`: Testbench for simulation.



