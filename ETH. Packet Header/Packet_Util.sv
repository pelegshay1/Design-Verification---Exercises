// Logic to use new types =]
// A function that creats new packet_header_t strcuts 
`include "packet_defs.sv"

module Packet_Util (
//	input clk,    // Clock
//	input clk_en, // Clock Enable
//	input rst_n,  // Asynchronous reset active low
);

import packet_defs::*;
function automatic packet_header_t create_packet(mac_addr_t des, mac_addr_t source, ethertype_e ethtype);
	packet_header_t newpacket;
	newpacket.dest=des;
	newpacket.source=source;
	newpacket.ethertype=ethtype;
	return newpacket;
endfunction : create_packet

endmodule : Packet_Util