# Important: do not put any other data before the frameBuffer
# Also: the Bitmap Display tool must be connected to MARS and set to
#   unit width in pixels: 8
#   unit height in pixels: 8
#   display width in pixels: 256
#   display height in pixels: 256
#   base address for display: 0x10010000 (static data)
.data
frameBuffer:

.text
# Example of drawing a Column; x-coordinate is set by $a0, 
# the pattern is set by the 32 bits in $a1
	li $a0, 8
	li $a1, 0x8000
	jal SetColumn
	li $v0,10
	syscall

SetColumn:
  # $a0 is x (must be within the display)
  # $a1 is column encoding
	add $t7, $a1, 0
	li $t0, -1
	li $t6,  0
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
	add $t3, $t3,$t1
	add $t4, $a0, $a0
	add $t4, $t4, $t4
	add $t4, $t4, $t3
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

