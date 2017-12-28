;--------------------------------------------------------
;
;	file: hw5_ex4.asm
;
;	description: take user input and print out histograms by distribution
;
;--------------------------------------------------------

%include "asm_io.inc"

segment .data
	msg1	db	"Enter an integer: ",0
	msg2	db	"Binary representation: ", 0
	msg3	db	"String representation: ", 0
	msg4	db	"Pattern DBB occurs this many times: ",0
	msg5	db	"Enter a 2-character pattern: ",0
	msg6	db	"Your pattern occurs this many times: ",0
	msg7	db	"Enter a pattern with at most 16 characters: ",0
	msg8	db	"Your pattern occurs this many times: ",0
	msg9	db	"Pattern B* occurs this many times: ", 0

segment	.bss
; no more than 20 bytes can be reserved
	input_int	resb	1	; size of bins
	input_bin	resb	4	; user input in binary
	two_chars	resb	1	; user two char input
	char_pattern	resb	4	; user multi char input
	char_count	resb	1	; number of char input

segment .text
	global asm_main

asm_main:
	; set up
	enter	0,0
	pusha
_start:

	;
	; ex1: print binary string of input
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg1			; load and print message
	call	print_string
	call	read_int			; take user input
	mov	[input_int], eax		; store input int

	mov	eax, msg2			; load and print message
	call	print_string

	mov	ebx, [input_int]		; mov input int to eax
	mov	ecx, 32				; load counter for loop

	; loop 32 time to print binary representation of user input
print_input_bin:
	shl	ebx, 1				; shift register left by one
	jc	print_one			; if carry flag is set jump i.e. last bit shifted out is one
	mov	eax, 0				; load zero into eax
	jmp	after_print_one			; skip print one
print_one:					; print one call label
	mov	eax, 1				; load one into eax
after_print_one:				; after print one label
	call print_int				; print eax i.e. one or zero
	loop	print_input_bin			; loop label

	call	print_nl
	mov	eax, [input_int]

	;
	; ex2: print encoded string
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg3			; load and print message
	call	print_string

	mov	eax, [input_int]		; load original input
	mov	ebx, 0				; clear ebx
	mov	cl, 0				; load shift left value

	; loop 30 times to print character representation of input
print_code_string:
	mov	eax, [input_int]		; load input integer
	shl	eax, cl				; shift left by current count
	shr	eax, 30				; shift right by 30 to zero out other bits

	mov	ebx, 0				; load "A" mask
	cmp	eax, ebx			; compare current bits to mask
	jz	print_a				; print character

	; repeat lines 89 - 91 for other characters
	mov	ebx, 1
	cmp	eax, ebx
	jz	print_b

	mov	ebx, 2
	cmp	eax, ebx
	jz	print_c

	mov	ebx, 3
	cmp	eax, ebx
	jz	print_d

	; print character
	jmp	after_print_a
print_a:
	mov	eax, "A"
	call	print_char
after_print_a:

	jmp	after_print_b
print_b:
	mov	eax, "B"
	call	print_char
after_print_b:

	jmp	after_print_c
print_c:
	mov	eax, "C"
	call	print_char
after_print_c:

	jmp	after_print_d
print_d:
	mov	eax, "D"
	call	print_char
after_print_d:

	add	cl, 2				; increment counter by 2
	cmp	cl, 32				; check if still in loop
	jne	print_code_string		; jump to the beginning of the loop

	call	print_nl

	;
	; ex3: occurance of DDB pattern
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; test number '656565'

	mov	eax, msg4			; load and print message
	call	print_string

	mov	eax, [input_int]		; load original input
	mov	ebx, 0				; clear ebx
	mov	ecx, 0				; load shift left value
	mov	edx, 0				; load counter

	; loop 30 times to print character representation of input
count_dbb:
	mov	eax, [input_int]		; load input integer
	shl	eax, cl				; shift left by current count
	shr	eax, 26				; shift right by 30 to zero out other bits

	mov	ebx, 000000035h			; load "DBB" mask
	cmp	eax, ebx			; compare current bits to mask
	je	inc_dbb				; jump if equal

	jmp	after_count_dbb			; skip dbb counter
inc_dbb:
	inc	edx				; inc dbb pattern counter
after_count_dbb:

	inc	cl				; increment counte
	cmp	ecx, 32				; check if still in loop
	jne	count_dbb		; jump to the beginning of the loop

	mov	eax, edx			; load and print count number
	call	print_int
	call	print_nl

	;
	; ex4: occurance of 2 character pattern
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg5			; load and print message
	call	print_string

	mov	[two_chars], dword 0		; clear reserved memory

	call	read_char			; read trash new line
	mov	ebx, 0				; clear ebx

	; get user input
	; loop until new char (Ah) read
two_char_input:
	mov	eax, 0
	call	read_char
	cmp	eax, 0Ah
	jz	after_two_char_input
	sub	eax, 041h
	shl	ebx, 2
	add	ebx, eax
	jmp	two_char_input
after_two_char_input:
	mov	[two_chars], ebx		; save two char input to ram

	; check for input pattern
	mov	eax, [two_chars]		; load original input
	mov	ebx, 0				; clear ebx
	mov	ecx, 0				; clear ecx, loop counter
	mov	edx, 0				; clear edx

	; loop 28 times to find number of times two char input is found
count_pattern:
	mov	eax, [input_int]		; load input integer
	shl	eax, cl				; shift left by current count
	shr	eax, 28				; shift right to zero out other bits

	mov	ebx, [two_chars]		; load two char pattern
	cmp	eax, ebx			; compare current bits to mask
	je	inc_pattern			; jump if equal
	jmp	after_count_pattern		; skip pattern coutner counter

inc_pattern:
	inc	edx				; inc pattern counter
after_count_pattern:

	add	ecx, 2
	cmp	ecx, 32				; check if still in loop
	jne	count_pattern			; jump to the beginning of the loop

	mov	eax, msg6			; load and print message
	call	print_string

	mov	eax, edx				; print number of times input pattern occurs
	call	print_int
	call	print_nl

	;
	; ex5: find any pattern up to 16 chars
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg7
	call	print_string

	mov	[char_pattern], dword 0		; clear reserved memory

	mov	eax, 0
	mov	ebx, 0				; clear ebx
	mov	ecx, 0
	mov	edx, 0

	; get user input
	; loop until new line (Ah) read
multi_char_input:
	mov	eax, 0				; clear eax
	call	read_char			; take user input
	cmp	eax, 0Ah			; check for enter
	jz	after_multi_char_input		; exti input loop
	sub	eax, 041h			; convert input to
	shl	ebx, 2				; shift register to clear 2 bit space
	add	ebx, eax			; move bit convertion to ebx
	inc	ecx				; increment counter
	jmp	multi_char_input
after_multi_char_input:
	mov	[char_pattern], ebx		; save two char input to ram

	shl	ecx, 1				; mul by two to make count into bit count
	mov	[char_count], ecx		; store counter value

	mov	eax, [char_pattern]		; load original input
	mov	ebx, 0				; clear ebx
	mov	ecx, 0				; clear ecx, loop counter
	mov	edx, 0				; clear edx

	; check for input pattern
	; loop 28 times to find number of times two char input is found
count_multi_char:
	mov	eax, [input_int]		; load input integer
	shl	eax, cl				; shift left by current count

	push edx				; store edx
	mov edx, ecx				; move current shift left value from ecx to edx
	push ecx				; store ecx

	mov	ecx, 32				; move total bit count to ecx
	sub	ecx, [char_count]		; sub input char count from total

	shr	eax, cl				; shift right to zero out

	pop ecx					; restore ecx
	pop edx					; restore edx

	mov	ebx, [char_pattern]		; load two char pattern

	cmp	eax, ebx			; compare current bits to mask
	je	inc_multi_char			; jump if equal
	jmp	after_count_multi_char		; skip pattern coutner counter
inc_multi_char:
	inc	edx				; inc pattern counter
after_count_multi_char:

	add	ecx, 2				; inc count by two
	cmp	ecx, 32				; check if still in loop
	jne	count_multi_char		; jump to the beginning of the loop

	mov	eax, msg8			; load and print message
	call	print_string

	mov	eax, edx			; load and print pattern count
	call	print_int

	; print number of times input patter occurs

end:
	; clean up
	popa
	mov	eax, 0
	leave
	ret
