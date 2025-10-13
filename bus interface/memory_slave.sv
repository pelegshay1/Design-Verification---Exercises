module Slave_memory (
	input logic clk,    // Clock port
	input logic reset,   //reset port
	bus_if.slave bus       //interface port
);

	logic [31:0] memory [255:0]; // define slave memory array

//Response to master request
 always_ff @(posedge clk or posedge reset) begin
    if (reset) begin //if reset is on - reset bus_granted and data_read
      bus.gnt   <= 0;
      bus.rdata <= 0;
    end else begin
      if (bus.req) begin //if Master requseted and interface with slave
        bus.gnt <= 1;

        if (bus.wr_en) begin // if write enable is on write to memory in address location
          memory[bus.addr] <= bus.wdata;
        end 

        else begin
          bus.rdata <= memory[bus.addr]; // if write enbale is off read from memory in adress location
        end

      end 

      else begin //If no request no granted
        bus.gnt <= 0; // After interface is done - reset bus granted to '0'
      end
    end
  end

endmodule : Slave_memory
