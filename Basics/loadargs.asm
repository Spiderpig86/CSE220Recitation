##############################
# Sample program for loading in args from the command line
##############################
.data

    ### Argument Properties ###
    # These will store the arguments that will be passed in in the program
    num_args: .word 0
    arg_1: .word 0
    arg_2: .word 0
    arg_3: .word 0

    ### MISC LABELS ###
    num_args_label: .asciiz "Arg Count: "
    arg_1_label: .asciiz "Arg_1: "
    arg_2_label: .asciiz "Arg_2: "
    arg_2_label: .asciiz "Arg_3: "

.text