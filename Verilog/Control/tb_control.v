`timescale 1 ns / 1 ns

module tb_control;

//	reg[7:0] step_val;
//	
//	task step();
//	begin
//		$write("%d: ", step_val);
//		step_val = step_val + 1;
//	end
//	endtask

	reg clk;
	reg rst;
	reg start;
	
	wire done;
	
	parameter simdelay = 20;
	parameter clock_delay = 10;
	
	// here is my SPI_parent
	Control DUT(clk, rst, start, done);
		
	initial
	begin
		
		#(simdelay) clk = 1'b0; rst = 1'b0;
		#(simdelay) rst = 1'b1; 
		#(simdelay) start = 1'b1;
		
		#1000; // let simulation finish
	
	end

/* this checks done every clock and when it goes high ends the simulation */
	always @(posedge clk)
	begin
		if (done == 1'b1)
		begin
			$write("DONE:"); $write("\n"); 
			$stop;
		end
//		else
//		begin
//			step(); $write("\n"); 
//		end
	end
	
	// this generates a clock
	always
	begin
		#(clock_delay) clk = !clk;
	end
	
	// this makes the simulation go for 1000 steps
	initial
		#1000 $stop;

endmodule
