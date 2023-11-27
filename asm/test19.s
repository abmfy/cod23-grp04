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
add	a4,ra,sp
li	t2,0
beq	a4,t2,test_3
j	fail

test_3:
li	gp,3
li	ra,1
li	sp,1
add	a4,ra,sp
li	t2,2
beq	a4,t2,test_4
j	fail

test_4:
li	gp,4
li	ra,3
li	sp,7
add	a4,ra,sp
li	t2,10
beq	a4,t2,test_5
j	fail

test_5:
li	gp,5
li	ra,0
lui	sp,0xffff8
add	a4,ra,sp
lui	t2,0xffff8
beq	a4,t2,test_6
j	fail

test_6:
li	gp,6
lui	ra,0x80000
li	sp,0
add	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_7
j	fail

test_7:
li	gp,7
lui	ra,0x80000
lui	sp,0xffff8
add	a4,ra,sp
lui	t2,0x7fff8
beq	a4,t2,test_8
j	fail

test_8:
li	gp,8
li	ra,0
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
add	a4,ra,sp
lui	t2,0x8
addi	t2,t2,-1 # _start-0x7fff8001
beq	a4,t2,test_9
j	fail

test_9:
li	gp,9
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
li	sp,0
add	a4,ra,sp
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffffaf4f
beq	a4,t2,test_10
j	fail

test_10:
li	gp,10
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
add	a4,ra,sp
lui	t2,0x80008
addi	t2,t2,-2 # _end+0x2f4e
beq	a4,t2,test_11
j	fail

test_11:
li	gp,11
lui	ra,0x80000
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
add	a4,ra,sp
lui	t2,0x80008
addi	t2,t2,-1 # _end+0x2f4f
beq	a4,t2,test_12
j	fail

test_12:
li	gp,12
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
lui	sp,0xffff8
add	a4,ra,sp
lui	t2,0x7fff8
addi	t2,t2,-1 # _start-0x8001
beq	a4,t2,test_13
j	fail

test_13:
li	gp,13
li	ra,0
li	sp,-1
add	a4,ra,sp
li	t2,-1
beq	a4,t2,test_14
j	fail

test_14:
li	gp,14
li	ra,-1
li	sp,1
add	a4,ra,sp
li	t2,0
beq	a4,t2,test_15
j	fail

test_15:
li	gp,15
li	ra,-1
li	sp,-1
add	a4,ra,sp
li	t2,-2
beq	a4,t2,test_16
j	fail

test_16:
li	gp,16
li	ra,1
lui	sp,0x80000
addi	sp,sp,-1 # _end+0xffffaf4f
add	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_17
j	fail

test_17:
li	gp,17
li	ra,13
li	sp,11
add	ra,ra,sp
li	t2,24
beq	ra,t2,test_18
j	fail

test_18:
li	gp,18
li	ra,14
li	sp,11
add	sp,ra,sp
li	t2,25
beq	sp,t2,test_19
j	fail

test_19:
li	gp,19
li	ra,13
add	ra,ra,ra
li	t2,26
beq	ra,t2,test_20
j	fail

test_20:
li	gp,20
li	tp,0
li	ra,13
li	sp,11
add	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_20+0x8
li	t2,24
beq	t1,t2,test_21
j	fail

test_21:
li	gp,21
li	tp,0
li	ra,14
li	sp,11
add	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_21+0x8
li	t2,25
beq	t1,t2,test_22
j	fail

test_22:
li	gp,22
li	tp,0
li	ra,15
li	sp,11
add	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_22+0x8
li	t2,26
beq	t1,t2,test_23
j	fail

test_23:
li	gp,23
li	tp,0
li	ra,13
li	sp,11
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_23+0x8
li	t2,24
beq	a4,t2,test_24
j	fail

test_24:
li	gp,24
li	tp,0
li	ra,14
li	sp,11
nop
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_24+0x8
li	t2,25
beq	a4,t2,test_25
j	fail

test_25:
li	gp,25
li	tp,0
li	ra,15
li	sp,11
nop
nop
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_25+0x8
li	t2,26
beq	a4,t2,test_26
j	fail

test_26:
li	gp,26
li	tp,0
li	ra,13
nop
li	sp,11
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_26+0x8
li	t2,24
beq	a4,t2,test_27
j	fail

test_27:
li	gp,27
li	tp,0
li	ra,14
nop
li	sp,11
nop
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_27+0x8
li	t2,25
beq	a4,t2,test_28
j	fail

test_28:
li	gp,28
li	tp,0
li	ra,15
nop
nop
li	sp,11
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_28+0x8
li	t2,26
beq	a4,t2,test_29
j	fail

test_29:
li	gp,29
li	tp,0
li	sp,11
li	ra,13
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_29+0x8
li	t2,24
beq	a4,t2,test_30
j	fail

test_30:
li	gp,30
li	tp,0
li	sp,11
li	ra,14
nop
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_30+0x8
li	t2,25
beq	a4,t2,test_31
j	fail

test_31:
li	gp,31
li	tp,0
li	sp,11
li	ra,15
nop
nop
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_31+0x8
li	t2,26
beq	a4,t2,test_32
j	fail

test_32:
li	gp,32
li	tp,0
li	sp,11
nop
li	ra,13
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_32+0x8
li	t2,24
beq	a4,t2,test_33
j	fail

test_33:
li	gp,33
li	tp,0
li	sp,11
nop
li	ra,14
nop
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_33+0x8
li	t2,25
beq	a4,t2,test_34
j	fail

test_34:
li	gp,34
li	tp,0
li	sp,11
nop
nop
li	ra,15
add	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_34+0x8
li	t2,26
beq	a4,t2,test_35
j	fail

test_35:
li	gp,35
li	ra,15
add	sp,zero,ra
li	t2,15
beq	sp,t2,test_36
j	fail

test_36:
li	gp,36
li	ra,32
add	sp,ra,zero
li	t2,32
beq	sp,t2,test_37
j	fail

test_37:
li	gp,37
add	ra,zero,zero
li	t2,0
beq	ra,t2,test_38
j	fail

test_38:
li	gp,38
li	ra,16
li	sp,30
add	zero,ra,sp
li	t2,0
beq	zero,t2,test_102
j	fail

test_102:
li	gp,102
li	ra,0
mv	a4,ra
li	t2,0
beq	a4,t2,test_103
j	fail

test_103:
li	gp,103
li	ra,1
addi	a4,ra,1
li	t2,2
beq	a4,t2,test_104
j	fail

test_104:
li	gp,104
li	ra,3
addi	a4,ra,7
li	t2,10
beq	a4,t2,test_105
j	fail

test_105:
li	gp,105
li	ra,0
addi	a4,ra,-2048
li	t2,-2048
beq	a4,t2,test_106
j	fail

test_106:
li	gp,106
lui	ra,0x80000
mv	a4,ra
lui	t2,0x80000
beq	a4,t2,test_107
j	fail

test_107:
li	gp,107
lui	ra,0x80000
addi	a4,ra,-2048 # _end+0xffffa750
lui	t2,0x80000
addi	t2,t2,-2048 # _end+0xffffa750
beq	a4,t2,test_108
j	fail

test_108:
li	gp,108
li	ra,0
addi	a4,ra,2047
li	t2,2047
beq	a4,t2,test_109
j	fail

test_109:
li	gp,109
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
mv	a4,ra
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffffaf4f
beq	a4,t2,test_110
j	fail

test_110:
li	gp,110
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
addi	a4,ra,2047
lui	t2,0x80000
addi	t2,t2,2046 # _end+0xffffb74e
beq	a4,t2,test_111
j	fail

test_111:
li	gp,111
lui	ra,0x80000
addi	a4,ra,2047 # _end+0xffffb74f
lui	t2,0x80000
addi	t2,t2,2047 # _end+0xffffb74f
beq	a4,t2,test_112
j	fail

test_112:
li	gp,112
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
addi	a4,ra,-2048
lui	t2,0x7ffff
addi	t2,t2,2047 # _start-0x801
beq	a4,t2,test_113
j	fail

test_113:
li	gp,113
li	ra,0
addi	a4,ra,-1
li	t2,-1
beq	a4,t2,test_114
j	fail

test_114:
li	gp,114
li	ra,-1
addi	a4,ra,1
li	t2,0
beq	a4,t2,test_115
j	fail

test_115:
li	gp,115
li	ra,-1
addi	a4,ra,-1
li	t2,-2
beq	a4,t2,test_116
j	fail

test_116:
li	gp,116
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffffaf4f
addi	a4,ra,1
lui	t2,0x80000
beq	a4,t2,test_117
j	fail

test_117:
li	gp,117
li	ra,13
addi	ra,ra,11
li	t2,24
beq	ra,t2,test_118
j	fail

test_118:
li	gp,118
li	tp,0
li	ra,13
addi	a4,ra,11
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_118+0x8
li	t2,24
beq	t1,t2,test_119
j	fail

test_119:
li	gp,119
li	tp,0
li	ra,13
addi	a4,ra,10
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_119+0x8
li	t2,23
beq	t1,t2,test_120
j	fail

test_120:
li	gp,120
li	tp,0
li	ra,13
addi	a4,ra,9
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_120+0x8
li	t2,22
beq	t1,t2,test_121
j	fail

test_121:
li	gp,121
li	tp,0
li	ra,13
addi	a4,ra,11
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_121+0x8
li	t2,24
beq	a4,t2,test_122
j	fail

test_122:
li	gp,122
li	tp,0
li	ra,13
nop
addi	a4,ra,10
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_122+0x8
li	t2,23
beq	a4,t2,test_123
j	fail

test_123:
li	gp,123
li	tp,0
li	ra,13
nop
nop
addi	a4,ra,9
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_123+0x8
li	t2,22
beq	a4,t2,test_124
j	fail

test_124:
li	gp,124
li	ra,32
li	t2,32
beq	ra,t2,test_125
j	fail

test_125:
li	gp,125
li	ra,33
addi	zero,ra,50
li	t2,0
beq	zero,t2,test_202
j	fail

test_202:
li	gp,202
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	a4,t2,test_203
j	fail

test_203:
li	gp,203
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
and	a4,ra,sp
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	a4,t2,test_204
j	fail

test_204:
li	gp,204
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
lui	t2,0xf0
addi	t2,t2,15 # _start-0x7ff0fff1
beq	a4,t2,test_205
j	fail

test_205:
li	gp,205
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
and	a4,ra,sp
lui	t2,0xf000f
beq	a4,t2,test_206
j	fail

test_206:
li	gp,206
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	ra,ra,sp
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	ra,t2,test_207
j	fail

test_207:
li	gp,207
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
and	sp,ra,sp
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	sp,t2,test_208
j	fail

test_208:
li	gp,208
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
and	ra,ra,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	ra,t2,test_209
j	fail

test_209:
li	gp,209
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_209+0x8
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	t1,t2,test_210
j	fail

test_210:
li	gp,210
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
and	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_210+0x8
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	t1,t2,test_211
j	fail

test_211:
li	gp,211
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_211+0x8
lui	t2,0xf0
addi	t2,t2,15 # _start-0x7ff0fff1
beq	t1,t2,test_212
j	fail

test_212:
li	gp,212
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_212+0x8
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	a4,t2,test_213
j	fail

test_213:
li	gp,213
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_213+0x8
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	a4,t2,test_214
j	fail

test_214:
li	gp,214
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
nop
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_214+0x8
lui	t2,0xf0
addi	t2,t2,15 # _start-0x7ff0fff1
beq	a4,t2,test_215
j	fail

test_215:
li	gp,215
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_215+0x8
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	a4,t2,test_216
j	fail

test_216:
li	gp,216
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_216+0x8
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	a4,t2,test_217
j	fail

test_217:
li	gp,217
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_217+0x8
lui	t2,0xf0
addi	t2,t2,15 # _start-0x7ff0fff1
beq	a4,t2,test_218
j	fail

test_218:
li	gp,218
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_218+0x8
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	a4,t2,test_219
j	fail

test_219:
li	gp,219
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_219+0x8
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	a4,t2,test_220
j	fail

test_220:
li	gp,220
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
nop
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_220+0x8
lui	t2,0xf0
addi	t2,t2,15 # _start-0x7ff0fff1
beq	a4,t2,test_221
j	fail

test_221:
li	gp,221
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_221+0x8
lui	t2,0xf001
addi	t2,t2,-256 # _start-0x70fff100
beq	a4,t2,test_222
j	fail

test_222:
li	gp,222
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_222+0x8
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	a4,t2,test_223
j	fail

test_223:
li	gp,223
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
nop
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
and	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_223+0x8
lui	t2,0xf0
addi	t2,t2,15 # _start-0x7ff0fff1
beq	a4,t2,test_224
j	fail

test_224:
li	gp,224
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
and	sp,zero,ra
li	t2,0
beq	sp,t2,test_225
j	fail

test_225:
li	gp,225
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
and	sp,ra,zero
li	t2,0
beq	sp,t2,test_226
j	fail

test_226:
li	gp,226
and	ra,zero,zero
li	t2,0
beq	ra,t2,test_227
j	fail

test_227:
li	gp,227
lui	ra,0x11111
addi	ra,ra,273 # _start-0x6eeeeeef
lui	sp,0x22222
addi	sp,sp,546 # _start-0x5dddddde
and	zero,ra,sp
li	t2,0
beq	zero,t2,test_302
j	fail

test_302:
li	gp,302
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
andi	a4,ra,-241
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_303
j	fail

test_303:
li	gp,303
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
andi	a4,ra,240
li	t2,240
beq	a4,t2,test_304
j	fail

test_304:
li	gp,304
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
andi	a4,ra,1807
li	t2,15
beq	a4,t2,test_305
j	fail

test_305:
li	gp,305
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
andi	a4,ra,240
li	t2,0
beq	a4,t2,test_306
j	fail

test_306:
li	gp,306
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
andi	ra,ra,240
li	t2,0
beq	ra,t2,test_307
j	fail

test_307:
li	gp,307
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
andi	a4,ra,1807
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_307+0x8
li	t2,1792
beq	t1,t2,test_308
j	fail

test_308:
li	gp,308
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
andi	a4,ra,240
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_308+0x8
li	t2,240
beq	t1,t2,test_309
j	fail

test_309:
li	gp,309
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
andi	a4,ra,-241
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_309+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	t1,t2,test_310
j	fail

test_310:
li	gp,310
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
andi	a4,ra,1807
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_310+0x8
li	t2,1792
beq	a4,t2,test_311
j	fail

test_311:
li	gp,311
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
andi	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_311+0x8
li	t2,240
beq	a4,t2,test_312
j	fail

test_312:
li	gp,312
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
nop
nop
andi	a4,ra,1807
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_312+0x8
li	t2,15
beq	a4,t2,test_313
j	fail

test_313:
li	gp,313
andi	ra,zero,240
li	t2,0
beq	ra,t2,test_314
j	fail

test_314:
li	gp,314
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
andi	zero,ra,1807
li	t2,0
beq	zero,t2,test_402
j	fail

test_402:
li	gp,402
nop
auipc	a0,0x2
addi	a0,a0,1820 # test_1818+0x28
jal	a1,test_402+0x14
li	a2,-1
xor	a1,a1,a2
addi	a1,a1,1
add	a0,a0,a1
lui	t2,0x2
addi	t2,t2,1808 # _start-0x7fffd8f0
beq	a0,t2,test_403
j	fail

test_403:
li	gp,403
auipc	a0,0xffffe
addi	a0,a0,-1796 # _start-0x16a4
jal	a1,test_403+0x10
li	a2,-1
xor	a1,a1,a2
addi	a1,a1,1
add	a0,a0,a1
lui	t2,0xffffe
addi	t2,t2,-1808 # _end+0x7fff8840
beq	a0,t2,test_502
j	fail

test_502:
li	gp,502
li	ra,0
li	sp,0
beq	ra,sp,test_502+0x1c
beq	zero,gp,test_502+0x18
j	fail
bne	zero,gp,test_503
beq	ra,sp,test_502+0x18
beq	zero,gp,test_503
j	fail

test_503:
li	gp,503
li	ra,1
li	sp,1
beq	ra,sp,test_503+0x1c
beq	zero,gp,test_503+0x18
j	fail
bne	zero,gp,test_504
beq	ra,sp,test_503+0x18
beq	zero,gp,test_504
j	fail

test_504:
li	gp,504
li	ra,-1
li	sp,-1
beq	ra,sp,test_504+0x1c
beq	zero,gp,test_504+0x18
j	fail
bne	zero,gp,test_505
beq	ra,sp,test_504+0x18
beq	zero,gp,test_505
j	fail

test_505:
li	gp,505
li	ra,0
li	sp,1
beq	ra,sp,test_505+0x14
bne	zero,gp,test_505+0x1c
beq	zero,gp,test_505+0x1c
j	fail
beq	ra,sp,test_505+0x14

test_506:
li	gp,506
li	ra,1
li	sp,0
beq	ra,sp,test_506+0x14
bne	zero,gp,test_506+0x1c
beq	zero,gp,test_506+0x1c
j	fail
beq	ra,sp,test_506+0x14

test_507:
li	gp,507
li	ra,-1
li	sp,1
beq	ra,sp,test_507+0x14
bne	zero,gp,test_507+0x1c
beq	zero,gp,test_507+0x1c
j	fail
beq	ra,sp,test_507+0x14

test_508:
li	gp,508
li	ra,1
li	sp,-1
beq	ra,sp,test_508+0x14
bne	zero,gp,test_508+0x1c
beq	zero,gp,test_508+0x1c
j	fail
beq	ra,sp,test_508+0x14

test_509:
li	gp,509
li	tp,0
li	ra,0
li	sp,-1
bne	ra,sp,test_509+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_509+0x8

test_510:
li	gp,510
li	tp,0
li	ra,0
li	sp,-1
nop
bne	ra,sp,test_510+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_510+0x8

test_511:
li	gp,511
li	tp,0
li	ra,0
li	sp,-1
nop
nop
bne	ra,sp,test_511+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_511+0x8

test_512:
li	gp,512
li	tp,0
li	ra,0
nop
li	sp,-1
bne	ra,sp,test_512+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_512+0x8

test_513:
li	gp,513
li	tp,0
li	ra,0
nop
li	sp,-1
nop
bne	ra,sp,test_513+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_513+0x8

test_514:
li	gp,514
li	tp,0
li	ra,0
nop
nop
li	sp,-1
bne	ra,sp,test_514+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_514+0x8

test_515:
li	gp,515
li	tp,0
li	ra,0
li	sp,-1
bne	ra,sp,test_515+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_515+0x8

test_516:
li	gp,516
li	tp,0
li	ra,0
li	sp,-1
nop
bne	ra,sp,test_516+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_516+0x8

test_517:
li	gp,517
li	tp,0
li	ra,0
li	sp,-1
nop
nop
bne	ra,sp,test_517+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_517+0x8

test_518:
li	gp,518
li	tp,0
li	ra,0
nop
li	sp,-1
bne	ra,sp,test_518+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_518+0x8

test_519:
li	gp,519
li	tp,0
li	ra,0
nop
li	sp,-1
nop
bne	ra,sp,test_519+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_519+0x8

test_520:
li	gp,520
li	tp,0
li	ra,0
nop
nop
li	sp,-1
bne	ra,sp,test_520+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_520+0x8

jalr_test_2:
li	gp,602
li	t0,0
auipc	t1,0x0
addi	t1,t1,16 # jalr_target_2
jalr	t0,t1

jalr_linkaddr_2:
j	fail

jalr_target_2:
auipc	t1,0x0
addi	t1,t1,-4 # jalr_linkaddr_2
beq	t0,t1,jalr_test_3
j	fail

jalr_test_3:
li	gp,603
auipc	t0,0x0
addi	t0,t0,16 # jalr_target_3
jalr	t0,t0

jalr_linkaddr_3:
j	fail

jalr_target_3:
auipc	t1,0x0
addi	t1,t1,-4 # jalr_linkaddr_3
beq	t0,t1,test_604
j	fail

test_604:
li	gp,604
li	tp,0
auipc	t1,0x0
addi	t1,t1,20 # test_604+0x1c
jalr	a3,t1
beq	zero,gp,test_604+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_604+0x8

test_605:
li	gp,605
li	tp,0
auipc	t1,0x0
addi	t1,t1,24 # test_605+0x20
nop
jalr	a3,t1
beq	zero,gp,test_605+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_605+0x8

test_606:
li	gp,606
li	tp,0
auipc	t1,0x0
addi	t1,t1,28 # test_606+0x24
nop
nop
jalr	a3,t1
beq	zero,gp,test_606+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_606+0x8

test_702:
li	gp,702
li	a5,-1
auipc	ra,0x4
addi	ra,ra,-1100 # begin_signature
lb	a4,0(ra)
li	t2,-1
beq	a4,t2,test_703
j	fail

test_703:
li	gp,703
li	a5,0
auipc	ra,0x4
addi	ra,ra,-1132 # begin_signature
lb	a4,1(ra)
li	t2,0
beq	a4,t2,test_704
j	fail

test_704:
li	gp,704
li	a5,-16
auipc	ra,0x4
addi	ra,ra,-1164 # begin_signature
lb	a4,2(ra)
li	t2,-16
beq	a4,t2,test_705
j	fail

test_705:
li	gp,705
li	a5,15
auipc	ra,0x4
addi	ra,ra,-1196 # begin_signature
lb	a4,3(ra)
li	t2,15
beq	a4,t2,test_706
j	fail

test_706:
li	gp,706
li	a5,-1
auipc	ra,0x4
addi	ra,ra,-1225 # lb_tdat4
lb	a4,-3(ra)
li	t2,-1
beq	a4,t2,test_707
j	fail

test_707:
li	gp,707
li	a5,0
auipc	ra,0x4
addi	ra,ra,-1257 # lb_tdat4
lb	a4,-2(ra)
li	t2,0
beq	a4,t2,test_708
j	fail

test_708:
li	gp,708
li	a5,-16
auipc	ra,0x4
addi	ra,ra,-1289 # lb_tdat4
lb	a4,-1(ra)
li	t2,-16
beq	a4,t2,test_709
j	fail

test_709:
li	gp,709
li	a5,15
auipc	ra,0x4
addi	ra,ra,-1321 # lb_tdat4
lb	a4,0(ra)
li	t2,15
beq	a4,t2,test_710
j	fail

test_710:
li	gp,710
auipc	ra,0x4
addi	ra,ra,-1352 # begin_signature
addi	ra,ra,-32
lb	t0,32(ra)
li	t2,-1
beq	t0,t2,test_711
j	fail

test_711:
li	gp,711
auipc	ra,0x4
addi	ra,ra,-1384 # begin_signature
addi	ra,ra,-6
lb	t0,7(ra)
li	t2,0
beq	t0,t2,test_712
j	fail

test_712:
li	gp,712
li	tp,0
auipc	ra,0x4
addi	ra,ra,-1419 # lb_tdat2
lb	a4,1(ra)
mv	t1,a4
li	t2,-16
beq	t1,t2,test_712+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_712+0x8

test_713:
li	gp,713
li	tp,0
auipc	ra,0x4
addi	ra,ra,-1466 # lb_tdat3
lb	a4,1(ra)
nop
mv	t1,a4
li	t2,15
beq	t1,t2,test_713+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_713+0x8

test_714:
li	gp,714
li	tp,0
auipc	ra,0x4
addi	ra,ra,-1520 # begin_signature
lb	a4,1(ra)
nop
nop
mv	t1,a4
li	t2,0
beq	t1,t2,test_714+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_714+0x8

test_715:
li	gp,715
li	tp,0
auipc	ra,0x4
addi	ra,ra,-1575 # lb_tdat2
lb	a4,1(ra)
li	t2,-16
beq	a4,t2,test_715+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_715+0x8

test_716:
li	gp,716
li	tp,0
auipc	ra,0x4
addi	ra,ra,-1618 # lb_tdat3
nop
lb	a4,1(ra)
li	t2,15
beq	a4,t2,test_716+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_716+0x8

test_717:
li	gp,717
li	tp,0
auipc	ra,0x4
addi	ra,ra,-1668 # begin_signature
nop
nop
lb	a4,1(ra)
li	t2,0
beq	a4,t2,test_717+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_717+0x8

test_718:
li	gp,718
auipc	t0,0x4
addi	t0,t0,-1716 # begin_signature
lb	sp,0(t0)
li	sp,2
li	t2,2
beq	sp,t2,test_719
j	fail

test_719:
li	gp,719
auipc	t0,0x4
addi	t0,t0,-1748 # begin_signature
lb	sp,0(t0)
nop
li	sp,2
li	t2,2
beq	sp,t2,test_802
j	fail

test_802:
li	gp,802
auipc	ra,0x4
addi	ra,ra,-1768 # sb_tdat
li	sp,-86
auipc	a5,0x0
addi	a5,a5,20 # test_802+0x24
sb	sp,0(ra)
lb	a4,0(ra)
j	test_802+0x28
mv	a4,sp
li	t2,-86
beq	a4,t2,test_803
j	fail

test_803:
li	gp,803
auipc	ra,0x4
addi	ra,ra,-1820 # sb_tdat
li	sp,0
auipc	a5,0x0
addi	a5,a5,20 # test_803+0x24
sb	sp,1(ra)
lb	a4,1(ra)
j	test_803+0x28
mv	a4,sp
li	t2,0
beq	a4,t2,test_804
j	fail

test_804:
li	gp,804
auipc	ra,0x4
addi	ra,ra,-1872 # sb_tdat
li	sp,-96
auipc	a5,0x0
addi	a5,a5,20 # test_804+0x24
sb	sp,2(ra)
lb	a4,2(ra)
j	test_804+0x28
mv	a4,sp
li	t2,-96
beq	a4,t2,test_805
j	fail

test_805:
li	gp,805
auipc	ra,0x4
addi	ra,ra,-1924 # sb_tdat
li	sp,10
auipc	a5,0x0
addi	a5,a5,20 # test_805+0x24
sb	sp,3(ra)
lb	a4,3(ra)
j	test_805+0x28
mv	a4,sp
li	t2,10
beq	a4,t2,test_806
j	fail

test_806:
li	gp,806
auipc	ra,0x4
addi	ra,ra,-1969 # sb_tdat8
li	sp,-86
auipc	a5,0x0
addi	a5,a5,20 # test_806+0x24
sb	sp,-3(ra)
lb	a4,-3(ra)
j	test_806+0x28
mv	a4,sp
li	t2,-86
beq	a4,t2,test_807
j	fail

test_807:
li	gp,807
auipc	ra,0x4
addi	ra,ra,-2021 # sb_tdat8
li	sp,0
auipc	a5,0x0
addi	a5,a5,20 # test_807+0x24
sb	sp,-2(ra)
lb	a4,-2(ra)
j	test_807+0x28
mv	a4,sp
li	t2,0
beq	a4,t2,test_808
j	fail

test_808:
li	gp,808
auipc	ra,0x3
addi	ra,ra,2023 # sb_tdat8
li	sp,-96
auipc	a5,0x0
addi	a5,a5,20 # test_808+0x24
sb	sp,-1(ra)
lb	a4,-1(ra)
j	test_808+0x28
mv	a4,sp
li	t2,-96
beq	a4,t2,test_809
j	fail

test_809:
li	gp,809
auipc	ra,0x3
addi	ra,ra,1971 # sb_tdat8
li	sp,10
auipc	a5,0x0
addi	a5,a5,20 # test_809+0x24
sb	sp,0(ra)
lb	a4,0(ra)
j	test_809+0x28
mv	a4,sp
li	t2,10
beq	a4,t2,test_810
j	fail

test_810:
li	gp,810
auipc	ra,0x3
addi	ra,ra,1920 # sb_tdat9
lui	sp,0x12345
addi	sp,sp,1656 # _start-0x6dcba988
addi	tp,ra,-32
sb	sp,32(tp) # _start-0x7fffffe0
lb	t0,0(ra)
li	t2,120
beq	t0,t2,test_811
j	fail

test_811:
li	gp,811
auipc	ra,0x3
addi	ra,ra,1876 # sb_tdat9
lui	sp,0x3
addi	sp,sp,152 # _start-0x7fffcf68
addi	ra,ra,-6
sb	sp,7(ra)
auipc	tp,0x3
addi	tp,tp,1853 # sb_tdat10
lb	t0,0(tp) # _start-0x80000000
li	t2,-104
beq	t0,t2,test_812
j	fail

test_812:
li	gp,812
li	tp,0
li	ra,-35
auipc	sp,0x3
addi	sp,sp,1808 # sb_tdat
sb	ra,0(sp)
lb	a4,0(sp)
li	t2,-35
beq	a4,t2,test_812+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_812+0x8

test_813:
li	gp,813
li	tp,0
li	ra,-51
auipc	sp,0x3
addi	sp,sp,1756 # sb_tdat
nop
sb	ra,1(sp)
lb	a4,1(sp)
li	t2,-51
beq	a4,t2,test_813+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_813+0x8

test_814:
li	gp,814
li	tp,0
li	ra,-52
auipc	sp,0x3
addi	sp,sp,1700 # sb_tdat
nop
nop
sb	ra,2(sp)
lb	a4,2(sp)
li	t2,-52
beq	a4,t2,test_814+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_814+0x8

test_815:
li	gp,815
li	tp,0
li	ra,-68
nop
auipc	sp,0x3
addi	sp,sp,1636 # sb_tdat
sb	ra,3(sp)
lb	a4,3(sp)
li	t2,-68
beq	a4,t2,test_815+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_815+0x8

test_816:
li	gp,816
li	tp,0
li	ra,-69
nop
auipc	sp,0x3
addi	sp,sp,1580 # sb_tdat
nop
sb	ra,4(sp)
lb	a4,4(sp)
li	t2,-69
beq	a4,t2,test_816+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_816+0x8

test_817:
li	gp,817
li	tp,0
li	ra,-85
nop
nop
auipc	sp,0x3
addi	sp,sp,1516 # sb_tdat
sb	ra,5(sp)
lb	a4,5(sp)
li	t2,-85
beq	a4,t2,test_817+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_817+0x8

test_818:
li	gp,818
li	tp,0
auipc	sp,0x3
addi	sp,sp,1468 # sb_tdat
li	ra,51
sb	ra,0(sp)
lb	a4,0(sp)
li	t2,51
beq	a4,t2,test_818+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_818+0x8

test_819:
li	gp,819
li	tp,0
auipc	sp,0x3
addi	sp,sp,1416 # sb_tdat
li	ra,35
nop
sb	ra,1(sp)
lb	a4,1(sp)
li	t2,35
beq	a4,t2,test_819+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_819+0x8

test_820:
li	gp,820
li	tp,0
auipc	sp,0x3
addi	sp,sp,1360 # sb_tdat
li	ra,34
nop
nop
sb	ra,2(sp)
lb	a4,2(sp)
li	t2,34
beq	a4,t2,test_820+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_820+0x8

test_821:
li	gp,821
li	tp,0
auipc	sp,0x3
addi	sp,sp,1300 # sb_tdat
nop
li	ra,18
sb	ra,3(sp)
lb	a4,3(sp)
li	t2,18
beq	a4,t2,test_821+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_821+0x8

test_822:
li	gp,822
li	tp,0
auipc	sp,0x3
addi	sp,sp,1244 # sb_tdat
nop
li	ra,17
nop
sb	ra,4(sp)
lb	a4,4(sp)
li	t2,17
beq	a4,t2,test_822+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_822+0x8

test_823:
li	gp,823
li	tp,0
auipc	sp,0x3
addi	sp,sp,1184 # sb_tdat
nop
nop
li	ra,1
sb	ra,5(sp)
lb	a4,5(sp)
li	t2,1
beq	a4,t2,test_823+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_823+0x8
li	a0,239
auipc	a1,0x3
addi	a1,a1,1128 # sb_tdat
sb	a0,3(a1)

test_902:
li	gp,902
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_903
j	fail

test_903:
li	gp,903
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
xor	a4,ra,sp
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_904
j	fail

test_904:
li	gp,904
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_905
j	fail

test_905:
li	gp,905
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
xor	a4,ra,sp
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	a4,t2,test_906
j	fail

test_906:
li	gp,906
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	ra,ra,sp
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	ra,t2,test_907
j	fail

test_907:
li	gp,907
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	sp,ra,sp
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	sp,t2,test_908
j	fail

test_908:
li	gp,908
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
xor	ra,ra,ra
li	t2,0
beq	ra,t2,test_909
j	fail

test_909:
li	gp,909
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_909+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	t1,t2,test_910
j	fail

test_910:
li	gp,910
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
xor	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_910+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	t1,t2,test_911
j	fail

test_911:
li	gp,911
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_911+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	t1,t2,test_912
j	fail

test_912:
li	gp,912
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_912+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_913
j	fail

test_913:
li	gp,913
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_913+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_914
j	fail

test_914:
li	gp,914
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_914+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_915
j	fail

test_915:
li	gp,915
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_915+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_916
j	fail

test_916:
li	gp,916
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_916+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_917
j	fail

test_917:
li	gp,917
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_917+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_918
j	fail

test_918:
li	gp,918
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_918+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_919
j	fail

test_919:
li	gp,919
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_919+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_920
j	fail

test_920:
li	gp,920
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_920+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_921
j	fail

test_921:
li	gp,921
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_921+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_922
j	fail

test_922:
li	gp,922
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_922+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_923
j	fail

test_923:
li	gp,923
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
nop
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_923+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_924
j	fail

test_924:
li	gp,924
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
xor	sp,zero,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	sp,t2,test_925
j	fail

test_925:
li	gp,925
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
xor	sp,ra,zero
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	sp,t2,test_926
j	fail

test_926:
li	gp,926
xor	ra,zero,zero
li	t2,0
beq	ra,t2,test_927
j	fail

test_927:
li	gp,927
lui	ra,0x11111
addi	ra,ra,273 # _start-0x6eeeeeef
lui	sp,0x22222
addi	sp,sp,546 # _start-0x5dddddde
xor	zero,ra,sp
li	t2,0
beq	zero,t2,test_1002
j	fail

test_1002:
li	gp,1002
li	ra,0
li	sp,1
bne	ra,sp,test_1002+0x1c
beq	zero,gp,test_1002+0x18
j	fail
bne	zero,gp,test_1003
bne	ra,sp,test_1002+0x18
beq	zero,gp,test_1003
j	fail

test_1003:
li	gp,1003
li	ra,1
li	sp,0
bne	ra,sp,test_1003+0x1c
beq	zero,gp,test_1003+0x18
j	fail
bne	zero,gp,test_1004
bne	ra,sp,test_1003+0x18
beq	zero,gp,test_1004
j	fail

test_1004:
li	gp,1004
li	ra,-1
li	sp,1
bne	ra,sp,test_1004+0x1c
beq	zero,gp,test_1004+0x18
j	fail
bne	zero,gp,test_1005
bne	ra,sp,test_1004+0x18
beq	zero,gp,test_1005
j	fail

test_1005:
li	gp,1005
li	ra,1
li	sp,-1
bne	ra,sp,test_1005+0x1c
beq	zero,gp,test_1005+0x18
j	fail
bne	zero,gp,test_1006
bne	ra,sp,test_1005+0x18
beq	zero,gp,test_1006
j	fail

test_1006:
li	gp,1006
li	ra,0
li	sp,0
bne	ra,sp,test_1006+0x14
bne	zero,gp,test_1006+0x1c
beq	zero,gp,test_1006+0x1c
j	fail
bne	ra,sp,test_1006+0x14

test_1007:
li	gp,1007
li	ra,1
li	sp,1
bne	ra,sp,test_1007+0x14
bne	zero,gp,test_1007+0x1c
beq	zero,gp,test_1007+0x1c
j	fail
bne	ra,sp,test_1007+0x14

test_1008:
li	gp,1008
li	ra,-1
li	sp,-1
bne	ra,sp,test_1008+0x14
bne	zero,gp,test_1008+0x1c
beq	zero,gp,test_1008+0x1c
j	fail
bne	ra,sp,test_1008+0x14

test_1009:
li	gp,1009
li	tp,0
li	ra,0
li	sp,0
beq	ra,sp,test_1009+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1009+0x8

test_1010:
li	gp,1010
li	tp,0
li	ra,0
li	sp,0
nop
beq	ra,sp,test_1010+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1010+0x8

test_1011:
li	gp,1011
li	tp,0
li	ra,0
li	sp,0
nop
nop
beq	ra,sp,test_1011+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1011+0x8

test_1012:
li	gp,1012
li	tp,0
li	ra,0
nop
li	sp,0
beq	ra,sp,test_1012+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1012+0x8

test_1013:
li	gp,1013
li	tp,0
li	ra,0
nop
li	sp,0
nop
beq	ra,sp,test_1013+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1013+0x8

test_1014:
li	gp,1014
li	tp,0
li	ra,0
nop
nop
li	sp,0
beq	ra,sp,test_1014+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1014+0x8

test_1015:
li	gp,1015
li	tp,0
li	ra,0
li	sp,0
beq	ra,sp,test_1015+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1015+0x8

test_1016:
li	gp,1016
li	tp,0
li	ra,0
li	sp,0
nop
beq	ra,sp,test_1016+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1016+0x8

test_1017:
li	gp,1017
li	tp,0
li	ra,0
li	sp,0
nop
nop
beq	ra,sp,test_1017+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1017+0x8

test_1018:
li	gp,1018
li	tp,0
li	ra,0
nop
li	sp,0
beq	ra,sp,test_1018+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1018+0x8

test_1019:
li	gp,1019
li	tp,0
li	ra,0
nop
li	sp,0
nop
beq	ra,sp,test_1019+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1019+0x8

test_1020:
li	gp,1020
li	tp,0
li	ra,0
nop
nop
li	sp,0
beq	ra,sp,test_1020+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1020+0x8

test_1021:
li	gp,1021
li	ra,1
bnez	ra,test_1021+0x1c
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
li	t2,3
beq	ra,t2,jal_test_2
j	fail

jal_test_2:
li	gp,1102
li	ra,0
jal	tp,jal_target_2

jal_linkaddr_2:
nop
nop
j	fail

jal_target_2:
auipc	sp,0x0
addi	sp,sp,-12 # jal_linkaddr_2
beq	sp,tp,test_1103
j	fail

test_1103:
li	gp,1103
li	ra,1
j	test_1103+0x1c
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
li	t2,3
beq	ra,t2,test_1202
j	fail

test_1202:
li	gp,1202
lui	a5,0xff0
addi	a5,a5,255 # _start-0x7f00ff01
auipc	ra,0x3
addi	ra,ra,-1068 # lw_tdat
lw	a4,0(ra)
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	a4,t2,test_1203
j	fail

test_1203:
li	gp,1203
lui	a5,0xff010
addi	a5,a5,-256 # _end+0x7f00ae50
auipc	ra,0x3
addi	ra,ra,-1108 # lw_tdat
lw	a4,4(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_1204
j	fail

test_1204:
li	gp,1204
lui	a5,0xff01
addi	a5,a5,-16 # _start-0x700ff010
auipc	ra,0x3
addi	ra,ra,-1148 # lw_tdat
lw	a4,8(ra)
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1205
j	fail

test_1205:
li	gp,1205
lui	a5,0xf00ff
addi	a5,a5,15 # _end+0x700f9f5f
auipc	ra,0x3
addi	ra,ra,-1188 # lw_tdat
lw	a4,12(ra)
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_1206
j	fail

test_1206:
li	gp,1206
lui	a5,0xff0
addi	a5,a5,255 # _start-0x7f00ff01
auipc	ra,0x3
addi	ra,ra,-1216 # lw_tdat4
lw	a4,-12(ra)
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	a4,t2,test_1207
j	fail

test_1207:
li	gp,1207
lui	a5,0xff010
addi	a5,a5,-256 # _end+0x7f00ae50
auipc	ra,0x3
addi	ra,ra,-1256 # lw_tdat4
lw	a4,-8(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_1208
j	fail

test_1208:
li	gp,1208
lui	a5,0xff01
addi	a5,a5,-16 # _start-0x700ff010
auipc	ra,0x3
addi	ra,ra,-1296 # lw_tdat4
lw	a4,-4(ra)
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1209
j	fail

test_1209:
li	gp,1209
lui	a5,0xf00ff
addi	a5,a5,15 # _end+0x700f9f5f
auipc	ra,0x3
addi	ra,ra,-1336 # lw_tdat4
lw	a4,0(ra)
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_1210
j	fail

test_1210:
li	gp,1210
auipc	ra,0x3
addi	ra,ra,-1380 # lw_tdat
addi	ra,ra,-32
lw	t0,32(ra)
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	t0,t2,test_1211
j	fail

test_1211:
li	gp,1211
auipc	ra,0x3
addi	ra,ra,-1416 # lw_tdat
addi	ra,ra,-3
lw	t0,7(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	t0,t2,test_1212
j	fail

test_1212:
li	gp,1212
li	tp,0
auipc	ra,0x3
addi	ra,ra,-1452 # lw_tdat2
lw	a4,4(ra)
mv	t1,a4
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	t1,t2,test_1212+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1212+0x8

test_1213:
li	gp,1213
li	tp,0
auipc	ra,0x3
addi	ra,ra,-1500 # lw_tdat3
lw	a4,4(ra)
nop
mv	t1,a4
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	t1,t2,test_1213+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1213+0x8

test_1214:
li	gp,1214
li	tp,0
auipc	ra,0x3
addi	ra,ra,-1564 # lw_tdat
lw	a4,4(ra)
nop
nop
mv	t1,a4
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	t1,t2,test_1214+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1214+0x8

test_1215:
li	gp,1215
li	tp,0
auipc	ra,0x3
addi	ra,ra,-1620 # lw_tdat2
lw	a4,4(ra)
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1215+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1215+0x8

test_1216:
li	gp,1216
li	tp,0
auipc	ra,0x3
addi	ra,ra,-1664 # lw_tdat3
nop
lw	a4,4(ra)
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f9f5f
beq	a4,t2,test_1216+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1216+0x8

test_1217:
li	gp,1217
li	tp,0
auipc	ra,0x3
addi	ra,ra,-1724 # lw_tdat
nop
nop
lw	a4,4(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	a4,t2,test_1217+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1217+0x8

test_1218:
li	gp,1218
auipc	t0,0x3
addi	t0,t0,-1776 # lw_tdat
lw	sp,0(t0)
li	sp,2
li	t2,2
beq	sp,t2,test_1219
j	fail

test_1219:
li	gp,1219
auipc	t0,0x3
addi	t0,t0,-1808 # lw_tdat
lw	sp,0(t0)
nop
li	sp,2
li	t2,2
beq	sp,t2,test_1302
j	fail

test_1302:
li	gp,1302
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
beq	a4,t2,test_1303
j	fail

test_1303:
li	gp,1303
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
or	a4,ra,sp
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff0af40
beq	a4,t2,test_1304
j	fail

test_1304:
li	gp,1304
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	a4,t2,test_1305
j	fail

test_1305:
li	gp,1305
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
or	a4,ra,sp
lui	t2,0xf0fff
addi	t2,t2,255 # _end+0x70ffa04f
beq	a4,t2,test_1306
j	fail

test_1306:
li	gp,1306
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	ra,ra,sp
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
beq	ra,t2,test_1307
j	fail

test_1307:
li	gp,1307
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	sp,ra,sp
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
beq	sp,t2,test_1308
j	fail

test_1308:
li	gp,1308
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
or	ra,ra,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
beq	ra,t2,test_1309
j	fail

test_1309:
li	gp,1309
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1309+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
bne	t1,t2,fail

test_1310:
li	gp,1310
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
or	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1310+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff0af40
bne	t1,t2,fail

test_1311:
li	gp,1311
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1311+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
bne	t1,t2,fail

test_1312:
li	gp,1312
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1312+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
bne	a4,t2,fail

test_1313:
li	gp,1313
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1313+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff0af40
bne	a4,t2,fail

test_1314:
li	gp,1314
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1314+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
bne	a4,t2,fail

test_1315:
li	gp,1315
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1315+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
bne	a4,t2,fail

test_1316:
li	gp,1316
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1316+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff0af40
bne	a4,t2,fail

test_1317:
li	gp,1317
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1317+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
bne	a4,t2,fail

test_1318:
li	gp,1318
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1318+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
bne	a4,t2,fail

test_1319:
li	gp,1319
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1319+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff0af40
bne	a4,t2,fail

test_1320:
li	gp,1320
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1320+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
bne	a4,t2,fail

test_1321:
li	gp,1321
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1321+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0fae5f
bne	a4,t2,fail

test_1322:
li	gp,1322
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f0a040
nop
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1322+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff0af40
bne	a4,t2,fail

test_1323:
li	gp,1323
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
nop
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1323+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
bne	a4,t2,fail

test_1324:
li	gp,1324
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
or	sp,zero,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f00ae50
bne	sp,t2,fail

test_1325:
li	gp,1325
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
or	sp,ra,zero
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
bne	sp,t2,fail

test_1326:
li	gp,1326
or	ra,zero,zero
li	t2,0
bne	ra,t2,fail

test_1327:
li	gp,1327
lui	ra,0x11111
addi	ra,ra,273 # _start-0x6eeeeeef
lui	sp,0x22222
addi	sp,sp,546 # _start-0x5dddddde
or	zero,ra,sp
li	t2,0
bne	zero,t2,fail

test_1402:
li	gp,1402
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
ori	a4,ra,-241
li	t2,-241
bne	a4,t2,fail

test_1403:
li	gp,1403
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
ori	a4,ra,240
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
bne	a4,t2,fail

test_1404:
li	gp,1404
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
ori	a4,ra,1807
lui	t2,0xff0
addi	t2,t2,2047 # _start-0x7f00f801
bne	a4,t2,fail

test_1405:
li	gp,1405
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
ori	a4,ra,240
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700fa04f
bne	a4,t2,fail

test_1406:
li	gp,1406
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f00ae50
ori	ra,ra,240
lui	t2,0xff010
addi	t2,t2,-16 # _end+0x7f00af40
bne	ra,t2,fail

test_1407:
li	gp,1407
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
ori	a4,ra,240
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1407+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
bne	t1,t2,fail

test_1408:
li	gp,1408
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
ori	a4,ra,1807
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1408+0x8
lui	t2,0xff0
addi	t2,t2,2047 # _start-0x7f00f801
bne	t1,t2,fail

test_1409:
li	gp,1409
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
ori	a4,ra,240
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1409+0x8
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700fa04f
bne	t1,t2,fail

test_1410:
li	gp,1410
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
ori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1410+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
bne	a4,t2,fail

test_1411:
li	gp,1411
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
ori	a4,ra,-241
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1411+0x8
li	t2,-1
bne	a4,t2,fail

test_1412:
li	gp,1412
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f9f5f
nop
nop
ori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1412+0x8
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700fa04f
bne	a4,t2,fail

test_1413:
li	gp,1413
ori	ra,zero,240
li	t2,240
bne	ra,t2,fail

test_1414:
li	gp,1414
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
ori	zero,ra,1807
li	t2,0
bne	zero,t2,fail

test_1502:
li	gp,1502
li	ra,1
slli	a4,ra,0x0
li	t2,1
bne	a4,t2,fail

test_1503:
li	gp,1503
li	ra,1
slli	a4,ra,0x1
li	t2,2
bne	a4,t2,fail

test_1504:
li	gp,1504
li	ra,1
slli	a4,ra,0x7
li	t2,128
bne	a4,t2,fail

test_1505:
li	gp,1505
li	ra,1
slli	a4,ra,0xe
lui	t2,0x4
bne	a4,t2,fail

test_1506:
li	gp,1506
li	ra,1
slli	a4,ra,0x1f
lui	t2,0x80000
bne	a4,t2,fail

test_1507:
li	gp,1507
li	ra,-1
slli	a4,ra,0x0
li	t2,-1
bne	a4,t2,fail

test_1508:
li	gp,1508
li	ra,-1
slli	a4,ra,0x1
li	t2,-2
bne	a4,t2,fail

test_1509:
li	gp,1509
li	ra,-1
slli	a4,ra,0x7
li	t2,-128
bne	a4,t2,fail

test_1510:
li	gp,1510
li	ra,-1
slli	a4,ra,0xe
lui	t2,0xffffc
bne	a4,t2,fail

test_1511:
li	gp,1511
li	ra,-1
slli	a4,ra,0x1f
lui	t2,0x80000
bne	a4,t2,fail

test_1512:
li	gp,1512
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x0
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
bne	a4,t2,fail

test_1513:
li	gp,1513
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x1
lui	t2,0x42424
addi	t2,t2,578 # _start-0x3dbdbdbe
bne	a4,t2,fail

test_1514:
li	gp,1514
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x7
lui	t2,0x90909
addi	t2,t2,128 # _end+0x10903fd0
bne	a4,t2,fail

test_1515:
li	gp,1515
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0xe
lui	t2,0x48484
bne	a4,t2,fail

test_1516:
li	gp,1516
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x1f
lui	t2,0x80000
bne	a4,t2,fail

test_1517:
li	gp,1517
li	ra,1
slli	ra,ra,0x7
li	t2,128
bne	ra,t2,fail

test_1518:
li	gp,1518
li	tp,0
li	ra,1
slli	a4,ra,0x7
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1518+0x8
li	t2,128
bne	t1,t2,fail

test_1519:
li	gp,1519
li	tp,0
li	ra,1
slli	a4,ra,0xe
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1519+0x8
lui	t2,0x4
bne	t1,t2,fail

test_1520:
li	gp,1520
li	tp,0
li	ra,1
slli	a4,ra,0x1f
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1520+0x8
lui	t2,0x80000
bne	t1,t2,fail

test_1521:
li	gp,1521
li	tp,0
li	ra,1
slli	a4,ra,0x7
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1521+0x8
li	t2,128
bne	a4,t2,fail

test_1522:
li	gp,1522
li	tp,0
li	ra,1
nop
slli	a4,ra,0xe
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1522+0x8
lui	t2,0x4
bne	a4,t2,fail

test_1523:
li	gp,1523
li	tp,0
li	ra,1
nop
nop
slli	a4,ra,0x1f
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1523+0x8
lui	t2,0x80000
bne	a4,t2,fail

test_1524:
li	gp,1524
slli	ra,zero,0x1f
li	t2,0
bne	ra,t2,fail

test_1525:
li	gp,1525
li	ra,33
slli	zero,ra,0x14
li	t2,0
bne	zero,t2,fail

test_1602:
li	gp,1602
lui	ra,0x80000
srli	a4,ra,0x0
lui	t2,0x80000
bne	a4,t2,fail

test_1603:
li	gp,1603
lui	ra,0x80000
srli	a4,ra,0x1
lui	t2,0x40000
bne	a4,t2,fail

test_1604:
li	gp,1604
lui	ra,0x80000
srli	a4,ra,0x7
lui	t2,0x1000
bne	a4,t2,fail

test_1605:
li	gp,1605
lui	ra,0x80000
srli	a4,ra,0xe
lui	t2,0x20
bne	a4,t2,fail

test_1606:
li	gp,1606
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffffaf51
srli	a4,ra,0x1f
li	t2,1
bne	a4,t2,fail

test_1607:
li	gp,1607
li	ra,-1
srli	a4,ra,0x0
li	t2,-1
bne	a4,t2,fail

test_1608:
li	gp,1608
li	ra,-1
srli	a4,ra,0x1
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffffaf4f
bne	a4,t2,fail

test_1609:
li	gp,1609
li	ra,-1
srli	a4,ra,0x7
lui	t2,0x2000
addi	t2,t2,-1 # _start-0x7e000001
bne	a4,t2,fail

test_1610:
li	gp,1610
li	ra,-1
srli	a4,ra,0xe
lui	t2,0x40
addi	t2,t2,-1 # _start-0x7ffc0001
bne	a4,t2,fail

test_1611:
li	gp,1611
li	ra,-1
srli	a4,ra,0x1f
li	t2,1
bne	a4,t2,fail

test_1612:
li	gp,1612
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x0
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
bne	a4,t2,fail

test_1613:
li	gp,1613
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x1
lui	t2,0x10909
addi	t2,t2,144 # _start-0x6f6f6f70
bne	a4,t2,fail

test_1614:
li	gp,1614
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x7
lui	t2,0x424
addi	t2,t2,578 # _start-0x7fbdbdbe
bne	a4,t2,fail

test_1615:
li	gp,1615
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0xe
lui	t2,0x8
addi	t2,t2,1156 # _start-0x7fff7b7c
bne	a4,t2,fail

test_1616:
li	gp,1616
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x1f
li	t2,0
bne	a4,t2,fail

test_1617:
li	gp,1617
lui	ra,0x80000
srli	ra,ra,0x7
lui	t2,0x1000
bne	ra,t2,fail

test_1618:
li	gp,1618
li	tp,0
lui	ra,0x80000
srli	a4,ra,0x7
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1618+0x8
lui	t2,0x1000
bne	t1,t2,fail

test_1619:
li	gp,1619
li	tp,0
lui	ra,0x80000
srli	a4,ra,0xe
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1619+0x8
lui	t2,0x20
bne	t1,t2,fail

test_1620:
li	gp,1620
li	tp,0
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffffaf51
srli	a4,ra,0x1f
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1620+0x8
li	t2,1
bne	t1,t2,fail

test_1621:
li	gp,1621
li	tp,0
lui	ra,0x80000
srli	a4,ra,0x7
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1621+0x8
lui	t2,0x1000
bne	a4,t2,fail

test_1622:
li	gp,1622
li	tp,0
lui	ra,0x80000
nop
srli	a4,ra,0xe
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1622+0x8
lui	t2,0x20
bne	a4,t2,fail

test_1623:
li	gp,1623
li	tp,0
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffffaf51
nop
nop
srli	a4,ra,0x1f
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1623+0x8
li	t2,1
bne	a4,t2,fail

test_1624:
li	gp,1624
srli	ra,zero,0x4
li	t2,0
bne	ra,t2,fail

test_1625:
li	gp,1625
li	ra,33
srli	zero,ra,0xa
li	t2,0
bne	zero,t2,fail

test_1702:
li	gp,1702
lui	ra,0x0
li	t2,0
bne	ra,t2,fail

test_1703:
li	gp,1703
lui	ra,0xfffff
srli	ra,ra,0x1
lui	t2,0x80000
addi	t2,t2,-2048 # _end+0xffffa750
bne	ra,t2,fail

test_1704:
li	gp,1704
lui	ra,0x7ffff
srli	ra,ra,0x14
li	t2,2047
bne	ra,t2,fail

test_1705:
li	gp,1705
lui	ra,0x80000
srli	ra,ra,0x14
lui	t2,0x1
addi	t2,t2,-2048 # _start-0x7ffff800
bne	ra,t2,fail

test_1706:
li	gp,1706
lui	zero,0x80000
li	t2,0
bne	zero,t2,fail

test_1802:
li	gp,1802
auipc	ra,0x2
addi	ra,ra,-792 # sw_tdat
lui	sp,0xaa0
addi	sp,sp,170 # _start-0x7f55ff56
auipc	a5,0x0
addi	a5,a5,20 # test_1802+0x28
sw	sp,0(ra)
lw	a4,0(ra)
j	test_1802+0x2c
mv	a4,sp
lui	t2,0xaa0
addi	t2,t2,170 # _start-0x7f55ff56
bne	a4,t2,fail

test_1803:
li	gp,1803
auipc	ra,0x2
addi	ra,ra,-848 # sw_tdat
lui	sp,0xaa00b
addi	sp,sp,-1536 # _end+0x2a005950
auipc	a5,0x0
addi	a5,a5,20 # test_1803+0x28
sw	sp,4(ra)
lw	a4,4(ra)
j	test_1803+0x2c
mv	a4,sp
lui	t2,0xaa00b
addi	t2,t2,-1536 # _end+0x2a005950
bne	a4,t2,fail

test_1804:
li	gp,1804
auipc	ra,0x2
addi	ra,ra,-904 # sw_tdat
lui	sp,0xaa01
addi	sp,sp,-1376 # _start-0x755ff560
auipc	a5,0x0
addi	a5,a5,20 # test_1804+0x28
sw	sp,8(ra)
lw	a4,8(ra)
j	test_1804+0x2c
mv	a4,sp
lui	t2,0xaa01
addi	t2,t2,-1376 # _start-0x755ff560
bne	a4,t2,fail

test_1805:
li	gp,1805
auipc	ra,0x2
addi	ra,ra,-960 # sw_tdat
lui	sp,0xa00aa
addi	sp,sp,10 # _end+0x200a4f5a
auipc	a5,0x0
addi	a5,a5,20 # test_1805+0x28
sw	sp,12(ra)
lw	a4,12(ra)
j	test_1805+0x2c
mv	a4,sp
lui	t2,0xa00aa
addi	t2,t2,10 # _end+0x200a4f5a
bne	a4,t2,fail

test_1806:
li	gp,1806
auipc	ra,0x2
addi	ra,ra,-988 # sw_tdat8
lui	sp,0xaa0
addi	sp,sp,170 # _start-0x7f55ff56
auipc	a5,0x0
addi	a5,a5,20 # test_1806+0x28
sw	sp,-12(ra)
lw	a4,-12(ra)
j	test_1806+0x2c
mv	a4,sp
lui	t2,0xaa0
addi	t2,t2,170 # _start-0x7f55ff56
bne	a4,t2,fail

test_1807:
li	gp,1807
auipc	ra,0x2
addi	ra,ra,-1044 # sw_tdat8
lui	sp,0xaa00b
addi	sp,sp,-1536 # _end+0x2a005950
auipc	a5,0x0
addi	a5,a5,20 # test_1807+0x28
sw	sp,-8(ra)
lw	a4,-8(ra)
j	test_1807+0x2c
mv	a4,sp
lui	t2,0xaa00b
addi	t2,t2,-1536 # _end+0x2a005950
bne	a4,t2,fail

test_1808:
li	gp,1808
auipc	ra,0x2
addi	ra,ra,-1100 # sw_tdat8
lui	sp,0xaa01
addi	sp,sp,-1376 # _start-0x755ff560
auipc	a5,0x0
addi	a5,a5,20 # test_1808+0x28
sw	sp,-4(ra)
lw	a4,-4(ra)
j	test_1808+0x2c
mv	a4,sp
lui	t2,0xaa01
addi	t2,t2,-1376 # _start-0x755ff560
bne	a4,t2,fail

test_1809:
li	gp,1809
auipc	ra,0x2
addi	ra,ra,-1156 # sw_tdat8
lui	sp,0xa00aa
addi	sp,sp,10 # _end+0x200a4f5a
auipc	a5,0x0
addi	a5,a5,20 # test_1809+0x28
sw	sp,0(ra)
lw	a4,0(ra)
j	test_1809+0x2c
mv	a4,sp
lui	t2,0xa00aa
addi	t2,t2,10 # _end+0x200a4f5a
bne	a4,t2,fail

test_1810:
li	gp,1810
auipc	ra,0x2
addi	ra,ra,-1208 # sw_tdat9
lui	sp,0x12345
addi	sp,sp,1656 # _start-0x6dcba988
addi	tp,ra,-32
sw	sp,32(tp) # _start-0x7fffffe0
lw	t0,0(ra)
lui	t2,0x12345
addi	t2,t2,1656 # _start-0x6dcba988
bne	t0,t2,fail

test_1811:
li	gp,1811
auipc	ra,0x2
addi	ra,ra,-1252 # sw_tdat9
lui	sp,0x58213
addi	sp,sp,152 # _start-0x27decf68
addi	ra,ra,-3
sw	sp,7(ra)
auipc	tp,0x2
addi	tp,tp,-1272 # sw_tdat10
lw	t0,0(tp) # _start-0x80000000
lui	t2,0x58213
addi	t2,t2,152 # _start-0x27decf68
bne	t0,t2,fail

test_1812:
li	gp,1812
li	tp,0
lui	ra,0xaabbd
addi	ra,ra,-803 # _end+0x2abb7c2d
auipc	sp,0x2
addi	sp,sp,-1348 # sw_tdat
sw	ra,0(sp)
lw	a4,0(sp)
lui	t2,0xaabbd
addi	t2,t2,-803 # _end+0x2abb7c2d
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1812+0x8

test_1813:
li	gp,1813
li	tp,0
lui	ra,0xdaabc
addi	ra,ra,-819 # _end+0x5aab6c1d
auipc	sp,0x2
addi	sp,sp,-1404 # sw_tdat
nop
sw	ra,4(sp)
lw	a4,4(sp)
lui	t2,0xdaabc
addi	t2,t2,-819 # _end+0x5aab6c1d
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1813+0x8

test_1814:
li	gp,1814
li	tp,0
lui	ra,0xddaac
addi	ra,ra,-1076 # _end+0x5daa6b1c
auipc	sp,0x2
addi	sp,sp,-1464 # sw_tdat
nop
nop
sw	ra,8(sp)
lw	a4,8(sp)
lui	t2,0xddaac
addi	t2,t2,-1076 # _end+0x5daa6b1c
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1814+0x8

test_1815:
li	gp,1815
li	tp,0
lui	ra,0xcddab
addi	ra,ra,-1092 # _end+0x4dda5b0c
nop
auipc	sp,0x2
addi	sp,sp,-1532 # sw_tdat
sw	ra,12(sp)
lw	a4,12(sp)
lui	t2,0xcddab
addi	t2,t2,-1092 # _end+0x4dda5b0c
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1815+0x8

test_1816:
li	gp,1816
li	tp,0
lui	ra,0xccddb
addi	ra,ra,-1349 # _end+0x4cdd5a0b
nop
auipc	sp,0x2
addi	sp,sp,-1592 # sw_tdat
nop
sw	ra,16(sp)
lw	a4,16(sp)
lui	t2,0xccddb
addi	t2,t2,-1349 # _end+0x4cdd5a0b
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1816+0x8

test_1817:
li	gp,1817
li	tp,0
lui	ra,0xbccde
addi	ra,ra,-1365 # _end+0x3ccd89fb
nop
nop
auipc	sp,0x2
addi	sp,sp,-1660 # sw_tdat
sw	ra,20(sp)
lw	a4,20(sp)
lui	t2,0xbccde
addi	t2,t2,-1365 # _end+0x3ccd89fb
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1817+0x8

test_1818:
li	gp,1818
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1708 # sw_tdat
lui	ra,0x112
addi	ra,ra,563 # _start-0x7feeddcd
sw	ra,0(sp)
lw	a4,0(sp)
lui	t2,0x112
addi	t2,t2,563 # _start-0x7feeddcd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1818+0x8

test_1819:
li	gp,1819
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1764 # sw_tdat
lui	ra,0x30011
addi	ra,ra,547 # _start-0x4ffeeddd
nop
sw	ra,4(sp)
lw	a4,4(sp)
lui	t2,0x30011
addi	t2,t2,547 # _start-0x4ffeeddd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1819+0x8

test_1820:
li	gp,1820
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1824 # sw_tdat
lui	ra,0x33001
addi	ra,ra,290 # _start-0x4cffeede
nop
nop
sw	ra,8(sp)
lw	a4,8(sp)
lui	t2,0x33001
addi	t2,t2,290 # _start-0x4cffeede
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1820+0x8

test_1821:
li	gp,1821
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1888 # sw_tdat
nop
lui	ra,0x23300
addi	ra,ra,274 # _start-0x5ccffeee
sw	ra,12(sp)
lw	a4,12(sp)
lui	t2,0x23300
addi	t2,t2,274 # _start-0x5ccffeee
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1821+0x8

test_1822:
li	gp,1822
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1948 # sw_tdat
nop
lui	ra,0x22330
addi	ra,ra,17 # _start-0x5dccffef
nop
sw	ra,16(sp)
lw	a4,16(sp)
lui	t2,0x22330
addi	t2,t2,17 # _start-0x5dccffef
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1822+0x8

test_1823:
li	gp,1823
li	tp,0
auipc	sp,0x2
addi	sp,sp,-2012 # sw_tdat
nop
nop
lui	ra,0x12233
addi	ra,ra,1 # _start-0x6ddccfff
sw	ra,20(sp)
lw	a4,20(sp)
lui	t2,0x12233
addi	t2,t2,1 # _start-0x6ddccfff
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1823+0x8
bne	zero,gp,pass

.data

begin_signature:
.byte 0xff

lb_tdat2:
.byte 0x00

lb_tdat3:
.byte 0xf0

lb_tdat4:
.byte 0x0f

.zero 12

sb_tdat:
.byte 0

sb_tdat2:
.byte 0

sb_tdat3:
.byte 0

sb_tdat4:
.byte 0

sb_tdat5:
.byte 0

sb_tdat6:
.byte 0

sb_tdat7:
.byte 0

sb_tdat8:
.byte 0

sb_tdat9:
.byte 0

sb_tdat10:
.byte 0

.zero 6

lh_tdat:
.half 0

lh_tdat2:
.half 0

lh_tdat3:
.half 0

lh_tdat4:
.half 0

.zero 8

lw_tdat:
.word 0x00ff00ff

lw_tdat2:
.word 0xff00ff00

lw_tdat3:
.word 0x0ff00ff0

lw_tdat4:
.word 0xf00ff00f

sh_tdat:
.half 0

sh_tdat2:
.half 0

sh_tdat3:
.half 0

sh_tdat4:
.half 0

sh_tdat5:
.half 0

sh_tdat6:
.half 0

sh_tdat7:
.half 0

sh_tdat8:
.half 0

sh_tdat9:
.half 0

sh_tdat10:
.half 0

.zero 12

lbu_tdat:
.byte 0

lbu_tdat2:
.byte 0

lbu_tdat3:
.byte 0

lbu_tdat4:
.byte 0

.zero 12

lhu_tdat:
.half 0

lhu_tdat2:
.half 0

lhu_tdat3:
.half 0

lhu_tdat4:
.half 0

.zero 8

sw_tdat:
.word 0

sw_tdat2:
.word 0

sw_tdat3:
.word 0

sw_tdat4:
.word 0

sw_tdat5:
.word 0

sw_tdat6:
.word 0

sw_tdat7:
.word 0

sw_tdat8:
.word 0

sw_tdat9:
.word 0

sw_tdat10:
.word 0
