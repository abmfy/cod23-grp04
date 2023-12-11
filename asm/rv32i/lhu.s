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
li	a5,255
auipc	ra,0x2
addi	ra,ra,-208 # begin_signature
lhu	a4,0(ra)
li	t2,255
bne	a4,t2,fail

test_3:
li	gp,3
lui	a5,0x10
addi	a5,a5,-256 # _start-0x7fff0100
auipc	ra,0x2
addi	ra,ra,-240 # begin_signature
lhu	a4,2(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	a4,t2,fail

test_4:
li	gp,4
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x2
addi	ra,ra,-276 # begin_signature
lhu	a4,4(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail

test_5:
li	gp,5
lui	a5,0xf
addi	a5,a5,15 # _start-0x7fff0ff1
auipc	ra,0x2
addi	ra,ra,-312 # begin_signature
lhu	a4,6(ra)
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	a4,t2,fail

test_6:
li	gp,6
li	a5,255
auipc	ra,0x2
addi	ra,ra,-338 # tdat4
lhu	a4,-6(ra)
li	t2,255
bne	a4,t2,fail

test_7:
li	gp,7
lui	a5,0x10
addi	a5,a5,-256 # _start-0x7fff0100
auipc	ra,0x2
addi	ra,ra,-370 # tdat4
lhu	a4,-4(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	a4,t2,fail

test_8:
li	gp,8
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x2
addi	ra,ra,-406 # tdat4
lhu	a4,-2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail

test_9:
li	gp,9
lui	a5,0xf
addi	a5,a5,15 # _start-0x7fff0ff1
auipc	ra,0x2
addi	ra,ra,-442 # tdat4
lhu	a4,0(ra)
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	a4,t2,fail

test_10:
li	gp,10
auipc	ra,0x2
addi	ra,ra,-476 # begin_signature
addi	ra,ra,-32
lhu	t0,32(ra)
li	t2,255
bne	t0,t2,fail

test_11:
li	gp,11
auipc	ra,0x2
addi	ra,ra,-504 # begin_signature
addi	ra,ra,-5
lhu	t0,7(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	t0,t2,fail

test_12:
li	gp,12
li	tp,0
auipc	ra,0x2
addi	ra,ra,-538 # tdat2
lhu	a4,2(ra)
mv	t1,a4
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_12+0x8

test_13:
li	gp,13
li	tp,0
auipc	ra,0x2
addi	ra,ra,-584 # tdat3
lhu	a4,2(ra)
nop
mv	t1,a4
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_13+0x8

test_14:
li	gp,14
li	tp,0
auipc	ra,0x2
addi	ra,ra,-640 # begin_signature
lhu	a4,2(ra)
nop
nop
mv	t1,a4
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_14+0x8

test_15:
li	gp,15
li	tp,0
auipc	ra,0x2
addi	ra,ra,-694 # tdat2
lhu	a4,2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_15+0x8

test_16:
li	gp,16
li	tp,0
auipc	ra,0x2
addi	ra,ra,-736 # tdat3
nop
lhu	a4,2(ra)
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_16+0x8

test_17:
li	gp,17
li	tp,0
auipc	ra,0x2
addi	ra,ra,-788 # begin_signature
nop
nop
lhu	a4,2(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_17+0x8

test_18:
li	gp,18
auipc	t0,0x2
addi	t0,t0,-836 # begin_signature
lhu	sp,0(t0)
li	sp,2
li	t2,2
bne	sp,t2,fail

test_19:
li	gp,19
auipc	t0,0x2
addi	t0,t0,-864 # begin_signature
lhu	sp,0(t0)
nop
li	sp,2
li	t2,2
bne	sp,t2,fail
bne	zero,gp,pass

.data

begin_signature:
.half 0x00ff

tdat2:
.half 0xff00

tdat3:
.half 0x0ff0

tdat4:
.half 0xf00f
