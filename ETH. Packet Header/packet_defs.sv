//shared type definitons
// define the new typdefs - Addres and Enum- type of ETH. , and a packet_header struct that contains both of them to define the ETH. interface
package packet_defs;
	typedef logic [47:0] mac_addr_t;
	typedef enum logic [1:0] {IPV4, ARP, IPV6 } ethertype_e;
	typedef struct {
		mac_addr_t dest;
		mac_addr_t source;
		ethertype_e ethertype;
	}packet_header_t;
endpackage : packet_defs

