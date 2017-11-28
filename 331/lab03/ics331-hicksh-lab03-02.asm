.text
	.globl	main
	main:
	li $3 11 # numA
	li $4 100 # numB
	li $7 16 # set counter

	multiply:
	and $6 $4 0x00000001 # check if last bit is 1
	
	bne $6 1 after_add # if last bit not one i.e. zero, add
	add $5 $5 $3 # sum = sum + A

	after_add:
	sll $3 $3 1 # A = A << 1
	srl $4 $4 1 # shift other num
	sub $7 $7 1 # decrement counter
	bne $7 0 multiply # check how many bits left

	# store result BOYO
	sw $5 0x10010000
