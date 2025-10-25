
`ifndef TRANSACTION_SV  //include guard
`define TRANSACTION_SV  //include guard

class transaction;
	logic [7:0] addr;   //address
	logic [31:0] data;	//data
	

	function new ();  //construct
	endfunction : new 

	function void display(string name = "Transaction");					//Print the new object
        $display("[%s] Addr: 0x%h, Data: 0x%h", name, addr, data);
    endfunction

endclass : transaction

`endif  //include guard