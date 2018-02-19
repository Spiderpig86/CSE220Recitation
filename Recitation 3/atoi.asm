# atoi
.data
    some_num: .asciiz "101"
    err_string: .asciiz "Error\n"
.text

    la $s0, some_num # Load the address of the string
    li $s1, 0 # Result

    atoi_loop:
        lb $t0, ($s0) # Load the character
        beqz $t0, atoi_loop_end
        li $t1, '0'
        li $t2, '9'

        blt $t0, $t1, atoi_err
        bgt $t0, $t2, atoi_err

        move $a0, $t0
        jal atoi_helper

        # At this point $v0 should have the number
        li $t3, 10
        mul $s1, $s1, $t3 
        add $s1, $s1, $v0

        addi $s0, $s0, 1
        j atoi_loop

    atoi_loop_end:

    j atoi_err_end
    atoi_err:
        la $a0, err_string
        li $v0, 4
        syscall
    atoi_err_end:

    li $v0, 10
    syscall

# $a0 = the char we want to convert
atoi_helper:
    li $t0, '0' # ASCII 48
    sub $v0, $a0, $t0 # Actual conversion
    jr $ra
