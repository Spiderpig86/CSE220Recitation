# Hamming distance
# str1 = "1010"
# str2 = "1100"
# Result is the number of differences in chars

.data
    str1: .asciiz "1010"
    str2: .asciiz "1100"

    err_string: .asciiz "Error\n"

.text
    la $s0, str1
    la $s1, str2

    # First check if the lengths are the same
    move $a0, $s0
    jal strlen
    move $s2, $v0 # Copy the length of str1

    move $a0, $s1
    jal strlen
    bne $s2, $v0, hamming_err

    li $t2, 0 # Counter for number of different chars
    hamming_loop:
        lb $t0, ($s0)   # Load char from str1
        lb $t1, ($s1)   # Load char from str2

        beqz $t0, hamming_loop_end

        beq $t0, $t1, same_chars # Branch if the chars match

        # The cars do not match, so increment the counter
        addi $t2, $t2, 1
        same_chars:

        addi $s0, $s0, 1     # Shift the strings over 1 char
        addi $s1, $s1, 1

        j hamming_loop

    hamming_loop_end:

    # Print the hamming distance
    li $v0, 1
    move $a0, $t2
    syscall

    j hamming_err_end
    hamming_err:
        li $v0, 4
        la $a0, err_string
        syscall
    hamming_err_end:

    li $v0, 10
    syscall

strlen:
    li $t0, 0 # Counter
    strlen_loop:
        lb $t1, 0($a0)  # Loads the current char at address stored in $a0
        beqz $t1, strlen_loop_end

        addi $t0, $t0, 1   
        addi $a0, $a0, 1 # Increment the address

        j strlen_loop 

    strlen_loop_end:
    move $v0, $t0    
    jr $ra