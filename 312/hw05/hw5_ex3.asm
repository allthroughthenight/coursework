;--------------------------------------------------------
;
;	hw: 5
;
;	class: 312
;
;	file: hw5_ex3.asm
;
;	description: prints out histograms by range
;
;--------------------------------------------------------

%include "asm_io.inc"

segment .data
	start_prompt	db	"Enter the bin size: ",0
	valid_msg	db	"Valid bin size!", 0
	invalid_msg	db	"Invalid bin size, aborting!", 0
	total_bins	db	"The total number of bins is: ", 0
	list_bins	db	"List of bins: '", 0
	bin_seperator	db	"' '", 0
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

	; print prompt and take user input
	mov eax, start_prompt		; load message address
	call print_string		; print message
	call read_int			; take user integer input
	mov [bin_size], al		; store user input into the location of the label bin size

	;-------------------------------------------------
	; user input check

	; less than 0
	mov eax, 0			; clear eax
	cmp eax, [bin_size]		; 0 - bin size
	jg invalid			; if greater than i.e. negative, then exit

	; greater than 95
	mov eax, 95			; load 95 into eax
	cmp eax, [bin_size]		; 95 - bin size
	jl invalid			; if less than i.e. positive, then exit
	;-------------------------------------------------

	; valid input
	mov eax, valid_msg		; load message address
	call print_string		; print message
	call print_nl			; print new line

	; divide 95 by bin_size
	mov eax, 0			; clear eax
	mov al, [max_bin]		; load al with max bin size i.e. 95
	mov bl, [bin_size]		; load bl with bin size
	div bl				; divide al by bl i.e. 95 by bin size

	; store quotient and remainder
	mov [bin_count], al		; store al, the quotient, into the location of the laben bin count
	mov [bin_remainder], ah		; store ah, the remainder, into the location of the label bin remainder

	; check if remainder is greater than zero
	mov eax, 0			; load zero into eax
	cmp eax, [bin_remainder]	; 0 - bin remainder
	jl extra_bin			; if less that i.e. greater than 0, jump to extra bin
	jmp no_extra_bin		; else run normally

extra_bin:
; used if there is a 'remainder' bin, used to add an extra bin count for accuracy

	; if greater than zero, increment bin count
	mov al, [bin_count]		; load bin count into al
	inc al				; inc al
	mov [bin_count], al		; store al into the location of the label bin count

no_extra_bin:
; default block if there is no 'remainder' bin

	; print bin count message
	mov eax, total_bins		; load message adderess
	call print_string		; print message
	mov eax, 0			; clear eax
	mov al, [bin_count]		; load bin count
	call print_int			; print bin count
	call print_nl			; print new line

	; move loop counter to ecx
	mov ecx, 0			; clear ecx
	mov cl, [bin_count]		; load bin count
	sub cl, 2			; subtract two since last bin(s) are handled differently

	; print bin range message
	mov eax, list_bins		; load message address
	call print_string		; print message

	; move first ascii char to eax and print
	mov edx, 0			; clear edx
	mov dl, 32			; move 32 to dl, ascii char space, and use as 'base' char to incriment
	mov eax, 0			; clear eax
	mov al, 32			; load 32 to al
	call print_char			; print int in al as ascii char

	; increment eax by bin range size
	add dl, [bin_size]		; add bin size to dl to get next char in range
	dec dl				; dec to stay in range

	; print next eax range char
	mov al, dl			; load al with new char in dl
	call print_char			; print int in al as ascii char

bin_range:
; print out bin of regular numbers

	; print bin seperator
	mov eax, bin_seperator		; load message address
	call print_string		; print message

	; print first char in range
	mov eax, 0			; clear eax
	mov al, dl			; load al with new char in dl
	inc al				; inc to stay in range
	call print_char			; print int in al as ascii char

	; print last char in range
	add dl, [bin_size]		; add bin size to dl to get next char in range
	mov al, dl			; load al with new char in dl
	call print_char			; pint int in al as ascii char

	; loop check
	cmp cl, [bin_count]		; counter - bin count
	dec cl				; dec before jump
	jz after_bin_range		; if zero exit loop
	jmp bin_range			; else repeat

after_bin_range:
; used to print out last bin, meant for ranges that might have a 'reamainder' bin

	mov eax, bin_seperator		; load message address
	call print_string		; print message

	mov eax, 0			; clear eax
	mov al, dl			; move dl into al
	inc al				; inc al to stay in range
	call print_char			; print int in al as ascii char

	; print tilde since it's always last
	mov al, 126			; load 126 into al
	call print_char			; print int in al as ascii char

	; print last comma and new line
	mov al, 39			; load 39 into al
	call print_char			; print int in al as ascii char
	call print_nl			; print new line

	;-------------------------------------------------
	; invalid user input exit
	jmp exit			; jump block unless entered on purpose
invalid:
	mov eax, invalid_msg		; load message address
	call print_string		; print message
	jmp exit			; jump to programs end
	;-------------------------------------------------

exit:
	; clean up
	popa
	mov	eax, 0
	leave
	ret

