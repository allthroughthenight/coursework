# Important: do not put any other data before the frameBuffer
# Also: "Bitmap Display" from "Tools" must be connected and set to
#   unit width in pixels: 8
#   unit height in pixels: 8
#   display width in pixels: 256
#   display height in pixels: 256
#   base address for display: 0x10010000 (static data)
.data
frameBuffer:
ball_edge: .half 0x8000
ball_center: .half 0x8000

.text
main:
	# location to draw at
	li $a0 0
	li $t5 0
	
	move_right:
	addi $t5 $t5 1
	# pattern to draw
	li $a1 0x8000
	# draw ball
	jal SetColumn
	
	# remove old ball
	li $a1, 0x0000
	subi $a0 $a0 1
	jal SetColumn

	# add to location i.e. move ball
	addi $a0, $a0, 2
	ble $t5 30 move_right
	
	move_left:
	addi $t5 $t5 -1
	# pattern to draw
	li $a1 0x8000
	
	# draw ball
	jal SetColumn
	
	# remove old ball
	li $a1, 0x0000
	subi $a0 $a0 -1
	jal SetColumn

	# add to location i.e. move ball
	addi $a0, $a0, -2
	bge $t5 0 move_left
	
	j main
	# end execution
	li $v0,10
	syscall

SetColumn:
  # $a0 is x (must be within the display)
  # $a1 is column encoding
	add $t7, $a1, 0
	li $t0, -1
	li $t6,  0
	
	# frame buffer is starting address?
	la $t1, frameBuffer
	li $t2, 0
   SetColumn_forloop:
	add $t3, $t2,$t2
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	add $t3, $t3,$t3
	
	# load address
	add $t3, $t3,$t1
	
	# double a0 and store
	add $t4, $a0, $a0
	
	# add loaded address
	add $t4, $t4, $t4
	add $t4, $t4, $t3
	
	# magic number = 0b1000 0000 0000 0000 0000 0000 0000 0000
	andi $t8, $t7, 2147483648
	bne $t8, $zero, SetColumn_elsecase
	sw $t6,($t4)
	j SetColumn_skip_else
      SetColumn_elsecase:
	sw $t0,($t4)
      SetColumn_skip_else:
	addu $t7, $t7, $t7
	addi $t2, $t2, 1
	blt $t2, 33, SetColumn_forloop
	jr $ra

