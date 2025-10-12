module lab2_shift_reg ( input logic clk,
input logic [1:0] mode,  //shift mode
input logic [3:0] p_in,  // input register
input logic s_in,    	  //input bit to push
output logic [3:0] q_out,  //output register
output logic is_zero);     // if q_out is zero raise flag


// shift register logic inside a single 'always_ff' block.

always_ff @(posedge clk) begin
	case (mode)
	2'b00:
		q_out<=q_out;
	2'b01:
		q_out<={p_in[2:0], s_in};
	2'b10:
		q_out<={s_in, p_in[3:1]};
	2'b11:
		q_out<=p_in;
		default : q_out<=q_out;
	endcase
end

//  'is_zero' combinational output logic.
always_comb	begin
	is_zero=(q_out == 0);
end

endmodule
