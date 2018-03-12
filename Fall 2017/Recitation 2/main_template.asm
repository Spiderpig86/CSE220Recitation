# This macro takes a string and displays it to the standard output
# a sample call for the macro is as follows:
# 	print("some string")
.macro print(%prompt)
.data # telling the assembler that we will be placing a data field on the proceeding lines
string: .asciiz %prompt #creating a label to associate with the string passed into the macro
.text # telling the assembler that we will be writing program instructions on the proceeding lines
la $a0, string # loading the address of the string into $a0, for the syscall
ori $v0, $0, 4 # loading the value 4 into register $v0 (equivalent to: li $v0, 4)
syscall # performing the system call
.end_macro

# Prints an immediate value out to the system console
# sample call:
#	printImm(42) 
.macro printImm(%immediate)
ori $a0, $0, %immediate # loading the immediate value as an integer into $a0
ori $v0, $0, 1 # loading the syscall code (1) for printing an int into $v0
syscall # performing the syscall
.end_macro

# This macro takes a register containing the address of a null terminated string and outputs it to 
# the system console.
# sample call:
#	print_string($t0)
.macro print_string(%reg_src)
ori $a0, %reg_src, 0 # loading the register into $a0
ori $v0, $0, 4 # loading the immediate value (4) into $v0
syscall # performing the syscall
.end_macro

# This macro prints the contents of a register to the console as an integer.
# sample call:
#	printReg($t0)
.macro printReg(%reg_src)
ori $a0, %reg_src, 0 # loading the int value of register source onto $a0
ori $v0, $0, 1 # loading the value to print an int into $v0, for the syscall
syscall # performing the syscall
.end_macro

# This macro handles reading and saving an integer from the console and storing 
# it into the register provided as an argument into this macro.
# sample call:
#	readInt($t0) <-- (after this call $t0 would have the value read from the console)
.macro readInt(%reg_dest)
ori $v0, $0, 5 # loading immediate (5) into register $v0
syscall # performing the syscall
ori %reg_dest, $v0, 0 # storing the value of $v0 into the provided register destination
.end_macro

# This macro handles reading a string from the standard input, and storing 
# the reference to the string in a register provided as the first argument, the second
# argument is the maximum number of bytes (characters) to read from standard input.
# sample call:
#	read_string($t0, 100)
.macro read_string(%reg_dest, %buffer_size)
.data # telling the assembler that we will be placing a data field on the proceeding lines
string: .space %buffer_size # Allocating space to store the string, of size buffer_size
.byte 0 # null terminator for end of string
.text # telling the assembler that we will be writing program instructions on the proceeding lines
la $a0, string # loading the address of the string into $a0
ori $a1, $0, %buffer_size # loading the maximum size of the string into $a1
ori $v0, $0, 8 # syscall for reading a string from standard in
syscall # performaing the syscall
la %reg_dest, string # storing the address of the string read, into the provided register
.end_macro

# This macro will just contain the instructions to terminate the main program
.macro exit()
ori $v0, $0, 10 # loading the value 10 int register $v0 (equivalent to: li $v0, 10)
syscall # performaing the system call
.end_macro


.text
.globl main
main:
	
	terminate:	
		exit()
