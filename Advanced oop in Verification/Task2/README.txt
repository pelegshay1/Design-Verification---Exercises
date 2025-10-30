

-----

```
README: Polymorphic and Constrained Testbench Project (OOP/CRV)

This is a comprehensive summary of your SystemVerilog project, detailing its purpose, structure, and the technical solutions implemented to achieve a functional constrained random verification (CRV) testbench.

***

Project Goals

This project demonstrates core principles of **Object-Oriented Programming (OOP)** and **Constrained Random Verification (CRV)** in SystemVerilog, essential for hardware verification.

* **Polymorphism (OOP):** Implement a base transaction class and derived classes that share a common method (`display()`) but execute specific logic based on the object's type.
* **Constrained Randomization:** Use the built-in `randomize()` method and `constraint` blocks to enforce complex rules (e.g., `addr` must be even if `kind` is READ) and ensure only valid data is generated.
* **Testbench Architecture:** Structure all components within a dedicated **Package** (`bus_trans_v2_pkg`) for clean scope management.

---

File Structure

| File | Description |
| :--- | :--- |
| **`bus_trans_v2.sv`** | The **Base Class** (`enhanced_bus_trans`). Defines 8-bit random properties (`addr`, `data`) and the `kind_e` enum property. It includes the `kind_c` and `addr_c` constraints, and the `virtual display()` method. |
| **`derived_trans_v2.sv`** | The **Derived Classes** (`write_trans` and `read_trans`). Implements method **Override** for `display()` and uses the `type_c` constraint to enforce `kind == READ` or `kind == WRITE`. |
| **`bus_trans_v2_pkg.sv`** | The **Package**. Defines the `kind_e` enumeration and includes all class files. |
| **`tb_constrained.sv`** | The **Testbench**. Imports the package, creates specific constrained transactions, and demonstrates polymorphism. |

---

Key Technical Solutions

1. Polymorphism and Display Override

* **Override Fix:** The derived class `display()` calls `super.display(name)` and then prints the specific `addr` and `data` details, preventing double printing and ensuring the correct "WRITE" or "READ" string appears.
* **Syntax Fix:** Ensured the overridden `display()` function includes a **default argument** (e.g., `string name = "..."`) to comply with SystemVerilog rules and allow successful compilation.

2. Constrained Randomization and Syntax

* **Enum Scoping:** Solved errors by ensuring all constraints use the correct scoped syntax (`kind == kind_e::READ`).
* **Critical Constraint:** Implemented the required conditional constraint: `constraint kind_c {if(kind == kind_e::READ) addr % 2 == 0 ;}`.
* **Initialization Fix:** Ensured all variables participating in constraints were correctly defined as **`rand`** (Random) and properly initialized, preventing runtime errors.

---

Simulation

The Testbench (`tb_constrained.sv`) demonstrates the core functionality:

1.  Imports `bus_trans_v2_pkg::*`.
2.  Creates specific constrained transactions.
3.  Randomizes the objects with custom inline constraints (e.g., data > 200).
4.  Calls `w.display()` and `r.display()`. The polymorphic output verifies that the correct derived method is executed and that the generated data adheres to all specified constraints.
```