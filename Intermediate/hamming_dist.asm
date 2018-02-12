.data
    str1: .asciiz "1010"
    str2: .asciiz "0000"
    dist_str: .asciiz "Hamming distance: "
    newline: .asciiz "\n"
    err_str: .asciiz "Argument error\n"


.text:
    la $a0, str1
    jal strlen
    move $s0, $v0 # len of str1
    la $a0, str2
    jal strlen # len of str2 in v0
    bne $s0, $v0, hamming_err

    # strings are same len --> can compute hamming dist
    la $t0, str1
    la $t1, str2
    li $t3, 0 # dist

    hamming_loop:
        lb $t4, ($t0)
        lb $t5, ($t1)
        beqz $t4, hamming_end # reached end of str
        addi $t0, $t0, 1  # inc string
        addi $t1, $t1, 1  # inc string
        beq $t4, $t5, hamming_loop # equal --> dist doesn't change
        addi $t3, $t3, 1 # dist += 1
        j hamming_loop

    hamming_end:
        la $a0, dist_str
        li $v0, 4
        syscall
        
        move $a0, $t3
        li $v0, 1
        syscall
        
        la $a0, newline
        li $v0, 4
        syscall

        j exit

    hamming_err:
        la $a0, err_str
        li $v0, 4
        syscall
    
    exit:
        li $v0, 10 # exit
        syscall 
        

strlen:
    # a0 = addr of string
    # return len in v0

    li $v0, 0  # len
    strlen_loop:
        lb $t1, 0($a0)
        beqz $t1, strlen_end
        addi $v0, $v0, 1  # len += 1
        addi $a0, $a0, 1  # str += 1
        j strlen_loop
    strlen_end:
        jr $ra # return 