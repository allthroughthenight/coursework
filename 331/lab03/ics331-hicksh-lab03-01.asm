.data
	# TODO: wut

.text
	.globl	main
	main:
	la $sp 0x10010000($0)	# stack base pointer
	la $6 0x10010000($0) # memory base address
	li $3 5 # hailstone sequence to calcuelate
	li $4 1 # base case of 1
	sw $3 ($6)
	addi $6 $6 4
	jal hailstone
	j end
		hailstone:

		subi $sp, $sp, 4 # allocate stack space
		sw $ra, ($sp) # save return address
		
		jal hailstone_helper
		
		lw $ra, ($sp) # load return address
		addi $sp, $sp, 4 # deallocate stack space
		jr $ra # return to caller
		
		hailstone_helper:
		
		subi $sp, $sp, 4 # allocate stack space
		sw $ra, ($sp) # save return address

		and $5 $3 0x0000001 # check if odd
		beq $5 1 odd # if odd divide, else multiply

		srl $3 $3 1 # divide 
		j after_odd # skip odd

		odd: # 'odd' calculation
		addi $t1 $3 0
		add $3 $3 $t1
		add $3 $3 $t1
		addi $3 $3 1	

		after_odd: 

		sw $3 ($6) # store calcuelated number
		addi $6 $6 4 # increment storage address

		beq $3 $4 exit # check base case
		jal hailstone_helper # else recurse

		exit:
		lw $ra, ($sp) # load return address
		addi $sp, $sp, 4 # deallocate stack space
		jr $ra # return to caller
	end:
