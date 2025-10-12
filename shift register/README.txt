## 🧠 What the DUT Does

The `lab2_shift_reg` module implements a 4-bit shift register with the following modes:

| Mode (`mode`) | Operation        | Description                                  |
|---------------|------------------|----------------------------------------------|
| `2'b00`       | Hold             | Keeps current value                          |
| `2'b01`       | Shift Left       | Shifts left, inserts `s_in` at LSB           |
| `2'b10`       | Shift Right      | Shifts right, inserts `s_in` at MSB          |
| `2'b11`       | Parallel Load    | Loads value from `p_in`                      |

It also outputs a flag `is_zero` which is high (`1`) when all bits of `q_out` are zero.

---

## 🧪 Testbench Highlights

The testbench:
- Generates a clock signal (`clk`)
- Applies a sequence of inputs to test all shift modes
- Includes a creative sequence that drives the register to zero
- Uses `$display` to log each operation
- Asserts the `is_zero` flag when the register is empty

---
