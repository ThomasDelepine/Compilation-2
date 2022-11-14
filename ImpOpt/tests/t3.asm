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
	li $t9, 0
	li $t0, 1
	subi $sp, $sp, 0
	sw $t0, 0($sp)
	subi $sp, $sp, 0
	li $t0, 2
	subi $sp, $sp, 4
	sw $t0, 0($sp)
	subi $sp, $sp, -4
	li $t8, 3
	li $t7, 4
	li $t6, 5
	li $t5, 6
	li $t4, 7
	li $t3, 8
	li $t2, 9
	li $t0, 10
	subi $sp, $sp, 36
	sw $t0, 0($sp)
	subi $sp, $sp, -36
	li $t0, 11
	subi $sp, $sp, 40
	sw $t0, 0($sp)
	subi $sp, $sp, -40
	li $t0, 12
	subi $sp, $sp, 44
	sw $t0, 0($sp)
	subi $sp, $sp, -44
	li $t0, 13
	subi $sp, $sp, 48
	sw $t0, 0($sp)
	subi $sp, $sp, -48
	li $t0, 14
	subi $sp, $sp, 52
	sw $t0, 0($sp)
	subi $sp, $sp, -52
	li $t0, 15
	subi $sp, $sp, 56
	sw $t0, 0($sp)
	subi $sp, $sp, -56
	li $t0, 16
	subi $sp, $sp, 60
	sw $t0, 0($sp)
	subi $sp, $sp, -60
	li $t0, 17
	subi $sp, $sp, 64
	sw $t0, 0($sp)
	subi $sp, $sp, -64
	li $t0, 18
	subi $sp, $sp, 68
	sw $t0, 0($sp)
	subi $sp, $sp, -68
	li $t0, 19
	subi $sp, $sp, 72
	sw $t0, 0($sp)
	subi $sp, $sp, -72
	li $t0, 20
	subi $sp, $sp, 76
	sw $t0, 0($sp)
	subi $sp, $sp, -76
	li $t0, 21
	subi $sp, $sp, 80
	sw $t0, 0($sp)
	subi $sp, $sp, -80
	li $t0, 22
	subi $sp, $sp, 84
	sw $t0, 0($sp)
	subi $sp, $sp, -84
	li $t0, 23
	subi $sp, $sp, 32
	sw $t0, 0($sp)
	subi $sp, $sp, -32
	li $t0, 24
	subi $sp, $sp, 28
	sw $t0, 0($sp)
	subi $sp, $sp, -28
	li $t0, 25
	subi $sp, $sp, 24
	sw $t0, 0($sp)
	subi $sp, $sp, -24
	li $t0, 26
	subi $sp, $sp, 20
	sw $t0, 0($sp)
	subi $sp, $sp, -20
	li $t0, 27
	subi $sp, $sp, 16
	sw $t0, 0($sp)
	subi $sp, $sp, -16
	li $t0, 28
	subi $sp, $sp, 12
	sw $t0, 0($sp)
	subi $sp, $sp, -12
	li $t0, 29
	subi $sp, $sp, 8
	sw $t0, 0($sp)
	subi $sp, $sp, -8
	addi $t9, $t9, 65
	move $a0, $t9
	li $v0, 11
	syscall
	subi $sp, $sp, 0
	lw $t0, 0($sp)
	subi $sp, $sp, 0
	addi $t9, $t0, 65
	move $a0, $t9
	li $v0, 11
	syscall
	subi $sp, $sp, 4
	lw $t0, 0($sp)
	subi $sp, $sp, -4
	addi $t9, $t0, 65
	move $a0, $t9
	li $v0, 11
	syscall
	addi $t8, $t8, 65
	move $a0, $t8
	li $v0, 11
	syscall
	addi $t7, $t7, 65
	move $a0, $t7
	li $v0, 11
	syscall
	addi $t6, $t6, 65
	move $a0, $t6
	li $v0, 11
	syscall
	addi $t5, $t5, 65
	move $a0, $t5
	li $v0, 11
	syscall
	addi $t4, $t4, 65
	move $a0, $t4
	li $v0, 11
	syscall
	addi $t3, $t3, 65
	move $a0, $t3
	li $v0, 11
	syscall
	addi $t2, $t2, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 36
	lw $t0, 0($sp)
	subi $sp, $sp, -36
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 40
	lw $t0, 0($sp)
	subi $sp, $sp, -40
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 44
	lw $t0, 0($sp)
	subi $sp, $sp, -44
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 48
	lw $t0, 0($sp)
	subi $sp, $sp, -48
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 52
	lw $t0, 0($sp)
	subi $sp, $sp, -52
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 56
	lw $t0, 0($sp)
	subi $sp, $sp, -56
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 60
	lw $t0, 0($sp)
	subi $sp, $sp, -60
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 64
	lw $t0, 0($sp)
	subi $sp, $sp, -64
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 68
	lw $t0, 0($sp)
	subi $sp, $sp, -68
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 72
	lw $t0, 0($sp)
	subi $sp, $sp, -72
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 76
	lw $t0, 0($sp)
	subi $sp, $sp, -76
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 80
	lw $t0, 0($sp)
	subi $sp, $sp, -80
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 84
	lw $t0, 0($sp)
	subi $sp, $sp, -84
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 32
	lw $t0, 0($sp)
	subi $sp, $sp, -32
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 28
	lw $t0, 0($sp)
	subi $sp, $sp, -28
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 24
	lw $t0, 0($sp)
	subi $sp, $sp, -24
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 20
	lw $t0, 0($sp)
	subi $sp, $sp, -20
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 16
	lw $t0, 0($sp)
	subi $sp, $sp, -16
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 12
	lw $t0, 0($sp)
	subi $sp, $sp, -12
	addi $t2, $t0, 65
	move $a0, $t2
	li $v0, 11
	syscall
	subi $sp, $sp, 8
	lw $t0, 0($sp)
	subi $sp, $sp, -8
	addi $t2, $t0, 65
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
