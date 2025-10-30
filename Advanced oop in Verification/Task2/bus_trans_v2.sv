import bus_trans_v2_pkg::*;
class enhanced_bus_trans;
	//Propertis 	
	rand logic [7:0]  addr , data;
	 rand kind_e kind;

	//constructor
	function new();
	endfunction : new
	//constraint
	constraint addr_c {addr>=8'h10 ; addr<=8'hF0;}
	constraint kind_c {if(kind == READ) addr % 2 == 0 ;}

	//print propertis
	virtual function void display(string name);
		$display("[%0s] ADDR: %0h, DATA: %0h",name, addr, data);	
	endfunction : display


endclass : enhanced_bus_trans