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
	li $s7, 0
	li $t0, 1
	subi $gp, $gp, 0
	sw $t0, 0($gp)
	subi $gp, $gp, 0
	li $t0, 2
	subi $gp, $gp, 4
	sw $t0, 0($gp)
	subi $gp, $gp, -4
	li $s6, 3
	li $s5, 4
	li $s4, 5
	li $s3, 6
	li $s2, 7
	li $s1, 8
	li $s0, 9
	li $t0, 10
	subi $gp, $gp, 36
	sw $t0, 0($gp)
	subi $gp, $gp, -36
	li $t0, 11
	subi $gp, $gp, 40
	sw $t0, 0($gp)
	subi $gp, $gp, -40
	li $t0, 12
	subi $gp, $gp, 44
	sw $t0, 0($gp)
	subi $gp, $gp, -44
	li $t0, 13
	subi $gp, $gp, 48
	sw $t0, 0($gp)
	subi $gp, $gp, -48
	li $t0, 14
	subi $gp, $gp, 52
	sw $t0, 0($gp)
	subi $gp, $gp, -52
	li $t0, 15
	subi $gp, $gp, 56
	sw $t0, 0($gp)
	subi $gp, $gp, -56
	li $t0, 16
	subi $gp, $gp, 60
	sw $t0, 0($gp)
	subi $gp, $gp, -60
	li $t0, 17
	subi $gp, $gp, 64
	sw $t0, 0($gp)
	subi $gp, $gp, -64
	li $t0, 18
	subi $gp, $gp, 68
	sw $t0, 0($gp)
	subi $gp, $gp, -68
	li $t0, 19
	subi $gp, $gp, 72
	sw $t0, 0($gp)
	subi $gp, $gp, -72
	li $t0, 20
	subi $gp, $gp, 76
	sw $t0, 0($gp)
	subi $gp, $gp, -76
	li $t0, 21
	subi $gp, $gp, 80
	sw $t0, 0($gp)
	subi $gp, $gp, -80
	li $t0, 22
	subi $gp, $gp, 84
	sw $t0, 0($gp)
	subi $gp, $gp, -84
	li $t0, 23
	subi $gp, $gp, 32
	sw $t0, 0($gp)
	subi $gp, $gp, -32
	li $t0, 24
	subi $gp, $gp, 28
	sw $t0, 0($gp)
	subi $gp, $gp, -28
	li $t0, 25
	subi $gp, $gp, 24
	sw $t0, 0($gp)
	subi $gp, $gp, -24
	li $t0, 26
	subi $gp, $gp, 20
	sw $t0, 0($gp)
	subi $gp, $gp, -20
	li $t0, 27
	subi $gp, $gp, 16
	sw $t0, 0($gp)
	subi $gp, $gp, -16
	li $t0, 28
	subi $gp, $gp, 12
	sw $t0, 0($gp)
	subi $gp, $gp, -12
	li $t0, 29
	subi $gp, $gp, 8
	sw $t0, 0($gp)
	subi $gp, $gp, -8
	addi $s7, $s7, 65
	move $a0, $s7
	li $v0, 11
	syscall
	subi $gp, $gp, 0
	lw $t0, 0($gp)
	subi $gp, $gp, 0
	addi $s7, $t0, 65
	move $a0, $s7
	li $v0, 11
	syscall
	subi $gp, $gp, 4
	lw $t0, 0($gp)
	subi $gp, $gp, -4
	addi $s7, $t0, 65
	move $a0, $s7
	li $v0, 11
	syscall
	addi $s6, $s6, 65
	move $a0, $s6
	li $v0, 11
	syscall
	addi $s5, $s5, 65
	move $a0, $s5
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
	subi $gp, $gp, 36
	lw $t0, 0($gp)
	subi $gp, $gp, -36
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 40
	lw $t0, 0($gp)
	subi $gp, $gp, -40
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 44
	lw $t0, 0($gp)
	subi $gp, $gp, -44
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 48
	lw $t0, 0($gp)
	subi $gp, $gp, -48
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 52
	lw $t0, 0($gp)
	subi $gp, $gp, -52
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 56
	lw $t0, 0($gp)
	subi $gp, $gp, -56
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 60
	lw $t0, 0($gp)
	subi $gp, $gp, -60
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 64
	lw $t0, 0($gp)
	subi $gp, $gp, -64
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 68
	lw $t0, 0($gp)
	subi $gp, $gp, -68
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 72
	lw $t0, 0($gp)
	subi $gp, $gp, -72
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 76
	lw $t0, 0($gp)
	subi $gp, $gp, -76
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 80
	lw $t0, 0($gp)
	subi $gp, $gp, -80
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 84
	lw $t0, 0($gp)
	subi $gp, $gp, -84
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 32
	lw $t0, 0($gp)
	subi $gp, $gp, -32
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 28
	lw $t0, 0($gp)
	subi $gp, $gp, -28
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 24
	lw $t0, 0($gp)
	subi $gp, $gp, -24
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 20
	lw $t0, 0($gp)
	subi $gp, $gp, -20
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 16
	lw $t0, 0($gp)
	subi $gp, $gp, -16
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 12
	lw $t0, 0($gp)
	subi $gp, $gp, -12
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
	subi $gp, $gp, 8
	lw $t0, 0($gp)
	subi $gp, $gp, -8
	addi $s0, $t0, 65
	move $a0, $s0
	li $v0, 11
	syscall
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
