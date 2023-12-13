.globl accumulatorone
.globl accumulatortwo
.globl accumulatorthree
.globl accumulatorfour
.globl accumulatorfive

#Accumulator:
#Inputs: a0 contains a pointer to an array of nonzero integers, terminated with 0
#Output: a0 should return the sum of the elements of the array
#
#Example: Let a0 = [1,2,3,4,5,6,7,0]
#
#         Then the expected output (in a0) is 1+2+3+4+5+6+7=28

#DO NOT EDIT THIS FILE
#We have provided five versions of accumulator. Only one is correct, though all five pass the sanity test above.

accumulatorone:
	lw s0 0(a0)
	beq s0 x0 Endone
	addi sp sp -8
	sw s0 0(sp)
	sw ra 4(sp)
	addi a0 a0 4
	jal accumulatorone
	lw t1 0(sp)
	lw ra 4(sp)
	addi sp sp 8
	add a0 a0 t1
	jr ra
Endone:
	li a0 0
	jr ra

accumulatortwo:
	addi sp sp 4
	sw s0 0(sp)
	li t0 0
	li s0 0
Looptwo:
	slli t1 t0 2
	add t2 a0 t1
	lw t3 0(t2)
	add s0 s0 t3
	addi t0 t0 1
	bnez t3 Looptwo
	j Endtwo
Endtwo:
	mv a0 s0
	lw s0 0(sp)
	addi sp sp -4
	jr ra

accumulatorthree:
	addi sp sp -8
	sw s0 0(sp)
	sw ra 4(sp)
	lw s0 0(a0)
	beq s0 x0 TailCasethree
	addi a0 a0 4
	jal accumulatorthree
	add a0 a0 s0
	j Epiloguethree
TailCasethree:
	mv a0 x0
	j Epiloguethree
Epiloguethree:	
	lw s0 0(sp)
	lw ra 4(sp)
	addi sp sp 8
	jr ra

accumulatorfour:
	lw t1 0(a0)
	beq t1 x0 Endfour
	add t2 t2 t1
	addi a0 a0 4
	j accumulatorfour
Endfour:
	mv a0 t2
	jr ra


accumulatorfive:
	addi sp sp -8
	sw s0 0(sp)
	sw ra 4(sp)
	mv s0 a0
	lw a0 0(a0)
Loopfive:
	addi s0 s0 4
	lw t0 0(s0)
	add a0 a0 t0
	bne t0 x0 Loopfive
	lw s0 0(sp)
	lw ra 4(sp)
	addi sp sp 8
	jr ra
