#lw/sw

main:		addi t0, zero, 3  # num
		addi t1, zero, 1  # sub 1 (num--)
		addi t2, zero, 3  # temp_num
		addi t3, zero, 0  # temp for lw stuff
		addi t4, zero, 0  # temp for lw stuff
		
while_cond:	bge t2, t1, while_body  # while temp_num >= 1
		jal main2

while_body:	sw t2, (sp)
		sub t2, t2, t1  # temp_num--
		addi sp, sp, 4
		jal while_cond
		
main2:		addi sp, sp, -4
		jal while2_cond
		
while2_cond:	bne t2, t0, while2_body  # while temp_num != num (3)
		jal exit

while2_body:	lw t3, (sp)
		sub t4, t4, t3
		add t2, t2, t1  # temp_num++
		addi sp, sp, -4
		jal while2_cond

exit:		add t5, zero, t4