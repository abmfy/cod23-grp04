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
auipc	ra,0x2
addi	ra,ra,-204 # begin_signature
li	sp,170
auipc	a5,0x0
addi	a5,a5,20 # test_2+0x24
sh	sp,0(ra)
lh	a4,0(ra)
j	test_2+0x28
mv	a4,sp
li	t2,170
bne	a4,t2,fail

test_3:
li	gp,3
auipc	ra,0x2
addi	ra,ra,-252 # begin_signature
lui	sp,0xffffb
addi	sp,sp,-1536 # _end+0x7fff89e0
auipc	a5,0x0
addi	a5,a5,20 # test_3+0x28
sh	sp,2(ra)
lh	a4,2(ra)
j	test_3+0x2c
mv	a4,sp
lui	t2,0xffffb
addi	t2,t2,-1536 # _end+0x7fff89e0
bne	a4,t2,fail

test_4:
li	gp,4
auipc	ra,0x2
addi	ra,ra,-308 # begin_signature
lui	sp,0xbeef1
addi	sp,sp,-1376 # _end+0x3eeeea80
auipc	a5,0x0
addi	a5,a5,20 # test_4+0x28
sh	sp,4(ra)
lw	a4,4(ra)
j	test_4+0x2c
mv	a4,sp
lui	t2,0xbeef1
addi	t2,t2,-1376 # _end+0x3eeeea80
bne	a4,t2,fail

test_5:
li	gp,5
auipc	ra,0x2
addi	ra,ra,-364 # begin_signature
lui	sp,0xffffa
addi	sp,sp,10 # _end+0x7fff7fea
auipc	a5,0x0
addi	a5,a5,20 # test_5+0x28
sh	sp,6(ra)
lh	a4,6(ra)
j	test_5+0x2c
mv	a4,sp
lui	t2,0xffffa
addi	t2,t2,10 # _end+0x7fff7fea
bne	a4,t2,fail

test_6:
li	gp,6
auipc	ra,0x2
addi	ra,ra,-406 # tdat8
li	sp,170
auipc	a5,0x0
addi	a5,a5,20 # test_6+0x24
sh	sp,-6(ra)
lh	a4,-6(ra)
j	test_6+0x28
mv	a4,sp
li	t2,170
bne	a4,t2,fail

test_7:
li	gp,7
auipc	ra,0x2
addi	ra,ra,-454 # tdat8
lui	sp,0xffffb
addi	sp,sp,-1536 # _end+0x7fff89e0
auipc	a5,0x0
addi	a5,a5,20 # test_7+0x28
sh	sp,-4(ra)
lh	a4,-4(ra)
j	test_7+0x2c
mv	a4,sp
lui	t2,0xffffb
addi	t2,t2,-1536 # _end+0x7fff89e0
bne	a4,t2,fail

test_8:
li	gp,8
auipc	ra,0x2
addi	ra,ra,-510 # tdat8
lui	sp,0x1
addi	sp,sp,-1376 # _start-0x7ffff560
auipc	a5,0x0
addi	a5,a5,20 # test_8+0x28
sh	sp,-2(ra)
lh	a4,-2(ra)
j	test_8+0x2c
mv	a4,sp
lui	t2,0x1
addi	t2,t2,-1376 # _start-0x7ffff560
bne	a4,t2,fail

test_9:
li	gp,9
auipc	ra,0x2
addi	ra,ra,-566 # tdat8
lui	sp,0xffffa
addi	sp,sp,10 # _end+0x7fff7fea
auipc	a5,0x0
addi	a5,a5,20 # test_9+0x28
sh	sp,0(ra)
lh	a4,0(ra)
j	test_9+0x2c
mv	a4,sp
lui	t2,0xffffa
addi	t2,t2,10 # _end+0x7fff7fea
bne	a4,t2,fail

test_10:
li	gp,10
auipc	ra,0x2
addi	ra,ra,-620 # tdat9
lui	sp,0x12345
addi	sp,sp,1656 # _start-0x6dcba988
addi	tp,ra,-32
sh	sp,32(tp) # _start-0x7fffffe0
lh	t0,0(ra)
lui	t2,0x5
addi	t2,t2,1656 # _start-0x7fffa988
bne	t0,t2,fail

test_11:
li	gp,11
auipc	ra,0x2
addi	ra,ra,-664 # tdat9
lui	sp,0x3
addi	sp,sp,152 # _start-0x7fffcf68
addi	ra,ra,-5
sh	sp,7(ra)
auipc	tp,0x2
addi	tp,tp,-686 # tdat10
lh	t0,0(tp) # _start-0x80000000
lui	t2,0x3
addi	t2,t2,152 # _start-0x7fffcf68
bne	t0,t2,fail

test_12:
li	gp,12
li	tp,0
lui	ra,0xffffd
addi	ra,ra,-803 # _end+0x7fffacbd
auipc	sp,0x2
addi	sp,sp,-744 # begin_signature
sh	ra,0(sp)
lh	a4,0(sp)
lui	t2,0xffffd
addi	t2,t2,-803 # _end+0x7fffacbd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_12+0x8

test_13:
li	gp,13
li	tp,0
lui	ra,0xffffc
addi	ra,ra,-819 # _end+0x7fff9cad
auipc	sp,0x2
addi	sp,sp,-800 # begin_signature
nop
sh	ra,2(sp)
lh	a4,2(sp)
lui	t2,0xffffc
addi	t2,t2,-819 # _end+0x7fff9cad
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_13+0x8

test_14:
li	gp,14
li	tp,0
lui	ra,0xffffc
addi	ra,ra,-1076 # _end+0x7fff9bac
auipc	sp,0x2
addi	sp,sp,-860 # begin_signature
nop
nop
sh	ra,4(sp)
lh	a4,4(sp)
lui	t2,0xffffc
addi	t2,t2,-1076 # _end+0x7fff9bac
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_14+0x8

test_15:
li	gp,15
li	tp,0
lui	ra,0xffffb
addi	ra,ra,-1092 # _end+0x7fff8b9c
nop
auipc	sp,0x2
addi	sp,sp,-928 # begin_signature
sh	ra,6(sp)
lh	a4,6(sp)
lui	t2,0xffffb
addi	t2,t2,-1092 # _end+0x7fff8b9c
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_15+0x8

test_16:
li	gp,16
li	tp,0
lui	ra,0xffffb
addi	ra,ra,-1349 # _end+0x7fff8a9b
nop
auipc	sp,0x2
addi	sp,sp,-988 # begin_signature
nop
sh	ra,8(sp)
lh	a4,8(sp)
lui	t2,0xffffb
addi	t2,t2,-1349 # _end+0x7fff8a9b
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_16+0x8

test_17:
li	gp,17
li	tp,0
lui	ra,0xffffe
addi	ra,ra,-1365 # _end+0x7fffba8b
nop
nop
auipc	sp,0x2
addi	sp,sp,-1056 # begin_signature
sh	ra,10(sp)
lh	a4,10(sp)
lui	t2,0xffffe
addi	t2,t2,-1365 # _end+0x7fffba8b
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_17+0x8

test_18:
li	gp,18
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1104 # begin_signature
lui	ra,0x2
addi	ra,ra,563 # _start-0x7fffddcd
sh	ra,0(sp)
lh	a4,0(sp)
lui	t2,0x2
addi	t2,t2,563 # _start-0x7fffddcd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_18+0x8

test_19:
li	gp,19
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1160 # begin_signature
lui	ra,0x1
addi	ra,ra,547 # _start-0x7fffeddd
nop
sh	ra,2(sp)
lh	a4,2(sp)
lui	t2,0x1
addi	t2,t2,547 # _start-0x7fffeddd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_19+0x8

test_20:
li	gp,20
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1220 # begin_signature
lui	ra,0x1
addi	ra,ra,290 # _start-0x7fffeede
nop
nop
sh	ra,4(sp)
lh	a4,4(sp)
lui	t2,0x1
addi	t2,t2,290 # _start-0x7fffeede
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_20+0x8

test_21:
li	gp,21
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1284 # begin_signature
nop
li	ra,274
sh	ra,6(sp)
lh	a4,6(sp)
li	t2,274
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_21+0x8

test_22:
li	gp,22
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1336 # begin_signature
nop
li	ra,17
nop
sh	ra,8(sp)
lh	a4,8(sp)
li	t2,17
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_22+0x8

test_23:
li	gp,23
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1392 # begin_signature
nop
nop
lui	ra,0x3
addi	ra,ra,1 # _start-0x7fffcfff
sh	ra,10(sp)
lh	a4,10(sp)
lui	t2,0x3
addi	t2,t2,1 # _start-0x7fffcfff
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_23+0x8
lui	a0,0xc
addi	a0,a0,-273 # _start-0x7fff4111
auipc	a1,0x2
addi	a1,a1,-1456 # begin_signature
sh	a0,6(a1)
bne	zero,gp,pass

.data

begin_signature:
.half 0xbeef

tdat2:
.half 0xbeef

tdat3:
.half 0xbeef

tdat4:
.half 0xbeef

tdat5:
.half 0xbeef

tdat6:
.half 0xbeef

tdat7:
.half 0xbeef

tdat8:
.half 0xbeef

tdat9:
.half 0xbeef

tdat10:
.half 0xbeef
