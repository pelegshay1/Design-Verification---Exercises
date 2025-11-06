class mem_trans;
	//properties
	typedef enum {WRITE, READ, IDLE} opcode_e;
	rand opcode_e opcode;
	rand logic [7:0] m_addr;
	rand logic [31:0] m_data;
	rand int m_burst_len;

	constraint burst_c {m_burst_len>=1 ; m_burst_len<=8;}

	constraint op_code_dist {opcode dist {WRITE :/40,READ :/40,IDLE :/20}; }

	constraint idle_signle_burst {(opcode == IDLE) -> (m_burst_len==1); }
	
	function display();
      $display("Trans. Properties: Addr:%h,	Data:%h,	OP-Code:%s,	Burst length:%d",m_addr, m_data, opcode, m_burst_len);
	endfunction : display	
	
endclass : mem_trans