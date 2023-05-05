# testing

#addi t0, zero, 2
#addi t1, zero, 4
#addi t2, zero, 6
#addi t3, zero, -5
#addi t4, zero, 3
#addi t5, zero, -6
#addi t6, zero, 1
#addi s11, zero, 7


# testing lw/sw
main:		addi t0, zero, 3  # num
#		addi t1, zero, 1  # sub 1 (num--)
#		add t2, zero, t0  # holding num
#		addi t3, zero, 0  # temp for lw stuff
#		addi t4, zero, 1  # temp for lw stuff
		
		sw t0, (sp)
		addi t0, t0, 1
		sw t0, 4(sp)
		addi sp, sp, 8
		addi t0, t0, 1
		sw t0, (sp)
		
		lw t1, (sp)
		addi sp, sp, -8
		lw t2, 4(sp)
		lw t3, (sp)
		


# testing lui and auipc
#lui t0, 222
#auipc t0, 222


# testing function (with jal and jalr) - recursive
#main1:		addi t0, zero, 5  # factorial = 5
#		addi t1, zero, 3  # num = 4
#		
#		jal FUNC_CALL
#		jal exit
#		
#FUNC_CALL:	blt zero, t1, FUNC_BODY  # if (0 < num)
#		jalr ra
#		
#FUNC_BODY:	mul t0, t0, t1  # factorial *= num
#		addi t1, t1, -1  # num -= 1
#		jal FUNC_CALL
#
#exit:		add t2, zero, t0


# testing lw/sw
#sw t0, (sp)
#sw t1, 1(sp)
#lw t3, (sp)
#lw t4, 1(sp)


# testing while loop
#while_main:	bge t1, t0, while_body
#		jal main_2
#		
#while_body:	sw t1, (sp)
#		lw t3, (sp) 
#		addi t3, zero, 0
#		addi t1, t1, -1
#		
#		jal while_main
#
#main_2:		xor s1, t2, t3


# testing if with beq
#		beq t0, t0, if_body
#		jal main_2
#	
#if_body:	mul s2, t0, t1
#
#main_2:		and s3, t0, t0


# r-type
#add s0, t0, t1
#sub s1, t0, t1
#mul s2, t0, t1
#and s3, t0, t1
#or s4, t0, t2
#xor s5, t0, t2
#slt s6, t3, t4 
#sltu s7, t3, t4
#sra s8, t5, t6
#srl s9, t4, t6
#sll s10, t4, t6

# i-type
#addi s0, s11, 3
#andi s1, t1, 2
#ori s2, t2, 2
#xori s3, t2, 2
#slti s4, t3, 3
#sltiu s5, t3, 3
#rai s6, t5, 1
#srli s7, t4, 1
#slli s8, t4, 1
