# Scoreboard Counter Using Associative Array in SystemVerilog

This project implements a simple scoreboard module using SystemVerilog's associative arrays. It tracks the number of times each string item is added and allows querying the count per item.

## 📦 Module: scoreboard

Implements a dynamic counter using an associative array:

### 🔧 Internal Structure

- `count_db[string]`: Associative array mapping string keys to integer counts.

### 🛠️ Tasks and Functions

- `add_item(string name)`: Adds an item to the scoreboard. If the item exists, increments its count; otherwise, initializes it to 1.
- `get_count(string name)`: Returns the current count for a given item.

## 🧪 Testbench: tb_lab3

Simulates the scoreboard logic by adding items and verifying their counts.

### 🧾 Test Flow

1. Adds multiple items:
   - `"apple"` added 3 times
   - `"Meat"` added once
   - `"Chips"` added twice
2. Uses `assert` to verify correct counts.
3. Displays the results.


## 📁 Files

- `scoreboard.sv`: Scoreboard module.
- `tb_lab3.sv`: Testbench for validation.




