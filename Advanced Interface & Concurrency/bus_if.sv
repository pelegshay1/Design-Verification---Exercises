interface bus_if (input logic clk);
	logic req;
	logic gnt;
	logic [7:0] addr;
	logic [31:0] data;
	
	modport master (output req,output addr,output data,input gnt);

	modport slave (input req,output gnt,input addr,input data);

	clocking driver_cb @(posedge clk); // Define clocking block named 'driver_cb'
		default input #1step output #2; // Default skews (input: 1 step before edge, output: 2 units after)
										// Can override defaults per signal:
		output req; 					// Uses default output skew #2
		output data;					 // Uses default output skew #2
		output addr;					// Uses default output skew #2
		input gnt; 						// Uses default input skew #1step
	endclocking : driver_cb

	clocking monitor_cb @(posedge clk);
		default input #1step output #0; // Monitor might not drive outputs
		
		input req, gnt, data,addr; // All sampled 1 step before clock edge
	endclocking : monitor_cb

	modport driver (clocking driver_cb); // Expose only the clocking block signals/timing
	modport monitor (clocking monitor_cb);

endinterface : bus_if