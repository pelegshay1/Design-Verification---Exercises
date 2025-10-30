
import bus_trans_v2_pkg::*;
class write_trans extends enhanced_bus_trans;
	//Constructor -
	function new();
	endfunction : new

	//override display function - changes the string - WRITE
	function void display(string name );
		name= "WRITE Transaction";
		$display("[%0s] ADDR: %0h, DATA: %0h",name, addr, data);
	endfunction : display

	constraint type_c {kind == WRITE;}
endclass : write_trans



class read_trans extends enhanced_bus_trans;
	//Constructor -s
	function new();
	endfunction : new

	//override display function - changes the string - READ
function void display(string name );
	name = "READ Transaction";
	$display("[%0s] ADDR: %0h, DATA: %0h",name, addr, data);
endfunction : display
	constraint type_c {kind == READ;}
endclass : read_trans


