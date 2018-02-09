#################################
# Demonstration of how to load data stored in data section. Depending on the type of the data you want to load, there are different instructions.
#################################
.data

    ### STRINGS ###
    load_str: .asciiz "I love CSE 220" # Use .asciiz for a string
    load_str_num: .asciiz "123" # Numbers can always be represented as a string like in any other programming language

    ### NUMBERS ###
    load_word: .word 420 # An integer will be declared as a word in MIPS, which represents a 32 bit value
    load_word_hex: .word 0x66210023 # Declaring hexadecimal values is the same thing

    ### NUMBER ARRAY ###
    load_word_arr: .word 65, 2, 784, 53, 90 # Of course in MIPS, arrays can be declared just by chaining values together by using commas

    ### PROGRAM MISC ###
    lbl_la: .asciiz "la: "
    lbl_lw: .asciiz "lw: "
    lbl_lb: .asciiz "lb: "
    lbl_lh: .asciiz "lh: "
    newline: .asciiz "\n"

    .macro nl()
        la $a0, newline
        li $v0, 4
        syscall
    .end_macro

    .macro print_la()
        la $a0, lbl_la
        li $v0, 4
        syscall
    .end_macro
    
    .macro print_lw()
        la $a0, lbl_lw
        li $v0, 4
        syscall
    .end_macro

    .macro print_lb()
        la $a0, lbl_lb
        li $v0, 4
        syscall
    .end_macro

    .macro print_lh()
        la $a0, lbl_lh
        li $v0, 4
        syscall
    .end_macro
.text

    ### LOADING STRINGS ###
    # Load a string in MIPS, first you must load the location of the string in memory, or the memory address.
    print_la()
    la $a0, load_str # This line will load the address of where the string is located in memory
    li $v0, 4 # Load the syscall for printing a string
    syscall # Actually print the string

    nl()

    # We can load a single character of a string using the lb or load byte instruction, since a character is essentially a single byte.
    print_lb()
    la $a0, load_str
    lb $t0, 5($a0) # Load the 5th carhacter of the string which is 'e'
    move $a0, $t0 # Copy the value of the char to $a0 for printing
    li $v0, 11 # Syscall 11 for printing a char
    syscall

    nl()

    # For the string that contains numbers, it is all treated as a regular character
    print_lb()
    la $a0, load_str_num
    lb $a0, 1($a0) # Loads the char '2' in the string
    li $v0, 11 # Note that this is also 50 in ASCII
    syscall
    
    nl()

    ### LOADING NUMBERS ###
    # Loading numbers is a bit different as we do not need to load the address directly. Since it is a single value unlike a string (multiple chars), we can simply just load the word value
    print_lw()
    lw $a0, load_word # Loads 420 to $a0
    la $t0, load_word # If we use la, we load the address of where the number is located in memory
    li $v0, 1
    syscall

    nl()
    
    # Unlike strngs, we will not be able to load the inividual digits of a given number. Instead, we must use bit masking in binary to do that.

    # Looking at the hex number, we can easily load each of these values. Since a word is 32 bits, this means that we can load 4 different bytes in it
    print_lb()
    la $t0, load_word_hex # Load the address of hex int, lw will not work
    lb $a0, 0($t0) # Load the first byte of the number, or the LSB on the right side
    li $v0, 34 # Syscall for printing out hex
    syscall

    nl()

    print_lb()
    la $t0, load_word_hex # Load the address of hex int, lw will not work
    lb $a0, 1($t0) # Load the first byte of the number, or the LSB on the right side
    li $v0, 34 # Syscall for printing out hex
    syscall

    nl()

    print_lb()
    la $t0, load_word_hex # Load the address of hex int, lw will not work
    lb $a0, 2($t0) # Load the first byte of the number, or the LSB on the right side
    li $v0, 34 # Syscall for printing out hex
    syscall

    nl()

    print_lb()
    la $t0, load_word_hex # Load the address of hex int, lw will not work
    lb $a0, 3($t0) # Load the first byte of the number, or the LSB on the right side
    li $v0, 34 # Syscall for printing out hex
    syscall

    nl()

    # For loading an array, it essentially has the same idea as the example above. We need to load the addres (not lw since that just gives us the value, not where it is located in memory)
    # Then, the offsets must be in multiples of 4 since the size of an int is 4 bytes.
    print_lw()
    la $t0, load_word_arr # Load the address of the number array
    lw $a0, ($t0) # Load the first number
    li $v0, 1
    syscall
    nl()

    # Now we can print the other elements by changing the offsets
    print_lw()
    lw $a0, 4($t0) # Load the first number
    li $v0, 1
    syscall
    nl()

    print_lw()
    lw $a0, 8($t0) # Load the first number
    li $v0, 1
    syscall
    nl()

    print_lw()
    lw $a0, 12($t0) # Load the first number
    li $v0, 1
    syscall