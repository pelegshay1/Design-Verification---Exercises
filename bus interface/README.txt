# Bus Master-Slave Interface in SystemVerilog

This project implements a simple bus-based communication system in SystemVerilog, consisting of a `BusMaster`, a `Slave_memory`, and a shared `bus_if` interface.
 It also includes a testbench (`tb_lab3`) that verifies the correct operation of the system.

## 🧩 Project Structure

- `BusMaster`: Initiates read and write transactions over the bus.
- `Slave_memory`: Responds to bus requests and stores data in an internal memory array.
- `bus_if`: Defines the shared bus interface with modports for master and slave.
- `tb_lab3`: A testbench that simulates the system and verifies functionality.

## 🔧 Features

- **Modular Design**: Clear separation between master, slave, and interface.
- **Handshake Protocol**: Uses `req` and `gnt` signals to manage access to the bus.
- **Read/Write Tasks**: Master module includes `do_write` and `do_read` tasks.
- **Memory Array**: Slave contains a 256x32-bit memory array.
- **Testbench Verification**: Includes assertions and `$monitor` for runtime validation.

## 🧪 Test Scenario

The testbench performs the following sequence:

1. Applies reset.
2. Writes the value `0xFEEDFACE` to address `0xB1`.
3. Reads back from the same address.
4. Compares the read value with the written value.
5. Displays a success or failure message.


