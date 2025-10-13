
interface bus_if(
	input logic clk
	);
// interface def
  logic req;
  logic gnt;                // define the bus interface - input port clock
  logic [7:0] addr;
  logic [31:0] rdata;       //interface signals
  logic [31:0] wdata;
  logic wr_en;

// slave def                        2 modports - master and slave
  modport slave (
    input  req, addr, wdata, wr_en,
    output gnt, rdata                       
  );

// master def
  modport master (
    input  gnt, rdata,
    output req, addr, wdata, wr_en
  );
endinterface
