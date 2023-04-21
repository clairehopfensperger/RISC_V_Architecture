module Control(
	input clk, rst,
	input start,
	output reg done
);

	reg [31:0]instruction;
	reg [7:0]PC; // should it be 32 bits?

	// instructions memory instantiation
	
	reg [7:0]address;
	reg [31:0]number_input_to_mem;
	wire [31:0]number_output_to_mem;
	reg wren;  // never writing to memory, always set to 1'b0

	instructions_mem inst_mem(address, clk, number_input_to_mem, 1'b0, number_output_to_mem);
	
	// main memory instantiation
	// create separate on chip memory for this
	
	// ALU instantiation
	
	reg [31:0]rs1, rs2;
	wire [31:0]rd;
	
	alu my_alu(instruction, rs1, rs2, rd);
	
	// Register instantiation
	
	/*	+ x0 : zero the constant value 0
		+ x1 : ra return address (caller saved)
		+ x2 : sp stack pointer (called saved)
		+ x3 : gp global pointer
		+ x4 : tp thread pointer
		+ x5 : t0 temporary registers (caller saved)
		+ x6 : t1 "
		+ x7 : t2 "
		+ x8 : s0/fp saved register or frame pointer (callee saved)
		+ x9 : s1 saved register (callee saved)
		+ x10 : a0 function arguments and/or return values (caller saved)

		3/17/23, 9:19 PM https://www.csl.cornell.edu/courses/ece5745/handouts/ece5745-tinyrv-isa.txt

		https://www.csl.cornell.edu/courses/ece5745/handouts/ece5745-tinyrv-isa.txt 2/14
		+ x11 : a1 "
		+ x12 : a2 function arguments (caller saved)
		+ x13 : a3 "
		+ x14 : a4 "
		+ x15 : a5 "
		+ x16 : a6 "
		+ x17 : a7 "
		+ x18 : s2 saved registers (callee saved)
		+ x19 : s3 "
		+ x20 : s4 "
		+ x21 : s5 "
		+ x22 : s6 "
		+ x23 : s7 "
		+ x24 : s8 "
		+ x25 : s9 "
		+ x26 : s10 "
		+ x27 : s11 "
		+ x28 : t3 temporary registers (caller saved)
		+ x29 : t4 "
		+ x30 : t5 "
		+ x31 : t6 "
	*/
	
	// in
	reg [31:0]in_zero, in_ra, in_sp, in_gp, in_tp, in_t0, in_t1, in_t2, in_s0, in_s1, in_a0, in_a1, in_a2, 
		in_a3, in_a4, in_a5, in_a6, in_a7, in_s2, in_s3, in_s4, in_s5, in_s6, in_s7, in_s8, in_s9, in_S10, in_s11, 
		in_t3, in_t4, in_t5, in_t6;
	
	// en
	reg [31:0]en_zero, en_ra, en_sp, en_gp, en_tp, en_t0, en_t1, en_t2, en_s0, en_s1, en_a0, en_a1, en_a2, 
		en_a3, en_a4, en_a5, en_a6, en_a7, en_s2, en_s3, en_s4, en_s5, en_s6, en_s7, en_s8, en_s9, en_S10, en_s11, 
		en_t3, en_t4, en_t5, en_t6;
	
	// result
	wire [31:0]result_zero, result_ra, result_sp, result_gp, result_tp, result_t0, result_t1, result_t2, result_s0, 
		result_s1, result_a0, result_a1, result_a2, result_a3, result_a4, result_a5, result_a6, result_a7, result_s2, 
		result_s3, result_s4, result_s5, result_s6, result_s7, result_s8, result_s9, result_S10, result_s11, result_t3, 
		result_t4, result_t5, result_t6;
	
	Register zero(clk, rst, in_zero, en_zero, result_zero);
	
	// FSM stuff!!
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			S <= INIT;
		end
		else
			S <= NS;
	end
	
	// State movement
	always @(*)
	begin
		
	end
	
	// State executions
	always @(posedge clk or negedge rst)
	begin
	
	end

endmodule
