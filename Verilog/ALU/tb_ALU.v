module tb_ALU;

	reg [31:0]code;
	wire [4:0]rd;
	
	parameter simdelay = 100;
	
	ALU DOT(code, rd);
	
	initial
	begin
	
//---------------------------------------------------------------------------
	
// R-Type:
// 
// 31         25 24     20 19     15 14  12 11      7 6            0
//	+------------+---------+---------+------+---------+-------------+
//	| funct7     | rs2     | rs1     |funct3| rd      | opcode      |
//	+------------+---------+---------+------+---------+-------------+	
		
//		// ADD 00010 + 00100 = 00110
//		#(simdelay) code = 32'b00000000010000010000000000110011;
//		
//		// SUB 00010 - 00100 = 11110
//		#(simdelay) code = 32'b01000000010000010000000000110011;
//		
//		// MUL 00010 * 00100 = 01000
//		#(simdelay) code = 32'b00000010010000010000000000110011;
//		
//		// AND 00010 & 00100 = 00000
//		#(simdelay) code = 32'b00000000010000010111000000110011;
//		
//		// OR 00010 | 00110 = 00110
//		#(simdelay) code = 32'b00000000011000010110000000110011;
//		
//		// XOR 00010 ^ 00110 = 00100
//		#(simdelay) code = 32'b00000000011000010100000000110011;
//		
//		// sLT 11011 < 00011 = 00001
//		#(simdelay) code = 32'b00000000001111011010000000110011;
//		
//		// SLTU 11011 < 00011 = 00000
//		#(simdelay) code = 32'b00000000001111011011000000110011;
//		
//		// SRA 11010 >>> 00001 = 11101
//		#(simdelay) code = 32'b01000000000111010101000000110011;
//		
//		// SRL 00011 >> 00001 = 00001
//		#(simdelay) code = 32'b00000000000100011101000000110011;
//		
//		// SLL 00011 << 00001 = 00110
//		#(simdelay) code = 32'b00000000000100011001000000110011;

//---------------------------------------------------------------------------

// I-Type:
//
// 31                   20 19     15 14  12 11      7 6            0
// +----------------------+---------+------+---------+-------------+
// | imm                  | rs1     |funct3| rd      | opcode      |
// +----------------------+---------+------+---------+-------------+

		// ADDI 12'd3 + 5'd7 = 5'd10 = 3'b01010
		#(simdelay) code = 32'b00000000001100111000000000010011; // works woo :)


		#100; // let simulation finish
	
	end
	
endmodule
