.data
	x: .word 0
.text
	main:
		li $t0, 1
		sw $t0, x 
	while:
		li $t1, 10
		ble $t0, $t1, loop 
	j fin
	loop:
		li $t2, 1
		add $t0, $t1, $t2
		sw $t0, x 
	j while
fin:
# li $v0, 1
# move $a0, $t0
# syscall
