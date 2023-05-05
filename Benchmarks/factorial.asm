# testing function (with jal and jalr) - recursive
main1:		addi t0, zero, 5  # factorial = 5
		addi t1, zero, 4  # num = 4
		
		jal FUNC_CALL
		jal exit
		
FUNC_CALL:	blt zero, t1, FUNC_BODY  # if (0 < num)
		jalr ra
		
FUNC_BODY:	mul t0, t0, t1  # factorial *= num
		addi t1, t1, -1  # num -= 1
		jal FUNC_CALL

exit:		add t2, zero, t0