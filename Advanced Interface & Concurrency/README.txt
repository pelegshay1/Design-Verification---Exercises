SystemVerilog Verification Environment: Concurrency Test

Overview

This project is a minimal, self-contained SystemVerilog Testbench designed to verify the correct operation and arbitration of a simple request/grant bus interface. 
The primary goal of the testbench is to demonstrate concurrency control when multiple agents (drivers) attempt to access a shared resource (the DUT/bus) simultaneously using a SystemVerilog semaphore.

The verification environment follows basic Universal Verification Methodology (UVM) principles, utilizing transaction-level modeling, a bus interface with clocking blocks, separate driver and monitor components, and a checker.

File Structure (Plain Text Friendly)

The project is composed of the following files:

File Name           : Type                      : Description
------------------- : ------------------------- : -------------------------------------------------------------------------------------------------------------------
dut_slave.sv        : Design Under Test (DUT)   : A simple bus slave module that immediately asserts the 'gnt' (grant) signal whenever the 'req' (request) signal is high.
bus_if.sv           : Interface                 : Defines the bus signals ('req', 'gnt', 'addr', 'data'). Includes clocking blocks and modports for timing control.
transaction.sv      : Data Object               : A SystemVerilog class defining the transaction object ('addr', 'data') used to pass information between components.
driver.sv           : Verification Component    : The Busdriver class. It uses a semaphore ('access_limit' initialized to 1) to ensure only one driver can access the bus at a time.
monitor.sv          : Verification Component    : The monitor passively observes the bus, samples data upon a valid transaction, and sends it to the checker via a mailbox.
checker.sv          : Verification Component    : The mychecker class. It retrieves transactions from the mailbox, validates the fixed 'addr' and 'data', and counts processed transactions.
tb_concurrency.sv   : Testbench Top             : The top module that sets up the environment, including the semaphore, mailbox, and launches two concurrent driver instances.

Test Scenario

The test scenario implemented in tb_concurrency.sv is as follows:

A single semaphore key is created ('access_limit = new(1)').

Two instances of 'Busdriver' are instantiated, both referencing the same bus interface and sharing the same semaphore handle.

The 'monitor' and 'checker' tasks are started in a 'fork...join_none' block to run continuously.

Both drivers are launched concurrently in a 'fork...join' block.

The semaphore ensures that only one driver can proceed with the transaction at a time ('access_limit.get(1)').

The test completes after a specific number of transactions (set to 2 in the 'checker.sv' limit). An assertion checks that exactly two transactions were processed successfully.

This test effectively verifies that the two concurrent drivers correctly arbitrate access to the bus using the semaphore.

How to Run

This project can be simulated using any standard IEEE 1800-2017 compliant SystemVerilog simulator - cannot gurantee - Simulated on Questa only.

Compile all SystemVerilog files: 'transaction.sv', 'bus_if.sv', 'dut_slave.sv', 'driver.sv', 'monitor.sv', 'checker.sv', and 'tb_concurrency.sv'.

Elaborate the top module: 'tb_concurrency'.

Run the simulation.


The simulation output should show the two drivers sequentially gaining access to the bus, and the checker confirming the validity of the two resulting transactions.
