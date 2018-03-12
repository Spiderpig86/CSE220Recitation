################################################################################
## Test Main
################################################################################
.globl main
.text
main:

	la $a0, test_print_string	# Load address of string for printing
	jal print_string

	la $a0, test_print_string	# Load address of string for string_length
	jal string_length

	move $s0, $v0			# Preserve the string length

	la $a0, nl			# Load address of newline for printing
	jal print_string

	li $v0, 1			# Set syscall to 1 for printing an integer
	move $a0, $s0			# Copy the string length for printing
	syscall
	
	la $a0, nl			# Print the newline char again
	jal print_string

	la $a0, test_print_string
	la $a1, copy_space
	jal string_copy			# Copy test_print_string into copy_space

	la $a0, copy_space		# Print the newly copied string from copy_space
	jal print_string

	li $v0, 10 #exit program
	syscall

################################################################################
## Text Functions
################################################################################

################################################################################
##
## print_string function: this function will print the string
##		$a0-> address of the string to print
##  	there is no return type for this function
##
################################################################################
print_string:
	li $v0, 4	#system call to print string
	syscall
	jr $ra		#return to the caller function

################################################################################
##
## string_length function: this function will return the length of the string
##		$a0-> address of the string to calculate the length of
##		$v0-> the length of the string will be returned here.
##
################################################################################
string_length:
	li $v0, 0 #initialize length of string to be zero
	move $t0, $a0
	string_length_loop:
		lb $t1, 0($t0)		#load the byte at address $t0
		beqz $t1, string_length_loop_done	#check if the byte is zero which means null character
		addi $t0, $t0, 1	#advance the address by one byte
		addi $v0, $v0, 1	#add one to the counter for length of the string
		j string_length_loop	#jump back to top of the loop

	string_length_loop_done:
		#length of string is already computed in $v0 register
		jr $ra #return

################################################################################
##
## sum_five_numbers function: this function is designed to utilize the stack for the fifth argument
## $a0-> number one
## $a1-> number two
## $a2-> number three
## $a3-> number four
## First word on the stack-> number five
## $v0-> will contain the sum of all five numbers
##
################################################################################
sum_five_numbers:
	lw $t0, 0($sp)		#load fifth word off the stack
	addi $sp, $sp, 4 	#pop the stack
	li $v0, 0 		#initialize summation register with zero
	add $v0, $v0, $t0 	#add the sum number five
	add $v0, $v0, $a0 	#add the sum number one
	add $v0, $v0, $a1 	#add the sum number two
	add $v0, $v0, $a2 	#add the sum number three
	add $v0, $v0, $a3 	#add the sum number four
	#$v0 has the sum of all five numbers
	jr $ra #return

################################################################################
##
## string_copy: string copy call string length and then copys strin to the address
##   $a0 string to copy
##   $a1 address to put string
##   return NULL
##   This function is unique because it calls another function so it isnt a leaf
##   function. You have to understand the stack to understand this one.
################################################################################
string_copy:
	#We are calling the string_length function from inside this funciton so what
	#do we need to do.
	#save ra, save the arguments so they are also not lost
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)

	#call string_length function
	jal string_length
	#v0 has the length of string $a0

	#restore arguments from stack and pop stack
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12 #pop the stack

	move $t3, $a0	#make temp reference to char index
	move $t4, $a1	#make temp reference to dest char index

	li $t0, 0	#counter for loop until the length of the loop
	copy_loop:
		beq $t0, $v0, copy_loop_done
		lb $t1, 0($t3)	#load the char from $a0
		sb $t1, 0($t4)	#store the char in the char buffer
		addi $t3, $t3, 1 #advance to next char
		addi $t4, $t4, 1 #advance to next char index to store
		addi $t0, $t0, 1 #increment counter
		j copy_loop
	copy_loop_done:
		sb $zero, 0($t4)	#put the null terminator at the end of the char buffer

		jr $ra #return null because we copied string to buffer



################################################################################
## Data section
################################################################################
.data
nl: .asciiz "\n"
test_print_string: .asciiz "Test print string"
.align 2
copy_space: .space 100
