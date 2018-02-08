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
        la $a0, newline
        li $v0, 4
        syscall
    .end_macro
    
    .macro print_lw()
        la $a0, newline
        li $v0, 4
        syscall
    .end_macro

    .macro print_lb()
        la $a0, newline
        li $v0, 4
        syscall
    .end_macro

    .macro print_lh()

    .end_macro
.text

    ### LOADING STRINGS ###
    # Load a string in MIPS, first you must load the location of the string in memory, or the memory address.
    la $a0, load_str # This line will load the address of where the string is located in memory
    li $v0, 4 # Load the syscall for printing a string
    syscall # Actually print the string

    nl()

    # We can load a single character of a string using the lb or load byte instruction, since a character is essentially a single byte.
    la $a0, load_str
    lb $t0, 5($a0) # Load the 5th carhacter of the string which is 'e'
    move $a0, $t0 # Copy the value of the char to $a0 for printing
    li $v0, 11 # Syscall 11 for printing a char
    syscall

    nl()

    # For the string that contains numbers, it is all treated as a regular character
    la $a0, load_str_num
    lb $a0, 1($a0) # Loads the char '2' in the string
    li $v0, 1
    syscall
    
    nl()