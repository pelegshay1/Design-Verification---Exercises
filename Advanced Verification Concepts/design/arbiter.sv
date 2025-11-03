module arbiter (
	input clk,    // Clock
	input reset,  // Asynchronous reset active low
	input logic req_0, req_1,
	output logic gnt_0, gnt_1
);

always @(posedge clk) begin
	if (reset||!req_0&&!req_1)begin
		gnt_0<=0;
		gnt_1<=0;
	end
	else begin
		if (req_0) begin
			gnt_0<=1;
			gnt_1<=0;
		end
		else begin
			if (req_1) begin
				gnt_0<=0;
				gnt_1<=1;
			end
		end
	end
end

endmodule : arbiter