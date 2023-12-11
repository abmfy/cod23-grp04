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
lh	a4,0(ra)
li	t2,255
bne	a4,t2,fail

test_3:
li	gp,3
li	a5,-256
auipc	ra,0x2
addi	ra,ra,-236 # begin_signature
lh	a4,2(ra)
li	t2,-256
bne	a4,t2,fail

test_4:
li	gp,4
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x2
addi	ra,ra,-268 # begin_signature
lh	a4,4(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail

test_5:
li	gp,5
lui	a5,0xfffff
addi	a5,a5,15 # _end+0x7fffcfff
auipc	ra,0x2
addi	ra,ra,-304 # begin_signature
lh	a4,6(ra)
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fffcfff
bne	a4,t2,fail

test_6:
li	gp,6
li	a5,255
auipc	ra,0x2
addi	ra,ra,-330 # tdat4
lh	a4,-6(ra)
li	t2,255
bne	a4,t2,fail

test_7:
li	gp,7
li	a5,-256
auipc	ra,0x2
addi	ra,ra,-358 # tdat4
lh	a4,-4(ra)
li	t2,-256
bne	a4,t2,fail

test_8:
li	gp,8
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x2
addi	ra,ra,-390 # tdat4
lh	a4,-2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail

test_9:
li	gp,9
lui	a5,0xfffff
addi	a5,a5,15 # _end+0x7fffcfff
auipc	ra,0x2
addi	ra,ra,-426 # tdat4
lh	a4,0(ra)
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fffcfff
bne	a4,t2,fail

test_10:
li	gp,10
auipc	ra,0x2
addi	ra,ra,-460 # begin_signature
addi	ra,ra,-32
lh	t0,32(ra)
li	t2,255
bne	t0,t2,fail

test_11:
li	gp,11
auipc	ra,0x2
addi	ra,ra,-488 # begin_signature
addi	ra,ra,-5
lh	t0,7(ra)
li	t2,-256
bne	t0,t2,fail

test_12:
li	gp,12
li	tp,0
auipc	ra,0x2
addi	ra,ra,-518 # tdat2
lh	a4,2(ra)
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
addi	ra,ra,-564 # tdat3
lh	a4,2(ra)
nop
mv	t1,a4
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fffcfff
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_13+0x8

test_14:
li	gp,14
li	tp,0
auipc	ra,0x2
addi	ra,ra,-620 # begin_signature
lh	a4,2(ra)
nop
nop
mv	t1,a4
li	t2,-256
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_14+0x8

test_15:
li	gp,15
li	tp,0
auipc	ra,0x2
addi	ra,ra,-670 # tdat2
lh	a4,2(ra)
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
addi	ra,ra,-712 # tdat3
nop
lh	a4,2(ra)
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fffcfff
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_16+0x8

test_17:
li	gp,17
li	tp,0
auipc	ra,0x2
addi	ra,ra,-764 # begin_signature
nop
nop
lh	a4,2(ra)
li	t2,-256
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_17+0x8

test_18:
li	gp,18
auipc	t0,0x2
addi	t0,t0,-808 # begin_signature
lh	sp,0(t0)
li	sp,2
li	t2,2
bne	sp,t2,fail

test_19:
li	gp,19
auipc	t0,0x2
addi	t0,t0,-836 # begin_signature
lh	sp,0(t0)
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
