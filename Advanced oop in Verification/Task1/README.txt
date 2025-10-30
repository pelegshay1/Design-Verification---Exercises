README: Polymorphic and Constrained Testbench Project (OOP/CRV)

This is a comprehensive summary of your SystemVerilog project, detailing its purpose, structure, and the technical solutions implemented to achieve a functional constrained random verification (CRV) testbench.

***

Project Goals

This project demonstrates core principles of **Object-Oriented Programming (OOP)** and **Constrained Random Verification (CRV)** in SystemVerilog, essential for hardware verification.

* **Polymorphism (OOP):** Implement a base transaction class and derived classes that share a common method (`display()`) but execute specific logic based on the object's type.
* **Constrained Randomization:** Use the built-in `randomize()` method and `constraint` blocks to ensure only valid, specified transaction data is generated.
* **Testbench Architecture:** Structure all classes within a dedicated **Package** and use an external Testbench to drive the simulation.

---

File Structure

| File | Description |
| :--- | :--- |
| **`bus_trans.SV`** | The **Base Class**. Defines shared properties and includes the mandatory `virtual display()` method. |
| **`derived_trans.sv`** | The **Derived Classes** (`write_trans` and `read_trans`). Implements method **Override** for `display()` and logic to de-randomize the `read_trans` data properties. |
| **`bus_trans_pkg.sv`** | The **Package**. Defines the scope and includes the transaction files via `\`include` directives. |
| **`tb_oop.sv`** | The **Testbench**. Imports the package, generates 10 derived objects, and demonstrates polymorphism via the `display()` call. |

---

Key Technical Solutions

1. Polymorphism and Method Override

* **Override Fix:** The derived class `display()` calls `super.display(name)` and then prints the specific `addr` and `data` details, preventing double printing and ensuring the correct "WRITE" or "READ" string appears.
* **Syntax Fix:** Ensured the overridden `display()` function includes a **default argument** (e.g., `string name = "..."`) to comply with SystemVerilog rules and allow successful compilation.

2. Randomization and Constraint Control (CRV)

* **Successful Generation:** Logic was implemented to handle randomization failures (`if (!t.randomize())`) and ensure that **10 valid transactions** are successfully pushed to the queue.
* **Illegal X/Z Fix:** Added initialization (e.g., `addr = '0'`) in the base class constructor to prevent an **"Invalid X or Z"** runtime error when constraints are first evaluated.

---

Simulation

The Testbench (`tb_oop.sv`) demonstrates the core functionality:

1.  Imports `bus_trans_pkg::*`.
2.  Randomly creates `write_trans` or `read_trans` objects and assigns them to a base class handle.
3.  Uses a `foreach` loop to iterate over the queue and calls `q[idx].display()`.
4.  The polymorphic output verifies that the correct derived method is executed.