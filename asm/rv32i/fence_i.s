_start:
beq x0, x0, reset_vector

loop:
beq x0, x0, loop

fail:
lui t0, 0x10000
lb t1, 5(t0)
andi t1, t1, 0x20
beq t1, zero, fail
addi a0, zero, 'F'
sb a0, 0(t0)
beq x0, x0, loop

pass:
lui t0, 0x10000
lb t1, 5(t0)
andi t1, t1, 0x20
beq t1, zero, pass
addi a0, zero, 'P'
sb a0, 0(t0)
beq x0, x0, loop

nop
nop
nop

reset_vector:
li	ra,0
li	sp,0
li	gp,0
li	tp,0
li	t0,0
li	t1,0
li	t2,0
li	s0,0
li	s1,0
li	a0,0
li	a1,0
li	a2,0
li	a3,0
li	a4,0
li	a5,0
li	a6,0
li	a7,0
li	s2,0
li	s3,0
li	s4,0
li	s5,0
li	s6,0
li	s7,0
li	s8,0
li	s9,0
li	s10,0
li	s11,0
li	t3,0
li	t4,0
li	t5,0
li	t6,0
li	a3,111
auipc	a0,0x2
lh	a0,-204(a0) # begin_signature
auipc	a1,0x2
lh	a1,-210(a1) # begin_signature+0x2
nop
nop
nop
nop
nop
nop
nop
nop
nop
auipc	t0,0x2
sh	a0,-252(t0) # begin_signature+0x4
auipc	t0,0x2
sh	a1,-258(t0) # begin_signature+0x6
fence.i
auipc	a5,0x2
addi	a5,a5,-272 # begin_signature+0x4
jalr	t1,a5

test_2:
li	gp,2
nop
li	t2,444
bne	a3,t2,fail
li	a4,100
addi	a4,a4,-1
bnez	a4,test_2+0x14
auipc	t0,0x2
sh	a0,-304(t0) # begin_signature+0xc
auipc	t0,0x2
sh	a1,-310(t0) # begin_signature+0xe
fence.i
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
auipc	a5,0x2
addi	a5,a5,-372 # begin_signature+0xc
jalr	t1,a5

test_3:
li	gp,3
nop
li	t2,777
bne	a3,t2,fail
bne	zero,gp,pass

.data

begin_signature:
addi	a3,a3,333
addi	a3,a3,222
jalr	a5,t1
addi	a3,a3,555
jalr	a5,t1
