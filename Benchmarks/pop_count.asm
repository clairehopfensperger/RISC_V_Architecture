# pop count

main:		addi t0, zero, 476  # input
		addi t1, zero, 0  # counter = 0
		addi t2, zero, 0  # i = 0
		addi t3, zero, 32  # max = 32
		addi t4, zero, 0   # temp
		
		jal pop_count
		
		# for (int i = 0; i < 32; i++) 
		# {
		# 	counter += (input) & 1; 
		# 	input = input/2; 
		# } 
		
pop_count:	blt t2, t3, pop_ex  # for (int i = 0; i < 32; i++)
		jal exit

pop_ex:		andi t4, t0, 1  # temp = (input) & 1;
		add t1, t1, t4  # counter += temp;
		srli t0, t0, 1  # input = input/2;
		
		jal pop_inc
		
pop_inc:	addi t2, t2, 1  # i++
		jal pop_count
		
exit:		add t5, zero, t1
