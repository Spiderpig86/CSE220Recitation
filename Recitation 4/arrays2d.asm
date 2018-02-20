########################################
# 2D array demonstration
#
# The basic fomrula for a 2D array given the base address, number of columns, number of rows, row index, and column index.
# This equation could be written as:
#       base_addr + I * size_of_a_row_in_bytes + j * size_of_column_in_bytes
# This can be simplified to:
#       base_addr + I * num_cols * size_of_element + j * size_of element
# And further simplified to:
#       base_addr + size_of_element * (I * num_cols + j)
########################################
.data
    matrix: .space 60 # 5x3 matrix of 4-byte words
    num_rows: .word 5
    num_cols: .word 3

.text
    main:
        # Load the variables
        la $t0, matrix
        lw $t1, num_rows # Number of rows
        lw $t2, num_cols # Number of columns

        li $t3, 0 # Temp counter to iterate through the rows. (i)
        li $t9, 65 # Value to store within the 2d array

        row_loop: # Loops through each loop 

            li $t4, 0 # Counter for columns moving from left to right. (j)

            col_loop: # Loop through the columns
                # All these assignments could easily be done just by adding 4 to the starting address, but that really only shows us how a 1-D array is implemented and not the principles of a 2-D array.

                mul $t5, $t3, $t2 # I * num_columns
                add $t5, $t5, $t4 # (I * num_columns) + j
                sll $t5, $t5, 2 # [(I * num_columns) + j] * 4
                add $t5, $t5, $t0 # (I * num_columns) + j + base_addr. Pretty much we will have to keep adding this offset to the base address.
                sw $t9, ($t5) # Store the value into the array

                # Increment
                addi $t4, $t4, 1 # j++
                addi $t9, $t9, 1 # Generate next value to save.
                blt $t4, $t2, col_loop # Keep running until j == num_columns
            col_loop_end:

            addi $t3, $t3, 1 # i++
            blt $t3, $t2, row_loop # Keep looping until i == num_rows
        
        row_loop_done:
    
        # Get specific element
        la $a0, matrix # Load address
        lw $a1, num_rows
        lw $a2, num_cols
        li $a3, 4 # Size of words

        addi $sp, $sp, -8
        li $t0, 0
        sw $t0, ($sp)
        li $t0, 0
        sw $t0, 4($sp)

        jal arr_get

        addi $sp, $sp, 8

        move $a0, $v0
        li $v0, 1
        syscall

        li $v0, 10
        syscall

    ########################################
    # Get an element in an array given i and j. (Note that there are no checks in this implementation and it is assumed that all parameters are valid)
    #
    # Arguments:
    #   $a0 = (base_addr) Base address of the array
    #   $a1 = (num_rows) number of rows
    #   $a2 = (num_cols) number of columns
    #   $a3 = (obj_size) size of object
    #   0($sp) = (i) desired row
    #   4($sp) = (j) desired column
    #
    # Returns:
    #   $v0 = the element at that index
    ########################################
    arr_get:
        lw $t0, 0($sp) # i
        lw $t1, 4($sp) # j

        # Calculate the offset
        move $t2, $a3 # sizeof(object)
        mul $t3, $t2, $a2 # row_size = num_cols * sizeof(obj)
        mul $t2, $t2, $t1 # sizeof(obj) * j
        add $t2, $t2, $t3 # offset = (num_rows * i) + (sizeof(obj) * j)

        add $t4, $a0, $t2 # Add to base address to get offset
        lw $v0, ($t4) # Get the value we want

        jr $ra