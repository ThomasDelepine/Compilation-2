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
	li $t6, 37
	li $t4, 0
	li $t2, 10
	li $t5, 32
	addi $t3, $t6, 1
	slt $t3, $t4, $t3
	b __lab_2
__lab_3:
	li $t3, 0
	addi $t7, $t6, 1
	slt $t7, $t3, $t7
	b __lab_4
__lab_5:
	mul $t8, $t4, $t4
	mul $t7, $t3, $t3
	add $t8, $t8, $t7
	mul $t7, $t6, $t6
	slt $t7, $t8, $t7
	bnez $t7, __lab_6
	li $t7, 35
	move $a0, $t7
	li $v0, 11
	syscall
	b __lab_7
__lab_6:
	li $t7, 46
	move $a0, $t7
	li $v0, 11
	syscall
__lab_7:
	move $a0, $t5
	li $v0, 11
	syscall
	addi $t3, $t3, 1
__lab_4:
	addi $t7, $t6, 1
	slt $t7, $t3, $t7
	bnez $t7, __lab_5
	move $a0, $t2
	li $v0, 11
	syscall
	addi $t3, $t4, 1
	move $t4, $t3
__lab_2:
	addi $t3, $t6, 1
	slt $t3, $t4, $t3
	bnez $t3, __lab_3
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
