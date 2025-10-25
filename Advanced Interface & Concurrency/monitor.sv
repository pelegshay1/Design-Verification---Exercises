`include "transaction.sv"

class monitor;
	//virtual bus_if.slave bus_vi;
	virtual bus_if.monitor bus_vi;   // virtual bus modport to monitor 
	transaction tr;
	mailbox # (transaction) mail_box_h;

	function new(virtual bus_if.monitor vi,mailbox # (transaction) mbx); // Constructor for monitor object 
		//intialize the object
		bus_vi = vi ; 
		mail_box_h = mbx; 													
	endfunction : new

	
	task run(); // run task
		//forever begin
		//	wait (bus_vi.req); // wait for req from master
		//	#5;
		//	$display("Request signal raised by master splinter");
		//	$display("Monitor: Transaction observed -> addr=%h, data=%h, Request=%b", bus_vi.addr, bus_vi.data, bus_vi.req);
		//end

		forever @(bus_vi.monitor_cb) begin
			wait (bus_vi.monitor_cb.req && bus_vi.monitor_cb.gnt);			//wait for full transaction : Request AND Granted == 1
			tr = new(); 					// creat new transaction object
			tr.addr = bus_vi.monitor_cb.addr;
			tr.data = bus_vi.monitor_cb.data;
			mail_box_h.put(tr);			  //put transaction in mailbox
			$display("[%tns] New transaction inside mailbox: Sampled req=%b, gnt=%b, data=%h", $time, bus_vi.monitor_cb.req, bus_vi.monitor_cb.gnt, bus_vi.monitor_cb.data);

		end
	endtask : run
endclass : monitor
