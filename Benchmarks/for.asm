# for loop

main: 		addi t0, zero, 'a'
		addi t1, zero, 'A'
		
		sw t0, (sp)
		sw t1, 4(sp)
		
		addi t6, zero, 3  # counter
		
		j FOR_COND
		
		# for (int i = 3; i >= 0; i--) {
		# 	
		# }

FOR_COND:	bge t6, zero, FOR_BODY
		jal exit
		
FOR_BODY:	addi t0, t0, 1
		addi t1, t1, 1
		
		addi sp, sp, 8
		
		sw t0, (sp)
		sw t1, 4(sp)
		
		jal FOR_INC

FOR_INC:	addi t6, t6, -1
		jal FOR_COND

exit:		lw t2, (sp)
		lw t0, 4(sp)
		add t1, zero, t2
		add t2, zero, zero