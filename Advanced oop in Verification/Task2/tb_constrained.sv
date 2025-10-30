

module tb_constrained ;
	import bus_trans_v2_pkg::*;

	write_trans w;
	read_trans r;
	string name;
	initial begin
		w=new();
		r=new();
		//high-data writes
		repeat (5)begin
			if (!(w.randomize() with {data>200;})) begin // Check return value!
				$error("Randomization failed!");
			end else begin
				//$display("Randomized: Data=%d, Address=%d", w.data, w.addr);
				w.display(name);
			end
		end

		repeat (5)begin
			if (!(r.randomize() with {addr<8'h80;})) begin // Check return value!
				$error("Randomization failed!");
			end else begin
				//$display("Randomized: Data=%d, Address=%d", w.data, w.addr);
				r.display(name);
			end
		end
	end

endmodule : tb_constrained