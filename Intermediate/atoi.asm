
.data
    string: .asciiz "123"

.text

    la $s0, string
    li $s1, 0 # Store the number
    loop:
        lb $a0, ($s0)
        beqz $a0, end_loop
        jal atoi_helper

		li $t0, 10
        mul $s1, $s1, $t0
        add $s1, $s1, $v0

        addi $s0, $s0, 1

        j loop

    end_loop:

    move $a0, $s1
    li $v0, 1
    syscall

    li $v0, 10
    syscall


# Convert ASCII chars to integers
atoi_helper:
    li $t0, '0'
    sub $v0, $a0, $t0
    jr $ra