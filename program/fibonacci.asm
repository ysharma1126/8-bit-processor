.data
zero  00000000
one   00000001
two   00000010
three 00000011
four  00000100
five  00000101
num1  00000011
.text
main:li $0,num1
j fib
fib:li $1,one
sw $0,000($1)
li $1,two
li $0,zero
sw $0,000($1)
li $1,three
li $0,one
sw $0,000($1)
li $1,four
li $0,zero
sw $0,000($1)
j intermediate
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
addi $0,$0,000
intermediate:addi $0,$0,000
loop:li $0,two
li $1,three
lw $0,000($0)
lw $1,000($1)
add $0,$1
li $1,five
sw $0,000($1)
li $1,three
lw $0,000($1)
li $1,two
sw $0,000($1)
li $1,five
lw $0,000($1)
li $1,three
sw $0,000($1)
li $1,four
lw $0,000($1)
addi $0,$0,001
sw $0,000($1)
li $1,one
lw $1,000($1)
beq $0,$1,exit
j loop
exit:li $0,three
lw $0,000($0)
