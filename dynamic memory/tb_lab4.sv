//test bench dynamic array biaaaaatch
module tb_lab4 (
);
`include "dynamic_mem.sv";
dynamic_mem dut ();

initial begin
	dut.configure (4);
	dut.write (5,8'hAB);
	dut.read (5);
	assert (dut.memory[5] == 8'hAB) else $fatal (1, "ERROR Data is not correct");
	$display("Test PASSED - Array resized succefuly DATA written %h",dut.memory[5]);
	$finish;
end
endmodule : tb_lab4