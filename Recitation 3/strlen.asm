# Strlen
.data
    some_string: .asciiz "some string"

.text
    li $s0, 0           # Keep the length of the string
    la $s1, some_string
    strlen_loop:
        lb $t0, 0($s1)  # Loads the current char at address stored in $s1
        beqz $t0, strlen_loop_end

        addi $s1, $s1, 1    # Increment the address
        addi $s0, $s0, 1

        j strlen_loop 

    strlen_loop_end:

    move $a0, $s0
    li $v0, 1
    syscall

    li $v0, 10
    syscall # Exiting the program