.globl main
.text

main:
#############################################################
##
## below is the body of a do while loop 
##
#############################################################
li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall

move $t2, $v0



##############################################################
##
##  //For loop, equivalen to While loop condition is checked before body of loop is executed
##  
##  int summation = 0;
##  for( int i = 1; i <= n; i++){
##  	summation += i;
##  } 
##	System.out.println("The sum of 1 to 10 is " + summation);
##
##  Trivia: more efficient way to compute this? 
##  Think from your math classes [( n * (n + 1) ) / 2] 
##
##############################################################

li $t0, 0 #t0 will be the summation variable above
li $t1, 1 #t1 will be i used in the for loop

# $t2 is n for the above loop basically 

# for loop label
for:
	bgt $t1, $t2, for_loop_done #check condition i <= 10 ? continue : for_loop_done
	add $t0, $t0, $t1	#add i to summation
	addi $t1, $t1, 1	#increment i (i++)
	j for 	#loop back to the top of for to repeat

for_loop_done:
	
	# print out "The sum of 1 to 10 is "
	li $v0, 4		#system call to print string
	la $a0, label	#address of label to print
	syscall	
	
	# print out the summation
	li $v0, 1		#system call to print integer
	move $a0, $t0	#value to print
	syscall
	
# ask the user if they want to run the program again
li $v0, 4	#system call to print string
la $a0, prompt2
syscall
# get the users input
li $v0, 5	#system call to read integer
syscall


##############################################################
##
##  In do while, you basically execute the body of the loop once and 
##  check the condition at the end befoe looping here we ask the user 
##  if they want to repeat the program at the end and check 
##
##############################################################


#do while loop that checks after executing the body once
beq $v0, 0, end 
j main
  
end:
# End the program	
li $v0, 10	#system call to end program
syscall


.data
label: .asciiz "The sum is: "
prompt: .asciiz "\nEnter a positive number: "
prompt2: .asciiz "\nRepeat? (0 = No, 1 = Yes) "

 
