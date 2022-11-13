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
	addi $sp, $sp, -60
	li $t7, 0
	li $t0, 1
	addi $sp, $sp, -8
	sw $t0, 0($sp)
	addi $sp, $sp, 8
	li $t0, 2
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	addi $sp, $sp, 12
	li $s4, 3
	li $s3, 4
	li $s2, 5
	li $s1, 6
	li $s0, 7
	li $a3, 8
	li $a2, 9
	li $t0, 10
	addi $sp, $sp, -44
	sw $t0, 0($sp)
	addi $sp, $sp, 44
	li $t0, 11
	addi $sp, $sp, -48
	sw $t0, 0($sp)
	addi $sp, $sp, 48
	li $t0, 12
	addi $sp, $sp, -52
	sw $t0, 0($sp)
	addi $sp, $sp, 52
	li $t0, 13
	addi $sp, $sp, -56
	sw $t0, 0($sp)
	addi $sp, $sp, 56
	li $t0, 14
	addi $sp, $sp, -60
	sw $t0, 0($sp)
	addi $sp, $sp, 60
	li $t0, 15
	addi $sp, $sp, -64
	sw $t0, 0($sp)
	addi $sp, $sp, 64
	li $t0, 16
	addi $sp, $sp, -40
	sw $t0, 0($sp)
	addi $sp, $sp, 40
	li $t0, 17
	addi $sp, $sp, -36
	sw $t0, 0($sp)
	addi $sp, $sp, 36
	li $t0, 18
	addi $sp, $sp, -32
	sw $t0, 0($sp)
	addi $sp, $sp, 32
	li $t0, 19
	addi $sp, $sp, -28
	sw $t0, 0($sp)
	addi $sp, $sp, 28
	li $t0, 20
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	addi $sp, $sp, 24
	li $t0, 21
	addi $sp, $sp, -20
	sw $t0, 0($sp)
	addi $sp, $sp, 20
	li $t0, 22
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	addi $sp, $sp, 16
	li $t6, 23
	li $t5, 24
	li $t4, 25
	li $t3, 26
	li $s7, 27
	li $s6, 28
	li $s5, 29
	addi $t7, $t7, 65
	move $a0, $t7
	li $v0, 11
	syscall
	addi $sp, $sp, -8
	lw $t0, 0($sp)
	addi $sp, $sp, 8
	addi $t7, $t0, 65
	move $a0, $t7
	li $v0, 11
	syscall
	addi $sp, $sp, -12
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	addi $t7, $t0, 65
	move $a0, $t7
	li $v0, 11
	syscall
	addi $s4, $s4, 65
	move $a0, $s4
	li $v0, 11
	syscall
	addi $s3, $s3, 65
	move $a0, $s3
	li $v0, 11
	syscall
	addi $s2, $s2, 65
	move $a0, $s2
	li $v0, 11
	syscall
	addi $s1, $s1, 65
	move $a0, $s1
	li $v0, 11
	syscall
	addi $s0, $s0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	addi $a3, $a3, 65
	move $a0, $a3
	li $v0, 11
	syscall
	addi $a2, $a2, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -44
	lw $t0, 0($sp)
	addi $sp, $sp, 44
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -48
	lw $t0, 0($sp)
	addi $sp, $sp, 48
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -52
	lw $t0, 0($sp)
	addi $sp, $sp, 52
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -56
	lw $t0, 0($sp)
	addi $sp, $sp, 56
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -60
	lw $t0, 0($sp)
	addi $sp, $sp, 60
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -64
	lw $t0, 0($sp)
	addi $sp, $sp, 64
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -40
	lw $t0, 0($sp)
	addi $sp, $sp, 40
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -36
	lw $t0, 0($sp)
	addi $sp, $sp, 36
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -32
	lw $t0, 0($sp)
	addi $sp, $sp, 32
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -28
	lw $t0, 0($sp)
	addi $sp, $sp, 28
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -24
	lw $t0, 0($sp)
	addi $sp, $sp, 24
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -20
	lw $t0, 0($sp)
	addi $sp, $sp, 20
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $sp, $sp, -16
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	addi $a2, $t0, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $t6, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $t5, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $t4, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $t3, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $s7, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $s6, 65
	move $a0, $a2
	li $v0, 11
	syscall
	addi $a2, $s5, 65
	move $a0, $a2
	li $v0, 11
	syscall
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
