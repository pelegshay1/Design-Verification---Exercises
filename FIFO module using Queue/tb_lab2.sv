// FIFO TB
module tb_lab2 (
);

logic [31:0] datain [3:0]= {32'hDEADBEEF,32'hCAFEBABE,32'hFEEDFACE,32'hBAADF00D};
logic [31:0] dataout [3:0]= '{default:32'h00000000};

logic clk=0;
always #5 clk = ~clk;
int count = 0;
 logic push;
logic pop;
logic [31:0] data_in;
logic [31:0] data_out;
logic empty;
`include "FIFO_MODULE.sv"

 FIFO_MODULE dut (
  .clk(clk),
  .push(push),
  .pop(pop),
  .data_in(data_in),
  .data_out(data_out),
  .empty(empty)
);

task automatic push_item(input logic [31:0] item);
	push=1;
	data_in=item;
	@(posedge clk);
	push=0;
endtask

task automatic pop_item();
	pop=1;
	@(posedge clk);
	pop=0;
endtask : pop_item


initial begin
	push=0;
	pop=0;
	push_item(datain[3]);
	push_item(datain[2]);
	push_item(datain[1]);
	push_item(datain[0]);

	@ (posedge clk);
	assert (empty!=1) else $fatal (1, "ERROR - FIFO should be loaded");
	@ (posedge clk);


	//pop first
	pop_item();
	dataout [3] = dut.data_out;
	assert (dataout[3] == datain [3]) else $fatal (1, "ERROR - DATA IN != DATA OUT");
	assert (empty!=1) else $fatal (1, "ERROR - FIFO should be loaded");
	$display("First Item PASSED: %h == %h",dataout[3], datain[3]);

	@ (posedge clk);

	//pop second
	pop_item();
	dataout [2] = dut.data_out;
	assert (dataout[2] == datain [2]) else $fatal (1, "ERROR - DATA IN != DATA OUT");
	assert (empty!=1) else $fatal (1, "ERROR - FIFO should be loaded");
	$display("First Item PASSED: %h == %h",dataout[2], datain[2]);

	@ (posedge clk);
	
	//pop third
	pop_item();
	dataout [1] = dut.data_out;
	assert (dataout[1] == datain [1]) else $fatal (1, "ERROR - DATA IN != DATA OUT");
	assert (empty!=1) else $fatal (1, "ERROR - FIFO should be loaded");
	$display("First Item PASSED: %h == %h",dataout[1], datain[1]);

	@ (posedge clk);
	
	//pop fourth
	pop_item();
	dataout [0] = dut.data_out;
	assert (dataout[0] == datain [0]) else $fatal (1, "ERROR - DATA IN != DATA OUT");
	assert (empty!=1) else $fatal (1, "ERROR - FIFO should be loaded");
	$display("First Item PASSED: %h == %h",dataout[0], datain[0]);

	@ (posedge clk);
	

	$finish;
end
endmodule : tb_lab2
