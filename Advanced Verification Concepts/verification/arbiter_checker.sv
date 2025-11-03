module arbiter_checker (
	input clk,    // Clock
	input reset,  // Asynchronous reset active low
	input logic req_0, req_1,
	input logic gnt_0, gnt_1
);


property A1_MUTUAL_EXCLUSION;
	@(posedge clk) disable iff (reset)
	!(gnt_0 && gnt_1); // both grants can never be active at the same time.
endproperty : A1_MUTUAL_EXCLUSION

A1: assert property (A1_MUTUAL_EXCLUSION) else $error("Mutual exclusion failed!");

property A2_GRANT0_IMPLIES_REQ0;
	@(posedge clk) disable iff (reset)
		gnt_0 |->$past(req_0) ; // If gnt0 is high req0 also must be high 1 cycle before hence the $past() func
	endproperty : A2_GRANT0_IMPLIES_REQ0


A2: assert property (A2_GRANT0_IMPLIES_REQ0) else $error("Implies 0 exclusion failed!");

property A3_GRANT1_IMPLIES_REQ1;
	@(posedge clk) disable iff (reset)
		gnt_1 |-> $past(req_1) ; // If gnt1 is high req1 also must be high 1 cycle before hence the $past() func
	endproperty : A3_GRANT1_IMPLIES_REQ1


A3: assert property (A3_GRANT1_IMPLIES_REQ1) else $error("Implies 1 exclusion failed!");

property A4_REQ1_IMPLIES_GRANT1;
	@(posedge clk) disable iff (reset)
		req_1 |-> gnt_1 ; //  if req_1 asserted gnt_1 must be asserted also at the same clk cycle 
	endproperty : A4_REQ1_IMPLIES_GRANT1


A4: assert property (A4_REQ1_IMPLIES_GRANT1) else $error("Granted1 not given for Request1!");

property A5_REQ0_IMPLIES_GRANT0;
	@(posedge clk) disable iff (reset)
		req_0 |-> gnt_0 ; //  if req_0 asserted gnt_0 must be asserted also at the same clk cycle 
	endproperty : A5_REQ0_IMPLIES_GRANT0


A5: assert property (A5_REQ0_IMPLIES_GRANT0) else $error("Granted0 not given for Request0!");


endmodule : arbiter_checker
