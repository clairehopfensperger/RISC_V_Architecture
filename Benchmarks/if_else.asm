# if else

main:		addi t1, zero, 3  # int num1 = 3  # t0 exists, so idk why i started with t1
		addi t2, zero, 5  # int num2 = 5
		addi t3, zero, 8  # int num3 = 8
		
		jal IF_COND
		
IF_COND:	blt t1, t3, IF_BODY_1  # if (num1 < num3)
		jal IF_BODY_2  # else
		
IF_BODY_1:	sub t1, t1, t2  # num1 -= num2
		add t3, t3, t1  # num3 -= num1
		jal exit
		
IF_BODY_2:	mul t1, t2, t3  # num1 = num2 * num3
		jal exit
		
exit:		
