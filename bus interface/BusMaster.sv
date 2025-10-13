module BusMaster (
	input logic clk,    // Clock
	bus_if.master bus
);

//Busmaster moudle - control the bus interface - 2 ports - input clock and and interface called bus bus_if type.
task automatic do_write(input logic [7:0] adr, input logic [31:0] dat); 
    bus.addr  = adr;     
    bus.wdata = dat;   // automatic task - to write to slave memory
    bus.wr_en = 1;
    bus.req   = 1;

    wait (bus.gnt == 1);

    bus.req   = 0;
    bus.wr_en = 0;
  endtask 

task automatic do_read(input logic [7:0] adr);
    bus.addr  =  adr;
    bus.req   = 1;                          // automatic task - to read from slave memory
    repeat (2) @(posedge clk);
    bus.wr_en = 0;
    
    wait (bus.gnt == 1);

    $display("Read data: %h", bus.rdata);

    bus.req = 0;
  endtask


endmodule : BusMaster
