######################################################
# Some basic mathematical operations in MIPS
######################################################

.data
    # An int is essentially reprsented as a word in MIPS
    num1: .word 12
    num2: .word 3 # A word takes up 4 bytes in memory, which is 32 bits

    num_arr: .word 1, 2, 3, 4, 5

    newline: .asciiz "\n"

    .macro nl()
        la $a0, newline
        li $v0, 4
        syscall
    .end_macro


.text
    ######################################################
    # ADDING
    ######################################################
    lw $t0, num1 # Load in 12 into register $t0
    lw $t1, num2 # Load 3 into register $t1

    add $t2, $t0, $t1 # Add the numbers

    # Print out the numbers
    move $a0, $t2 # Move the sum from $t0 to $a0 to print
    li $v0, 1 # Syscall for printing 1
    syscall

    nl()

    ######################################################
    # SUBTRACTION
    ######################################################
    lw $t0, num2 # Let's try loading in 3 instead
    lw $t1, num1 # Load in 12

    sub $a0, $t0, $t1 # This performs $a0 = $t0 - $t1
    # So instead of moving to $a0 later, why not just write to it right away

    li $v0, 1
    syscall

    nl()

    ######################################################
    # MULTIPLICATION
    ######################################################
    # NO NEED TO RELOAD ANY OF THE REGISTERS, THE VALUES ARE ALREADY THERE 
    mul $a0, $t0, $t1 # This gives us 3 * 12 = 36

    li $v0, 1
    syscall

    nl()

    ######################################################
    # DIVISION
    ######################################################
    # Same thing over here, let's divide 12 by 3
    div $t1, $t0 # Divide 12 by 3, and store it inside the Lo register

    # NOTE: Unlike the other instructions we have used, the division instruction sepcifically (not div.d or div.s) only takes in 2 registers which are the two operands
    # The result gets stored in the HI and LO registers of the processor, since one will store the quotient and one will store the remainder
    # The quotient is stored in LO and the remainder is stored in HI

    # To print them, we need to use these instructions
    mflo $a0 # Move the quotient from LO and store it into $a0
    li $v0, 1
    syscall

    nl()

    mfhi $a0 # Move the remainder from HI into $a0
    li $v0, 1
    syscall

    nl()

    ######################################################
    # SHIFT LEFT LOGICAL
    ######################################################
    
    # This instruction is commonly used for shifting the bits to the left given an immediate or a register
    # This is also a much shorter way to multiply a number
    sll $a0, $t0, 1 # Is essentially multiplying by 2 if we hsift left by 1. If shifting left by n, it is multiplying by 2^n
    li $v0, 1
    syscall # This will output 2

    nl()

    sll $a0, $t0, 2
    li $v0, 1
    syscall # This will output 3

    li $v0, 10
    syscall