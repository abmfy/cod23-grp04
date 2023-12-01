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

test_2:
li	gp,2
li	ra,0
sltiu	a4,ra,0
li	t2,0
bne	a4,t2,fail

test_3:
li	gp,3
li	ra,1
seqz	a4,ra
li	t2,0
bne	a4,t2,fail

test_4:
li	gp,4
li	ra,3
sltiu	a4,ra,7
li	t2,1
bne	a4,t2,fail

test_5:
li	gp,5
li	ra,7
sltiu	a4,ra,3
li	t2,0
bne	a4,t2,fail

test_6:
li	gp,6
li	ra,0
sltiu	a4,ra,-2048
li	t2,1
bne	a4,t2,fail

test_7:
li	gp,7
lui	ra,0x80000
sltiu	a4,ra,0
li	t2,0
bne	a4,t2,fail

test_8:
li	gp,8
lui	ra,0x80000
sltiu	a4,ra,-2048
li	t2,1
bne	a4,t2,fail

test_9:
li	gp,9
li	ra,0
sltiu	a4,ra,2047
li	t2,1
bne	a4,t2,fail

test_10:
li	gp,10
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffdfff
sltiu	a4,ra,0
li	t2,0
bne	a4,t2,fail

test_11:
li	gp,11
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffdfff
sltiu	a4,ra,2047
li	t2,0
bne	a4,t2,fail

test_12:
li	gp,12
lui	ra,0x80000
sltiu	a4,ra,2047
li	t2,0
bne	a4,t2,fail

test_13:
li	gp,13
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffdfff
sltiu	a4,ra,-2048
li	t2,1
bne	a4,t2,fail

test_14:
li	gp,14
li	ra,0
sltiu	a4,ra,-1
li	t2,1
bne	a4,t2,fail

test_15:
li	gp,15
li	ra,-1
seqz	a4,ra
li	t2,0
bne	a4,t2,fail

test_16:
li	gp,16
li	ra,-1
sltiu	a4,ra,-1
li	t2,0
bne	a4,t2,fail

test_17:
li	gp,17
li	ra,11
sltiu	ra,ra,13
li	t2,1
bne	ra,t2,fail

test_18:
li	gp,18
li	tp,0
li	ra,15
sltiu	a4,ra,10
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_18+0x8
li	t2,0
bne	t1,t2,fail

test_19:
li	gp,19
li	tp,0
li	ra,10
sltiu	a4,ra,16
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_19+0x8
li	t2,1
bne	t1,t2,fail

test_20:
li	gp,20
li	tp,0
li	ra,16
sltiu	a4,ra,9
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_20+0x8
li	t2,0
bne	t1,t2,fail

test_21:
li	gp,21
li	tp,0
li	ra,11
sltiu	a4,ra,15
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_21+0x8
li	t2,1
bne	a4,t2,fail

test_22:
li	gp,22
li	tp,0
li	ra,17
nop
sltiu	a4,ra,8
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_22+0x8
li	t2,0
bne	a4,t2,fail

test_23:
li	gp,23
li	tp,0
li	ra,12
nop
nop
sltiu	a4,ra,14
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_23+0x8
li	t2,1
bne	a4,t2,fail

test_24:
li	gp,24
sltiu	ra,zero,-1
li	t2,1
bne	ra,t2,fail

test_25:
li	gp,25
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
sltiu	zero,ra,-1
li	t2,0
bne	zero,t2,fail
bne	zero,gp,pass
