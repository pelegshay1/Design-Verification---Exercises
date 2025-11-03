module arbiter_checker (
	input clk,    // Clock
	input reset,  // Asynchronous reset active low
	input logic req_0, req_1,
	input logic gnt_0, gnt_1
);

//property: both grants can never be active at the same time.
property A1_MUTUAL_EXCLUSION;
	@(posedge clk) disable iff (reset)
	!(gnt_0 && gnt_1);
endproperty : A1_MUTUAL_EXCLUSION

A1: assert property (A1_MUTUAL_EXCLUSION) else $error("Mutual exclusion failed!");

property A2_GRANT0_IMPLIES_REQ0;
	@(posedge clk) disable iff (reset)
		req_0 |-> gnt_0; // If req0 is high gnt also must be high
	endproperty : A2_GRANT0_IMPLIES_REQ0


A2: assert property (A2_GRANT0_IMPLIES_REQ0) else $error("Implies 0 exclusion failed!");

property A3_GRANT1_IMPLIES_REQ1;
	@(posedge clk) disable iff (reset)
		req_1 |-> gnt_1; // If req0 is high gnt also must be high
	endproperty : A3_GRANT1_IMPLIES_REQ1


A3: assert property (A3_GRANT1_IMPLIES_REQ1) else $error("Implies 1 exclusion failed!");



endmodule : arbiter_checker
