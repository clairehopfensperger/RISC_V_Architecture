module Control(
	input clk, rst,
	input start,
	output reg done
);

	reg [31:0]instruction;
	reg [7:0]PC; // should it be 32 bits?

	// instructions memory instantiation ----------------------------------------------------------------------------
	
	reg [7:0]inst_mem_address;
	reg [31:0]inst_mem_input;
	wire [31:0]inst_mem_output;
	reg inst_mem_wren;  // never writing to memory, always set to 1'b0

	instructions_mem inst_mem(inst_mem_address, clk, inst_mem_input, 1'b0, inst_mem_output);
	
	// What's in it rn:
	// addi t0, zero, 5 : 32'b(imm)000000000100 00000 000 00101 0010011 = 32'd4194963
	// addi t1, zero, 5 : 32'b(imm)000000000011 00000 000 00110 0010011 = 32'd3146515
	// add t2, t0, t1 : 32'b0000000 00110 00101 000 00111 0010011 = 32'd6456211
	
	// !!! main memory instantiation ----------------------------------------------------------------------------
	// create separate on chip memory for this
	
	// ALU instantiation ----------------------------------------------------------------------------
	
	reg [4:0]rs1, rs2, rd;
	reg [31:0]rs1_val, rs2_val, rd_val;
	reg [11:0]imm;
	reg [6:0]funct7;
	reg [2:0]funct3;
	reg [6:0]opcode;
	
	/*
		input [6:0]opcode,
		input [6:0]funct7,
		input [2:0]funct3,
		input [11:0]imm,
		
		input [31:0]rs1_val,
		input [31:0]rs2_val,
		
		output reg [31:0]rd_val
	*/
	
	alu my_alu(opcode, funct7, funct3, imm, rs1_val, rs2_val, rd_val);
	
	// Register instantiation ----------------------------------------------------------------------------
	
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
	
	Register zero(clk, rst, 32'd0, 1'b1, result_zero);
	Register ra(clk, rst, in_ra, en_ra, result_ra);
	Register sp(clk, rst, in_sp, en_sp, result_sp);
	Register gp(clk, rst, in_gp, en_gp, result_gp);
	Register tp(clk, rst, in_tp, en_tp, result_tp);
	Register t0(clk, rst, in_t0, en_t0, result_t0);
	Register t1(clk, rst, in_t1, en_t1, result_t1);
	Register t2(clk, rst, in_t2, en_t2, result_t2);
	Register s0(clk, rst, in_s0, en_s0, result_s0);
	Register s1(clk, rst, in_s1, en_s1, result_s1);
	Register a0(clk, rst, in_a0, en_a0, result_a0);
	Register a1(clk, rst, in_a1, en_a1, result_a1);
	Register a2(clk, rst, in_a2, en_a2, result_a2);
	Register a3(clk, rst, in_a3, en_a3, result_a3);
	Register a4(clk, rst, in_a4, en_a4, result_a4);
	Register a5(clk, rst, in_a5, en_a5, result_a5);
	Register a6(clk, rst, in_a6, en_a6, result_a6);
	Register a7(clk, rst, in_a7, en_a7, result_a7);
	Register s2(clk, rst, in_s2, en_s2, result_s2);
	Register s3(clk, rst, in_s3, en_s3, result_s3);
	Register s4(clk, rst, in_s4, en_s4, result_s4);
	Register s5(clk, rst, in_s5, en_s5, result_s5);
	Register s6(clk, rst, in_s6, en_s6, result_s6);
	Register s7(clk, rst, in_s7, en_s7, result_s7);
	Register s8(clk, rst, in_s8, en_s8, result_s8);
	Register s9(clk, rst, in_s9, en_s9, result_s9);
	Register s10(clk, rst, in_s10, en_s10, result_s10);
	Register s11(clk, rst, in_s11, en_s11, result_s11);
	Register t3(clk, rst, in_t3, en_t3, result_t3);
	Register t4(clk, rst, in_t4, en_t4, result_t4);
	Register t5(clk, rst, in_t5, en_t5, result_t5);
	Register t6(clk, rst, in_t6, en_t6, result_t6);
	
	parameter	
		zero = 5'd0,
		ra = 5'd1,
		sp = 5'd2,
		gp = 5'd3,
		tp = 5'd4,
		t0 = 5'd5,
		t1 = 5'd6,
		t2 = 5'd7,
		s0 = 5'd8,
		s1 = 5'd9,
		a0 = 5'd10,
		a1 = 5'd11,
		a2 = 5'd12,
		a3 = 5'd13,
		a4 = 5'd14,
		a5 = 5'd15,
		a6 = 5'd16, 
		a7 = 5'd17,
		s2 = 5'd18,
		s3 = 5'd19,
		s4 = 5'd20,
		s5 = 5'd21,
		s6 = 5'd22, 
		s7 = 5'd23,
		s8 = 5'd24,
		s9 = 5'd25,
		s10 = 5'd26,
		s11 = 5'd27,
		t3 = 5'd28,
		t4 = 5'd29,
		t5 = 5'd30,
		t6 = 5'd31;
	
	// FSM stuff!! ----------------------------------------------------------------------------
	
	reg [4:0]S;
	reg [4:0]NS;
	
	parameter
		INIT = 5'd0,
		FETCH_1 = 5'd1,
		FETCH_2 = 5'd8,  // may not need but idk
		FETCH_DELAY = 5'd2,
		DECODE_1 = 5'd3,
		DECODE_2 = 5'd9,
		DECODE_3 = 5'd10,
		EXECUTE = 5'd4,
		EXECUTE_DELAY = 5'd5,
		WRITEBACK = 5'd6,
		DONE = 5'd7,
		ERROR = 5'hF;
		// latest number used is 5'd10
	
	// Changing states
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
		case(S)
			INIT: NS = FETCH;
			FETCH_1: NS = FETCH_2;
			FETCH_2: NS = FETCH_DELAY;
			FETCH_DELAY:
			begin
				if (instruction = 32'd0)
					NS = DONE;
				else 
					NS = DECODE;
			end
			DECODE_1: NS = DECODE_2;
			DECODE_2: NS = DECODE_3;
			DECODE_3: NS = EXECUTE;
			EXECUTE: NS = EXECUTE_DELAY;
			EXECUTE_DELAY: NS = WRITEBACK;
			WRITEBACK: NS = FETCH;
			DONE: NS = DONE;
			default: NS = ERROR;
		endcase
	end
	
	// State executions
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			PC <= 32'd0;
			instruction <= 32'd0;
			
			inst_mem_address <= 32'd0;
			inst_mem_input <= 32'd0;
			wren <= 1'b0;
			
			rs1 <= 5'd0;
			rs2 <= 5'd0;
			rd <= 5'd0;
			imm <= 12'd0;
			funct7 <= 7'd0;
			funct3 <= 3'd0;
			
			// need to initialize in_reg and en_reg
		end
		else
		begin
			case(S):
				
				INIT:
				begin
					PC <= 32'd0;
					instruction <= 32'd0;
					
					inst_mem_address <= 32'd0;
					inst_mem_input <= 32'd0;
					wren <= 1'b0;
					
					rs1 <= 5'd0;
					rs2 <= 5'd0;
					rd <= 5'd0;
					imm <= 12'd0;
					funct7 <= 7'd0;
					funct3 <= 3'd0;
				end
				
				FETCH_1:
				begin
					inst_mem_address <= PC;
				end
				
				FETCH_2:
				begin
					instruction <= inst_mem_output;
				end
				
				FETCH_DELAY:
				begin
				end
				
				DECODE_1:
				begin
					
					// same for all
					opcode <= instruction[6:0];
					rd <= instruction[11:7];
					
					//----------------------------------------------------------------------------	
					//
					// R-Type:
					// 
					// 31         25 24     20 19     15 14  12 11      7 6            0
					//	+------------+---------+---------+------+---------+-------------+
					//	| funct7     | rs2     | rs1     |funct3| rd      | opcode      |
					//	+------------+---------+---------+------+---------+-------------+
					//
					//----------------------------------------------------------------------------
					if (instruction[6:0] == 7'b0110011)
					begin
						rs1 <= instruction[19:15];
						rs2 <= instruction[24:20];
						funct7 <= instruction[31:25];
						funct3 <= instruction[14:12];
					end
					
					//-----------------------------------------------------------------------------
					// I-Type:
					//
					// 31                   20 19     15 14  12 11      7 6            0
					// +----------------------+---------+------+---------+-------------+
					// | imm                  | rs1     |funct3| rd      | opcode      |
					// +----------------------+---------+------+---------+-------------+
					//	
					//-----------------------------------------------------------------------------	
					else if (instruction[6:0] == 7'b0010011)
					begin					
						rs1 <= instruction[19:15];
						imm <= instruction[31:20];
						funct3 <= instruction[14:12];
					end
					
					//-----------------------------------------------------------------------------
					// 
					// 31                                    12 11      7 6            0
					// +---------------------------------------+---------+-------------+
					// | imm                                   | rd      | 0110111     |
					// +---------------------------------------+---------+-------------+
					// 
					//-----------------------------------------------------------------------------
					
					// LUI || AUIPC
					else if (instruction[6:0] == 7'b0110111 || instruction[6:0] == 7'b0010111)
					begin
						imm <= instruction[31:12];
					end
				end
				
				DECODE_2:
				begin
					// more I-type specifications
					if (instruction[6:0] == 7'b0010011)
					begin						
						if (funct3 == 3'b101 || funct3 == 3'b001)
						begin
							funct7 <= instruction[31:25];
							imm <= instruction[24:20];
						end
					end
				end
				
				DECODE_3:
				begin
					// put values in rs1_val, rs2_val
					case(rs1):
						zero: rs1_val <= result_zero;
						ra: rs1_val <= result_ra;
						sp: rs1_val <= result_sp;
						gp: rs1_val <= result_gp;
						tp: rs1_val <= result_tp;
						t0: rs1_val <= result_t0;
						t1: rs1_val <= result_t1;
						t2: rs1_val <= result_t2;
						s0: rs1_val <= result_s0;
						s1: rs1_val <= result_s1;
						a0: rs1_val <= result_a0;
						a1: rs1_val <= result_a1;
						a2: rs1_val <= result_a2;
						a3: rs1_val <= result_a3;
						a4: rs1_val <= result_a4;
						a5: rs1_val <= result_a5;
						a6: rs1_val <= result_a6;
						a7: rs1_val <= result_a7;
						s2: rs1_val <= result_s2;
						s3: rs1_val <= result_s3;
						s4: rs1_val <= result_s4;
						s5: rs1_val <= result_s5;
						s6: rs1_val <= result_s6;
						s7: rs1_val <= result_s7;
						s8: rs1_val <= result_s8;
						s9: rs1_val <= result_s9;
						s10: rs1_val <= result_s10;
						s11: rs1_val <= result_s11;
						t3: rs1_val <= result_t3;
						t4: rs1_val <= result_t4;
						t5: rs1_val <= result_t5;
						t6: rs1_val <= result_t6;
						default:
						begin
						end
					endcase
						
					case(rs2):
						zero: rs2_val <= result_zero;
						ra: rs2_val <= result_ra;
						sp: rs2_val <= result_sp;
						gp: rs2_val <= result_gp;
						tp: rs2_val <= result_tp;
						t0: rs2_val <= result_t0;
						t1: rs2_val <= result_t1;
						t2: rs2_val <= result_t2;
						s0: rs2_val <= result_s0;
						s1: rs2_val <= result_s1;
						a0: rs2_val <= result_a0;
						a1: rs2_val <= result_a1;
						a2: rs2_val <= result_a2;
						a3: rs2_val <= result_a3;
						a4: rs2_val <= result_a4;
						a5: rs2_val <= result_a5;
						a6: rs2_val <= result_a6;
						a7: rs2_val <= result_a7;
						s2: rs2_val <= result_s2;
						s3: rs2_val <= result_s3;
						s4: rs2_val <= result_s4;
						s5: rs2_val <= result_s5;
						s6: rs2_val <= result_s6;
						s7: rs2_val <= result_s7;
						s8: rs2_val <= result_s8;
						s9: rs2_val <= result_s9;
						s10: rs2_val <= result_s10;
						s11: rs2_val <= result_s11;
						t3: rs2_val <= result_t3;
						t4: rs2_val <= result_t4;
						t5: rs2_val <= result_t5;
						t6: rs2_val <= result_t6;
						default:
						begin
						end
					endcase
				end
				
				EXECUTE:
				begin	
					// do ALU stuff or memory stuff
				end
				
				EXECUTE_DELAY:
				begin
				end
				
				WRITEBACK:
				begin
					// put rd_val in rd
					case(rd):
						zero:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						ra: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						sp: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						gp:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						tp: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t0:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t1: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t2:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s0: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s1: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a0: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a1:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a2:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a3:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a4:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a5:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a6: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						a7: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s2: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s3:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s4: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s5:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s6:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s7:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s8: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s9:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s10:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						s11: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t3:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t4: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t5:
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						t6: 
						begin
							en_zero <= 1'b1;
							in_zero <= rd_val;
						end
						default:
						begin
						end
					endcase
				end
				
				DONE:
				begin
				end
				
				default:
				begin
				end
			endcase
		end				
	end

endmodule
