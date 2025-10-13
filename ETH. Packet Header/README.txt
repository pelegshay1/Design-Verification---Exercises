# Ethernet Packet Header Generator in SystemVerilog

This project demonstrates the use of SystemVerilog `typedef`, `enum`, and `struct` constructs to model an Ethernet packet header. 
It includes a utility module for packet creation and a testbench to verify correct functionality.

## 📦 Package: `packet_defs`

Defines shared types used across the project:

- `mac_addr_t`: 48-bit MAC address.
- `ethertype_e`: Enum representing Ethernet types (`IPV4`, `ARP`, `IPV6`).
- `packet_header_t`: Struct containing destination MAC, source MAC, and ethertype.

## 🔧 Module: `Packet_Util`

Provides a function to create a new Ethernet packet header:

```systemverilog
function automatic packet_header_t create_packet(mac_addr_t des, mac_addr_t source, ethertype_e ethtype);

This function returns a packet_header_t struct populated with the provided parameters.


🧪 Testbench: tb_lab1
Simulates the creation of an Ethernet packet and verifies its correctness:
- Declares MAC addresses and ethertype.
- Calls create_packet to generate a new packet.
- Uses assert to verify the packet fields match the inputs.
- Displays the packet contents and simulation ti

 Files
- packet_defs.sv: Type definitions.
- Packet_Util.sv: Packet creation logic.
- tb_lab1.sv: Testbench for validation.

