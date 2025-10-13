// FIFO module implemntation
module FIFO_MODULE #(parameter int DATA_WIDTH=32)
 (
	input logic clk,    // Clock
	input logic push, //push back flag
	input logic pop,	//pop front flag
	input logic [DATA_WIDTH-1:0] data_in, //port for data in FIFO
	output logic  [DATA_WIDTH-1:0] data_out, // port for data out FIFO
	output logic empty
	
);

logic [DATA_WIDTH-1:0] fifo_q[$];  //dynamic array - OUR FIFO

always_ff @(posedge clk) begin  // LOGIC of the FIFO
	if (fifo_q.size() == 0) begin
		empty = 1;
	end else empty=0;
	if(push) begin
		fifo_q.push_back(data_in);
	end
	if (pop&&!empty) begin
		data_out=fifo_q.pop_front();
	end
end
endmodule : FIFO_MODULE
