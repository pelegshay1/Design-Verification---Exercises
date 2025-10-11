// Top-level module instantiating the ALU
module Top ;
	parameter DATA_WIDTH = 8; // Define width in top
	parameter DATA_WIDTH2= 16;
	logic clk = 0;
	logic reset;
	logic signed [DATA_WIDTH-1:0] operand_a;
	logic signed [DATA_WIDTH-1:0] operand_b;
	logic signed [DATA_WIDTH2-1:0] operand_a2;
	logic signed [DATA_WIDTH2-1:0] operand_b2;
	logic [1:0] opcode_tb;
	logic signed [DATA_WIDTH-1:0] result_tb;
	logic signed [DATA_WIDTH-1:0] result_tb2;
	// Signal in parent to connect
	// Instantiate the ALU module
	// Override the default WIDTH parameter
	// Use named port connections
	ALU #(
		.WIDTH(DATA_WIDTH)
	) ALU_instance (
		.a(operand_a), // Connect child port 'a' to parent signal 'operand_a'
		.b(operand_b), // Connect child port 'b' to parent signal 'operand_b'
		.opcode(opcode_tb),
		.result(result_tb) // Connect child port 'result' to parent signal 'result_tb'
	);
	ALU #(
		.WIDTH(DATA_WIDTH2)
	) ALU_instance2 (
		.a(operand_a), // Connect child port 'a' to parent signal 'operand_a'
		.b(operand_b), // Connect child port 'b' to parent signal 'operand_b'
		.opcode(opcode_tb),
		.result(result_tb2) // Connect child port 'result' to parent signal 'result_tb'
	);

	// Simple stimulus for demonstration
	initial begin
		reset = 1;
		#5 reset = 0;
		operand_a = 8'd10;
		operand_b = 8'd20;
		opcode_tb = 2'b00;
		#10;
		$display("Time %t: %0d + %0d = %0d", $time, operand_a, operand_b, result_tb);
		opcode_tb = 2'b01;
		#10;
		$display("Time %t: %0d - %0d = %0d", $time, operand_a, operand_b, result_tb);
		opcode_tb = 2'b10;
		#10;
		$display("Time %t: %0b & %0b = %0b", $time, operand_a, operand_b, result_tb);
		opcode_tb = 2'b11;
		#10;
		$display("Time %t: %0b || %0b = %0b", $time, operand_a, operand_b, result_tb);
		operand_a2 = 16'd230;
		operand_b2 = 16'd300;
		opcode_tb = 2'b00;
		#10;
		$display("Time %t: %0d + %0d = %0d", $time, operand_a2, operand_b2, result_tb2);
		opcode_tb = 2'b01;
		#10;
		$display("Time %t: %0d - %0d = %0d", $time, operand_a2, operand_b2, result_tb2);
		opcode_tb = 2'b10;
		#10;
		$display("Time %t: %0b & %0b = %0b", $time, operand_a2, operand_b2, result_tb2);
		opcode_tb = 2'b11;
		#10;
		$display("Time %t: %0b || %0b = %0b", $time, operand_a2, operand_b2, result_tb2);
		$finish;
	end
	// Clock generator
	always #5 clk = ~clk;
endmodule : Top