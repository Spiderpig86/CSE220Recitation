#####################
# Working with a number array
#####################
.data
    num_arr: .word 32, 53, 7, 43, 5 # A number array can be created by delimiting numbers using a comma
    num_len: .word 5

    min_num: .word 0x80000000 # INT_MIN
    max_num: .word 0x7fffffff # INT_MAX

    max_label: .asciiz "Max: "
    min_label: .asciiz "Min: "

    space: .asciiz " "
    newline: .asciiz "\n"

    .macro print_str(%str)
        la $a0, %str
        li $v0, 4
        syscall
    .end_macro

.text
    lw $t0, num_len # Load the value located at the word
    la $s0, num_arr # Load the address of where the array is located, so we can iterate through them
    li $t1, 0 # Counter for the loop
    lw $s1, min_num # Load the min num for comparison
    lw $s2, max_num # Load the max num for comparison
    arr_loop:
        beq $t1, $t0, arr_loop_end # Exit the loop when we reach the end of the array
        lw $t2, ($s0) # Load the word value at the current address pointed by $s0

        # Check if number is greater than the current max
        ble $t2, $s1, not_max # Branch if not greater than the current max
        la $s3, max_num
        move $s1, $t2
        sw $t2, ($s3) # Store the new max
        not_max:

        bgt $t2, $s1, not_min # Branch if not greater than the current max
        la $s3, min_num
        move $s2, $t2
        sw $s2, ($s3) # Store the new max
        not_min:

        # Print the number
        li $v0, 1
        move $a0, $t2
        syscall

        print_str(space)

        # Increment the addresses and pointer
        addi $s0, $s0, 4 # Increment by 4 to get to the next word
        addi $t1, $t1, 1 # Increment the counter

        j arr_loop

    arr_loop_end:
    
    print_str(newline)

    # Print out the max value
    print_str(max_label)
    lw $a0, max_num
    li $v0, 1
    syscall

    print_str(newline)

    # Print out the min value
    print_str(min_label)
    lw $a0, min_num
    li $v0, 1
    syscall

    li $v0, 10
    syscall