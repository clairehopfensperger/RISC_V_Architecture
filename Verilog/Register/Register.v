module Register(
	input clk, rst,
	input [31:0]in,
	input en,
	output reg [31:0]out
);

always @(posedge clk or negedge rst)
begin

	if (rst == 1'b0)
	begin
		out <= 32'd0;
	end
	else if (en == 1'b1)
	begin
		out <= in;
	end

end

endmodule
