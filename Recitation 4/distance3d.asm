# Program demonstrating how to pass in more than 4 args to a function

.data
     # X, Y, and Z points for calculating distance squared
     x1: .word 5
     y1: .word -3
     z1: .word 2
     x2: .word 8
     y2: .word -9
     z2: .word 6
     message: .asciiz "3D squared distance:"
     space: .asciiz " "
     endl: .asciiz "\n"

.text
.globl main
main:
    # Load the values into args
    lw $a0, x1
    lw $a1, y1
    lw $a2, z1
    lw $a3, x2

    # Store extra args in temp registers
    lw $t6, y2
    lw $t7, z2

    # Allocate space in the stack for new args
    addi $sp, $sp, -8
    sw $t6, 0($sp)
    sw $t7, 4($sp)

    # Call the function
    jal distance_3D

    # Free up memory from the stack
    addi $sp, $sp, 8 # Note we do not have to restore the argument registers unless we are using it again

    # Print out the result
    move $s0, $v0
    li $v0, 1
    syscall

    # Exit the program
    li $v0, 10
    syscall

#####################################
# Calculates the squared distance between two points (x1, y1, z1) and (x2, y2, z2)
#
# Arguments:
#   $a0 = x1
#   $a1 = y1
#   $a2 = z1
#   $a3 = x2
#   $t6 = y2
#   $t7 = z2
#
# Return:
#   $v0 = the squared distance of the points
#####################################
distance_3D:
    lw $t0, 0($sp) # Load fifth argument y2
    lw $t1, 4($sp) # Load sixth argument z2
    sub $t2, $a0, $a3 # $t2 = x1 - x2
    sub $t3, $a1, $t0 # $t3 = y1 - y2
    sub $t4, $a2, $t1 # $t4 = z1 - z2
    mul $t2, $t2, $t2 # $t2 = (x1 - x2)^2
    mul $t3, $t3, $t3 # $t3 = (y1 - y2)^2
    mul $t4, $t4, $t4 # $t4 = (z1 - z2)^2
    add $v0, $t2, $t3 # $v0 = (x1 - x2)^2 + (y1 - y2)^2
    add $v0, $v0, $t4 # $v0 += (y1 - y2)^2
    jr $ra