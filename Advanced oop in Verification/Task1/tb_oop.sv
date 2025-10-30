`include "derived_trans.sv"
import bus_trans_pkg::*;
module tb_oop ;

	static int  id=0;
	initial begin
		bus_trans q[$];  //queue of bus_trans
		bus_trans t;
		read_trans t_read;
		write_trans t_write;
		t=new(id);
		repeat (10) begin

			if ($urandom_range(0,1) == 0) begin // randomly pick which concrete transaction to create
				t_write = new(id); // Create derived write object
				t = t_write; // Assign derived handle to base handle
			end

			else begin
				t_read = new(id);// Create derived read object
				t = t_read; // Assign derived handle to base handle
			end

			// randomize fields inside the object (returns 1 on success)
			if (!t.randomize()) begin
				$display("Randomize failed for id=%0d", id);
				// handle failure (retry, fatal, or skip). Example: retry once:
				assert(t.randomize()) else $fatal("randomize retry failed");
			end

			q.push_back(t);
			id++;
		end
		foreach (q[idx]) begin
			q[idx].display();
		end
	end

endmodule : tb_oop
