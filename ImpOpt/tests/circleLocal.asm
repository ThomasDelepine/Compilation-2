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
	li $s4, 37
	li $s2, 0
	li $s0, 10
	li $s3, 32
	addi $s1, $s4, 1
	slt $s1, $s2, $s1
	b __lab_2
__lab_3:
	li $s1, 0
	addi $s5, $s4, 1
	slt $s5, $s1, $s5
	b __lab_4
__lab_5:
	mul $s6, $s2, $s2
	mul $s5, $s1, $s1
	add $s6, $s6, $s5
	mul $s5, $s4, $s4
	slt $s5, $s6, $s5
	bnez $s5, __lab_6
	li $s5, 35
	move $a0, $s5
	li $v0, 11
	syscall
	b __lab_7
__lab_6:
	li $s5, 46
	move $a0, $s5
	li $v0, 11
	syscall
__lab_7:
	move $a0, $s3
	li $v0, 11
	syscall
	addi $s1, $s1, 1
__lab_4:
	addi $s5, $s4, 1
	slt $s5, $s1, $s5
	bnez $s5, __lab_5
	move $a0, $s0
	li $v0, 11
	syscall
	addi $s1, $s2, 1
	move $s2, $s1
__lab_2:
	addi $s1, $s4, 1
	slt $s1, $s2, $s1
	bnez $s1, __lab_3
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
	lw $ra, 32($sp)
	lw $fp, 36($sp)
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
