`timescale 1 ps / 1 ps

module tb_Register;

	reg clk, rst,
	reg [31:0]in,
	reg en,
	wire reg [31:0]out
	
	Register DOT(clk, rst, in, en, out);
	
	initial
	begin
	
	#100; // let simulation finish
	
	end
	
	
	parameter simdelay = 20; // guaranteed 2 clocks
	parameter clock_delay = 5;
	parameter fullclk = 11;
	
	initial
	begin
		
		/* start clk and reset */
		#(simdelay) rst = 1'b0; clk = 1'b0; step_val = 8'd0;
		#(simdelay) rst = 1'b1; /* go into normal circuit operation */ 
		
		// haven't actually written any test cases
		
		#100; // let simulation finish
		
	end
	
endmodule
