`timescale 1ns / 1ps
module tb_lab1_parity_checker;

  // --- Testbench Variables ---
  logic clk, reset, start, data_in;
  logic checking, parity_error;
  
  // --- Instantiate the DUT ---
  // We can test the default DATA_WIDTH of 8.
  lab1_parity_checker #(.DATA_WIDTH(8)) dut (.*);

  // --- Clock Generator ---
  initial clk = 0;
  always #5 clk = ~clk;

  // --- Main Test Sequence ---
  initial begin
    $monitor("Time:%3tns | rst:%b start:%b din:%b | checking:%b error:%b",
             $time, reset, start, data_in, checking, parity_error);

    // 1. Reset the DUT
    reset = 1;
    start = 0;
    data_in = 0;
    @(posedge clk);
    reset = 0;
    @(posedge clk);
    assert(!checking);
    // --- TEST CASE 1: Odd Parity (Should trigger error) ---
    $display("\n--- Starting Test Case 1: ODD Parity (1011_0101 -> 5 ones) ---");
    start <= 1;
    @(posedge clk);
    start <= 0;
    
    // Send 8 bits of data, one per clock cycle
    data_in <= 1; @(posedge clk); // Parity becomes 1 (odd) -> error should assert
    assert(parity_error);
    data_in <= 0; @(posedge clk); // Parity stays 1
    assert(parity_error);
    data_in <= 1; @(posedge clk); // Parity becomes 0 (even) -> error should de-assert
    assert(!parity_error);
    data_in <= 1; @(posedge clk); // Parity becomes 1
    assert(parity_error);
    data_in <= 0; @(posedge clk); // Parity stays 1
    assert(parity_error);
    data_in <= 1; @(posedge clk); // Parity becomes 0
    assert(!parity_error);
    data_in <= 0; @(posedge clk); // Parity stays 0
    assert(!parity_error);
    data_in <= 1; @(posedge clk); // Parity becomes 1 -> Final state is error
    assert(parity_error);
    
    // Wait for the FSM to enter the DONE state
    @(posedge clk);
    $display("--- Test Case 1 Finished ---\n");
    assert(!checking);
    
    // "reset" for next scenario
    start <= 0;
    data_in <= 0;
    @(posedge clk);
    
    // --- TEST CASE 2: Even Parity (Should NOT trigger error) ---
    $display("--- Starting Test Case 2: EVEN Parity (1100_1100 -> 4 ones) ---");
    start <= 1;
    @(posedge clk);
    start <= 0;

    // Send 8 bits of data
    data_in <= 1; @(posedge clk);
    assert(parity_error);
    data_in <= 1; @(posedge clk);
    assert(!parity_error);
    data_in <= 0; @(posedge clk);
    assert(!parity_error);
    data_in <= 0; @(posedge clk);
    assert(!parity_error);
    data_in <= 1; @(posedge clk);
    assert(parity_error);
    data_in <= 1; @(posedge clk);
    assert(!parity_error);
    data_in <= 0; @(posedge clk);
    assert(!parity_error);
    data_in <= 0; @(posedge clk);
    assert(!parity_error);
    
    @(posedge clk);
    $display("--- Test Case 2 Finished ---\n");

    #20;
   
    $finish;
  end
  
  initial begin
    $dumpfile("aa.vcd");       // Create a VCD output file named 'aa.vcd'
  	$dumpvars(0, tb_lab1_parity_checker); // Dump all variables in the testbench hierarchy
  end

endmodule