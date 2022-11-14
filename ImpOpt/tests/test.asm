.data
retour:
	.word 0
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
	sw $t9, 0($sp)
	sw $t8, -4($sp)
	sw $t7, -8($sp)
	sw $t6, -12($sp)
	sw $t5, -16($sp)
	sw $t4, -20($sp)
	sw $t3, -24($sp)
	sw $t2, -28($sp)
	sw $fp, -32($sp)
	sw $ra, -36($sp)
	subi $fp, $sp, 32
	subi $sp, $sp, 40
	li $t3, 24
	li $t5, 0
	li $t1, 10
	la $gp, retour
	sw $t1, 0($gp)
	li $t4, 32
	b __lab_4
__lab_5:
	li $t6, 0
	b __lab_6
__lab_7:
	mul $t1, $t5, $t5
	mul $t2, $t6, $t6
	add $t1, $t1, $t2
	sw $a3, 0($sp)
	subi $sp, $sp, 4
	sw $a2, 0($sp)
	subi $sp, $sp, 4
	li $a2, 3
	addi $t2, $t3, 1
	sw $a1, 0($sp)
	subi $sp, $sp, 4
	move $a1, $t2
	jal return_arg
	addi $sp, $sp, 44
	sw $a3, 0($sp)
	subi $sp, $sp, 4
	sw $a2, 0($sp)
	subi $sp, $sp, 4
	li $a2, 4
	addi $t2, $t3, 1
	sw $a1, 0($sp)
	subi $sp, $sp, 4
	move $a1, $t2
	jal return_arg
	addi $sp, $sp, 44
	mul $t2, $v0, $v0
	slt $t1, $t1, $t2
	bnez $t1, __lab_8
	li $a0, 35
	li $v0, 11
	syscall
	b __lab_9
__lab_8:
	li $a0, 46
	li $v0, 11
	syscall
__lab_9:
	move $a0, $t4
	li $v0, 11
	syscall
	addi $t6, $t6, 1
	li $t1, 10
	la $gp, retour
	sw $t1, 0($gp)
__lab_6:
	sw $a2, 0($sp)
	subi $sp, $sp, 4
	addi $t1, $t3, 1
	sw $a1, 0($sp)
	subi $sp, $sp, 4
	move $a1, $t1
	jal return_arg
	addi $sp, $sp, 44
	slt $t1, $t6, $v0
	bnez $t1, __lab_7
	li $t0, 6
	sw $t0, 0($sp)
	subi $sp, $sp, 4
	li $t0, 5
	sw $t0, 0($sp)
	subi $sp, $sp, 4
	la $gp, retour
	lw $t1, 0($gp)
	sw $t1, 0($sp)
	subi $sp, $sp, 4
	li $t0, 3
	sw $t0, 0($sp)
	subi $sp, $sp, 4
	sw $a3, 0($sp)
	subi $sp, $sp, 4
	li $a3, 2
	sw $a2, 0($sp)
	subi $sp, $sp, 4
	li $a2, 4
	sw $a1, 0($sp)
	subi $sp, $sp, 4
	li $a1, 4
	jal print_return
	addi $sp, $sp, 44
	move $a0, $v0
	li $v0, 11
	syscall
	addi $t5, $t5, 1
	li $t4, 32
__lab_4:
	sw $a2, 0($sp)
	subi $sp, $sp, 4
	addi $t1, $t3, 1
	sw $a1, 0($sp)
	subi $sp, $sp, 4
	move $a1, $t1
	jal return_arg
	addi $sp, $sp, 44
	slt $t1, $t5, $v0
	bnez $t1, __lab_5
__lab_3:
	move $sp, $fp
	lw $t2, 4($fp)
	lw $t3, 8($fp)
	lw $t4, 12($fp)
	lw $t5, 16($fp)
	lw $t6, 20($fp)
	lw $t7, 24($fp)
	lw $t8, 28($fp)
	lw $t9, 32($fp)
	lw $a1, 36($fp)
	lw $a2, 40($fp)
	lw $a3, 44($fp)
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
print_return:
	sw $t9, 0($sp)
	sw $t8, -4($sp)
	sw $t7, -8($sp)
	sw $t6, -12($sp)
	sw $t5, -16($sp)
	sw $t4, -20($sp)
	sw $t3, -24($sp)
	sw $t2, -28($sp)
	sw $fp, -32($sp)
	sw $ra, -36($sp)
	subi $fp, $sp, 32
	subi $sp, $sp, 40
	lw $v0, 60($sp)
	b __lab_2
__lab_2:
	move $sp, $fp
	lw $t2, 4($fp)
	lw $t3, 8($fp)
	lw $t4, 12($fp)
	lw $t5, 16($fp)
	lw $t6, 20($fp)
	lw $t7, 24($fp)
	lw $t8, 28($fp)
	lw $t9, 32($fp)
	lw $a1, 36($fp)
	lw $a2, 40($fp)
	lw $a3, 44($fp)
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra
return_arg:
	sw $t9, 0($sp)
	sw $t8, -4($sp)
	sw $t7, -8($sp)
	sw $t6, -12($sp)
	sw $t5, -16($sp)
	sw $t4, -20($sp)
	sw $t3, -24($sp)
	sw $t2, -28($sp)
	sw $fp, -32($sp)
	sw $ra, -36($sp)
	subi $fp, $sp, 32
	subi $sp, $sp, 40
	move $v0, $a1
	b __lab_1
__lab_1:
	move $sp, $fp
	lw $t2, 4($fp)
	lw $t3, 8($fp)
	lw $t4, 12($fp)
	lw $t5, 16($fp)
	lw $t6, 20($fp)
	lw $t7, 24($fp)
	lw $t8, 28($fp)
	lw $t9, 32($fp)
	lw $a1, 36($fp)
	lw $a2, 40($fp)
	lw $a3, 44($fp)
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
