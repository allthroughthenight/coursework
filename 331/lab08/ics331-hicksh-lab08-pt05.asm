

.data
frameBuffer:

.text
li $a0 5 # x cord i.e. column number
#li $a1 0 # y cord i.e. up down shift
li $a2 1 # left right direction
li $a3 1 # up down direction
li $t5 5 # up down coord
main:

	beq $a0 0 flip_ud		# if at top or bottom edge then change direction
	beq $a0 28 flip_ud

	j after_flip
	flip_ud:
		xor $a2 $a2 0x00000001
	after_flip_ud:

	beq $a2 1 move_right		# move left or right based on a2
	beq $a2 0 move_left

	move_right:
		addi $a0 $a0 1
		j after_move_left
	move_left:
		subi $a0 $a0 1
	after_move_left:

	blt $t5 0 flip_lr		# if at top or bottom edge then change direction
	bgt $t5 28 flip_lr
	j after_flip_lr

	flip_lr:
		xor $a3 $a3 0x00000001
	j check
	after_flip_lr:
				
	beq $a0 0 check			# check if at collumn to move up or down
	beq $a0 4 check			# TODO: clean this up you filthy animal
	beq $a0 8 check
	beq $a0 12 check
	beq $a0 16 check
	beq $a0 20 check
	beq $a0 24 check
	beq $a0 28 check
	beq $a0 32 check

	j after_collumn_check
	check:
	beq $a3 1 move_up		# move up or down based on a3
	beq $a3 0 move_down

	move_up:
		addi $t5 $t5 1
		j after_move_down
	move_down:
		subi $t5 $t5 1
	after_collumn_check:

	jal draw_ball			# call draw_ball

	j main				# loop back to main

draw_ball:
	addi $sp $sp -4			# allocate stack space
	sw $ra 0($sp)			# save return address

	subi $a0 $a0 1			# erase column
	li $a1 0
	jal SetColumn

	add $a0 $a0 1			# draw left
	li $a1 6
	sllv $a1 $a1 $t5		# set y coord
	jal SetColumn

	add $a0 $a0 1 			# draw top and bottom
	li $a1 9
	sllv $a1 $a1 $t5		# set y coord
	jal SetColumn
	add $a0 $a0 1
	jal SetColumn

	add $a0 $a0 1			# draw right
	li $a1 6
	sllv $a1 $a1 $t5		# set y coord
	jal SetColumn

	add $a0 $a0 1			# erase column
	li $a1 0
	jal SetColumn

	sub $a0 $a0 4			# return to starting column

	lw $ra 0($sp)			# restore return address
	addi $sp $sp 4			# free stack space
	jr $ra				# return

SetColumn:
	# $a0 is x (must be within the display)
	# $a1 is column encoding i.e. pattern to draw
	add $t7, $a1, 0			# create copy of $a1
	li $t0, -1			# set $t0 to 0xFFFFFFFF
	li $t6,  0			# set $t6 to 0
	la $t1, frameBuffer		# set $t1 to the framebuffer address
	li $t2, 0			# set $t2 to 0
   SetColumn_forloop:
	add $t3, $t2,$t2		# $t3 = $t2*2
	add $t3, $t3,$t3		# $t3 = ($t2*2)*2 = $t2 * 4
	add $t3, $t3,$t3		# $t3 = $t2*8
	add $t3, $t3,$t3		# $t3 = $t2*16
	add $t3, $t3,$t3		# $t3 = $t2*32
	add $t3, $t3,$t3		# $t3 = $t2*64
	add $t3, $t3,$t3		# $t3 = $t2*128
	add $t3, $t3,$t1		# $t3 = $t2*128 + framebuffer
	add $t4, $a0, $a0		# $t4 = column * 2
	add $t4, $t4, $t4		# $t4 = column * 4
	add $t4, $t4, $t3		# $t4 = column * 4 + $t2*128 + framebuffer
	andi $t8, $t7, 2147483648 	# $t8 = last bit of $t7 magic number is mask 0x80000000
	bne $t8, $zero, SetColumn_elsecase	# is the last bit 0?
	sw $t6,($t4)			# draw a black pixel
	j SetColumn_skip_else
      SetColumn_elsecase:
	sw $t0,($t4)			# draw a white pixel
      SetColumn_skip_else:
	addu $t7, $t7, $t7		# $t7 = $t7*2 = $t7<<1
	addi $t2, $t2, 1		# increment $t2
	blt $t2, 33, SetColumn_forloop	# are we done with the column?
	jr $ra				# return
