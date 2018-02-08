######################################################
# Example program with a hidden bug
######################################################
.data
    hex: .byte 125
	newline: .asciiz "\n"
	
	.macro nl()
		la $a0, newline
		li $v0, 4
		syscall
	.end_macro
.text
	
	li $t0, 6
    lb $a0, hex
	
	# Print the result
	add $t0, $a0, $t0
	move $a0, $t0
	li $v0, 1
	syscall # We get 145
	
	nl()

	# Store the result back
	sb $t0, hex
	
	lb $a0, hex
    li $v0, 1
    syscall

	nl()

	li $v0, 10
	syscall