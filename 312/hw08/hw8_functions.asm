;--------------------------------------------------------
;
;	file: hw8_functions.asm
;
;	description: sub-programs to take user input, put in an array, and print
;
;--------------------------------------------------------

;; function inputArray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	first_msg		db	"Enter a positive integer: ", 0

segment .text

	inputArray:

		; preamble
		mov	ecx, 0				; clear ecx
		push 	ebp				; save caller edp value
		mov	ebp, esp			; move edp to new esp lcoation
		mov	ebx, [ebp + 8]			; move array addres to edx

		input_loop:
			mov	eax, first_msg		; load message to print
			call	print_string		; print loaded message
			call	read_int		; take the first int
			mov	[ebx], eax		; place int at the array address
			add	ebx, byte 4		; move array pointer
			inc	ecx			; increment ecx to show that you read one additional integer
			cmp	ecx, [ebp + 12]		; compare ecx to the second parameter (10)
			jnae	input_loop		; jump if not above or equal
			jmp	input_end		; loop through inputArray function again

		input_end:

		; epilogue
		pop	ebp
		ret

;; function printArray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_printArray	db	"Function printArray not implemented yet!",10,0

segment .text

	printArray:

		; preamble
		mov	ecx, 0				; clear ecx
		push	ebp				; save caller edp value
		mov	ebp, esp			; move edp to new esp location
		mov	ebx, [ebp + 8]			; move array address to ebx

		print_loop:
			mov	eax, [ebx]		; load array number
			call	print_int		; print load number
			mov	eax, 32d		; load and print two spaces
			call	print_char
			call	print_char
			add	ebx, 4			; move array pointer
			inc	ecx			; increment loop counter
			cmp	ecx, [ebp + 12]		; compare loop counter to array pointer
			jnae	print_loop		; jump if not above or equal
			jmp	print_end		; uncondition jump to end of sub program

		print_end:
			call	print_nl

		; epilogue
		pop	ebp
		ret

;; function map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_map	db	"Function map not implemented yet!",10,0

segment .text

	map:
		; preamble
		mov	ecx, 0				; clear ecx
		push	ebp				; save caller edp value
		mov	ebp, esp			; move edp to new esp location
		mov	ebx, [ebp + 8]			; move array address to ebx

		map_loop:
			push	dword [ebx]			; the value of the first array item will be the first argument
			call	[ebp + 16]
			add	esp, 4				; clear the stack
			mov	[ebx], eax
			add	ebx, 4				; move to item next in the array
			inc	ecx				; increment counter
			cmp	ecx, [ebp + 12]			; check if still in loop
			jnae	map_loop			; jump if not above or equal

		; epilogue
		pop	ebp
		ret

;; function mapReduce
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

segment .data
	error_msg_mapReduce	db	"Function mapReduce not implemented yet!",10,0

segment .text

mapReduce:
	mov	eax, error_msg_mapReduce
	call	print_string
	ret
