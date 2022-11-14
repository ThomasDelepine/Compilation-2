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
	sw $gp, 0($sp)
	subi $sp, $sp, 4
	sw $s0, 0($sp)
	subi $sp, $sp, 4
	sw $s1, 0($sp)
	subi $sp, $sp, 4
	sw $s2, 0($sp)
	subi $sp, $sp, 4
	sw $s3, 0($sp)
	subi $sp, $sp, 4
	sw $s4, 0($sp)
	subi $sp, $sp, 4
	sw $s5, 0($sp)
	subi $sp, $sp, 4
	sw $s6, 0($sp)
	subi $sp, $sp, 4
	sw $s7, 0($sp)
	subi $sp, $sp, 4
	move $fp, $sp
	move $gp, $sp
	li $s0, 32
	la $a1, espace
	sw $s0, 0($a1)
	li $s0, 10
	sw $s0, 0($sp)
	subi $sp, $sp, 4
	li $s0, 5
	sw $s0, 0($sp)
	subi $sp, $sp, 4
	jal affiche_ligne
__lab_6:
	addi $sp, $sp, 4
	lw $s7, 0($sp)
	lw $s6, 4($sp)
	lw $s5, 8($sp)
	lw $s4, 12($sp)
	lw $s3, 16($sp)
	lw $s2, 20($sp)
	lw $s1, 24($sp)
	lw $s0, 28($sp)
	lw $gp, 32($sp)
	lw $ra, 36($sp)
	lw $fp, 40($sp)
	move $sp, $fp
	jr $ra
affiche_ligne:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	sw $gp, 0($sp)
	subi $sp, $sp, 4
	sw $s0, 0($sp)
	subi $sp, $sp, 4
	sw $s1, 0($sp)
	subi $sp, $sp, 4
	sw $s2, 0($sp)
	subi $sp, $sp, 4
	sw $s3, 0($sp)
	subi $sp, $sp, 4
	sw $s4, 0($sp)
	subi $sp, $sp, 4
	sw $s5, 0($sp)
	subi $sp, $sp, 4
	sw $s6, 0($sp)
	subi $sp, $sp, 4
	sw $s7, 0($sp)
	subi $sp, $sp, 4
	move $fp, $sp
	move $gp, $sp
	li $s1, 0
	subi $gp, $gp, -52
	lw $t0, 0($gp)
	subi $gp, $gp, 52
	addi $s2, $t0, 1
	slt $s2, $s1, $s2
	b __lab_2
__lab_3:
	subi $gp, $gp, -48
	lw $t0, 0($gp)
	subi $gp, $gp, 48
	subi $gp, $gp, -48
	lw $t1, 0($gp)
	subi $gp, $gp, 48
	mul $s3, $t0, $t1
	mul $s2, $s1, $s1
	add $s3, $s3, $s2
	subi $gp, $gp, -52
	lw $t0, 0($gp)
	subi $gp, $gp, 52
	subi $gp, $gp, -52
	lw $t1, 0($gp)
	subi $gp, $gp, 52
	mul $s2, $t0, $t1
	slt $s2, $s3, $s2
	bnez $s2, __lab_4
	li $s2, 35
	move $a0, $s2
	li $v0, 11
	syscall
	b __lab_5
__lab_4:
	li $s2, 46
	move $a0, $s2
	li $v0, 11
	syscall
__lab_5:
	la $s2, espace
	lw $s2, 0($s2)
	move $a0, $s2
	li $v0, 11
	syscall
	addi $s1, $s1, 1
__lab_2:
	subi $gp, $gp, -52
	lw $t0, 0($gp)
	subi $gp, $gp, 52
	addi $s2, $t0, 1
	slt $s2, $s1, $s2
	bnez $s2, __lab_3
__lab_1:
	addi $sp, $sp, 4
	lw $s7, 0($sp)
	lw $s6, 4($sp)
	lw $s5, 8($sp)
	lw $s4, 12($sp)
	lw $s3, 16($sp)
	lw $s2, 20($sp)
	lw $s1, 24($sp)
	lw $s0, 28($sp)
	lw $gp, 32($sp)
	lw $ra, 36($sp)
	lw $fp, 40($sp)
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
espace:
	.word 0
