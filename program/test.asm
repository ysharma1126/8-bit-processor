.data
string_pointer 10100110
num 010
length 1011
.text
main:li $0,string_pointer
addi $0,$0,001
j exit
li $1,01101001
exit:addi $0,$0,001
