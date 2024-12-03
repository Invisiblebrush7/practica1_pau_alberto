# Practica 1
# Paulina Torres, Alberto Romano
# No nos odie pls :( Somos tontos

.data
	tower_1: .word 0:10
	tower_2: .word 0:10
	tower_3: .word 0:10


.text

main:		la s0, tower_1 		# int* t1 = t1;
		la s1, tower_2		# int* t2 = t2;
		la s2, tower_3		# int* t3 = t3;
		
		addi t6, zero, 0	# int towerOneDisks = 0;
		
		addi a0, zero, 3	# int n = 3;
		
		# Push n value
		addi sp, sp, -4
		sw a0, 0(sp)
		
		jal init_tower		# init_tower();
		
		jal hanoi
		
		j exit
	
# Populate one tower with disks
init_tower:	beq t6, a0, end_tower	# if (towerOneDisks == n) end_tower();
		addi t6, t6, 1 		# currentTowerDisks++;
		sw t6, 0(s0)		# *t1 = currentTowerDisks;
		addi s0, s0, 4		# t1 += 4;
		
		j init_tower
		
end_tower: 	jr ra			# Return to main

# Base case: if N is 1, move the disk and return
hanoi:		# Get n value
		lw, t0, 0(sp)
		addi sp, sp, 4
		
		# Base Case n == 1
		addi t1, zero, 1
		beq t0, t1, base_case	# if ( n == 1 ) { move_disk(); } -> If only 1 disk left, move it. From -> to

		# Save parameters for Hanoi(n - 1, src, aux, dest)
		addi sp, sp, -20
		addi t0, t0, -1
		sw t0, 0(sp) 		# Save n
		sw s0, 4(sp)		# Save src tower
		sw s1, 8(sp)		# Save dest tower
		sw s2, 12(sp)		# Save aux tower
		sw ra, 16(sp)		# Save ra
		j hanoi
		
base_case:	jr ra


exit:		j exit
		
