####################
# A simple factorial program for demosntrating how functions work
####################
.data
    num: .word 6

.text
    # The main entry point of the program
    main:
        lw $a0, num # Load the value of the number we will be finding the factorial of

        jal factorial # Call the factorial function with number in arguments already

        move $a0, $v0
        li $v0, 1
        syscall

        li $v0, 10
        syscall

    ########################################
    # Helper function for finding the factorial
    #
    # Arguments:
    #   $a0 = (n) the number are currently multiplying
    #
    # Returns:
    #   $v0 = the result
    ########################################
    factorial:
        # Before doing anything, make sure to save the return address
        addi $sp, $sp, -8 # Allocate 4 bytes on the stack
        sw $a0, ($sp)
        sw $ra, 4($sp) # Store the return address at the top of the stack

        # Base Case #
        bgtz $a0, non_leaf # If param > 0, keep multiplying
        li $v0, 1 # Load 1 as return value
        j return

        non_leaf:

        addi $a0, $a0, -1 # Decrement
        jal factorial
        lw $a0, ($sp) # Load the original parameter
        mul $v0, $a0, $v0

        return:

        # Restore the old return address
        lw $ra, 4($sp)
        addi $sp, $sp, 8 # Free up memory
    
        jr $ra # Return