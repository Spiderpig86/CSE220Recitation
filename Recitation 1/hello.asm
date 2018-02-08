#################################
# Simple hwllo world example
#################################

# The data section is where all memory related variables should be stored to be accessed later.
# Usually we use special load instructions to access data stored in this field
.data

    hello_world: .asciiz "hello world" # Store 

# The text section is the portion of the program where the instructions or the program logic should go
.text
    la $a0, hello_world # Load the address of where the string "hello world" is located in memory
    li $v0, 4 # MIPS in general relies on syscall codes to tell the processor what it should do. In particular, 4 is used to print strings
    syscall # This is the instruction that tells the CPU to execute the given syscall along with the arguments passed into the argument register.