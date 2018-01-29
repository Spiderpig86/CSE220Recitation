##################

.data

    hello_world: .asciiz "hello world"

.text
    la $a0, hello_world
    li $v0, 4
    syscall