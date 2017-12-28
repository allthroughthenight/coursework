.data
	# elements to be sorted
	val: .word 	0x00000010,
			0x00000016,
			0x00000013,
			0x0000001A,
			0x0000001F,
			0x0000001C,
			0x0000001B,
			0x00000014,
			0x00000019,
			0x00000017,
			0x0000001E,
			0x00000011,
			0x0000001D,
			0x00000015,
			0x00000018

.text
	main:
	addi $3 $3 0				# i (loop index)
	addi $5 $0 0				# x
	addi $6 $0 0				# A[j]
	addi $7 $0 0				# j
	addi $8 $0 0				# i (* 4, multiplied address off-set loop index)
	addi $9 $0 0				# A[j - 1]
#						for i ← 1 to(length(A)-1)
#							x ← A[i]
#							j ← i
		loop:
		addi $3 $3 1			# increment loop counter
		sll $8 $3 2			# multiply loop counter by four for address offset		
		lw $5 0x10010000($8)		# x = A[i]
		addi $7 $8 0			# j*4 = i*4
		addi $6 $7 0x10010000		# A[j]
		
		addi $7 $7 -4
		lw $9 0x10010000($7)		# A[j - 1]
		addi $7 $7 4

#						while (j <> 0) and (A[j-1] > x)
#							A[j] ← A[j-1]
#							j ← j - 1
			swap:
			beqz $7 after_swap	# while (j <> 0) andk
			bgt $9 $5 after_swap	# (A[j - 1] > x)
			sw $9 ($6)		# 	A[j] ← A[j - 1]
			addi $7 $7 -4		# 	j ← j - 1
			
			addi $7 $7 -4
			lw $9 0x10010000($7)	# A[j - 1]
			addi $7 $7 4
			
			addi $6 $6 -4
			j swap
			after_swap:

#						A[j] ← x
		sw $5 0x10010000($7)		# A[j] ← x
		bne $3 15 loop			# check loop
