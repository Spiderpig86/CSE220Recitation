.data
input_prompt: .asciiz "Enter number of inputs: "
number_prompt: .asciiz "Enter number: "
average_prompt: .asciiz "\nAverage: "

.macro print_label (%label)
la $a0, %label
li $v0, 4
syscall
.end_macro

.macro readAndMoveInt (%reg)
li $v0, 5
syscall
move %reg, $v0
.end_macro

.macro exit
li $v0, 10
syscall
.end_macro

.text
.globl main
main:
	li $t0, 0 # execution count, aka. N
	li $t1, 0 # counter = 0
	li $t2, 0 # sum = 0
	
	print_label(input_prompt)
	
	readAndMoveInt($t0)
	
	EnterAndSumNextInt:
		bge $t1, $t0, calculate_int_average
		print_label(number_prompt)
		li $v0, 5
		syscall
		add  $t2, $t2, $v0
		addi $t1, $t1, 1
		j EnterAndSumNextInt
	calculate_int_average:
		print_label(average_prompt)
		div $t2, $t0
		mflo $a0
		li $v0, 1
		syscall
	exit()
