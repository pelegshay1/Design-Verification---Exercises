module tb_casting ;
	import casting_trans_pkg::*;
	bus_trans father;
	write_trans write;
	specialized_error_trans err;
	bus_trans q[$];

	initial begin
		repeat (10) begin
			if ($urandom_range(0,1) == 0) begin // if '0' create a write_trans if '1' creat an error_trans
				write = new();
				q.push_back(write);

			end
			else begin
				err = new (8'hff);
				q.push_back(err);
			end
		end
		foreach (q[idx]) begin
			specialized_error_trans err_handle;   //err handle to cast on
			if ($cast(err_handle, q[idx]))begin  //casting chack
				$display("Casting successful!! %h",err_handle.error_code); // success
			end
			else begin
				$display("Cating failed the object was not and error teansaction"); //fail
			end
		end
		$finish;
	end
endmodule : tb_casting
