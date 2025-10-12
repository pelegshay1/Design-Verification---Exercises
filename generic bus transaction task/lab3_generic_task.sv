module lab3_generic_task;
typedef enum {READ, WRITE} trans_kind_e;
logic [31:0] memory[logic[7:0]]; // 8-bit address, 32-bit data

//  generic 'bus_transaction' task here.
task automatic bus_transaction(input trans_kind_e kind, input logic [7:0] adr, inout logic [31:0] dat) ;
	if (kind == WRITE) memory[adr]=dat;
	#15;
	if (kind == READ) dat=memory[adr];
	#15;
endtask : bus_transaction

logic [31:0] readback ,data=32'h0000abcd;

initial begin
// perform a write, then a read-back, and verify the result.
bus_transaction (WRITE, 8'h1b , data);
readback = 32'h00000000;
bus_transaction (READ, 8'h1b, readback);
assert (readback == data) $display("Test Sucsseful input data:%h is equal to readback data %h",data, readback);
else $fatal(1, "TEST FAILED! Mismatch. Wrote %h, Read %h", data, readback);

#10;
$finish;
end
endmodule
