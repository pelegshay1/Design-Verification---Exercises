class write_trans extends bus_trans;
	//contructor
	function new();
		super.new(100);
	endfunction : new
	//display
	virtual function display();
		$display("write_trans class");
	endfunction : display
	
endclass : write_trans

class specialized_error_trans extends bus_trans;
	logic [7:0] error_code;
	//constructor
	function new(logic [7:0] err);
		super.new(50);
		error_code = err;
	endfunction : new
	
	virtual function display();
		$display("error_trans class error code:%h",error_code);
	endfunction : display

endclass : specialized_error_trans
