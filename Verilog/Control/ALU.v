module ALU (
	input [6:0]opcode,
	input [6:0]funct7,
	input [2:0]funct3,
	input [11:0]imm,
	
	input [7:0]PC,
	
	input [31:0]rs1_val,
	input [31:0]rs2_val,
	
	output reg [31:0]rd_val
	);
	
	reg [31:0]rs1;
	reg [31:0]rs2;
	
	// executing arithmetic ops
	always @(*)
	begin
		
		// have these bc have to be able to do -rs1 or -rs2 for two's comp later
		rs1 = rs1_val[31:0];
		rs2 = rs2_val[31:0];
		
		// safe behavior needs initial value
		rd_val = 32'd0;
	
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
			
			// ADD/SUB/MUL
			if (funct3 == 3'b000)
			begin
				
				// ADD
				if (funct7 == 7'b0000000)
					rd_val = rs1 + rs2;
				
				// SUB
				else if (funct7 == 7'b0100000)
					rd_val = rs1 - rs2;
					
				// MUL
				else if (funct7 == 7'b0000001)
					rd_val = rs1 * rs2;
					
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
						rd_val = rs1 >>> rs2;
						rd_val = -rd_val;
					end
					else
						rd_val = rs1 >>> rs2;
				
				end
				
				// SRL
				else if (funct7 == 7'b0000000)
					rd_val = rs1 >> rs2;
					
			end
			
			// Bitwise ops, comparisons that result in 0/1, SLL
			else if (funct7 == 7'b0000000)
			begin
				
				// AND
				if (funct3 == 3'b111)
					rd_val = rs1 & rs2;
				
				// OR
				else if (funct3 == 3'b110)
					rd_val = rs1 | rs2;
				
				// XOR
				else if (funct3 == 3'b100)
					rd_val = rs1 ^ rs2;
				
				// SLT
				else if (funct3 == 3'b010)
				begin
				
					if (rs1[31] == 1'b1 && rs2[31] == 1'b0)
						rd_val = 32'd1;
					
					else if (rs1[31] == 1'b0 && rs2[31] == 1'b1)
						rd_val = 32'd0;
						
					else 
						rd_val = (rs1 < rs2);  // haven't tested
				
				end
				
				// SLTU
				else if (funct3 == 3'b011)
					rd_val = (rs1 < rs2);  // haven't tested
				
				// SLL
				else if (funct3 == 3'b001)
					rd_val = rs1 << rs2;
				
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
		
			// ADDI
			if (funct3 == 3'b000)
				rd_val = rs1 + {{20{imm[11]}}, imm};  // sign extended hopefully
				
			// SRAI/SRLI/SLLI shift ops
			else if (funct3 == 3'b101 || funct3 == 3'b001)
			begin
			
				if (funct3 == 3'b101)
				begin
				
					// SRAI
					if (funct7 == 7'b0100000)
					begin
				
						if (rs1[31] == 1'b1)
						begin
							rs1 = -rs1;
							rd_val = rs1 >>> imm;
							rd_val = -rd_val;
						end
						else
							rd_val = rs1 >>> imm;
				
					end
					
					// SRLI
					else if(funct7 == 7'b0000000)
						rd_val = rs1 >> imm;
						
				end
				
				// SLLI
				else if (funct3 == 3'b001)
					rd_val = rs1 << imm;
				
			end
			
			// imm Bitwise ops, comparisons that result in 0/1
			else
			begin
			
				// ANDI
				if (funct3 == 3'b111)
					rd_val = rs1 & {{20{imm[11]}}, imm};
				
				// ORI
				else if (funct3 == 3'b110)
					rd_val = rs1 | {{20{imm[11]}}, imm};
					
				// XORI
				else if (funct3 == 3'b100)
					rd_val = rs1 ^ {{20{imm[11]}}, imm};
					
				// SLTI
				else if(funct3 == 3'b010)
				begin
				
					if (rs1[31] == 1'b1 && imm[11] == 1'b0)
						rd_val = 32'd1;
					
					else if (rs1[31] == 1'b0 && imm[11] == 1'b1)
						rd_val = 32'd0;
						
					else 
						rd_val = (rs1 < {{20{imm[11]}}, imm});  // haven't tested
				
				end
				
				// SLTIU
				else if(funct3 == 3'b011)
					rd_val = (rs1 < {{20{imm[11]}}, imm});  // haven't tested 
					
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
			rd_val = imm << 12;  	
		end
		
		// AUIPC
		else if (opcode == 7'b0010111)
		begin
			rd_val = PC + (imm << 12);
			
		
		end
		
	end

endmodule
	
