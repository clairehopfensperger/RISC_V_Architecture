# if statement with many options

main:		addi s0, zero, 4
		addi s1, zero, -4
		
		addi t0, zero, 0  # i, also option
		addi s2, zero, 3  # i < s2
		
		addi s3, zero, 0  # option 0
		addi s4, zero, 1  # option 1
		addi s5, zero, 2  # option 2
		
FOR_HEAD:	blt t0, s2, FOR_BODY  # for (int i = 0; i < 3; i++)
		jal exit
		
FOR_BODY:	beq t0, s3, OPTION0  # if (i == 0)
		beq t0, s4, OPTION1  # else if (i == 1)
		beq t0, s5, OPTION2  # else if (i == 2)
		jal FOR_INC  # else

OPTION0:	# binary ops
		and t1, s0, s1
		andi t2, s0, 12
		or t3, s0, s4
		ori t4, s1, 1
		xor t5, s0, s1
		xori t6, s1, -5
		
		jal FOR_INC

OPTION1:	# comparisons and lui/auipc
		slt t1, s1, s0
		slti t2, s0, 5
		sltu t3, s1, s0
		sltiu t4, s0, -8
		
		lui t5, 345
		auipc t6, 345
		
		jal FOR_INC

OPTION2:	# shifts
		sra t1, s1, s4
		srai t2, s0, 1
		srl t3, s0, s4
		srli t4, s1, 2
		sll t5, s1, s5
		slli t6, s0, 3
		
		jal FOR_INC

FOR_INC:	addi t0, t0, 1  # i++
		jal FOR_HEAD

exit:		addi t0, zero, 0