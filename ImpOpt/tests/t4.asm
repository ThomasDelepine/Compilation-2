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
	li $t2, 35
	sw $t2, 0($sp)
	subi $sp, $sp, 4
	jal f
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
f:
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
	subi $sp, $sp, -12
	lw $t0, 0($sp)
	subi $sp, $sp, 12
	move $a0, $t0
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
