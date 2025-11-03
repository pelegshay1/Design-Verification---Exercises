// Coverage Collector Class
// This class encapsulates the functional coverage logic
// for memory transactions (mem_trans).																									
class coverage_collector;

	// Covergroup type definiton
covergroup mem_trans_cg with function sample(mem_trans t);

		addres: coverpoint t.m_addr{ //address coverpoint
			bins low = {[0:63]};
			bins mid = {[64:191]};
			bins high = {[192:255]};
		}

		length: coverpoint t.m_burst_len {  //burst length coverpoint
			bins single = {1};
			bins burst = {[2:8]};
		}

		rw: coverpoint t.m_is_write {  //read or write bit
			bins read = {0};
			bins write = {1};
		}

		readwrite_x_burst : cross rw, length;


		endgroup : mem_trans_cg

		//constructor
		function new();
		// An instance of the covergroup must be created (allocated)
        // before it can be used. 'covergroup' is a type, and
        //***** 'mem_trans_cg' is the class property (handle) holding the instance.******
			mem_trans_cg = new();      
		endfunction : new

		// Public sample method
    // External components (like a monitor) will call this function
    // to report a new transaction for sampling.
		function void sample(mem_trans t);
			mem_trans_cg.sample(t);	// This function forwards the received transaction 't'
		endfunction : sample       // to the internal covergroup instance's own sample method
									// to perform the actual coverage sampling.
									//sample method that recieves the pointer to the object from outside
		

endclass : coverage_collector



//----------------------------------------------------------------------
    // NOTE: Explanation of 'with function' sampling
    //----------------------------------------------------------------------
    //
    // SystemVerilog provides two main ways to sample a covergroup:
    //
    // 1. Implicit (Clock-Based) Sampling:
    //    - Syntax: `covergroup my_cg @(posedge clk);`
    //    - How it works: The covergroup automatically samples the values
    //      of its coverpoints on every single clock edge.
    //    - Use Case: Good for sampling simple RTL signals or state
    //      machine variables that change with the clock.
    //
    // 2. Explicit (Functional) Sampling (THIS is what we are using):
    //    - Syntax: `covergroup my_cg with function sample(...);`
    //    - How it works: The covergroup does *NOT* sample automatically.
    //      It is a "passive" collector. It will *only* sample when
    //      another part of the code (in this case, our class's
    //      'sample' method) explicitly calls its 'sample' function.
    //
    // Why We Use 'with function' Here:
    // Our coverpoints (t.m_addr, t.m_burst_len) are not simple wires.
    // They are properties *inside* a transaction object ('t').
    //
    // This method allows our monitor (externally) to capture a complete
    // transaction object and then "push" that entire object into
    // this covergroup for analysis at the perfect moment.
    //
    //----------------------------------------------------------------------
    //----------------------------------------------------------------------
    // NOTE: How Total Coverage Percentage is Calculated
    //----------------------------------------------------------------------
    //
    // The initial assumption (that 1 transaction = 25%) only
    // considered the 'cross' coverage.
    //
    // However, the 'Total Coverage' percentage for the covergroup is
    // the weighted average of *ALL* components inside it
    // (all coverpoints and all crosses), unless weighted otherwise.
    //
    // Our components in this covergroup are:
    // 1. coverpoint 'addres' (with 3 bins)
    // 2. coverpoint 'length' (with 2 bins)
    // 3. coverpoint 'rw' (with 2 bins)
    // 4. cross 'readwrite_x_burst' (with 4 bins)
    //
    // We have a total of 4 coverage components.
    //
    // The formula for the Total Coverage is:
    // Total % = ( (%_addres) + (%_length) + (%_rw) + (%_cross) ) / 4
    //
    //----------------------------------------------------------------------
    // Analysis of the first run (Repeat 1):
    // Tx: (Write, Burst=4, Addr=191)
    //
    // %_addres = 1/3 bins = 33.33%
    // %_length = 1/2 bins = 50.00%
    // %_rw     = 1/2 bins = 50.00%
    // %_cross  = 1/4 bins = 25.00%
    // ------------------------------------
    // Total % = (33.33 + 50 + 50 + 25) / 4 = 158.33 / 4 = 39.58%
    //
    // This perfectly matches the simulation output (39.58%) and proves
    // the calculation is based on the average of all four components.
    //----------------------------------------------------------------------
