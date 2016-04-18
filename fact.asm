.text
fact:
li $1,0
lw $1,0($1)
addi $1,$1,-1
sw $0,0($1)
li $0,0
sw $1,0($0)
lw $0,0($1)
slti $1,$0,2
beq $1,$0,L1
li $1,0
lw $1,0($1)
addi $1,1
li $0,0
sw $1,0($0) 
li $0,1
j L2P2

L1:
addi $0,$0,-1
li $1,2
sw $0,0($1)
li $1,1
lw $0,0($1)
addi $0,$0,1
sw $0,0($1)
li $1,2
lw $0,0($1)
j fact

L2P2:
li $1,0
lw $1,0($1)
#pseudoinstruction
mul $0,$0,$1 
li $1,3
sw $0,0($1)
li $1,0
lw $1,0($1)
addi $1,$1,1
li $0,0
sw $0,0($1)
li $0,3
lw $0,0($0)
j L2P2