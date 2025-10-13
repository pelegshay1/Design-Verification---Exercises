module tb_lab3;
  logic clk = 0;
  logic reset;

  // 1. Instantiate the interface
  bus_if bus_inst(clk);

  // 2. Instantiate the Master Agent
  BusMaster master0 ( .clk(clk), .bus(bus_inst) );

  // 3. Instantiate the DUT (Slave)
  Slave_memory slave0 ( .clk(clk), .reset(reset), .bus(bus_inst) );

  // Clock Generator
  always #5 clk = ~clk;

  // --- Main Test Sequence ---
  // The test sequence now resides in the top-level testbench, where it belongs.
  initial begin
    logic [31:0] read_back_data;
    logic [31:0] write_data = 32'hFEEDFACE;
    logic [7:0]  test_addr  = 8'hB1;

    $monitor("Time:%3tns|rst:%b|req:%b gnt:%b|we:%b addr:%h|wdata:%h rdata:%h",
             $time, reset, bus_inst.req, bus_inst.gnt, bus_inst.wr_en, 
             bus_inst.addr, bus_inst.wdata, bus_inst.rdata);
             
    // --- Reset and Test Start ---
    reset = 1; #15;
    reset = 0;
    $display("\n[%tns] TESTBENCH: Starting transaction sequence.", $time);

    // --- Call tasks within the master instance ---
    master0.do_write(test_addr, write_data);
    
    @(posedge clk); // Give the bus a cycle to be idle
    
    master0.do_read(test_addr);

    // After the read task completes, the data is on the bus. Wait one cycle for it to be stable.
    @(posedge clk);
    read_back_data = bus_inst.rdata;

    @(posedge clk);
    
    // --- Verification ---
    assert (read_back_data == write_data)
      else $fatal(1, "TEST FAILED! Mismatch. Wrote %h, Read %h", write_data, read_back_data);

    $display("\n--- TEST PASSED! Write-then-read-back successful. ---\n");
    #20;
    $finish;
  end
endmodule