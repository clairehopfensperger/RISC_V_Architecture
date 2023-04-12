module ALU (
	input [31:0]code,
	output reg [4:0]rd
	);
	
// R-Type:
// 
// 31         25 24     20 19     15 14  12 11      7 6            0
//	+------------+---------+---------+------+---------+-------------+
//	| funct7     | rs2     | rs1     |funct3| rd      | opcode      |
//	+------------+---------+---------+------+---------+-------------+
	
	reg [6:0]opcode;
	reg [6:0]funct7;
	reg [2:0]funct3;
	reg [11:0]imm;
	
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
			
			// ADD/SUB ?
			if (funct3 == 3'b000)
			begin
				
				// ADD
				if (funct7 == 7'b0000000)
					rd = rs1 + rs2;
				
				// SUB
				if (funct7 == 7'b0100000)
					rd = rs1 - rs2;
					
			end
			
		end
		
		// I-type
		else if (opcode == 7'b0010011)
		begin
		
			funct3 = code[14:12];
			imm = code[31:20];
		
		end
	end

endmodule
	