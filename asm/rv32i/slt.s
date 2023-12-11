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
li	sp,0
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_3:
li	gp,3
li	ra,1
li	sp,1
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_4:
li	gp,4
li	ra,3
li	sp,7
slt	a4,ra,sp
li	t2,1
bne	a4,t2,fail

test_5:
li	gp,5
li	ra,7
li	sp,3
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_6:
li	gp,6
li	ra,0
lui	sp,0xffff8
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_7:
li	gp,7
lui	ra,0x80000
li	sp,0
slt	a4,ra,sp
li	t2,1
bne	a4,t2,fail

test_8:
li	gp,8
lui	ra,0x80000
lui	sp,0xffff8
slt	a4,ra,sp
li	t2,1
bne	a4,t2,fail

test_9:
li	gp,9
li	ra,0
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
slt	a4,ra,sp
li	t2,1
bne	a4,t2,fail

test_10:
li	gp,10
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffdfff
li	sp,0
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_11:
li	gp,11
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffdfff
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_12:
li	gp,12
lui	ra,0x80000
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
slt	a4,ra,sp
li	t2,1
bne	a4,t2,fail

test_13:
li	gp,13
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffdfff
lui	sp,0xffff8
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_14:
li	gp,14
li	ra,0
li	sp,-1
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_15:
li	gp,15
li	ra,-1
li	sp,1
slt	a4,ra,sp
li	t2,1
bne	a4,t2,fail

test_16:
li	gp,16
li	ra,-1
li	sp,-1
slt	a4,ra,sp
li	t2,0
bne	a4,t2,fail

test_17:
li	gp,17
li	ra,14
li	sp,13
slt	ra,ra,sp
li	t2,0
bne	ra,t2,fail

test_18:
li	gp,18
li	ra,11
li	sp,13
slt	sp,ra,sp
li	t2,1
bne	sp,t2,fail

test_19:
li	gp,19
li	ra,13
slt	ra,ra,ra
li	t2,0
bne	ra,t2,fail

test_20:
li	gp,20
li	tp,0
li	ra,11
li	sp,13
slt	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_20+0x8
li	t2,1
bne	t1,t2,fail

test_21:
li	gp,21
li	tp,0
li	ra,14
li	sp,13
slt	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_21+0x8
li	t2,0
bne	t1,t2,fail

test_22:
li	gp,22
li	tp,0
li	ra,12
li	sp,13
slt	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_22+0x8
li	t2,1
bne	t1,t2,fail

test_23:
li	gp,23
li	tp,0
li	ra,14
li	sp,13
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_23+0x8
li	t2,0
bne	a4,t2,fail

test_24:
li	gp,24
li	tp,0
li	ra,11
li	sp,13
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_24+0x8
li	t2,1
bne	a4,t2,fail

test_25:
li	gp,25
li	tp,0
li	ra,15
li	sp,13
nop
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_25+0x8
li	t2,0
bne	a4,t2,fail

test_26:
li	gp,26
li	tp,0
li	ra,10
nop
li	sp,13
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_26+0x8
li	t2,1
bne	a4,t2,fail

test_27:
li	gp,27
li	tp,0
li	ra,16
nop
li	sp,13
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_27+0x8
li	t2,0
bne	a4,t2,fail

test_28:
li	gp,28
li	tp,0
li	ra,9
nop
nop
li	sp,13
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_28+0x8
li	t2,1
bne	a4,t2,fail

test_29:
li	gp,29
li	tp,0
li	sp,13
li	ra,17
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_29+0x8
li	t2,0
bne	a4,t2,fail

test_30:
li	gp,30
li	tp,0
li	sp,13
li	ra,8
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_30+0x8
li	t2,1
bne	a4,t2,fail

test_31:
li	gp,31
li	tp,0
li	sp,13
li	ra,18
nop
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_31+0x8
li	t2,0
bne	a4,t2,fail

test_32:
li	gp,32
li	tp,0
li	sp,13
nop
li	ra,7
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_32+0x8
li	t2,1
bne	a4,t2,fail

test_33:
li	gp,33
li	tp,0
li	sp,13
nop
li	ra,19
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_33+0x8
li	t2,0
bne	a4,t2,fail

test_34:
li	gp,34
li	tp,0
li	sp,13
nop
nop
li	ra,6
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_34+0x8
li	t2,1
bne	a4,t2,fail

test_35:
li	gp,35
li	ra,-1
sgtz	sp,ra
li	t2,0
bne	sp,t2,fail

test_36:
li	gp,36
li	ra,-1
sltz	sp,ra
li	t2,1
bne	sp,t2,fail

test_37:
li	gp,37
sltz	ra,zero
li	t2,0
bne	ra,t2,fail

test_38:
li	gp,38
li	ra,16
li	sp,30
slt	zero,ra,sp
li	t2,0
bne	zero,t2,fail
bne	zero,gp,pass
