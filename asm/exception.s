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

tvec:
csrr s0, mstatus
bnez s0, fail
output:
lui t0, 0x10000
lb t1, 5(t0)
andi t1, t1, 0x20
beq t1, zero, output
addi a0, zero, 'a'
csrr t2, mcause
andi t2, t2, 0xff
add a0, a0, t2
sb a0, 0(t0)
csrr t3, mepc
addi t3, t3, 4
csrw mepc, t3
mret

test:
la t0, tvec
csrw mtvec, t0
la t0, user
csrw mepc, t0
mret

user:
ecall
ebreak
csrr s0, mstatus
bnez s0, fail

j pass
