`include "transaction.sv"

class mychecker;
	transaction tr;
	int count;
	int limit =2;
	mailbox # (transaction) mail_box_h;

	function new (mailbox # (transaction) mbx);  //construct
		mail_box_h=mbx;
	endfunction : new 

	task run();
		forever begin
		mail_box_h.get(tr);				//get the next mail in mailbox
		count++;						// one more to transaction counter
		assert (tr.data == 32'hF00D && tr.addr == 8'hAB);		// check the validity of the transaction

		if (count == limit) begin
                $display("Checker: Successfully processed %0d transactions. Exiting run task.", limit);
                return;		//If we got to the limit of transaction count. (only 2) exist the the forever loop
            end
		end
	endtask : run
	
endclass : mychecker
