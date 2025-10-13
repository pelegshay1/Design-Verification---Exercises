
// Test Bench - variable declarations and dut instastiation 

`include "Packet_Util.sv"


module tb_lab1 (
//	input clk,    // Clock
//	input clk_en, // Clock Enable
//	input rst_n,  // Asynchronous reset active low
	
);
import packet_defs::*;
Packet_Util dut ();
mac_addr_t Sour=48'hA3F9C7D2B8E1, Dest=48'h4D7E9A3C1F56; // Declarations 
ethertype_e Type = IPV6;
packet_header_t ETHpack;

initial begin
	ETHpack = dut.create_packet (Dest,Sour,Type); // Call function to create new struct and input to struct
	assert (ETHpack.dest == Dest && ETHpack.source == Sour && ETHpack.ethertype == Type) begin // Assert that the new ETH. pack parameters are equal to the input
	 #10;
	 $display("At %tns Sim Time: Test Succesful - ETH packet type - %s created",$time,ETHpack.ethertype);
	 $display("MAC Destination Adress: %h",ETHpack.dest);
	 $display("MAC Source Adress: %h",ETHpack.source);
	end
	else $display("ERROR: ETH packet creation Failed");
	$finish;
end
endmodule : tb_lab1
