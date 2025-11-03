class mem_trans;
	//properties
	rand logic [7:0] m_addr;
	rand logic [31:0] m_data;
	rand bit m_is_write;
	rand int m_burst_len;

	constraint burst_c {m_burst_len>=1 ; m_burst_len<=8;}
	
	function display();
			$display("Trans. Properties: Addr:%h,	Data:%h,	Write bit:%b,	Burst length:%d",m_addr, m_data, m_is_write, m_burst_len);
	endfunction : display	
	
endclass : mem_trans