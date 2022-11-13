.text
	beqz $a0, init_end
	lw $a0, 0($a1)
	jal atoi
init_end:
	move $a0, $v0
	jal main
	li $v0, 10
	syscall
main:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	addi $fp, $sp, 8
	addi $sp, $sp, 0
	jal f1
	jal f2
	jal f3
	la $a2, l
	lw $a2, 0($a2)
	move $a0, $a2
	li $v0, 11
	syscall
	li $a2, 111
	la $a1, o
	sw $a2, 0($a1)
	la $a2, o
	lw $a2, 0($a2)
	move $a0, $a2
	li $v0, 11
	syscall
__lab_4:
	move $sp, $fp
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
f1:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	addi $fp, $sp, 8
	addi $sp, $sp, 0
	li $a2, 0
	la $a1, h
	sw $a2, 0($a1)
	li $a2, 10
	la $a1, e
	sw $a2, 0($a1)
	li $a2, 20
	la $a1, l
	sw $a2, 0($a1)
	li $a2, 0
	la $a1, o
	sw $a2, 0($a1)
__lab_3:
	move $sp, $fp
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
f2:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	addi $fp, $sp, 8
	addi $sp, $sp, 0
	la $a3, h
	lw $a3, 0($a3)
	la $a2, e
	lw $a2, 0($a2)
	mul $a2, $a2, 7
	add $a2, $a3, $a2
	addi $a2, $a2, 2
	la $a1, h
	sw $a2, 0($a1)
	la $a2, h
	lw $a2, 0($a2)
	move $a0, $a2
	li $v0, 11
	syscall
	la $a2, e
	lw $a2, 0($a2)
	mul $a2, $a2, 10
	addi $a2, $a2, 1
	la $a1, e
	sw $a2, 0($a1)
	la $a2, e
	lw $a2, 0($a2)
	move $a0, $a2
	li $v0, 11
	syscall
__lab_2:
	move $sp, $fp
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
f3:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	addi $fp, $sp, 8
	addi $sp, $sp, 0
	li $a2, 108
	la $a1, l
	sw $a2, 0($a1)
	la $a2, l
	lw $a2, 0($a2)
	move $a0, $a2
	li $v0, 11
	syscall
__lab_1:
	move $sp, $fp
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
#built-in atoi
atoi:
	li $v0, 0
atoi_loop:
	lbu $t0, 0($a0)
	beqz $t0, atoi_end
	addi $t0, $t0, -48
	bltz $t0, atoi_error
	bge $t0, 10, atoi_error
	mul $v0, $v0, 10
	add $v0, $v0, $t0
	addi $a0, $a0, 1
	b atoi_loop
atoi_error:
	li $v0, 10
	syscall
atoi_end:
	jr $ra
.data
h:
	.word 0
e:
	.word 0
l:
	.word 0
o:
	.word 0
