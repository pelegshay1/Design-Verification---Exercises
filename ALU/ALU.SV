// Define ALU module
module ALU #(parameter WIDTH = 8) (
input logic [WIDTH-1:0] a,
input logic [WIDTH-1:0] b,
input logic [WIDTH-1:0] opcode,
output logic [WIDTH-1:0] result,
); // this is ANSI style – direction + type + name in module header
always_comb begin
	case (opcode)
	2'b00: begin //Add
		result=a+b;
	end
	2'b01: begin //Subtract
		result=a-b;
	end
	2'b10: begin //Bitwise AND
		result=a&b;
	end
	2'b11: begin //Bitwise OR
		result=a|b;
	end
		default : result='x;
	endcase
end
endmodule : ALU
