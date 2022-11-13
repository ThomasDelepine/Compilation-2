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
	li $s0, 10
	li $a3, 0
	li $a2, 10
	la $a1, retour
	sw $a2, 0($a1)
	li $a2, 32
	la $a1, espace
	sw $a2, 0($a1)
	addi $a2, $s0, 1
	slt $a2, $a3, $a2
	b __lab_7
__lab_8:
	sw $a3, 0($sp)
	subi $sp, $sp, 4
	sw $s0, 0($sp)
	subi $sp, $sp, 4
	jal affiche_ligne
	la $a2, retour
	lw $a2, 0($a2)
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $a3, 1
	move $a3, $a2
__lab_7:
	addi $a2, $s0, 1
	slt $a2, $a3, $a2
	bnez $a2, __lab_8
__lab_6:
	move $sp, $fp
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
affiche_ligne:
	sw $fp, 0($sp)
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	subi $sp, $sp, 4
	addi $fp, $sp, 8
	addi $sp, $sp, -8
	li $a3, 0
	addi $sp, $sp, -12
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	addi $s0, $t0, 1
	slt $s0, $a3, $s0
	b __lab_2
__lab_3:
	addi $sp, $sp, -8
	lw $t0, 0($sp)
	addi $sp, $sp, 8
	addi $sp, $sp, -8
	lw $t1, 0($sp)
	addi $sp, $sp, 8
	mul $s1, $t0, $t1
	mul $s0, $a3, $a3
	add $s1, $s1, $s0
	addi $sp, $sp, -12
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	addi $sp, $sp, -12
	lw $t1, 0($sp)
	addi $sp, $sp, 12
	mul $s0, $t0, $t1
	slt $s0, $s1, $s0
	bnez $s0, __lab_4
	li $s0, 35
	move $a0, $s0
	li $v0, 11
	syscall
	b __lab_5
__lab_4:
	li $s0, 46
	move $a0, $s0
	li $v0, 11
	syscall
__lab_5:
	la $s0, espace
	lw $s0, 0($s0)
	move $a0, $s0
	li $v0, 11
	syscall
	addi $a3, $a3, 1
__lab_2:
	addi $sp, $sp, -12
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	addi $s0, $t0, 1
	slt $s0, $a3, $s0
	bnez $s0, __lab_3
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
retour:
	.word 0
espace:
	.word 0
