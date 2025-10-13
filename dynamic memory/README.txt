# Dynamic Memory Array in SystemVerilog

This project demonstrates the use of dynamic arrays in SystemVerilog to implement a flexible memory module. The memory resizes automatically when out-of-bound access is attempted, 
allowing dynamic allocation during simulation.

## 📦 Module: dynamic_mem

Implements a dynamic memory array with read/write capabilities.

### 🔧 Internal Structure

- `bit [7:0] memory[]`: Dynamic array representing memory.

### 🛠️ Tasks and Functions

- `configure(int size)`: Initializes the memory array to a given size.
- `write(int addr, bit [7:0] data)`: Writes data to a specific address. If the address is out of bounds, the array is resized automatically.
- `read(int addr)`: Returns the data at a given address. If the address is out of bounds, returns `8'bxxxxxxxx`.

## 🧪 Testbench: tb_lab4

Simulates dynamic memory behavior and verifies automatic resizing.

### 🧾 Test Flow

1. Configures memory to size 4.
2. Writes to address 5 (out-of-bounds), triggering automatic resize.
3. Reads back from address 5.
4. Uses `assert` to verify correct data.
5. Displays result.


