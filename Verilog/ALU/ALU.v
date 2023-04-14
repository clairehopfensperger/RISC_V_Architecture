module ALU (
	input [31:0]code,
	output reg [4:0]rd
	);
	
//----------------------------------------------------------------------------	
//
// R-Type:
// 
// 31         25 24     20 19     15 14  12 11      7 6            0
//	+------------+---------+---------+------+---------+-------------+
//	| funct7     | rs2     | rs1     |funct3| rd      | opcode      |
//	+------------+---------+---------+------+---------+-------------+
//
//
// I-Type:
//
// 31                   20 19     15 14  12 11      7 6            0
// +----------------------+---------+------+---------+-------------+
// | imm                  | rs1     |funct3| rd      | opcode      |
// +----------------------+---------+------+---------+-------------+
//	
//-----------------------------------------------------------------------------	
	
	reg [6:0]opcode;
	reg [6:0]funct7;
	reg [2:0]funct3;
	reg [11:0]imm;
	
	// I MESSED UP: the registers use 5 bits to say which reg it is bc there are 32 of them, 
	// but Tiny RISC-V ISA says each reg is 32 bits wide (i want to do 16 bits wide)
	reg [4:0]rs1;
	reg [4:0]rs2;
	
	always @(*)
	begin
		
		opcode = code[6:0];
	
		// R-type
		if (opcode == 7'b0110011)
		begin
			
			funct7 = code[31:25];
			funct3 = code[14:12];
			
			rs1 = code[19:15];
			rs2 = code[24:20];
			
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
				
					if (rs1[4] == 1'b1)
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
				
					if (rs1[4] == 1'b1 && rs2[4] == 1'b0)
						rd = 5'd1;
					
					else if (rs1[4] == 1'b0 && rs2[4] == 1'b1)
						rd = 5'd0;
						
					else 
						rd = rs1[1] < rs2[2];
				
				end
				
				// SLTU
				else if (funct3 == 3'b011)
					rd = rs1[1] < rs2[2];
				
				// SLL
				else if (funct3 == 3'b001)
					rd = rs1 << rs2;
				
			end
			
		end
		
		// I-type
		else if (opcode == 7'b0010011)
		begin
		
			imm = code[31:20];
			funct3 = code[14:12];
			
			rs1 = code[19:15];
			
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
					if (funct7 == 7'b0100000);
					
					// SRLI
					else if(funct7 == 7'b0000000);
				
				end
				
				// SLII
				else if (funct3 == 3'b001);
				
				
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
					
				// SLTI
				else if(funct3 == 3'b010);
				
				// SLTIU
				else if(funct3 == 3'b011);
			
			end
		
		end
	end

endmodule
	