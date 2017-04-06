%include "asm_io.inc"

segment .data
	bin_counts times 95 dd 0	 ; array of bin counts

	; Using message to print
	msg1 			db   "Enter the bin size: ", 0
	msg2 			db   "Invalid bin size, aborting!", 0
	msg3 			db   "The total number of bins is: ", 0
	msg4 			db   "Bin '",0
	msg5 			db   "': ",0
	msg6			db   "List of bins: ",0
	msg7			db   "Enter a long string: ",0
	msg8			db   "Valid bin size!",0
	one_white_space		db   " ",0
	two_hashes_and_a_space	db   '## ',0
	three_spaces 		db   '   ',0
	one_pipe		db   '|',0
	two_dashes_and_a_pipe   db   '--|',0
	single_quote		db   "'",0

segment .bss
	bin_size resd 1	 	; Bin size
        num_bins resd 1		; Number of bins

segment .text
	global asm_main
asm_main:
	enter	0,0
	pusha

	;
	; Get the bin size from the user
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov eax, msg1		; Print the "enter bin size" message
	call print_string	; ...
	call read_int		; Read integer input from the keyboard

	mov   [bin_size], eax 	; Store the bin size in RAM

	cmp eax, 95 		; If it's > 95 it's not valid
	jg bin_size_is_not_valid; and jump to the error-handling code

	cmp eax, 0		; If it's > 0 then it's valid
	jg  bin_size_is_valid	; and jump over the error-handling code
				; to continue execution

bin_size_is_not_valid:		; Error-handling code:
	mov eax, msg2		; Print an error message
	call print_string	; ...
	call print_nl		; ...
	jmp end_of_program	; and jump to the end of the program

bin_size_is_valid:
	mov eax, msg8		; print "valid bin size" message
	call print_string	; ...
	call print_nl		; ...

	call read_char 		; Consume left-over linefeed from the
                                ; inputed integer

	;
	; Compute and print the number of bins
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov eax, msg3		; Print the "number of bins = " message
	call print_string	; ...
	mov eax, 95		; eax = 95 (total number of possible characters)
	mov edx, 0		; edx = 0 (preparing for the division)
	div dword [bin_size]	; eax = floor(95 / binsize), edx = 95 % binsize
        cmp edx, 0		; If 95 % binsize = 0 then
	jz  no_left_over	; move on
	inc eax			; otherwise, eax = 1 + floor(95 / binsize)
no_left_over:
	mov [num_bins],eax	; num_bins = eax
	call print_int		; print the number of bins
	call print_nl		; ...

	;
	; Print the bin ranges
	;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg6		; print "Bin ranges: "
	call	print_string		; ...
	mov ebx, 0			; ebx = 0 (loop index over the bins)
bin_range_print_loop:
	mov	eax, single_quote	; print "'"
	call	print_string		; ...
	mov	eax, ebx		; eax = ebx
	imul	dword eax, [bin_size]	; eax = ebx * bin_size
	add	eax, 32			; eax += 32
					; eax = ASCII code of the first character
					;	of the bin's range
	call	print_char		; print it
	add	dword eax, [bin_size]	; eax += bin_size
	dec	eax			; eax--
					; eaxh = ASCII code of the last character
					;	of the bin's range
	cmp	eax, 126		; compare the ASCII code to the max
					; ASCII code (126)
	jle	no_cap_2		; if lower than 126, all good
	mov	eax, 126		; otherwise, set it to 126
no_cap_2:
	call	print_char		; print it
	mov	eax, single_quote	; print "'"
	call	print_string		; ...
	mov	eax, one_white_space	; print a white space
	call	print_string		; ...
	inc ebx				; increase the loop index
	cmp ebx, [num_bins]		; if we still have bins to process
	jl  bin_range_print_loop	; loop back, otherwise fall through
	call	print_nl		; print carriage return



	;
	; Get the character input and compute bin counts
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov	eax, msg7
	call	print_string
input_loop:
	call read_char		; Get a character from the keyboard
	cmp al, 10		; If it's a linefeed
	jz end_input_loop	; then exit the input loop
	sub al, 32		; subtract 32 to the ASCII code
	movzx  eax, al		; size-extend it into a 4-byte value
	mov    edx, 0		; edx = 0 (preparing for a division)
	div    dword [bin_size] ; eax = floor(ASCII code / bin_size)
				;  (i.e., the bin index)
	imul	eax, 4		; eax = the byte offset in the bin count array
	mov	esi, bin_counts	; esi points to the first bin count
	add	esi, eax	; esi points to the target bin count
	inc	dword [esi]	; increment the target bin count
	jmp input_loop		; loop back
end_input_loop:

	;
	; Print all bin counts (and keep the maximum value)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov 	esi, bin_counts		; esi points to the first bin count
	mov	ebx, 0			; ebx = 0, loop index
	mov	ecx, 0			; ecx = 0, maximum count
print_loop:
	mov	eax, msg4		; print "Bin '"
	call	print_string		; ...
	mov	eax, ebx		; eax = loopindex
	imul	dword eax, [bin_size]	; eax *= bin_size
	add	eax, 32			; eax += 32
					; eax = ASCII code of the first character
					;       of the bin range
	call	print_char		; print it
	add	dword eax, [bin_size]	; eax += bin_size
	dec	eax			; eax--
					; eax = ASCII code of the last character
					;       of the bin range
	cmp	eax, 126		; compare the ASCII code to the max
					; ASCII code (126)
	jle	no_cap			; if lower than 126, all good
	mov	eax, 126		; otherwise, set it to 126
no_cap:
	call	print_char		; print it
	mov	eax, msg5		; print "': "
	call	print_string		; ...
	mov	eax, [esi]		; eax = the count for that bin
	cmp	eax, ecx		; compare it to the current max
	jle	not_the_max		; if lower move on
	mov	ecx, eax		; otherwise set the max to it
not_the_max:
	call	print_int		; print the count
	call	print_nl		; print the count
	add 	esi, 4			; point to the next bin count
	inc	ebx			; increment the loop index
	cmp	ebx, [num_bins]		; if we haven't processed all bins
	jl	print_loop		; then loop back, otherwise fall through

	call	print_nl		; print a final new line

	;
	; Print histogram bars
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; At this point ecx is the maximum, and will be used
	; as the loop index

hist_loop:				; loop from top display row all the
					; way to the bottom
	mov	eax, one_white_space	; print a white space
	call	print_string		; ...
	mov	ebx, 0			; ebx = 0 (loop index for the loop over
                                        ;          the bin counts)
row_loop:				; loop over the bin counts
	mov	esi, ebx		; esi = loop index
	imul	esi, 4			; esi *= 4
	add	esi, bin_counts		; esi += bin_counts
					;   esi points to the ebx-th bin count

	cmp     [esi], ecx		; If the bin count is greater than the current row
	jge	print_bar		; then print that part of the histogram bar
	mov	eax, three_spaces	; otherwise print three spaces
	call	print_string		; ...
	jmp	after_bar		; continue
print_bar:
	mov	eax, two_hashes_and_a_space	; print two hashes and a space
	call	print_string			; ...
after_bar:

	inc	ebx			; increment the loop index
	cmp 	ebx, [num_bins]		; if there are other bin counts to process
	jl	row_loop		; loop back, otherwise fall through

	call	print_nl		; print a carriage return

	dec	ecx			; decrement the row loop index
	jnz 	hist_loop		; if more rows to process, loop back
					; otherwise fall through

	;
	; Print the histogram's x-axis
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov eax, one_pipe		; print a pipe
	call print_string		; ...
	mov ebx, 0			; ebx = 0 (loop index over the bins)
hist_bar_loop:
	mov eax, two_dashes_and_a_pipe	; print two dashes and pipe
	call print_string		; ...
	inc ebx				; increment the loop index
	cmp ebx, [num_bins]		; if we still have bins to process
	jl  hist_bar_loop		; loop back, otherwise fall through
	call	print_nl		; print carriage return

	;
	; Print the histogram's x-axis labels
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov eax, one_white_space		; print a white space
	call print_string		; ...

	mov ebx, 0			; ebx = 0 (loop index over the bins)
hist_label_loop:
	mov	eax, ebx		; eax = ebx
	imul	dword eax, [bin_size]	; eax = ebx * bin_size
	add	eax, 32			; eax += 32
					; eax = ASCII code of the first character
					;	of the bin's range
	call	print_char		; print it
	add	dword eax, [bin_size]	; eax += bin_size
	dec	eax			; eax--
					; eaxh = ASCII code of the last character
					;	of the bin's range
	cmp	eax, 126		; compare the ASCII code to the max
					; ASCII code (126)
	jle	no_cap_3		; if lower than 126, all good
	mov	eax, 126		; otherwise, set it to 126
no_cap_3:
	call	print_char		; print it
	mov	eax, one_white_space	; print a white space
	call	print_string		; ...
	inc ebx				; increase the loop index
	cmp ebx, [num_bins]		; if we still have bins to process
	jl  hist_label_loop		; loop back, otherwise fall through
	call	print_nl		; print carriage return


end_of_program:

	popa
	mov	eax, 0
	leave
	ret

