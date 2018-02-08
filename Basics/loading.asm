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
.text

