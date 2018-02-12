##############################
# Calculate the length of the string
##############################
.data

    some_string: .asciiz "this is a string"

.text

    li $t0, 0 # Counter for the length of the string
    la $a0, some_string # Load the address of the string
    str_len_loop:
        lb $t1, 0($a0) # Load the char that is located at the current location of the address
        beqz $t1, str_len_loop_end # Check if the character is null which indicates the end of the string

        addi $t0, $t0, 1 # Increment the counter
        addi $a0, $a0, 1 # Increment the string pointer
        j str_len_loop

    str_len_loop_end:

    move $a0, $t0 # Move the counter
    li $v0, 1
    syscall

    li $v0, 10
    syscall