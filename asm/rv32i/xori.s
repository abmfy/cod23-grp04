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
lui	ra,0xff1
addi	ra,ra,-256 # _start-0x7f00f100
xori	a4,ra,-241
lui	t2,0xff00f
addi	t2,t2,15 # _end+0x7f00d00f
bne	a4,t2,fail

test_3:
li	gp,3
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
xori	a4,ra,240
lui	t2,0xff01
addi	t2,t2,-256 # _start-0x700ff100
bne	a4,t2,fail

test_4:
li	gp,4
lui	ra,0xff1
addi	ra,ra,-1793 # _start-0x7f00f701
xori	a4,ra,1807
lui	t2,0xff1
addi	t2,t2,-16 # _start-0x7f00f010
bne	a4,t2,fail

test_5:
li	gp,5
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700fd00f
xori	a4,ra,240
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700fd0ff
bne	a4,t2,fail

test_6:
li	gp,6
lui	ra,0xff00f
addi	ra,ra,1792 # _end+0x7f00d700
xori	ra,ra,1807
lui	t2,0xff00f
addi	t2,t2,15 # _end+0x7f00d00f
bne	ra,t2,fail

test_7:
li	gp,7
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
xori	a4,ra,240
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_7+0x8
lui	t2,0xff01
addi	t2,t2,-256 # _start-0x700ff100
bne	t1,t2,fail

test_8:
li	gp,8
li	tp,0
lui	ra,0xff1
addi	ra,ra,-1793 # _start-0x7f00f701
xori	a4,ra,1807
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_8+0x8
lui	t2,0xff1
addi	t2,t2,-16 # _start-0x7f00f010
bne	t1,t2,fail

test_9:
li	gp,9
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700fd00f
xori	a4,ra,240
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_9+0x8
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700fd0ff
bne	t1,t2,fail

test_10:
li	gp,10
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
xori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_10+0x8
lui	t2,0xff01
addi	t2,t2,-256 # _start-0x700ff100
bne	a4,t2,fail

test_11:
li	gp,11
li	tp,0
lui	ra,0xff1
addi	ra,ra,-1 # _start-0x7f00f001
nop
xori	a4,ra,15
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_11+0x8
lui	t2,0xff1
addi	t2,t2,-16 # _start-0x7f00f010
bne	a4,t2,fail

test_12:
li	gp,12
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700fd00f
nop
nop
xori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_12+0x8
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700fd0ff
bne	a4,t2,fail

test_13:
li	gp,13
xori	ra,zero,240
li	t2,240
bne	ra,t2,fail

test_14:
li	gp,14
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
xori	zero,ra,1807
li	t2,0
bne	zero,t2,fail
bne	zero,gp,pass
