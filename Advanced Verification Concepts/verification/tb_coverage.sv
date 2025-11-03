`include "mem_trans.sv"
`include "coverage_collector.sv"

module tb_coverage() ;
	initial begin
		coverage_collector collect;
		mem_trans txn;
		collect = new();
		repeat (100) begin
			txn = new();
			if(txn.randomize())begin
				txn.display();
				collect.sample(txn);
			end
			else begin
				$fatal(1, "Randomization failed! Check constraints.");
			end
		end
		$display("Final Coverage = %0.2f%%", $get_coverage());
	end
endmodule : tb_coverage