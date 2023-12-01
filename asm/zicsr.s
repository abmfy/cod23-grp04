_start:
beq x0, x0, test

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

test:
li t0, 0x114514
csrw mscratch, t0
csrr t1, mscratch
bne t0, t1, fail

test_20:
li gp, 20
csrw mscratch, zero
csrr a0, mscratch
li x7, 0
bne a0, x7, fail

test_21:
li gp, 21
csrrwi a0, mscratch, 0
csrrwi a0, mscratch, 0xF
li x7, 0
bne a0, x7, fail

test_22:
li gp, 22
csrrsi x0, mscratch, 0x10
csrr a0, mscratch
li x7, 0x1f
bne a0, x7, fail

csrwi mscratch, 3

test_2:
li gp, 2
csrr a0, mscratch
li x7, 3
bne a0, x7, fail

test_3:
li gp, 3
csrrci a1, mscratch, 1
li x7, 3
bne a1, x7, fail

test_4:
li gp, 4
csrrsi a2, mscratch, 4
li x7, 2
bne a2, x7, fail

test_5:
li gp, 5
csrrwi a3, mscratch, 2
li x7, 6
bne a3, x7, fail

test_6:
li gp, 6
li a0, 0xbad1dea
csrrw a1, mscratch, a0
li x7, 2
bne a1, x7, fail

test_7:
li gp, 7
li a0, 0x0001dea
csrrc a1, mscratch, a0
li x7, 0xbad1dea
bne a1, x7, fail

test_8:
li gp, 8
li a0, 0x000beef
csrrs a1, mscratch, a0
li x7, 0xbad0000
bne a1, x7, fail

test_9:
li gp, 9
li a0, 0xbad1dea
csrrw a0, mscratch, a0
li x7, 0xbadbeef
bne a0, x7, fail

test_10:
li gp, 10
li a0, 0x0001dea
csrrc a0, mscratch, a0
li x7, 0xbad1dea
bne a0, x7, fail

test_11:
li gp, 11
li a0, 0x000beef
csrrs a0, mscratch, a0
li x7, 0xbad0000
bne a0, x7, fail

test_12:
li gp, 12
csrr a0, mscratch
li x7, 0xbadbeef
bne a0, x7, fail

j pass
