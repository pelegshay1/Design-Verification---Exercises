module shift_reg_testbench (
	
);
logic clk, s_in, is_zero;
logic [1:0] mode;
logic [3:0] p_in, q_out;
initial begin
	clk=0;
	forever #5 clk = ~clk;
end
lab2_shift_reg U1(clk, mode, p_in, s_in, q_out, is_zero);
initial begin
	//input register
	mode=2'b11;
	p_in=4'b0001;
	#10;
	@(posedge clk)
	$display("The Sequence %b has been loaded to shift reg",p_in);
	#10;

	//shift left
	mode=2'b01;
	s_in=1;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted left %b with LSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;

	//shift left
	mode=2'b01;
	s_in=1;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted left %b with LSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;

	//shift right
	mode=2'b10;
	s_in=1;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted right %b with MSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;

	//shift right
	mode=2'b10;
	s_in=0;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted right %b with MSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;

	//shift right
	mode=2'b10;
	s_in=0;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted right %b with MSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;

	//shift right
	mode=2'b10;
	s_in=0;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted right %b with MSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;

	//shift right
	mode=2'b10;
	s_in=0;
	#10;
	@(posedge clk)
	$display("Loaded Sequence %b shifted right %b with MSB %b",p_in,q_out,s_in);
	p_in=q_out;
	#10;
	
	assert (is_zero) $display("%b Zero flag is high",is_zero);
	$finish;

end
endmodule : shift_reg_testbench
