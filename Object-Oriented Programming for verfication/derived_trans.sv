
`include "bus_trans.SV"

class write_trans extends bus_trans;

	//Constructor - just u_d inherit
	function new(int u_id);
		super.new(u_id);
	endfunction : new

	//override display function - changes the string - WRITE
	function void display(string name = "WRITE Transaction");
		super.display(name);
		$display("[%0s] ADDR: %0h, DATA: %0h",name, addr, data);
	endfunction : display
endclass : write_trans



class read_trans extends  bus_trans;
	randc logic [3:0] addr, data;

	//Constructor - u_d inherit and de-randomise properties data and adress
	function new(int u_id);
		super.new(u_id);
		data=4'h0;
		addr=4'h0;
	endfunction : new

	//override display function - changes the string - READ
	function void display(string name = "READ Transaction");
		super.display(name);
		$display("[%0s] ADDR: %0h, DATA: %0h",name, addr, data);
	endfunction : display
endclass : read_trans

