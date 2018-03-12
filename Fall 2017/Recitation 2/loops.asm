.data
    num_arr: .word 53, 1, 3, 82, 64 # String array of length 5
    num_arr_len: .word 5
    target: .word 3

    lbl_target_found: .asciiz "Target found: "
    lbl_not_target: .asciiz "Not target: "
    new_line: .asciiz "\n"

    .macro nl()
        li $v0, 4
        la $a0, new_line
        syscall
    .end_macro
.text
    # Perform linear search using a while loop
    # Code in Java:
    # int i = 0;
    # int target;
    # while (i < num_arr_len) {
    #   if (num_arr[i] == (target)) {
    #       System.out.println(lbl_target_found + num_arr[i]);
    #       break;
    #   } else {
    #       System.out.println(lbl_not_target + num_arr[i]);
    #   }
    # }

    la $t0, num_arr
    lw $t1, num_arr_len # Load the length of our array
    lw $t2, target # Load the target into register $t2
    li $t3, 0 # Counter

    lin_search_while:
        bgt $t3, $t1, lin_search_while_end # Exit loop when we exceeded length
        
        lw $t4, ($t0) # Load the value at the index of the array

        # Check if numbers do not match
        bne $t4, $t2, not_found # Branch if it does not match the target

        # If it matches, print that the target is found and exit the loop
        la $a0, lbl_target_found
        li $v0, 4
        syscall
        
        move $a0, $t4 # Print the current value (target)
        li $v0, 1
        syscall

        j lin_search_while_end
        not_found:

            la $a0, lbl_not_target
            li $v0, 4
            syscall

            move $a0, $t4
            li $v0, 1
            syscall
            nl()

            # Move to next value
            addi $t0, $t0, 4 # Since we are working with words, we will increment by 4 to reach the word aligned boundaries
            addi $t3, $t3, 1 # Incrememnt counter
            j lin_search_while

    lin_search_while_end:

    li $v0, 10
    syscall
