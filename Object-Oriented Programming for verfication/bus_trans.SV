//define bus transaction class
class bus_trans;

	//Propertis 
	static int ID;
	int U_ID;
	rand logic [3:0]  addr , data;

	//constructor
	function new(int u_id);
		U_ID = u_id;
	endfunction : new

	//print propertis
	virtual function void display(string name = "Bus_Transaction");
		$display("[%0s] ADDR: %0h, DATA: %0h",name, addr, data);	
	endfunction : display
endclass : bus_trans

