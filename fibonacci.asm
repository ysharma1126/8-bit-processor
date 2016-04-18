.text
fib: 
li $1, 1
sw $0, 0($1)
li $1,2
li $0,0
sw $0,0($1)
li $1,4
li $0,0
sw $0,0($1)

loop:
li $0,2
li $1,3
lw $0,0($0)
lw $1,0($1)
add $0,$1
li $1,5
sw $0,0($1)
li $1,3
lw $0,0($1)
li $1,2
sw $0,0($1)
li $1,5
lw $0,0($1)
li $1,3
sw $0,0($1)
li $1,4
lw $0,0($1)
addi $0,$0,1
sw $0,0($1)
li $1,3
lw $1,0($1)
beq $0,$1,exit
j loop

exit:
#######
