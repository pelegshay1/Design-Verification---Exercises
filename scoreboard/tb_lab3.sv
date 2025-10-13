// scoreboard tb
module tb_lab3 (
);
`include "scoreboard.sv"
scoreboard dut ();

initial begin

dut.add_item("apple");
dut.add_item("apple");
dut.add_item("apple");  //add items to associative array
dut.add_item("Meat");
dut.add_item("Chips");
dut.add_item("Chips");

assert (dut.get_count("apple") == 3 && dut.get_count("Meat") == 1 && dut.get_count("Chips") == 2) else $fatal (1," ERROR - Mismatch between key and Counter"); // Assert match between key and value
$display("Test Passed - apple - %d times, Meat - %d time, Chips - %d times",dut.get_count("apple"), dut.get_count("Meat"), dut.get_count("Chips")); // print result
$finish;
end

endmodule : tb_lab3
