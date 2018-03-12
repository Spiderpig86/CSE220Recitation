# The CPU supports up to 4 registers for arguments ($a0 - $a3). What if we needed to store 5 arguments?

.data
    num_arr: .word 1, 2, 3, 4, 5 # The 5 numbers we want to sum
.text
    main:
        la $s0, num_arr # Store starting address of array

        # Load the args into registers
        lw $a0, 0($s0)
        lw $a1, 4($s0)
        lw $a2, 8($s0)
        lw $a3, 12($s0)
        lw $t0, 16($s0) # Load fifth arg in $t0 as a temp placeholder

        # For the fifth arg, allocate space in the stack
        addi $sp, $sp, -4 # Allocate space for a word
        sw $t0, ($sp) # Store $t0 into free slot in stack

        # Now we can call the function
        jal sum_five # Here $ra would get updated to the address just after this line so the program can continue when it returns

        # Restore the $sp to before we allocated 4 bytes for the stack
        addi $sp, $sp, 4

        # Print our sum
        move $a0, $v0
        li $v0, 1
        syscall

        li $v0, 10
        syscall

    #######################################
    # A function designed to sum in 5 numbers
    # 
    # Arguments:
    #   $a0 = first number
    #   $a1 = second number
    #   $a2 = third number
    #   $a3 = fourth number
    #   0($sp) = fifth number
    #
    # Return:
    #   $v0 = the sum of 5 numbers
    #######################################
    sum_five:

        # First load off the fifth argument
        lw $t0, ($sp) # $t0 now has 5 as its value

        # Since we are also overwriting $s0 in the sum_five function, we must save the register to the stack also (following register conventions)
        # Remember that the CALLEE saves the $s registers
        addi $sp, $sp, -4
        sw $s0, ($sp) 

        li $s0, 0 # Clear $s0 to use as our register to store the sum

        # Now we do the addition
        add $s0, $s0, $a0 # sum + first_num
        add $s0, $s0, $a1 # sum + second_num
        add $s0, $s0, $a2 # sum + third_num
        add $s0, $s0, $a3 # sum + fourth_num
        add $s0, $s0, $t0 # sum + fifth_num

        move $v0, $s0 # Copy the final sum to $v0

        # Restore our $s registers
        lw $s0, ($sp) # Restores address of number array stored earlier
        addi $sp, $sp, 4 # Move $sp back to original position

        jr $ra # Return to the caller