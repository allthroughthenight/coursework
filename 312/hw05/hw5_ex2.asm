;--------------------------------------------------------
;
;	file: hw5_ex2.asm
;
;	description: prints out the number of bins available
;
;--------------------------------------------------------

%include "asm_io.inc"

segment .data
	start_prompt	db	"Enter the bin size: ",0
	valid_msg	db	"Valid bin size!", 0
	invalid_msg	db	"Invalid bin size, aborting!", 0
	total_bins	db	"The total number of bins is: ", 0
	min_bin		db	0
	max_bin		db	95

segment	.bss
	bin_size	resb	1			;
	bin_count	resb	1			;
	bin_remainder	resb	1

segment .text
	global asm_main

asm_main:
	; set up
	enter	0,0
	pusha


	; part 1

	; print prompt and take user input
	mov eax, start_prompt
	call print_string
	call read_int
	mov [bin_size], al

	;-------------------------------------------------
	; check user input

	; less than 0
	mov eax, 0
	cmp eax, [bin_size]
	jg invalid

	; greater than 95
	mov eax, 95
	cmp eax, [bin_size]
	jl invalid
	;-------------------------------------------------

	; valid input
	mov eax, valid_msg
	call print_string
	call print_nl

	; divide 95 by bin_size
	mov eax, 0
	mov al, [max_bin]
	mov bl, [bin_size]
	div bl

	; store quotient and remainder
	mov [bin_count], al
	mov [bin_remainder], ah
	mov eax, 0

	; check if remainder is greater than zero
	cmp eax, [bin_remainder]
	jl extra_bin
	jmp no_extra_bin
extra_bin:

	; if greater than zero, increment bin count
	mov al, [bin_count]
	inc al,
	mov [bin_count], al
no_extra_bin:

	; print bin count message
	mov eax, total_bins
	call print_string
	mov eax, 0
	mov al, [bin_count]
	call print_int

	;-------------------------------------------------
	; test block to check results
	jmp after_test			; comment out when want to check
	mov al, [bin_count]
	call print_int

	mov al, [bin_remainder]
	call print_nl
	call print_int
	;-------------------------------------------------
after_test:


	;-------------------------------------------------
	; invalid user input exit
	jmp exit
invalid:
	mov eax, invalid_msg
	call print_string
	jmp exit
	;-------------------------------------------------

exit:
	; clean up
	popa
	mov	eax, 0
	leave
	ret

