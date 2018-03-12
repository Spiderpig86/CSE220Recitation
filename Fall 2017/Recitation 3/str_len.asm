# Mini program to get the length of the string
.data
    str_label: .asciiz "Enter a string: "
    nl: .asciiz "\n"
    buffer: .space 40 # Space in memory to store the string

    .macro nl()
		li $v0, 4
		la $a0, nl
		syscall
	.end_macro

.text
    la $a0, str_label
    li $v0, 4
    syscall

    # Accept string input (up to 40 chars)
    la $a0, buffer # Load space in memory to store the string
    li $a1, 40 # Load the max number of characters that could be entered.
    li $v0, 8 # Syscall for reading input
    syscall

    # Now the string should be stored in buffer.

    # Call str_len to find the length of the strng from memory
    la $a0, buffer
    jal str_len

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

    #######################################
    # A function designed to sum in 5 numbers
    # 
    # Arguments:
    #   $a0 = address of string in memory
    # Return:
    #   $v0 = length of the string
    #######################################
    str_len:
        # $a0 has the mem address
        move $t2, $a0
        li $t0, 0 # Counter for number of chars
        str_loop:
            lb $t1, ($t2) # Temp storage of current char

            beqz $t1, str_loop_end # Reached the end of the string once we reach null terminator
			beq $t1, 10, str_loop_end # Ignore line return

            addi $t0, $t0, 1 # Incremement counter
            addi $t2, $t2, 1 # Shift address of string over by 1 byte

            j str_loop # Loop again
        str_loop_end:

        move $v0, $t0 # Return the length of the string
        jr $ra
