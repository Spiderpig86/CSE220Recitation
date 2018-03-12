# Loading values from memory and registers

.data
    num: .word 24
    num_arr: .word 65, 2, 784, 53, 90 # Create an array of length 5

    hello_world_str: .asciiz "hello world" # Declare a string
    num_str: .asciiz "4352"

    half_word_test: .word 54000000 # This stores 0x0337f980

    new_line: .asciiz "\n"

    lbl_la: .asciiz "la: "
    lbl_lw: .asciiz "lw: "
    lbl_lb: .asciiz "lb: "
    lbl_lh: .asciiz "lh: "

    .macro nl()
        li $v0, 4
        la $a0, new_line
        syscall
    .end_macro

    .macro print_str(%s)
        li $v0, 4
        la $a0, %s
        syscall
    .end_macro

    .macro print_hex(%s)
        li $v0, 34
        move $a0, %s
        syscall
    .end_macro

.text
    # LOADING STRINGS
    # Always use 'la' when loading strings from memory
    print_str(lbl_la)

    la $a0, hello_world_str
    li $v0, 4
    syscall

    nl()

    # Use the lw instruction to load num into a register
    lw $t0, num # $t0 = 24

    print_str(lbl_lw)
    
    move $a0, $t0 # Copy $t0 to $a0
    li $v0, 1
    syscall
	nl()

    # Load from an array, we first need to load the address of the array to a register
    la $t1, num_arr # $t1 now holds the address to the array

    # To access specific parts of the array, we use 4 as offsets
    # So if we wanted num_arr[3], multiply the index by 4 to get us 12
    lw $t2, 12($t1) # $t2 = 53

	move $a0, $t2
	li $v0, 1
	syscall

    nl()

    # LOADING BYTES
    # Another instruction we can use to load individual characters is the lb instruction
    # Note that this does not work words to get individual digits. To do that, use bit masking with logical operators instead
    la $s0, hello_world_str # Always use la when loading a string from memory

    # Offsets do not need to be multiples of 4 in this case
    # Let's say we wanted to extract the 'o' char. It is the 5th char (index 4) in the string
    lb $s1, 4($s0) # This will load 111 into the register since that is the ASCII character code for that char

    print_str(lbl_lb)

    move $a0, $s1
    li $v0, 11 # Print the char, Will convert 111 to 'o'. Using 4 will just print 111
    syscall

    nl()

    # LOAD HALF WORDS
    # To use the lh and lhu instructions, we must load the addres (not the word) into a register
    la $t0, half_word_test # Load our word value into $t0 (0x0337f980)

    # Loading a half word will load only 16-bits of the 32-bit word we have above.
    # Not specifying an offset will only load the lower half-word
    lhu $t1, ($t0) # Loads 0xf980 into $t1 => 0x0000f980

    print_str(lbl_lh)
    print_hex($t1)
    nl()

    lh $t2, ($t0) # Loads a sign extended version of the one above => 0xfffff980

    # To load the second half of the word, we will set an offset of 2 (half-words and aligned at multiples of 2)
    lhu $t3, 2($t0) # $t2 = 0x00000337

    print_str(lbl_lh)
    print_hex($t3)
