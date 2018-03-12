# This is a simple hello world program

.data
    # The data section stores the information that would be located in memory like ascii, asciiz, word, byte, etc.
    hello_world: .asciiz "Hello World"

.text
    # The functionality of the program
    .globl main # Make the main function accessible to external files
    main: # Label for the main function
        li $v0, 4 # Load 4 into return register to print string.
        la $a0, hello_world # Use la when loading a string from memory
        syscall # Execute printing the string

        # End the program
        li $v0, 10
        syscall
