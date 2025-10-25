class Busdriver;
	//virtual bus_if.master bus_vi; // Virtual Interface with modport Master of bus_if
	virtual bus_if.driver bus_vi;
	event trans_done; //handle 
	int id;
	semaphore access_limit;

	 function new(virtual bus_if.driver vi,semaphore limit_h ); // contructor for a new object of Driver class
    bus_vi = vi;
    access_limit = limit_h;
  	endfunction

  	task run (int id);
  		//bus_vi.req=1'b1;
  		//bus_vi.addr=8'hAB;
  		//bus_vi.data=32'hF00D;
  		@(bus_vi.driver_cb);
  		access_limit.get (1);   		//semaphore - wait for key
  		bus_vi.driver_cb.req<=1;		//signal request to slave
  		bus_vi.driver_cb.addr<=8'hAB;	// send Address
  		bus_vi.driver_cb.data<=32'hF00D; //send data
  		$display("Request sent at time %0t for transaction #%d", $time,id);
  		#5;
		wait (bus_vi.driver_cb.gnt);		//wait for granted from slave
		->>trans_done;						//finish event
		bus_vi.driver_cb.req<=1'b0;			//lower request signal
		access_limit.put (1); 			//semaphor - put key back  			
		//$display("Signal Bus Granted = %b",bus_vi.driver_cb.gnt);
		$display("Grant received at time %0t for transaction #%d", $time,id);
  	endtask : run 



endclass : Busdriver
