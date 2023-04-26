module seven_segment (
input [31:0]in,
input rd_en,
output reg [6:0]out,
output reg [6:0]out2
);


// HEX out - rewire DE2
//  ---a---
// |       |
// f       b
// |       |
//  ---g---
// |       |
// e       c
// |       |
//  ---d---

always @(*)
begin

	if (rd_en == 1'b1)
	begin
		
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
		
		case(in)
			32'd0:
			32'd1:
			32'd2:
			32'd3:
			32'd4:
			32'd5:
			32'd6:
			32'd7:
			32'd8:
			32'd9:
			32'd10:
			32'd11:
			32'd12:
			32'd13:
			32'd14:
			32'd15:
			32'd16:
			32'd17:
			32'd18:
			32'd19:
			32'd20:
			32'd21:
			32'd22:
			32'd23:
			32'd24:
			32'd25:
			32'd26:
			32'd27:
			32'd28:
			32'd29:
			32'd30:
			32'd31:
			default:
		endcase



	case (in)	    // abcdefg

		4'h0: out = 7'b0000001;
		4'h1: out = 7'b1001111;
		4'h2: out = 7'b0010010;
		4'h3: out = 7'b0000110;
		4'h4: out = 7'b1001100;
		4'h5: out = 7'b0100100;
		4'h6: out = 7'b0100000;
		4'h7: out = 7'b0001111;
		4'h8: out = 7'b0000000;
		4'h9: out = 7'b0000100;
		4'hA: out = 7'b0001000;
		4'hB: out = 7'b1100000;
		4'hC: out = 7'b0110001;
		4'hD: out = 7'b1000010;
		4'hE: out = 7'b0110000;
		4'hF: out = 7'b0111000;
		
//		4'hE: out = 7'b1111111; // blank display
//		4'hF: out = 7'b0011000; // P
		
		default: out = 7'b1111111;
	
	endcase
end

endmodule
