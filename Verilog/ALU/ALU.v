module ALU (
	input [31:0]code,
	//input [31:0]PC,
	
	input [31:0]rs1_og,  // testing
	input [31:0]rs2_og,  // testing
	
	//output reg [15:0]PC_new,
	output reg [31:0]rd  // testing
	);
	
	reg [6:0]opcode;
	reg [6:0]funct7;
	reg [2:0]funct3;
	reg [11:0]imm;
	
	reg [31:0]rs1;
	reg [31:0]rs2;
	//reg [31:0]rd;  // outputing for test rn
	
	// need to get values from registers in a function somehow (aka by using RF module)
	
	// executing arithmetic ops
	always @(*)
	begin
		
		// for testing?
		rs1 = rs1_og[31:0];
		rs2 = rs2_og[31:0];
		
		opcode = code[6:0];
	
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
	
		// R-type
		if (opcode == 7'b0110011)
		begin
			
			funct7 = code[31:25];
			funct3 = code[14:12];
			
			// ADD/SUB/MUL
			if (funct3 == 3'b000)
			begin
				
				// ADD
				if (funct7 == 7'b0000000)
					rd = rs1 + rs2;
				
				// SUB
				else if (funct7 == 7'b0100000)
					rd = rs1 - rs2;
					
				// MUL
				else if (funct7 == 7'b0000001)
					rd = rs1 * rs2;
					
			end
			
			// SRA/SRL
			else if (funct3 == 3'b101)
			begin
				
				// SRA
				if (funct7 == 7'b0100000)
				begin
				
					if (rs1[31] == 1'b1)
					begin
						rs1 = -rs1;
						rd = rs1 >>> rs2;
						rd = -rd;
					end
					else
						rd = rs1 >>> rs2;
				
				end
				
				// SRL
				else if (funct7 == 7'b0000000)
					rd = rs1 >> rs2;
					
			end
			
			// Bitwise ops, comparisons that result in 0/1, SLL
			else if (funct7 == 7'b0000000)
			begin
				
				// AND
				if (funct3 == 3'b111)
					rd = rs1 & rs2;
				
				// OR
				else if (funct3 == 3'b110)
					rd = rs1 | rs2;
				
				// XOR
				else if (funct3 == 3'b100)
					rd = rs1 ^ rs2;
				
				// SLT
				else if (funct3 == 3'b010)
				begin
				
					if (rs1[31] == 1'b1 && rs2[31] == 1'b0)
						rd = 32'd1;
					
					else if (rs1[31] == 1'b0 && rs2[31] == 1'b1)
						rd = 32'd0;
						
					else 
						rd = (rs1 < rs2);  // haven't tested
				
				end
				
				// SLTU
				else if (funct3 == 3'b011)
					rd = (rs1 < rs2);  // haven't tested
				
				// SLL
				else if (funct3 == 3'b001)
					rd = rs1 << rs2;
				
			end
			
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
		
		// I-type
		else if (opcode == 7'b0010011)
		begin
		
			imm = code[31:20];
			funct3 = code[14:12];
			
			//rs1 = code[19:15];
			
			// ADDI
			if (funct3 == 3'b000)
				rd = rs1 + imm;
				
			// SRAI/SRLI/SLLI shift ops
			else if (funct3 == 3'b101 || funct3 == 3'b001)
			begin
			
				funct7 = code[31:25];
				imm = code[24:20];
				
				
				if (funct3 == 3'b101)
				begin
				
					// SRAI
					if (funct7 == 7'b0100000)
					begin
				
						if (rs1[31] == 1'b1)
						begin
							rs1 = -rs1;
							rd = rs1 >>> imm;
							rd = -rd;
						end
						else
							rd = rs1 >>> imm;
				
					end
					
					// SRLI
					else if(funct7 == 7'b0000000)
						rd = rs1 >> imm;
						
				end
				
				// SLLI
				else if (funct3 == 3'b001)
					rd = rs1 << imm;
				
			end
			
			// imm Bitwise ops, comparisons that result in 0/1
			else
			begin
			
				// ANDI
				if (funct3 == 3'b111)
					rd = rs1 & imm;
				
				// ORI
				else if (funct3 == 3'b110)
					rd = rs1 | imm;
					
				// XORI
				else if (funct3 == 3'b100)
					rd = rs1 ^ imm;
					
				// !!! For SLTI and SLTIU, imm is supposed to be sign extended to
				// 32 bits (but I'll do 16 bits) - maybe make function to do that?
					
				// SLTI
				else if(funct3 == 3'b010)
				begin
				
					if (rs1[31] == 1'b1 && imm[11] == 1'b0)
						rd = 32'd1;
					
					else if (rs1[31] == 1'b0 && imm[11] == 1'b1)
						rd = 32'd0;
						
					else 
						rd = (rs1 < imm);  // haven't tested
				
				end
				
				// SLTIU
				else if(funct3 == 3'b011)
					rd = (rs1 < imm);  // haven't tested 
					
			end
		
		end
		
		//-----------------------------------------------------------------------------
		// 
		// 31                                    12 11      7 6            0
		// +---------------------------------------+---------+-------------+
		// | imm                                   | rd      | 0110111     |
		// +---------------------------------------+---------+-------------+
		// 
		//-----------------------------------------------------------------------------
		
		// LUI
		else if (opcode == 7'b0110111)
		begin
		
			
		
		end
		
		// AUIPC
		else if (opcode == 7'b0010111)
		begin
		
			
		
		end
		
	end

endmodule
	
