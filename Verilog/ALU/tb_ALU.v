module tb_ALU;

	reg [31:0]code;
	wire [4:0]rd;
	
	parameter simdelay = 10;
	
	ALU DOT(code, rd);
	
	initial
	begin
		
		#(simdelay) code = 32'b00000000010000010000000000110011;
		#(simdelay) code = 32'b01000000010000010000000000110011;
		
		#100; // let simulation finish
	
	end
	
endmodule
