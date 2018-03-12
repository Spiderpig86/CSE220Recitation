# A small program demonstrating how the stack works
# Note that the stack grows downward

.data
	nl: .asciiz "\n"

	.macro nl()
		li $v0, 4
		la $a0, nl
		syscall
	.end_macro

.text
    main:
        li $s0, 10 # Load 10 into $s0
        addi $s1, $0, 5 # Load 5 into $s1
        li $t0, 42 # Load 42 into $t0

        # The stack can be very helpful in saving old values of a register just in case it is modified in some other part of the program

        addi $sp, $sp, -8 # Allocate space to store 2 words
        sw $s0, ($sp) # Store $s0 at the first index of the allocated space
        sw $s1, 4($sp) # Store $s1 at the second word aligned position

        # If we wanted to store more values, we can simply allocate more space
        addi $sp, $sp, -4 
        sw $t0, ($sp) # Store $t0 at the new allocated space in the stack

		# Print 4($sp)
		li $v0, 1
		lw $a0, 4($sp)
		syscall
		nl()

        # So the stack now looks a bit something like this:
        # ------------
        # Other data...
        # ------------
        # 5
        # ------------
        # 10
        # ------------
        # 42 <- $sp
        # ------------

        # So what if we store $t0 in 4($sp)?
        sw $t0, 4($sp)
		nl()

		# Print contents of stack
		li $v0, 1
		lw $a0, 4($sp)
		syscall
		nl()

		li $v0, 1
		lw $a0, 4($sp)
		syscall
		nl()

		li $v0, 1
		lw $a0, 8($sp)
		syscall
		nl()

		# Therefore, it is important to keep track of what you have already stored in the stack and how much space you allocated to avoid accidentally overwriting previous values

        # Now when you are done with the stack, always remember to free up the used space by moving the stack pointer back up to its original position

        lw $t0, 0($sp) # Restore the register values in backwards order
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        addi $sp $sp, 12 # Move the stack pointer up 12 bytes since we took up space for 3 words