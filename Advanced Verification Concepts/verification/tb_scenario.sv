

`include "scenario_trans.sv"

module tb_scenario (
);

initial begin
	mem_trans transact;
	repeat (50) begin
		transact = new();
		if(transact.randomize()) begin
			transact.display();
		end
	end
end

endmodule : tb_scenario