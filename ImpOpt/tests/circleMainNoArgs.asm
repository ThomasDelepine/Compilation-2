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
	li $t3, 0
	li $t4, 10
	li $t2, 10
	la $a1, retour
	sw $t2, 0($a1)
	li $t2, 32
	la $a1, espace
	sw $t2, 0($a1)
	addi $t2, $t4, 1
	slt $t2, $t3, $t2
	b __lab_7
__lab_8:
	sw $t4, 0($sp)
	subi $sp, $sp, 4
	sw $t3, 0($sp)
	subi $sp, $sp, 4
	jal affiche_ligne
	la $t2, retour
	lw $t2, 0($t2)
	move $a0, $t2
	li $v0, 11
	syscall
	addi $t2, $t3, 1
	move $t3, $t2
__lab_7:
	addi $t2, $t4, 1
	slt $t2, $t3, $t2
	bnez $t2, __lab_8
__lab_6:
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
affiche_ligne:
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
	li $t3, 0
	subi $sp, $sp, -16
	lw $t0, 0($sp)
	subi $sp, $sp, 16
	addi $t4, $t0, 1
	slt $t4, $t3, $t4
	b __lab_2
__lab_3:
	subi $sp, $sp, -12
	lw $t0, 0($sp)
	subi $sp, $sp, 12
	subi $sp, $sp, -12
	lw $t1, 0($sp)
	subi $sp, $sp, 12
	mul $t5, $t0, $t1
	mul $t4, $t3, $t3
	add $t5, $t5, $t4
	subi $sp, $sp, -16
	lw $t0, 0($sp)
	subi $sp, $sp, 16
	subi $sp, $sp, -16
	lw $t1, 0($sp)
	subi $sp, $sp, 16
	mul $t4, $t0, $t1
	slt $t4, $t5, $t4
	bnez $t4, __lab_4
	li $t4, 35
	move $a0, $t4
	li $v0, 11
	syscall
	b __lab_5
__lab_4:
	li $t4, 46
	move $a0, $t4
	li $v0, 11
	syscall
__lab_5:
	la $t4, espace
	lw $t4, 0($t4)
	move $a0, $t4
	li $v0, 11
	syscall
	addi $t3, $t3, 1
__lab_2:
	subi $sp, $sp, -16
	lw $t0, 0($sp)
	subi $sp, $sp, 16
	addi $t4, $t0, 1
	slt $t4, $t3, $t4
	bnez $t4, __lab_3
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
retour:
	.word 0
espace:
	.word 0
