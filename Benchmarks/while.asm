# while

main:		addi t1, zero, 5  # t0 exists so idk why i started with t1
		addi t2, zero, 8
		addi t3, zero, 10
		addi t4, zero, 13
		
		jal WHILE_COND
		
		# while (t1 != t3) {
		#	t2 *= 4;  // slli t2, t2, 2
		# 	t6 = t4 < t5  // slt t6, t4, t5
		# 	t7 = t5 < t4  // slt t7, t5, t4
		#	t1 += 1;  // addi t1, t1, 1
		# }
		
WHILE_COND:	bne t1, t2, WHILE_BODY
		jal exit

WHILE_BODY:	slli t2, t2, 2
		slt t5, t3, t4  # 1 for true
		slt t6, t4, t3  # 0 for false
		addi t1, t1, 1
		
		jal WHILE_COND

exit:		
