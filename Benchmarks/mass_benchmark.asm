# mass benchmark - goal: cover all instructions

main0:		# saved registers, won't be changed
		addi s0, zero, 6  # int option = 2	// different options for if statement - 1 = while, 2 = for, 3 = function?
		addi s1, zero, 1  # if statement 1 comp, while statement add
		addi s2, zero, 5  # if statement 2 comp
		addi s3, zero, 3  # if statement 3 comp
		addi s4, zero, 10  # while statement comp
		addi s5, zero, 8  # for statement comp
		addi s6, zero, 1  # function factorial comp
		
		# temporary registers to be changed
		addi t0, zero, 2  # used in while loop
		addi t1, zero, 0  # for loop counter
		addi t2, zero, 3  # function factorial base
		addi t3, zero, 4  # function factorial num
		
		# mess around registers
		addi t4, zero, 5
		addi t5, zero, -6
		addi t6, zero, 7
		
		jal main1
		
		# if (s0 == 1) {
		#	while (t1 != 10) {
		#		// bitwise ops? - done
		#	}
		# } else if (s0 >= 5) {
		#	for (int i = 0; i < 8; i++) {
		#		// shift stuff? - done
		#	}
		# } else if (s0 < 3) {
		#	function_call(); - done
		# } else {
		#	// memory stuff?
		# }
		
main1:		beq s0, s1, IF_BODY
		bge s0, s2, IF_ELSE_1_BODY
		blt s0, s3, IF_ELSE_2_BODY
		jal ELSE_BODY
		
IF_BODY:	jal WHILE_COND	#------------------------------------------

	WHILE_COND:	bne t0, s4, WHILE_BODY
			jal main2
		
	WHILE_BODY:	# something
			and t4, t5, t6  # t4 = t5 & t6
			or t5, t6, t4  # t5 = t6 | t4
			xor t6, t4, t5  # t6 = t4 ^ t5
			
			andi t4, t4, 5  # t4 = t4 & 5
			ori t5, t5, 5  # t5 = t5 | 5
			xori t6, t6, 5  # t6 = t6 ^ 5
			
			add t0, t0, s1  # t0 += 1
			jal WHILE_COND

IF_ELSE_1_BODY:	jal FOR_COND	#------------------------------------------

	FOR_COND:	bltu t1, s5, FOR_BODY
			jal main2
	
	FOR_BODY:	# something
			sra t4, t4, s1  # t4 = t4 >>> 1
			srai t5, t5, 2  # t5 = t5 >>> 2
			
			srl t6, t6, s1  # t6 = t6 >> 1
			srli t4, t4, 1  # t4 = t4 >> 1
			sll t5, t5, s1  # t5 = t5 << 1
			slli t6, t6, 3  # t6 = t6 << 3 
			
			jal FOR_INC
	
	FOR_INC:	addi t1, t1, 1  # counter += 1
			jal FOR_COND

IF_ELSE_2_BODY:	jal FUNC_CALL	#------------------------------------------
		jal main2
				
	FUNC_CALL:	bgeu t3, s6, FUNC_BODY  # if (factorial num >= 1)
			jalr ra
		
	FUNC_BODY:	mul t2, t2, t3  # factorial base *= factorial num
			addi t3, t3, -1  # num -= 1
			jal FUNC_CALL	

ELSE_BODY:	jal main2

main2:		
