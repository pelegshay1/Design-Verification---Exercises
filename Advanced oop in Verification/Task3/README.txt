SystemVerilog OOP Labs: Polymorphism, Casting, and Randomization

== OVERVIEW ==

This project contains a set of small SystemVerilog labs designed to demonstrate key Object-Oriented Programming (OOP) concepts. The primary focus is on inheritance, polymorphism, and the practical application of dynamic casting ($cast). A secondary lab also demonstrates constrained randomization (randomize() with).

== KEY CONCEPTS DEMONSTRATED ==

1. Casting and Polymorphism (Main Lab)

   - Class Inheritance: A base class (bus_trans) is extended by two derived classes (write_trans and specialized_error_trans).
   - Polymorphism: Derived class objects (write and err) are stored in a queue (q[$]) of base class handles (bus_trans q[$]). This is possible through implicit up-casting.
   - Dynamic Down-Casting: The testbench (tb_casting.sv) iterates through the polymorphic queue and uses the $cast system function to safely check the "true" identity of each object at runtime.
   - Constructors & super: Derived classes use super.new() in their constructors to initialize the base class members.

2. Constrained Randomization (Secondary Lab)

   - In-line Constraints: The tb_constrained.sv testbench uses randomize() with { ... } to apply in-line constraints to class randomization.
   - Randomization Success Check: The code correctly checks the return value of randomize() to ensure the constraints were solvable.

== FILE STRUCTURE ==

* casting_trans_pkg.sv: The main package for the casting lab. It uses `include` to compile the class definitions in the correct order (base class first, then derived classes).
* casting_trans.sv: (Not provided, but included by the package) Assumed to contain the base class definition for bus_trans.
* derived_casting_trans.sv: Defines the derived classes write_trans and specialized_error_trans.
* tb_casting.sv: The testbench for the polymorphism and casting lab. It creates a mixed queue of transactions and uses $cast to identify them.
* bus_trans_v2_pkg.sv: (Not provided, but imported by tb_constrained) Assumed to contain the class definitions for the randomization lab.
* tb_constrained.sv: A separate testbench demonstrating constrained randomization.

== HOW TO COMPILE AND RUN ==

To run this project, you must compile the files in the correct order. The package must be compiled before the testbench that uses it.

Crucially: Do not compile casting_trans.sv or derived_casting_trans.sv as separate files. The casting_trans_pkg.sv file handles their inclusion.

Example: Running the Casting Lab with QuestaSim

1.  Compile the package:
    vlog +sv casting_trans_pkg.sv

2.  Compile the testbench:
    vlog +sv tb_casting.sv

3.  Run the simulation:
    # Load the design (use -c for batch mode)
    vsim -c tb_casting -do "run -all; quit"

== EXPECTED OUTPUT (from tb_casting.sv) ==

The output will vary due to randomization. You will see a mix of success and failure messages as the testbench loops through the queue and checks if each object is an error_trans.

# Casting failed the object was not and error teansaction
# Casting failed the object was not and error teansaction
# Casting successful!! ff
# Casting failed the object was not and error teansaction
# Casting successful!! ff
# Casting successful!! ff
# Casting failed the object was not and error teansaction
# Casting successful!! ff
# Casting failed the object was not and error teansaction
# Casting successful!! ff