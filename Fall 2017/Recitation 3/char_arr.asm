# Strings are just character arrays. Each character takes up 1 byte
.data
    str: .asciiz "abcdefghijklmnopqrstuvwxyz" # Null terminated string

    .macro print_char(%char)
        move $a0, %char
        li $v0, 11
        syscall
    .end_macro

.text
    # Unlike words, each character seen in the string above can be accessed by specifying what byte we want to load the data from

    # First we need to load the address of the string
    la $t0, str

    # To load the first letter, just load the 0th index to a register and print
    lb $t1, ($t0) # => a
    print_char($t1)

    li $v0, 10
    syscall