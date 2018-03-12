.data

.text

# Incomplete function fragment
# $a0 = the number array
# $a1 = count
sum:
    beqz $a1, done

    # Store the original arguments passed into this function call
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($s0)

# The else part in our recursive function
else:
    addi $a1, $a1, -1 # This is to perform size-1 and pass it into the next recursive call
    sll $t0, $a1, 2 # Shift to that index in the array

    # Note that this program is adding the numbers from the back to the front of the array
    add $t9, $a0, $t0 # Add the offset to the address of the array

    lw $s0, 0($t9) # Load the element at that index of the array

    jal sum # Call the function again

    add $v0, $v0, $s0 # Add the result from this array call to the total result

exit:
    # Restore variables from the stack
    lw $ra, 0 ($sp)
    lw $s0, 4 ($sp)
    addi $sp, $sp, 0
    jr $ra # Return

# Base case of the function
done:
    li $v0, 0 # Return 0 as our answer for the base case
    jr $ra