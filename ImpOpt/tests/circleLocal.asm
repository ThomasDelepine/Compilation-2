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
	li $s2, 37
	li $s0, 0
	li $a2, 10
	li $s1, 32
	addi $a3, $s2, 1
	slt $a3, $s0, $a3
	b __lab_2
__lab_3:
	li $a3, 0
	addi $s3, $s2, 1
	slt $s3, $a3, $s3
	b __lab_4
__lab_5:
	mul $s4, $s0, $s0
	mul $s3, $a3, $a3
	add $s4, $s4, $s3
	mul $s3, $s2, $s2
	slt $s3, $s4, $s3
	bnez $s3, __lab_6
	li $s3, 35
	move $a0, $s3
	li $v0, 11
	syscall
	b __lab_7
__lab_6:
	li $s3, 46
	move $a0, $s3
	li $v0, 11
	syscall
__lab_7:
	move $a0, $s1
	li $v0, 11
	syscall
	addi $a3, $a3, 1
__lab_4:
	addi $s3, $s2, 1
	slt $s3, $a3, $s3
	bnez $s3, __lab_5
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a3, $s0, 1
	move $s0, $a3
__lab_2:
	addi $a3, $s2, 1
	slt $a3, $s0, $a3
	bnez $a3, __lab_3
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
