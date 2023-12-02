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
    # If timer interrupt, disable it
    csrr t0, mcause
    li t1, 1 << 31 | 7
    bne t0, t1, end
    li t0, 1 << 7
    csrc mie, t0
    end:
        mret

test:
    # Setup trap handler
    la t0, tvec
    csrw mtvec, t0
    la t0, user
    csrw mepc, t0
    # Setup timer for 10000 cycles
    li t0, 0x200bff8
    lw t1, 0(t0)
    lw t2, 4(t0)
    li t3, 10000
    add t3, t1, t3
    sltu t1, t3, t1
    add t2, t2, t1
    li t0, 0x2004000
    sw t2, 4(t0)
    sw t3, 0(t0)
    # Enable timer interrupt
    li t0, 1 << 7
    csrs mie, t0
    mret

user:
    ecall
    ebreak
    spin:
        j spin
    csrr s0, mstatus
    bnez s0, fail

j pass
