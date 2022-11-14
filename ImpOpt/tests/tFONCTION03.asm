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
	move $s0, $t2
	move $s1, $t3
	move $s2, $t4
	move $s3, $t5
	move $s4, $t6
	move $s5, $t7
	move $s6, $t8
	move $s7, $t9
	move $fp, $sp
	jal f1
	jal f2
	jal f3
	la $t2, l
	lw $t2, 0($t2)
	move $a0, $t2
	li $v0, 11
	syscall
	li $t2, 111
	la $a1, o
	sw $t2, 0($a1)
	la $t2, o
	lw $t2, 0($t2)
	move $a0, $t2
	li $v0, 11
	syscall
__lab_4:
	addi $sp, $sp, 4
	move $t2, $s0
	move $t3, $s1
	move $t4, $s2
	move $t5, $s3
	move $t6, $s4
	move $t7, $s5
	move $t8, $s6
	move $t9, $s7
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $sp, $fp
	jr $ra
f1:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	move $s0, $t2
	move $s1, $t3
	move $s2, $t4
	move $s3, $t5
	move $s4, $t6
	move $s5, $t7
	move $s6, $t8
	move $s7, $t9
	move $fp, $sp
	li $t2, 0
	la $a1, h
	sw $t2, 0($a1)
	li $t2, 10
	la $a1, e
	sw $t2, 0($a1)
	li $t2, 20
	la $a1, l
	sw $t2, 0($a1)
	li $t2, 0
	la $a1, o
	sw $t2, 0($a1)
__lab_3:
	addi $sp, $sp, 4
	move $t2, $s0
	move $t3, $s1
	move $t4, $s2
	move $t5, $s3
	move $t6, $s4
	move $t7, $s5
	move $t8, $s6
	move $t9, $s7
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $sp, $fp
	jr $ra
f2:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	move $s0, $t2
	move $s1, $t3
	move $s2, $t4
	move $s3, $t5
	move $s4, $t6
	move $s5, $t7
	move $s6, $t8
	move $s7, $t9
	move $fp, $sp
	la $t3, h
	lw $t3, 0($t3)
	la $t2, e
	lw $t2, 0($t2)
	mul $t2, $t2, 7
	add $t2, $t3, $t2
	addi $t2, $t2, 2
	la $a1, h
	sw $t2, 0($a1)
	la $t2, h
	lw $t2, 0($t2)
	move $a0, $t2
	li $v0, 11
	syscall
	la $t2, e
	lw $t2, 0($t2)
	mul $t2, $t2, 10
	addi $t2, $t2, 1
	la $a1, e
	sw $t2, 0($a1)
	la $t2, e
	lw $t2, 0($t2)
	move $a0, $t2
	li $v0, 11
	syscall
__lab_2:
	addi $sp, $sp, 4
	move $t2, $s0
	move $t3, $s1
	move $t4, $s2
	move $t5, $s3
	move $t6, $s4
	move $t7, $s5
	move $t8, $s6
	move $t9, $s7
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $sp, $fp
	jr $ra
f3:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	move $s0, $t2
	move $s1, $t3
	move $s2, $t4
	move $s3, $t5
	move $s4, $t6
	move $s5, $t7
	move $s6, $t8
	move $s7, $t9
	move $fp, $sp
	li $t2, 108
	la $a1, l
	sw $t2, 0($a1)
	la $t2, l
	lw $t2, 0($t2)
	move $a0, $t2
	li $v0, 11
	syscall
__lab_1:
	addi $sp, $sp, 4
	move $t2, $s0
	move $t3, $s1
	move $t4, $s2
	move $t5, $s3
	move $t6, $s4
	move $t7, $s5
	move $t8, $s6
	move $t9, $s7
	lw $ra, 0($sp)
	lw $fp, 4($sp)
	move $sp, $fp
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
