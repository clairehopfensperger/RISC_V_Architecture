module seven_seg_display (
input [7:0]PC,
input [4:0]rd,
input [31:0]rd_val,

// displaying PC count
output [6:0]PC_seg7,

// displaying rd name (display s10 as 10, display s11 as 11)
output [6:0]rd_seg7_msb,
output [6:0]rd_seg7_lsb,

// displaying rd val
output [6:0]rd_val_seg7_neg,
output [6:0]rd_val_seg7_hund,
output [6:0]rd_val_seg7_ten,
output [6:0]rd_val_seg7_one,

// void output not used bc i needed another output
output [6:0]void
);

	// regs to be used in calculations and instantiations of seven_segment.v
	reg [31:0]result_PC;
	
	reg [31:0]result_rd;
	
	reg [31:0]result_rd_val_neg;
	reg [31:0]result_rd_val_hund;
	reg [31:0]result_rd_val_ten;
	reg [31:0]result_rd_val_one;
	
	reg [31:0]twos_comp;  // holds twos comp of rd_val
		  

	always @(*)
	begin
		
		// twos comp calc
		if (rd_val[31] == 31'd1)
		begin
			twos_comp = -rd_val;
		end
		else
		begin
			twos_comp = rd_val;
		end
		
		// PC and rd to be passed to seven_segment instantiations
		result_PC = {24'd0, PC};
		
		result_rd = {27'd0, rd};
		
		// calculating seperate digits of rd_val
		result_rd_val_neg = rd_val[31];
		result_rd_val_hund = (twos_comp / 10) / 10;
		result_rd_val_ten = (twos_comp / 10) % 10;
		result_rd_val_one = = twos_comp % 10;
		  
	end

	/* instantiate the modules for each of the seven seg decoders */
	seven_segment PC_disp(result_PC, 1'b0, PC_seg7, void);
	seven_segment rd_disp(result_rd, 1'b1, rd_seg7_msb, rd_seg7_lsb);
	seven_segment rd_val_neg_disp(result_rd_val_neg, 1'b0, rd_val_seg7_neg, void);
	seven_segment rd_val_hund_disp(result_rd_val_hund, 1'b0, rd_val_seg7_hund, void);
	seven_segment rd_val_ten_disp(result_rd_val_ten, 1'b0, rd_val_seg7_ten, void);
	seven_segment rd_val_one_disp(result_rd_val_one, 1'b0, rd_val_seg7_one, void);

endmodule
