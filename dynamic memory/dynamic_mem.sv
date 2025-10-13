module dynamic_mem ();
bit [7:0] memory[];

task automatic configure(input int size);
	memory=new[size];
endtask : configure

task write(input int addr, input bit [7:0] data);
	if (addr >= memory.size()) configure(addr + 1); //if addr is out of bounds - creat a new space in array
	if (addr >= 0 && addr < memory.size()) // if addr is in bound - write to the address in array
		memory[addr] = data;
endtask : write

function automatic bit [7:0] read(input int addr);
	if (addr >= 0 && addr < memory.size()) return memory[addr]; // if addr is inbound read from array in adress
	else return 8'bxxxxxxxx; // if addr is outofbounds return don't care
endfunction : read


endmodule : dynamic_mem
