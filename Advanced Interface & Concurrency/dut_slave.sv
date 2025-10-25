module dut_slave (
	input clk,    // Clock
	input reset,  // Asynchronous reset active low
	bus_if.slave bus
);

always_ff @(posedge clk or posedge reset) begin
	if(bus.req) begin 
		bus.gnt<=1'b1;
	end
	else bus.gnt<=1'b0;
end

endmodule : dut_slave
