.text
	main:
	addi $3 $0 0 		# fib temp 1
	addi $4 $0 1 		# fib temp 2
	addi $5 $0 1		# fib num
	addi $6 $0 11 		# set loop counter
	addi $7 $0 0x10010000 	# store starting memory address

		loop:
		# mem storage
		sb $5 ($7) 	# store fib register into memory
		addi $7 $7 1 	# increment memory

		# fib calculations
		add $5 $4 $3	# calc and store new fib and store
		move $3 $4 	# store fib temps
		move $4 $5

		# decrement and check loop
		subi $6 $6 1
		bnez $6 loop
	break
