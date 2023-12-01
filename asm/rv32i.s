_start:
beq x0, x0, reset_vector

loop:
beq x0, x0, loop

.zero 68

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
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,0
add	a4,ra,sp
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_10
j	fail

test_10:
li	gp,10
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
add	a4,ra,sp
lui	t2,0x80008
addi	t2,t2,-2 # _end+0xffffdf2e
beq	a4,t2,test_11
j	fail

test_11:
li	gp,11
lui	ra,0x80000
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
add	a4,ra,sp
lui	t2,0x80008
addi	t2,t2,-1 # _end+0xffffdf2f
beq	a4,t2,test_12
j	fail

test_12:
li	gp,12
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
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
addi	sp,sp,-1 # _end+0xffff5f2f
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
addi	a4,ra,-2048 # _end+0xffff5730
lui	t2,0x80000
addi	t2,t2,-2048 # _end+0xffff5730
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
addi	ra,ra,-1 # _end+0xffff5f2f
mv	a4,ra
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_110
j	fail

test_110:
li	gp,110
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
addi	a4,ra,2047
lui	t2,0x80000
addi	t2,t2,2046 # _end+0xffff672e
beq	a4,t2,test_111
j	fail

test_111:
li	gp,111
lui	ra,0x80000
addi	a4,ra,2047 # _end+0xffff672f
lui	t2,0x80000
addi	t2,t2,2047 # _end+0xffff672f
beq	a4,t2,test_112
j	fail

test_112:
li	gp,112
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
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
addi	ra,ra,-1 # _end+0xffff5f2f
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
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
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
addi	ra,ra,15 # _end+0x700f4f3f
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
and	a4,ra,sp
lui	t2,0xf000f
beq	a4,t2,test_206
j	fail

test_206:
li	gp,206
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
and	sp,ra,sp
lui	t2,0xf00
addi	t2,t2,240 # _start-0x7f0fff10
beq	sp,t2,test_208
j	fail

test_208:
li	gp,208
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
and	ra,ra,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	ra,t2,test_209
j	fail

test_209:
li	gp,209
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
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
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
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
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
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
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
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
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	sp,sp,240 # _end+0x70f05020
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
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	ra,ra,-256 # _end+0x7f005e30
andi	a4,ra,-241
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
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
addi	ra,ra,15 # _end+0x700f4f3f
andi	a4,ra,240
li	t2,0
beq	a4,t2,test_306
j	fail

test_306:
li	gp,306
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
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
addi	ra,ra,15 # _end+0x700f4f3f
andi	a4,ra,-241
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_309+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
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
addi	ra,ra,15 # _end+0x700f4f3f
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
addi	a0,a0,1820 # test_1807+0x20
jal	a1,test_402+0x14
sub	a0,a0,a1
lui	t2,0x2
addi	t2,t2,1808 # _start-0x7fffd8f0
beq	a0,t2,test_403
j	fail

test_403:
li	gp,403
nop
auipc	a0,0xffffe
addi	a0,a0,-1796 # _start-0x16ac
jal	a1,test_403+0x14
sub	a0,a0,a1
lui	t2,0xffffe
addi	t2,t2,-1808 # _end+0x7fff3820
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

test_602:
li	gp,602
li	ra,0
li	sp,0
bge	ra,sp,test_602+0x1c
beq	zero,gp,test_602+0x18
j	fail
bne	zero,gp,test_603
bge	ra,sp,test_602+0x18
beq	zero,gp,test_603
j	fail

test_603:
li	gp,603
li	ra,1
li	sp,1
bge	ra,sp,test_603+0x1c
beq	zero,gp,test_603+0x18
j	fail
bne	zero,gp,test_604
bge	ra,sp,test_603+0x18
beq	zero,gp,test_604
j	fail

test_604:
li	gp,604
li	ra,-1
li	sp,-1
bge	ra,sp,test_604+0x1c
beq	zero,gp,test_604+0x18
j	fail
bne	zero,gp,test_605
bge	ra,sp,test_604+0x18
beq	zero,gp,test_605
j	fail

test_605:
li	gp,605
li	ra,1
li	sp,0
bge	ra,sp,test_605+0x1c
beq	zero,gp,test_605+0x18
j	fail
bne	zero,gp,test_606
bge	ra,sp,test_605+0x18
beq	zero,gp,test_606
j	fail

test_606:
li	gp,606
li	ra,1
li	sp,-1
bge	ra,sp,test_606+0x1c
beq	zero,gp,test_606+0x18
j	fail
bne	zero,gp,test_607
bge	ra,sp,test_606+0x18
beq	zero,gp,test_607
j	fail

test_607:
li	gp,607
li	ra,-1
li	sp,-2
bge	ra,sp,test_607+0x1c
beq	zero,gp,test_607+0x18
j	fail
bne	zero,gp,test_608
bge	ra,sp,test_607+0x18
beq	zero,gp,test_608
j	fail

test_608:
li	gp,608
li	ra,0
li	sp,1
bge	ra,sp,test_608+0x14
bne	zero,gp,test_608+0x1c
beq	zero,gp,test_608+0x1c
j	fail
bge	ra,sp,test_608+0x14

test_609:
li	gp,609
li	ra,-1
li	sp,1
bge	ra,sp,test_609+0x14
bne	zero,gp,test_609+0x1c
beq	zero,gp,test_609+0x1c
j	fail
bge	ra,sp,test_609+0x14

test_610:
li	gp,610
li	ra,-2
li	sp,-1
bge	ra,sp,test_610+0x14
bne	zero,gp,test_610+0x1c
beq	zero,gp,test_610+0x1c
j	fail
bge	ra,sp,test_610+0x14

test_611:
li	gp,611
li	ra,-2
li	sp,1
bge	ra,sp,test_611+0x14
bne	zero,gp,test_611+0x1c
beq	zero,gp,test_611+0x1c
j	fail
bge	ra,sp,test_611+0x14

test_612:
li	gp,612
li	tp,0
li	ra,-1
li	sp,0
blt	ra,sp,test_612+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_612+0x8

test_613:
li	gp,613
li	tp,0
li	ra,-1
li	sp,0
nop
blt	ra,sp,test_613+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_613+0x8

test_614:
li	gp,614
li	tp,0
li	ra,-1
li	sp,0
nop
nop
blt	ra,sp,test_614+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_614+0x8

test_615:
li	gp,615
li	tp,0
li	ra,-1
nop
li	sp,0
blt	ra,sp,test_615+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_615+0x8

test_616:
li	gp,616
li	tp,0
li	ra,-1
nop
li	sp,0
nop
blt	ra,sp,test_616+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_616+0x8

test_617:
li	gp,617
li	tp,0
li	ra,-1
nop
nop
li	sp,0
blt	ra,sp,test_617+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_617+0x8

test_618:
li	gp,618
li	tp,0
li	ra,-1
li	sp,0
blt	ra,sp,test_618+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_618+0x8

test_619:
li	gp,619
li	tp,0
li	ra,-1
li	sp,0
nop
blt	ra,sp,test_619+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_619+0x8

test_620:
li	gp,620
li	tp,0
li	ra,-1
li	sp,0
nop
nop
blt	ra,sp,test_620+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_620+0x8

test_621:
li	gp,621
li	tp,0
li	ra,-1
nop
li	sp,0
blt	ra,sp,test_621+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_621+0x8

test_622:
li	gp,622
li	tp,0
li	ra,-1
nop
li	sp,0
nop
blt	ra,sp,test_622+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_622+0x8

test_623:
li	gp,623
li	tp,0
li	ra,-1
nop
nop
li	sp,0
blt	ra,sp,test_623+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_623+0x8

jalr_test_2:
li	gp,702
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
li	gp,703
auipc	t0,0x0
addi	t0,t0,16 # jalr_target_3
jalr	t0,t0

jalr_linkaddr_3:
j	fail

jalr_target_3:
auipc	t1,0x0
addi	t1,t1,-4 # jalr_linkaddr_3
beq	t0,t1,test_704
j	fail

test_704:
li	gp,704
li	tp,0
auipc	t1,0x0
addi	t1,t1,20 # test_704+0x1c
jalr	a3,t1
beq	zero,gp,test_704+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_704+0x8

test_705:
li	gp,705
li	tp,0
auipc	t1,0x0
addi	t1,t1,24 # test_705+0x20
nop
jalr	a3,t1
beq	zero,gp,test_705+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_705+0x8

test_706:
li	gp,706
li	tp,0
auipc	t1,0x0
addi	t1,t1,28 # test_706+0x24
nop
nop
jalr	a3,t1
beq	zero,gp,test_706+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_706+0x8

test_802:
li	gp,802
li	a5,-1
auipc	ra,0x9
addi	ra,ra,-1944 # begin_signature
lb	a4,0(ra)
li	t2,-1
beq	a4,t2,test_803
j	fail

test_803:
li	gp,803
li	a5,0
auipc	ra,0x9
addi	ra,ra,-1976 # begin_signature
lb	a4,1(ra)
li	t2,0
beq	a4,t2,test_804
j	fail

test_804:
li	gp,804
li	a5,-16
auipc	ra,0x9
addi	ra,ra,-2008 # begin_signature
lb	a4,2(ra)
li	t2,-16
beq	a4,t2,test_805
j	fail

test_805:
li	gp,805
li	a5,15
auipc	ra,0x9
addi	ra,ra,-2040 # begin_signature
lb	a4,3(ra)
li	t2,15
beq	a4,t2,test_806
j	fail

test_806:
li	gp,806
li	a5,-1
auipc	ra,0x8
addi	ra,ra,2027 # lb_tdat4
lb	a4,-3(ra)
li	t2,-1
beq	a4,t2,test_807
j	fail

test_807:
li	gp,807
li	a5,0
auipc	ra,0x8
addi	ra,ra,1995 # lb_tdat4
lb	a4,-2(ra)
li	t2,0
beq	a4,t2,test_808
j	fail

test_808:
li	gp,808
li	a5,-16
auipc	ra,0x8
addi	ra,ra,1963 # lb_tdat4
lb	a4,-1(ra)
li	t2,-16
beq	a4,t2,test_809
j	fail

test_809:
li	gp,809
li	a5,15
auipc	ra,0x8
addi	ra,ra,1931 # lb_tdat4
lb	a4,0(ra)
li	t2,15
beq	a4,t2,test_810
j	fail

test_810:
li	gp,810
auipc	ra,0x8
addi	ra,ra,1900 # begin_signature
addi	ra,ra,-32
lb	t0,32(ra)
li	t2,-1
beq	t0,t2,test_811
j	fail

test_811:
li	gp,811
auipc	ra,0x8
addi	ra,ra,1868 # begin_signature
addi	ra,ra,-6
lb	t0,7(ra)
li	t2,0
beq	t0,t2,test_812
j	fail

test_812:
li	gp,812
li	tp,0
auipc	ra,0x8
addi	ra,ra,1833 # lb_tdat2
lb	a4,1(ra)
mv	t1,a4
li	t2,-16
beq	t1,t2,test_812+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_812+0x8

test_813:
li	gp,813
li	tp,0
auipc	ra,0x8
addi	ra,ra,1786 # lb_tdat3
lb	a4,1(ra)
nop
mv	t1,a4
li	t2,15
beq	t1,t2,test_813+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_813+0x8

test_814:
li	gp,814
li	tp,0
auipc	ra,0x8
addi	ra,ra,1732 # begin_signature
lb	a4,1(ra)
nop
nop
mv	t1,a4
li	t2,0
beq	t1,t2,test_814+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_814+0x8

test_815:
li	gp,815
li	tp,0
auipc	ra,0x8
addi	ra,ra,1677 # lb_tdat2
lb	a4,1(ra)
li	t2,-16
beq	a4,t2,test_815+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_815+0x8

test_816:
li	gp,816
li	tp,0
auipc	ra,0x8
addi	ra,ra,1634 # lb_tdat3
nop
lb	a4,1(ra)
li	t2,15
beq	a4,t2,test_816+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_816+0x8

test_817:
li	gp,817
li	tp,0
auipc	ra,0x8
addi	ra,ra,1584 # begin_signature
nop
nop
lb	a4,1(ra)
li	t2,0
beq	a4,t2,test_817+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_817+0x8

test_818:
li	gp,818
auipc	t0,0x8
addi	t0,t0,1536 # begin_signature
lb	sp,0(t0)
li	sp,2
li	t2,2
beq	sp,t2,test_819
j	fail

test_819:
li	gp,819
auipc	t0,0x8
addi	t0,t0,1504 # begin_signature
lb	sp,0(t0)
nop
li	sp,2
li	t2,2
beq	sp,t2,test_902
j	fail

test_902:
li	gp,902
auipc	ra,0x8
addi	ra,ra,1484 # sb_tdat
li	sp,-86
auipc	a5,0x0
addi	a5,a5,20 # test_902+0x24
sb	sp,0(ra)
lb	a4,0(ra)
j	test_902+0x28
mv	a4,sp
li	t2,-86
beq	a4,t2,test_903
j	fail

test_903:
li	gp,903
auipc	ra,0x8
addi	ra,ra,1432 # sb_tdat
li	sp,0
auipc	a5,0x0
addi	a5,a5,20 # test_903+0x24
sb	sp,1(ra)
lb	a4,1(ra)
j	test_903+0x28
mv	a4,sp
li	t2,0
beq	a4,t2,test_904
j	fail

test_904:
li	gp,904
auipc	ra,0x8
addi	ra,ra,1380 # sb_tdat
lui	sp,0xfffff
addi	sp,sp,-96 # _end+0x7fff4ed0
auipc	a5,0x0
addi	a5,a5,20 # test_904+0x28
sb	sp,2(ra)
lh	a4,2(ra)
j	test_904+0x2c
mv	a4,sp
lui	t2,0xfffff
addi	t2,t2,-96 # _end+0x7fff4ed0
beq	a4,t2,test_905
j	fail

test_905:
li	gp,905
auipc	ra,0x8
addi	ra,ra,1320 # sb_tdat
li	sp,10
auipc	a5,0x0
addi	a5,a5,20 # test_905+0x24
sb	sp,3(ra)
lb	a4,3(ra)
j	test_905+0x28
mv	a4,sp
li	t2,10
beq	a4,t2,test_906
j	fail

test_906:
li	gp,906
auipc	ra,0x8
addi	ra,ra,1275 # sb_tdat8
li	sp,-86
auipc	a5,0x0
addi	a5,a5,20 # test_906+0x24
sb	sp,-3(ra)
lb	a4,-3(ra)
j	test_906+0x28
mv	a4,sp
li	t2,-86
beq	a4,t2,test_907
j	fail

test_907:
li	gp,907
auipc	ra,0x8
addi	ra,ra,1223 # sb_tdat8
li	sp,0
auipc	a5,0x0
addi	a5,a5,20 # test_907+0x24
sb	sp,-2(ra)
lb	a4,-2(ra)
j	test_907+0x28
mv	a4,sp
li	t2,0
beq	a4,t2,test_908
j	fail

test_908:
li	gp,908
auipc	ra,0x8
addi	ra,ra,1171 # sb_tdat8
li	sp,-96
auipc	a5,0x0
addi	a5,a5,20 # test_908+0x24
sb	sp,-1(ra)
lb	a4,-1(ra)
j	test_908+0x28
mv	a4,sp
li	t2,-96
beq	a4,t2,test_909
j	fail

test_909:
li	gp,909
auipc	ra,0x8
addi	ra,ra,1119 # sb_tdat8
li	sp,10
auipc	a5,0x0
addi	a5,a5,20 # test_909+0x24
sb	sp,0(ra)
lb	a4,0(ra)
j	test_909+0x28
mv	a4,sp
li	t2,10
beq	a4,t2,test_910
j	fail

test_910:
li	gp,910
auipc	ra,0x8
addi	ra,ra,1068 # sb_tdat9
lui	sp,0x12345
addi	sp,sp,1656 # _start-0x6dcba988
addi	tp,ra,-32
sb	sp,32(tp) # _start-0x7fffffe0
lb	t0,0(ra)
li	t2,120
beq	t0,t2,test_911
j	fail

test_911:
li	gp,911
auipc	ra,0x8
addi	ra,ra,1024 # sb_tdat9
lui	sp,0x3
addi	sp,sp,152 # _start-0x7fffcf68
addi	ra,ra,-6
sb	sp,7(ra)
auipc	tp,0x8
addi	tp,tp,1001 # sb_tdat10
lb	t0,0(tp) # _start-0x80000000
li	t2,-104
beq	t0,t2,test_912
j	fail

test_912:
li	gp,912
li	tp,0
li	ra,-35
auipc	sp,0x8
addi	sp,sp,956 # sb_tdat
sb	ra,0(sp)
lb	a4,0(sp)
li	t2,-35
beq	a4,t2,test_912+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_912+0x8

test_913:
li	gp,913
li	tp,0
li	ra,-51
auipc	sp,0x8
addi	sp,sp,904 # sb_tdat
nop
sb	ra,1(sp)
lb	a4,1(sp)
li	t2,-51
beq	a4,t2,test_913+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_913+0x8

test_914:
li	gp,914
li	tp,0
li	ra,-52
auipc	sp,0x8
addi	sp,sp,848 # sb_tdat
nop
nop
sb	ra,2(sp)
lb	a4,2(sp)
li	t2,-52
beq	a4,t2,test_914+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_914+0x8

test_915:
li	gp,915
li	tp,0
li	ra,-68
nop
auipc	sp,0x8
addi	sp,sp,784 # sb_tdat
sb	ra,3(sp)
lb	a4,3(sp)
li	t2,-68
beq	a4,t2,test_915+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_915+0x8

test_916:
li	gp,916
li	tp,0
li	ra,-69
nop
auipc	sp,0x8
addi	sp,sp,728 # sb_tdat
nop
sb	ra,4(sp)
lb	a4,4(sp)
li	t2,-69
beq	a4,t2,test_916+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_916+0x8

test_917:
li	gp,917
li	tp,0
li	ra,-85
nop
nop
auipc	sp,0x8
addi	sp,sp,664 # sb_tdat
sb	ra,5(sp)
lb	a4,5(sp)
li	t2,-85
beq	a4,t2,test_917+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_917+0x8

test_918:
li	gp,918
li	tp,0
auipc	sp,0x8
addi	sp,sp,616 # sb_tdat
li	ra,51
sb	ra,0(sp)
lb	a4,0(sp)
li	t2,51
beq	a4,t2,test_918+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_918+0x8

test_919:
li	gp,919
li	tp,0
auipc	sp,0x8
addi	sp,sp,564 # sb_tdat
li	ra,35
nop
sb	ra,1(sp)
lb	a4,1(sp)
li	t2,35
beq	a4,t2,test_919+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_919+0x8

test_920:
li	gp,920
li	tp,0
auipc	sp,0x8
addi	sp,sp,508 # sb_tdat
li	ra,34
nop
nop
sb	ra,2(sp)
lb	a4,2(sp)
li	t2,34
beq	a4,t2,test_920+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_920+0x8

test_921:
li	gp,921
li	tp,0
auipc	sp,0x8
addi	sp,sp,448 # sb_tdat
nop
li	ra,18
sb	ra,3(sp)
lb	a4,3(sp)
li	t2,18
beq	a4,t2,test_921+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_921+0x8

test_922:
li	gp,922
li	tp,0
auipc	sp,0x8
addi	sp,sp,392 # sb_tdat
nop
li	ra,17
nop
sb	ra,4(sp)
lb	a4,4(sp)
li	t2,17
beq	a4,t2,test_922+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_922+0x8

test_923:
li	gp,923
li	tp,0
auipc	sp,0x8
addi	sp,sp,332 # sb_tdat
nop
nop
li	ra,1
sb	ra,5(sp)
lb	a4,5(sp)
li	t2,1
beq	a4,t2,test_923+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_923+0x8
li	a0,239
auipc	a1,0x8
addi	a1,a1,276 # sb_tdat
sb	a0,3(a1)

test_1002:
li	gp,1002
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1003
j	fail

test_1003:
li	gp,1003
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
xor	a4,ra,sp
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1004
j	fail

test_1004:
li	gp,1004
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1005
j	fail

test_1005:
li	gp,1005
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
xor	a4,ra,sp
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	a4,t2,test_1006
j	fail

test_1006:
li	gp,1006
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	ra,ra,sp
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	ra,t2,test_1007
j	fail

test_1007:
li	gp,1007
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	sp,ra,sp
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	sp,t2,test_1008
j	fail

test_1008:
li	gp,1008
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
xor	ra,ra,ra
li	t2,0
beq	ra,t2,test_1009
j	fail

test_1009:
li	gp,1009
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1009+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	t1,t2,test_1010
j	fail

test_1010:
li	gp,1010
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
xor	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1010+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	t1,t2,test_1011
j	fail

test_1011:
li	gp,1011
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
bne	tp,t0,test_1011+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	t1,t2,test_1012
j	fail

test_1012:
li	gp,1012
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1012+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1013
j	fail

test_1013:
li	gp,1013
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1013+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1014
j	fail

test_1014:
li	gp,1014
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
bne	tp,t0,test_1014+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1015
j	fail

test_1015:
li	gp,1015
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1015+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1016
j	fail

test_1016:
li	gp,1016
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1016+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1017
j	fail

test_1017:
li	gp,1017
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
bne	tp,t0,test_1017+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1018
j	fail

test_1018:
li	gp,1018
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1018+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1019
j	fail

test_1019:
li	gp,1019
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1019+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1020
j	fail

test_1020:
li	gp,1020
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
bne	tp,t0,test_1020+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1021
j	fail

test_1021:
li	gp,1021
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1021+0x8
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1022
j	fail

test_1022:
li	gp,1022
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
nop
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
xor	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1022+0x8
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1023
j	fail

test_1023:
li	gp,1023
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
bne	tp,t0,test_1023+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1024
j	fail

test_1024:
li	gp,1024
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
xor	sp,zero,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	sp,t2,test_1025
j	fail

test_1025:
li	gp,1025
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
xor	sp,ra,zero
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	sp,t2,test_1026
j	fail

test_1026:
li	gp,1026
xor	ra,zero,zero
li	t2,0
beq	ra,t2,test_1027
j	fail

test_1027:
li	gp,1027
lui	ra,0x11111
addi	ra,ra,273 # _start-0x6eeeeeef
lui	sp,0x22222
addi	sp,sp,546 # _start-0x5dddddde
xor	zero,ra,sp
li	t2,0
beq	zero,t2,test_1102
j	fail

test_1102:
li	gp,1102
li	ra,0
li	sp,1
blt	ra,sp,test_1102+0x1c
beq	zero,gp,test_1102+0x18
j	fail
bne	zero,gp,test_1103
blt	ra,sp,test_1102+0x18
beq	zero,gp,test_1103
j	fail

test_1103:
li	gp,1103
li	ra,-1
li	sp,1
blt	ra,sp,test_1103+0x1c
beq	zero,gp,test_1103+0x18
j	fail
bne	zero,gp,test_1104
blt	ra,sp,test_1103+0x18
beq	zero,gp,test_1104
j	fail

test_1104:
li	gp,1104
li	ra,-2
li	sp,-1
blt	ra,sp,test_1104+0x1c
beq	zero,gp,test_1104+0x18
j	fail
bne	zero,gp,test_1105
blt	ra,sp,test_1104+0x18
beq	zero,gp,test_1105
j	fail

test_1105:
li	gp,1105
li	ra,1
li	sp,0
blt	ra,sp,test_1105+0x14
bne	zero,gp,test_1105+0x1c
beq	zero,gp,test_1105+0x1c
j	fail
blt	ra,sp,test_1105+0x14

test_1106:
li	gp,1106
li	ra,1
li	sp,-1
blt	ra,sp,test_1106+0x14
bne	zero,gp,test_1106+0x1c
beq	zero,gp,test_1106+0x1c
j	fail
blt	ra,sp,test_1106+0x14

test_1107:
li	gp,1107
li	ra,-1
li	sp,-2
blt	ra,sp,test_1107+0x14
bne	zero,gp,test_1107+0x1c
beq	zero,gp,test_1107+0x1c
j	fail
blt	ra,sp,test_1107+0x14

test_1108:
li	gp,1108
li	ra,1
li	sp,-2
blt	ra,sp,test_1108+0x14
bne	zero,gp,test_1108+0x1c
beq	zero,gp,test_1108+0x1c
j	fail
blt	ra,sp,test_1108+0x14

test_1109:
li	gp,1109
li	tp,0
li	ra,0
li	sp,-1
bge	ra,sp,test_1109+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1109+0x8

test_1110:
li	gp,1110
li	tp,0
li	ra,0
li	sp,-1
nop
bge	ra,sp,test_1110+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1110+0x8

test_1111:
li	gp,1111
li	tp,0
li	ra,0
li	sp,-1
nop
nop
bge	ra,sp,test_1111+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1111+0x8

test_1112:
li	gp,1112
li	tp,0
li	ra,0
nop
li	sp,-1
bge	ra,sp,test_1112+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1112+0x8

test_1113:
li	gp,1113
li	tp,0
li	ra,0
nop
li	sp,-1
nop
bge	ra,sp,test_1113+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1113+0x8

test_1114:
li	gp,1114
li	tp,0
li	ra,0
nop
nop
li	sp,-1
bge	ra,sp,test_1114+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1114+0x8

test_1115:
li	gp,1115
li	tp,0
li	ra,0
li	sp,-1
bge	ra,sp,test_1115+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1115+0x8

test_1116:
li	gp,1116
li	tp,0
li	ra,0
li	sp,-1
nop
bge	ra,sp,test_1116+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1116+0x8

test_1117:
li	gp,1117
li	tp,0
li	ra,0
li	sp,-1
nop
nop
bge	ra,sp,test_1117+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1117+0x8

test_1118:
li	gp,1118
li	tp,0
li	ra,0
nop
li	sp,-1
bge	ra,sp,test_1118+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1118+0x8

test_1119:
li	gp,1119
li	tp,0
li	ra,0
nop
li	sp,-1
nop
bge	ra,sp,test_1119+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1119+0x8

test_1120:
li	gp,1120
li	tp,0
li	ra,0
nop
nop
li	sp,-1
bge	ra,sp,test_1120+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1120+0x8

test_1121:
li	gp,1121
li	ra,1
bgtz	ra,test_1121+0x1c
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
li	ra,0
li	sp,1
bne	ra,sp,test_1202+0x1c
beq	zero,gp,test_1202+0x18
j	fail
bne	zero,gp,test_1203
bne	ra,sp,test_1202+0x18
beq	zero,gp,test_1203
j	fail

test_1203:
li	gp,1203
li	ra,1
li	sp,0
bne	ra,sp,test_1203+0x1c
beq	zero,gp,test_1203+0x18
j	fail
bne	zero,gp,test_1204
bne	ra,sp,test_1203+0x18
beq	zero,gp,test_1204
j	fail

test_1204:
li	gp,1204
li	ra,-1
li	sp,1
bne	ra,sp,test_1204+0x1c
beq	zero,gp,test_1204+0x18
j	fail
bne	zero,gp,test_1205
bne	ra,sp,test_1204+0x18
beq	zero,gp,test_1205
j	fail

test_1205:
li	gp,1205
li	ra,1
li	sp,-1
bne	ra,sp,test_1205+0x1c
beq	zero,gp,test_1205+0x18
j	fail
bne	zero,gp,test_1206
bne	ra,sp,test_1205+0x18
beq	zero,gp,test_1206
j	fail

test_1206:
li	gp,1206
li	ra,0
li	sp,0
bne	ra,sp,test_1206+0x14
bne	zero,gp,test_1206+0x1c
beq	zero,gp,test_1206+0x1c
j	fail
bne	ra,sp,test_1206+0x14

test_1207:
li	gp,1207
li	ra,1
li	sp,1
bne	ra,sp,test_1207+0x14
bne	zero,gp,test_1207+0x1c
beq	zero,gp,test_1207+0x1c
j	fail
bne	ra,sp,test_1207+0x14

test_1208:
li	gp,1208
li	ra,-1
li	sp,-1
bne	ra,sp,test_1208+0x14
bne	zero,gp,test_1208+0x1c
beq	zero,gp,test_1208+0x1c
j	fail
bne	ra,sp,test_1208+0x14

test_1209:
li	gp,1209
li	tp,0
li	ra,0
li	sp,0
beq	ra,sp,test_1209+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1209+0x8

test_1210:
li	gp,1210
li	tp,0
li	ra,0
li	sp,0
nop
beq	ra,sp,test_1210+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1210+0x8

test_1211:
li	gp,1211
li	tp,0
li	ra,0
li	sp,0
nop
nop
beq	ra,sp,test_1211+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1211+0x8

test_1212:
li	gp,1212
li	tp,0
li	ra,0
nop
li	sp,0
beq	ra,sp,test_1212+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1212+0x8

test_1213:
li	gp,1213
li	tp,0
li	ra,0
nop
li	sp,0
nop
beq	ra,sp,test_1213+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1213+0x8

test_1214:
li	gp,1214
li	tp,0
li	ra,0
nop
nop
li	sp,0
beq	ra,sp,test_1214+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1214+0x8

test_1215:
li	gp,1215
li	tp,0
li	ra,0
li	sp,0
beq	ra,sp,test_1215+0x18
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1215+0x8

test_1216:
li	gp,1216
li	tp,0
li	ra,0
li	sp,0
nop
beq	ra,sp,test_1216+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1216+0x8

test_1217:
li	gp,1217
li	tp,0
li	ra,0
li	sp,0
nop
nop
beq	ra,sp,test_1217+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1217+0x8

test_1218:
li	gp,1218
li	tp,0
li	ra,0
nop
li	sp,0
beq	ra,sp,test_1218+0x1c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1218+0x8

test_1219:
li	gp,1219
li	tp,0
li	ra,0
nop
li	sp,0
nop
beq	ra,sp,test_1219+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1219+0x8

test_1220:
li	gp,1220
li	tp,0
li	ra,0
nop
nop
li	sp,0
beq	ra,sp,test_1220+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1220+0x8

test_1221:
li	gp,1221
li	ra,1
bnez	ra,test_1221+0x1c
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
li	t2,3
beq	ra,t2,test_1221+0x30
j	fail
li	a3,111
auipc	a0,0x7
lh	a0,1464(a0) # fence_i_insn
auipc	a1,0x7
lh	a1,1458(a1) # fence_i_insn+0x2
nop
nop
auipc	t0,0x7
sh	a0,1444(t0) # fence_i_insn+0x4
auipc	t0,0x7
sh	a1,1438(t0) # fence_i_insn+0x6
fence.i
auipc	a5,0x7
addi	a5,a5,1424 # fence_i_insn+0x4
jalr	a6,a5

test_1302:
li	gp,1302
nop
li	t2,444
beq	a3,t2,test_1302+0x14
j	fail
li	a4,100
addi	a4,a4,-1
bnez	a4,test_1302+0x18
auipc	t0,0x7
sh	a0,1388(t0) # fence_i_insn+0xc
auipc	t0,0x7
sh	a1,1382(t0) # fence_i_insn+0xe
fence.i
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
auipc	a5,0x7
addi	a5,a5,1324 # fence_i_insn+0xc
jalr	a6,a5

test_1303:
li	gp,1303
nop
li	t2,777
beq	a3,t2,jal_test_2
j	fail

jal_test_2:
li	gp,1402
li	ra,0
jal	tp,jal_target_2

jal_linkaddr_2:
nop
nop
j	fail

jal_target_2:
auipc	sp,0x0
addi	sp,sp,-12 # jal_linkaddr_2
beq	sp,tp,test_1403
j	fail

test_1403:
li	gp,1403
li	ra,1
j	test_1403+0x1c
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
li	t2,3
beq	ra,t2,test_1502
j	fail

test_1502:
li	gp,1502
li	a5,255
auipc	ra,0x7
addi	ra,ra,1216 # lh_tdat
lh	a4,0(ra)
li	t2,255
beq	a4,t2,test_1503
j	fail

test_1503:
li	gp,1503
li	a5,-256
auipc	ra,0x7
addi	ra,ra,1184 # lh_tdat
lh	a4,2(ra)
li	t2,-256
beq	a4,t2,test_1504
j	fail

test_1504:
li	gp,1504
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x7
addi	ra,ra,1148 # lh_tdat
lh	a4,4(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
beq	a4,t2,test_1505
j	fail

test_1505:
li	gp,1505
lui	a5,0xfffff
addi	a5,a5,15 # _end+0x7fff4f3f
auipc	ra,0x7
addi	ra,ra,1108 # lh_tdat
lh	a4,6(ra)
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fff4f3f
beq	a4,t2,test_1506
j	fail

test_1506:
li	gp,1506
li	a5,255
auipc	ra,0x7
addi	ra,ra,1078 # lh_tdat4
lh	a4,-6(ra)
li	t2,255
beq	a4,t2,test_1507
j	fail

test_1507:
li	gp,1507
li	a5,-256
auipc	ra,0x7
addi	ra,ra,1046 # lh_tdat4
lh	a4,-4(ra)
li	t2,-256
beq	a4,t2,test_1508
j	fail

test_1508:
li	gp,1508
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x7
addi	ra,ra,1010 # lh_tdat4
lh	a4,-2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
beq	a4,t2,test_1509
j	fail

test_1509:
li	gp,1509
lui	a5,0xfffff
addi	a5,a5,15 # _end+0x7fff4f3f
auipc	ra,0x7
addi	ra,ra,970 # lh_tdat4
lh	a4,0(ra)
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fff4f3f
beq	a4,t2,test_1510
j	fail

test_1510:
li	gp,1510
auipc	ra,0x7
addi	ra,ra,932 # lh_tdat
addi	ra,ra,-32
lh	t0,32(ra)
li	t2,255
beq	t0,t2,test_1511
j	fail

test_1511:
li	gp,1511
auipc	ra,0x7
addi	ra,ra,900 # lh_tdat
addi	ra,ra,-5
lh	t0,7(ra)
li	t2,-256
beq	t0,t2,test_1512
j	fail

test_1512:
li	gp,1512
li	tp,0
auipc	ra,0x7
addi	ra,ra,866 # lh_tdat2
lh	a4,2(ra)
mv	t1,a4
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
beq	t1,t2,test_1512+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1512+0x8

test_1513:
li	gp,1513
li	tp,0
auipc	ra,0x7
addi	ra,ra,816 # lh_tdat3
lh	a4,2(ra)
nop
mv	t1,a4
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fff4f3f
beq	t1,t2,test_1513+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1513+0x8

test_1514:
li	gp,1514
li	tp,0
auipc	ra,0x7
addi	ra,ra,756 # lh_tdat
lh	a4,2(ra)
nop
nop
mv	t1,a4
li	t2,-256
beq	t1,t2,test_1514+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1514+0x8

test_1515:
li	gp,1515
li	tp,0
auipc	ra,0x7
addi	ra,ra,702 # lh_tdat2
lh	a4,2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
beq	a4,t2,test_1515+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1515+0x8

test_1516:
li	gp,1516
li	tp,0
auipc	ra,0x7
addi	ra,ra,656 # lh_tdat3
nop
lh	a4,2(ra)
lui	t2,0xfffff
addi	t2,t2,15 # _end+0x7fff4f3f
beq	a4,t2,test_1516+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1516+0x8

test_1517:
li	gp,1517
li	tp,0
auipc	ra,0x7
addi	ra,ra,600 # lh_tdat
nop
nop
lh	a4,2(ra)
li	t2,-256
beq	a4,t2,test_1517+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1517+0x8

test_1518:
li	gp,1518
auipc	t0,0x7
addi	t0,t0,552 # lh_tdat
lh	sp,0(t0)
li	sp,2
li	t2,2
beq	sp,t2,test_1519
j	fail

test_1519:
li	gp,1519
auipc	t0,0x7
addi	t0,t0,520 # lh_tdat
lh	sp,0(t0)
nop
li	sp,2
li	t2,2
beq	sp,t2,test_1602
j	fail

test_1602:
li	gp,1602
lui	a5,0xff0
addi	a5,a5,255 # _start-0x7f00ff01
auipc	ra,0x7
addi	ra,ra,492 # lw_tdat
lw	a4,0(ra)
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	a4,t2,test_1603
j	fail

test_1603:
li	gp,1603
lui	a5,0xff010
addi	a5,a5,-256 # _end+0x7f005e30
auipc	ra,0x7
addi	ra,ra,452 # lw_tdat
lw	a4,4(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1604
j	fail

test_1604:
li	gp,1604
lui	a5,0xff01
addi	a5,a5,-16 # _start-0x700ff010
auipc	ra,0x7
addi	ra,ra,412 # lw_tdat
lw	a4,8(ra)
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1605
j	fail

test_1605:
li	gp,1605
lui	a5,0xf00ff
addi	a5,a5,15 # _end+0x700f4f3f
auipc	ra,0x7
addi	ra,ra,372 # lw_tdat
lw	a4,12(ra)
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1606
j	fail

test_1606:
li	gp,1606
lui	a5,0xff0
addi	a5,a5,255 # _start-0x7f00ff01
auipc	ra,0x7
addi	ra,ra,344 # lw_tdat4
lw	a4,-12(ra)
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	a4,t2,test_1607
j	fail

test_1607:
li	gp,1607
lui	a5,0xff010
addi	a5,a5,-256 # _end+0x7f005e30
auipc	ra,0x7
addi	ra,ra,304 # lw_tdat4
lw	a4,-8(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1608
j	fail

test_1608:
li	gp,1608
lui	a5,0xff01
addi	a5,a5,-16 # _start-0x700ff010
auipc	ra,0x7
addi	ra,ra,264 # lw_tdat4
lw	a4,-4(ra)
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1609
j	fail

test_1609:
li	gp,1609
lui	a5,0xf00ff
addi	a5,a5,15 # _end+0x700f4f3f
auipc	ra,0x7
addi	ra,ra,224 # lw_tdat4
lw	a4,0(ra)
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1610
j	fail

test_1610:
li	gp,1610
auipc	ra,0x7
addi	ra,ra,180 # lw_tdat
addi	ra,ra,-32
lw	t0,32(ra)
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	t0,t2,test_1611
j	fail

test_1611:
li	gp,1611
auipc	ra,0x7
addi	ra,ra,144 # lw_tdat
addi	ra,ra,-3
lw	t0,7(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	t0,t2,test_1612
j	fail

test_1612:
li	gp,1612
li	tp,0
auipc	ra,0x7
addi	ra,ra,108 # lw_tdat2
lw	a4,4(ra)
mv	t1,a4
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	t1,t2,test_1612+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1612+0x8

test_1613:
li	gp,1613
li	tp,0
auipc	ra,0x7
addi	ra,ra,60 # lw_tdat3
lw	a4,4(ra)
nop
mv	t1,a4
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	t1,t2,test_1613+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1613+0x8

test_1614:
li	gp,1614
li	tp,0
auipc	ra,0x7
addi	ra,ra,-4 # lw_tdat
lw	a4,4(ra)
nop
nop
mv	t1,a4
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	t1,t2,test_1614+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1614+0x8

test_1615:
li	gp,1615
li	tp,0
auipc	ra,0x7
addi	ra,ra,-60 # lw_tdat2
lw	a4,4(ra)
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1615+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1615+0x8

test_1616:
li	gp,1616
li	tp,0
auipc	ra,0x7
addi	ra,ra,-104 # lw_tdat3
nop
lw	a4,4(ra)
lui	t2,0xf00ff
addi	t2,t2,15 # _end+0x700f4f3f
beq	a4,t2,test_1616+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1616+0x8

test_1617:
li	gp,1617
li	tp,0
auipc	ra,0x7
addi	ra,ra,-164 # lw_tdat
nop
nop
lw	a4,4(ra)
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	a4,t2,test_1617+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1617+0x8

test_1618:
li	gp,1618
auipc	t0,0x7
addi	t0,t0,-216 # lw_tdat
lw	sp,0(t0)
li	sp,2
li	t2,2
beq	sp,t2,test_1619
j	fail

test_1619:
li	gp,1619
auipc	t0,0x7
addi	t0,t0,-248 # lw_tdat
lw	sp,0(t0)
nop
li	sp,2
li	t2,2
beq	sp,t2,test_1702
j	fail

test_1702:
li	gp,1702
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	a4,t2,test_1703
j	fail

test_1703:
li	gp,1703
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
or	a4,ra,sp
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff05f20
beq	a4,t2,test_1704
j	fail

test_1704:
li	gp,1704
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	a4,t2,test_1705
j	fail

test_1705:
li	gp,1705
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
or	a4,ra,sp
lui	t2,0xf0fff
addi	t2,t2,255 # _end+0x70ff502f
beq	a4,t2,test_1706
j	fail

test_1706:
li	gp,1706
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	ra,ra,sp
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	ra,t2,test_1707
j	fail

test_1707:
li	gp,1707
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	sp,ra,sp
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	sp,t2,test_1708
j	fail

test_1708:
li	gp,1708
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
or	ra,ra,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	ra,t2,test_1709
j	fail

test_1709:
li	gp,1709
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1709+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	t1,t2,test_1710
j	fail

test_1710:
li	gp,1710
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
or	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1710+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff05f20
beq	t1,t2,test_1711
j	fail

test_1711:
li	gp,1711
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
bne	tp,t0,test_1711+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	t1,t2,test_1712
j	fail

test_1712:
li	gp,1712
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1712+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	a4,t2,test_1713
j	fail

test_1713:
li	gp,1713
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1713+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff05f20
beq	a4,t2,test_1714
j	fail

test_1714:
li	gp,1714
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
bne	tp,t0,test_1714+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	a4,t2,test_1715
j	fail

test_1715:
li	gp,1715
li	tp,0
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
nop
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1715+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	a4,t2,test_1716
j	fail

test_1716:
li	gp,1716
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1716+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff05f20
beq	a4,t2,test_1717
j	fail

test_1717:
li	gp,1717
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
bne	tp,t0,test_1717+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	a4,t2,test_1718
j	fail

test_1718:
li	gp,1718
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1718+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	a4,t2,test_1719
j	fail

test_1719:
li	gp,1719
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1719+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff05f20
beq	a4,t2,test_1720
j	fail

test_1720:
li	gp,1720
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
bne	tp,t0,test_1720+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	a4,t2,test_1721
j	fail

test_1721:
li	gp,1721
li	tp,0
lui	sp,0xf0f1
addi	sp,sp,-241 # _start-0x70f0f0f1
nop
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1721+0x8
lui	t2,0xff100
addi	t2,t2,-241 # _end+0x7f0f5e3f
beq	a4,t2,test_1722
j	fail

test_1722:
li	gp,1722
li	tp,0
lui	sp,0xf0f0f
addi	sp,sp,240 # _end+0x70f05020
nop
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
nop
or	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1722+0x8
lui	t2,0xfff10
addi	t2,t2,-16 # _end+0x7ff05f20
beq	a4,t2,test_1723
j	fail

test_1723:
li	gp,1723
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
bne	tp,t0,test_1723+0x8
lui	t2,0xfff1
addi	t2,t2,-1 # _start-0x7000f001
beq	a4,t2,test_1724
j	fail

test_1724:
li	gp,1724
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
or	sp,zero,ra
lui	t2,0xff010
addi	t2,t2,-256 # _end+0x7f005e30
beq	sp,t2,test_1725
j	fail

test_1725:
li	gp,1725
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
or	sp,ra,zero
lui	t2,0xff0
addi	t2,t2,255 # _start-0x7f00ff01
beq	sp,t2,test_1726
j	fail

test_1726:
li	gp,1726
or	ra,zero,zero
li	t2,0
beq	ra,t2,test_1727
j	fail

test_1727:
li	gp,1727
lui	ra,0x11111
addi	ra,ra,273 # _start-0x6eeeeeef
lui	sp,0x22222
addi	sp,sp,546 # _start-0x5dddddde
or	zero,ra,sp
li	t2,0
beq	zero,t2,test_1802
j	fail

test_1802:
li	gp,1802
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
ori	a4,ra,-241
li	t2,-241
beq	a4,t2,test_1803
j	fail

test_1803:
li	gp,1803
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
ori	a4,ra,240
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1804
j	fail

test_1804:
li	gp,1804
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
ori	a4,ra,1807
lui	t2,0xff0
addi	t2,t2,2047 # _start-0x7f00f801
beq	a4,t2,test_1805
j	fail

test_1805:
li	gp,1805
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
ori	a4,ra,240
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700f502f
beq	a4,t2,test_1806
j	fail

test_1806:
li	gp,1806
lui	ra,0xff010
addi	ra,ra,-256 # _end+0x7f005e30
ori	ra,ra,240
lui	t2,0xff010
addi	t2,t2,-16 # _end+0x7f005f20
beq	ra,t2,test_1807
j	fail

test_1807:
li	gp,1807
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
ori	a4,ra,240
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1807+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	t1,t2,test_1808
j	fail

test_1808:
li	gp,1808
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
ori	a4,ra,1807
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1808+0x8
lui	t2,0xff0
addi	t2,t2,2047 # _start-0x7f00f801
beq	t1,t2,test_1809
j	fail

test_1809:
li	gp,1809
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
ori	a4,ra,240
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1809+0x8
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700f502f
beq	t1,t2,test_1810
j	fail

test_1810:
li	gp,1810
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
ori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1810+0x8
lui	t2,0xff01
addi	t2,t2,-16 # _start-0x700ff010
beq	a4,t2,test_1811
j	fail

test_1811:
li	gp,1811
li	tp,0
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
nop
ori	a4,ra,-241
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1811+0x8
li	t2,-1
beq	a4,t2,test_1812
j	fail

test_1812:
li	gp,1812
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
nop
nop
ori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1812+0x8
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700f502f
beq	a4,t2,test_1813
j	fail

test_1813:
li	gp,1813
ori	ra,zero,240
li	t2,240
beq	ra,t2,test_1814
j	fail

test_1814:
li	gp,1814
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
ori	zero,ra,1807
li	t2,0
beq	zero,t2,test_1902
j	fail

test_1902:
li	gp,1902
auipc	ra,0x6
addi	ra,ra,1984 # sh_tdat
li	sp,170
auipc	a5,0x0
addi	a5,a5,20 # test_1902+0x24
sh	sp,0(ra)
lh	a4,0(ra)
j	test_1902+0x28
mv	a4,sp
li	t2,170
beq	a4,t2,test_1903
j	fail

test_1903:
li	gp,1903
auipc	ra,0x6
addi	ra,ra,1932 # sh_tdat
lui	sp,0xffffb
addi	sp,sp,-1536 # _end+0x7fff0930
auipc	a5,0x0
addi	a5,a5,20 # test_1903+0x28
sh	sp,2(ra)
lh	a4,2(ra)
j	test_1903+0x2c
mv	a4,sp
lui	t2,0xffffb
addi	t2,t2,-1536 # _end+0x7fff0930
beq	a4,t2,test_1904
j	fail

test_1904:
li	gp,1904
auipc	ra,0x6
addi	ra,ra,1872 # sh_tdat
lui	sp,0xbeef1
addi	sp,sp,-1376 # _end+0x3eee69d0
auipc	a5,0x0
addi	a5,a5,20 # test_1904+0x28
sh	sp,4(ra)
lw	a4,4(ra)
j	test_1904+0x2c
mv	a4,sp
lui	t2,0xbeef1
addi	t2,t2,-1376 # _end+0x3eee69d0
beq	a4,t2,test_1905
j	fail

test_1905:
li	gp,1905
auipc	ra,0x6
addi	ra,ra,1812 # sh_tdat
lui	sp,0xffffa
addi	sp,sp,10 # _end+0x7ffeff3a
auipc	a5,0x0
addi	a5,a5,20 # test_1905+0x28
sh	sp,6(ra)
lh	a4,6(ra)
j	test_1905+0x2c
mv	a4,sp
lui	t2,0xffffa
addi	t2,t2,10 # _end+0x7ffeff3a
beq	a4,t2,test_1906
j	fail

test_1906:
li	gp,1906
auipc	ra,0x6
addi	ra,ra,1766 # sh_tdat8
li	sp,170
auipc	a5,0x0
addi	a5,a5,20 # test_1906+0x24
sh	sp,-6(ra)
lh	a4,-6(ra)
j	test_1906+0x28
mv	a4,sp
li	t2,170
beq	a4,t2,test_1907
j	fail

test_1907:
li	gp,1907
auipc	ra,0x6
addi	ra,ra,1714 # sh_tdat8
lui	sp,0xffffb
addi	sp,sp,-1536 # _end+0x7fff0930
auipc	a5,0x0
addi	a5,a5,20 # test_1907+0x28
sh	sp,-4(ra)
lh	a4,-4(ra)
j	test_1907+0x2c
mv	a4,sp
lui	t2,0xffffb
addi	t2,t2,-1536 # _end+0x7fff0930
beq	a4,t2,test_1908
j	fail

test_1908:
li	gp,1908
auipc	ra,0x6
addi	ra,ra,1654 # sh_tdat8
lui	sp,0x1
addi	sp,sp,-1376 # _start-0x7ffff560
auipc	a5,0x0
addi	a5,a5,20 # test_1908+0x28
sh	sp,-2(ra)
lh	a4,-2(ra)
j	test_1908+0x2c
mv	a4,sp
lui	t2,0x1
addi	t2,t2,-1376 # _start-0x7ffff560
beq	a4,t2,test_1909
j	fail

test_1909:
li	gp,1909
auipc	ra,0x6
addi	ra,ra,1594 # sh_tdat8
lui	sp,0xffffa
addi	sp,sp,10 # _end+0x7ffeff3a
auipc	a5,0x0
addi	a5,a5,20 # test_1909+0x28
sh	sp,0(ra)
lh	a4,0(ra)
j	test_1909+0x2c
mv	a4,sp
lui	t2,0xffffa
addi	t2,t2,10 # _end+0x7ffeff3a
beq	a4,t2,test_1910
j	fail

test_1910:
li	gp,1910
auipc	ra,0x6
addi	ra,ra,1536 # sh_tdat9
lui	sp,0x12345
addi	sp,sp,1656 # _start-0x6dcba988
addi	tp,ra,-32
sh	sp,32(tp) # _start-0x7fffffe0
lh	t0,0(ra)
lui	t2,0x5
addi	t2,t2,1656 # _start-0x7fffa988
beq	t0,t2,test_1911
j	fail

test_1911:
li	gp,1911
auipc	ra,0x6
addi	ra,ra,1488 # sh_tdat9
lui	sp,0x3
addi	sp,sp,152 # _start-0x7fffcf68
addi	ra,ra,-5
sh	sp,7(ra)
auipc	tp,0x6
addi	tp,tp,1466 # sh_tdat10
lh	t0,0(tp) # _start-0x80000000
lui	t2,0x3
addi	t2,t2,152 # _start-0x7fffcf68
beq	t0,t2,test_1912
j	fail

test_1912:
li	gp,1912
li	tp,0
lui	ra,0xffffd
addi	ra,ra,-803 # _end+0x7fff2c0d
auipc	sp,0x6
addi	sp,sp,1404 # sh_tdat
sh	ra,0(sp)
lh	a4,0(sp)
lui	t2,0xffffd
addi	t2,t2,-803 # _end+0x7fff2c0d
beq	a4,t2,test_1912+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1912+0x8

test_1913:
li	gp,1913
li	tp,0
lui	ra,0xffffc
addi	ra,ra,-819 # _end+0x7fff1bfd
auipc	sp,0x6
addi	sp,sp,1344 # sh_tdat
nop
sh	ra,2(sp)
lh	a4,2(sp)
lui	t2,0xffffc
addi	t2,t2,-819 # _end+0x7fff1bfd
beq	a4,t2,test_1913+0x34
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1913+0x8

test_1914:
li	gp,1914
li	tp,0
lui	ra,0xffffc
addi	ra,ra,-1076 # _end+0x7fff1afc
auipc	sp,0x6
addi	sp,sp,1280 # sh_tdat
nop
nop
sh	ra,4(sp)
lh	a4,4(sp)
lui	t2,0xffffc
addi	t2,t2,-1076 # _end+0x7fff1afc
beq	a4,t2,test_1914+0x38
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1914+0x8

test_1915:
li	gp,1915
li	tp,0
lui	ra,0xffffb
addi	ra,ra,-1092 # _end+0x7fff0aec
nop
auipc	sp,0x6
addi	sp,sp,1208 # sh_tdat
sh	ra,6(sp)
lh	a4,6(sp)
lui	t2,0xffffb
addi	t2,t2,-1092 # _end+0x7fff0aec
beq	a4,t2,test_1915+0x34
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1915+0x8

test_1916:
li	gp,1916
li	tp,0
lui	ra,0xffffb
addi	ra,ra,-1349 # _end+0x7fff09eb
nop
auipc	sp,0x6
addi	sp,sp,1144 # sh_tdat
nop
sh	ra,8(sp)
lh	a4,8(sp)
lui	t2,0xffffb
addi	t2,t2,-1349 # _end+0x7fff09eb
beq	a4,t2,test_1916+0x38
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1916+0x8

test_1917:
li	gp,1917
li	tp,0
lui	ra,0xffffe
addi	ra,ra,-1365 # _end+0x7fff39db
nop
nop
auipc	sp,0x6
addi	sp,sp,1072 # sh_tdat
sh	ra,10(sp)
lh	a4,10(sp)
lui	t2,0xffffe
addi	t2,t2,-1365 # _end+0x7fff39db
beq	a4,t2,test_1917+0x38
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1917+0x8

test_1918:
li	gp,1918
li	tp,0
auipc	sp,0x6
addi	sp,sp,1020 # sh_tdat
lui	ra,0x2
addi	ra,ra,563 # _start-0x7fffddcd
sh	ra,0(sp)
lh	a4,0(sp)
lui	t2,0x2
addi	t2,t2,563 # _start-0x7fffddcd
beq	a4,t2,test_1918+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1918+0x8

test_1919:
li	gp,1919
li	tp,0
auipc	sp,0x6
addi	sp,sp,960 # sh_tdat
lui	ra,0x1
addi	ra,ra,547 # _start-0x7fffeddd
nop
sh	ra,2(sp)
lh	a4,2(sp)
lui	t2,0x1
addi	t2,t2,547 # _start-0x7fffeddd
beq	a4,t2,test_1919+0x34
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1919+0x8

test_1920:
li	gp,1920
li	tp,0
auipc	sp,0x6
addi	sp,sp,896 # sh_tdat
lui	ra,0x1
addi	ra,ra,290 # _start-0x7fffeede
nop
nop
sh	ra,4(sp)
lh	a4,4(sp)
lui	t2,0x1
addi	t2,t2,290 # _start-0x7fffeede
beq	a4,t2,test_1920+0x38
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1920+0x8

test_1921:
li	gp,1921
li	tp,0
auipc	sp,0x6
addi	sp,sp,828 # sh_tdat
nop
li	ra,274
sh	ra,6(sp)
lh	a4,6(sp)
li	t2,274
beq	a4,t2,test_1921+0x2c
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1921+0x8

test_1922:
li	gp,1922
li	tp,0
auipc	sp,0x6
addi	sp,sp,772 # sh_tdat
nop
li	ra,17
nop
sh	ra,8(sp)
lh	a4,8(sp)
li	t2,17
beq	a4,t2,test_1922+0x30
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1922+0x8

test_1923:
li	gp,1923
li	tp,0
auipc	sp,0x6
addi	sp,sp,712 # sh_tdat
nop
nop
lui	ra,0x3
addi	ra,ra,1 # _start-0x7fffcfff
sh	ra,10(sp)
lh	a4,10(sp)
lui	t2,0x3
addi	t2,t2,1 # _start-0x7fffcfff
beq	a4,t2,test_1923+0x38
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_1923+0x8
lui	a0,0xc
addi	a0,a0,-273 # _start-0x7fff4111
auipc	a1,0x6
addi	a1,a1,644 # sh_tdat
sh	a0,6(a1)

test_2002:
li	gp,2002
li	ra,1
li	sp,0
sll	a4,ra,sp
li	t2,1
beq	a4,t2,test_2003
j	fail

test_2003:
li	gp,2003
li	ra,1
li	sp,1
sll	a4,ra,sp
li	t2,2
beq	a4,t2,test_2004
j	fail

test_2004:
li	gp,2004
li	ra,1
li	sp,7
sll	a4,ra,sp
li	t2,128
beq	a4,t2,test_2005
j	fail

test_2005:
li	gp,2005
li	ra,1
li	sp,14
sll	a4,ra,sp
lui	t2,0x4
beq	a4,t2,test_2006
j	fail

test_2006:
li	gp,2006
li	ra,1
li	sp,31
sll	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_2007
j	fail

test_2007:
li	gp,2007
li	ra,-1
li	sp,0
sll	a4,ra,sp
li	t2,-1
beq	a4,t2,test_2008
j	fail

test_2008:
li	gp,2008
li	ra,-1
li	sp,1
sll	a4,ra,sp
li	t2,-2
beq	a4,t2,test_2009
j	fail

test_2009:
li	gp,2009
li	ra,-1
li	sp,7
sll	a4,ra,sp
li	t2,-128
beq	a4,t2,test_2010
j	fail

test_2010:
li	gp,2010
li	ra,-1
li	sp,14
sll	a4,ra,sp
lui	t2,0xffffc
beq	a4,t2,test_2011
j	fail

test_2011:
li	gp,2011
li	ra,-1
li	sp,31
sll	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_2012
j	fail

test_2012:
li	gp,2012
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,0
sll	a4,ra,sp
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
beq	a4,t2,test_2013
j	fail

test_2013:
li	gp,2013
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,1
sll	a4,ra,sp
lui	t2,0x42424
addi	t2,t2,578 # _start-0x3dbdbdbe
beq	a4,t2,test_2014
j	fail

test_2014:
li	gp,2014
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,7
sll	a4,ra,sp
lui	t2,0x90909
addi	t2,t2,128 # _end+0x108fefb0
beq	a4,t2,test_2015
j	fail

test_2015:
li	gp,2015
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,14
sll	a4,ra,sp
lui	t2,0x48484
beq	a4,t2,test_2016
j	fail

test_2016:
li	gp,2016
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,31
sll	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_2017
j	fail

test_2017:
li	gp,2017
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-64
sll	a4,ra,sp
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
beq	a4,t2,test_2018
j	fail

test_2018:
li	gp,2018
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-63
sll	a4,ra,sp
lui	t2,0x42424
addi	t2,t2,578 # _start-0x3dbdbdbe
beq	a4,t2,test_2019
j	fail

test_2019:
li	gp,2019
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-57
sll	a4,ra,sp
lui	t2,0x90909
addi	t2,t2,128 # _end+0x108fefb0
beq	a4,t2,test_2020
j	fail

test_2020:
li	gp,2020
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-50
sll	a4,ra,sp
lui	t2,0x48484
beq	a4,t2,test_2022
j	fail

test_2022:
li	gp,2022
li	ra,1
li	sp,7
sll	ra,ra,sp
li	t2,128
beq	ra,t2,test_2023
j	fail

test_2023:
li	gp,2023
li	ra,1
li	sp,14
sll	sp,ra,sp
lui	t2,0x4
beq	sp,t2,test_2024
j	fail

test_2024:
li	gp,2024
li	ra,3
sll	ra,ra,ra
li	t2,24
beq	ra,t2,test_2025
j	fail

test_2025:
li	gp,2025
li	tp,0
li	ra,1
li	sp,7
sll	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2025+0x8
li	t2,128
beq	t1,t2,test_2026
j	fail

test_2026:
li	gp,2026
li	tp,0
li	ra,1
li	sp,14
sll	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2026+0x8
lui	t2,0x4
beq	t1,t2,test_2027
j	fail

test_2027:
li	gp,2027
li	tp,0
li	ra,1
li	sp,31
sll	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2027+0x8
lui	t2,0x80000
beq	t1,t2,test_2028
j	fail

test_2028:
li	gp,2028
li	tp,0
li	ra,1
li	sp,7
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2028+0x8
li	t2,128
beq	a4,t2,test_2029
j	fail

test_2029:
li	gp,2029
li	tp,0
li	ra,1
li	sp,14
nop
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2029+0x8
lui	t2,0x4
beq	a4,t2,test_2030
j	fail

test_2030:
li	gp,2030
li	tp,0
li	ra,1
li	sp,31
nop
nop
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2030+0x8
lui	t2,0x80000
beq	a4,t2,test_2031
j	fail

test_2031:
li	gp,2031
li	tp,0
li	ra,1
nop
li	sp,7
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2031+0x8
li	t2,128
beq	a4,t2,test_2032
j	fail

test_2032:
li	gp,2032
li	tp,0
li	ra,1
nop
li	sp,14
nop
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2032+0x8
lui	t2,0x4
beq	a4,t2,test_2033
j	fail

test_2033:
li	gp,2033
li	tp,0
li	ra,1
nop
nop
li	sp,31
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2033+0x8
lui	t2,0x80000
beq	a4,t2,test_2034
j	fail

test_2034:
li	gp,2034
li	tp,0
li	sp,7
li	ra,1
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2034+0x8
li	t2,128
beq	a4,t2,test_2035
j	fail

test_2035:
li	gp,2035
li	tp,0
li	sp,14
li	ra,1
nop
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2035+0x8
lui	t2,0x4
beq	a4,t2,test_2036
j	fail

test_2036:
li	gp,2036
li	tp,0
li	sp,31
li	ra,1
nop
nop
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2036+0x8
lui	t2,0x80000
beq	a4,t2,test_2037
j	fail

test_2037:
li	gp,2037
li	tp,0
li	sp,7
nop
li	ra,1
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2037+0x8
li	t2,128
beq	a4,t2,test_2038
j	fail

test_2038:
li	gp,2038
li	tp,0
li	sp,14
nop
li	ra,1
nop
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2038+0x8
lui	t2,0x4
beq	a4,t2,test_2039
j	fail

test_2039:
li	gp,2039
li	tp,0
li	sp,31
nop
nop
li	ra,1
sll	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2039+0x8
lui	t2,0x80000
beq	a4,t2,test_2040
j	fail

test_2040:
li	gp,2040
li	ra,15
sll	sp,zero,ra
li	t2,0
beq	sp,t2,test_2041
j	fail

test_2041:
li	gp,2041
li	ra,32
sll	sp,ra,zero
li	t2,32
beq	sp,t2,test_2042
j	fail

test_2042:
li	gp,2042
sll	ra,zero,zero
li	t2,0
beq	ra,t2,test_2043
j	fail

test_2043:
li	gp,2043
li	ra,1024
lui	sp,0x1
addi	sp,sp,-2048 # _start-0x7ffff800
sll	zero,ra,sp
li	t2,0
beq	zero,t2,test_2102
j	fail

test_2102:
lui	gp,0x1
addi	gp,gp,-1994 # _start-0x7ffff7ca
li	ra,1
slli	a4,ra,0x0
li	t2,1
beq	a4,t2,test_2103
j	fail

test_2103:
lui	gp,0x1
addi	gp,gp,-1993 # _start-0x7ffff7c9
li	ra,1
slli	a4,ra,0x1
li	t2,2
beq	a4,t2,test_2104
j	fail

test_2104:
lui	gp,0x1
addi	gp,gp,-1992 # _start-0x7ffff7c8
li	ra,1
slli	a4,ra,0x7
li	t2,128
beq	a4,t2,test_2105
j	fail

test_2105:
lui	gp,0x1
addi	gp,gp,-1991 # _start-0x7ffff7c7
li	ra,1
slli	a4,ra,0xe
lui	t2,0x4
beq	a4,t2,test_2106
j	fail

test_2106:
lui	gp,0x1
addi	gp,gp,-1990 # _start-0x7ffff7c6
li	ra,1
slli	a4,ra,0x1f
lui	t2,0x80000
beq	a4,t2,test_2107
j	fail

test_2107:
lui	gp,0x1
addi	gp,gp,-1989 # _start-0x7ffff7c5
li	ra,-1
slli	a4,ra,0x0
li	t2,-1
beq	a4,t2,test_2108
j	fail

test_2108:
lui	gp,0x1
addi	gp,gp,-1988 # _start-0x7ffff7c4
li	ra,-1
slli	a4,ra,0x1
li	t2,-2
beq	a4,t2,test_2109
j	fail

test_2109:
lui	gp,0x1
addi	gp,gp,-1987 # _start-0x7ffff7c3
li	ra,-1
slli	a4,ra,0x7
li	t2,-128
beq	a4,t2,test_2110
j	fail

test_2110:
lui	gp,0x1
addi	gp,gp,-1986 # _start-0x7ffff7c2
li	ra,-1
slli	a4,ra,0xe
lui	t2,0xffffc
beq	a4,t2,test_2111
j	fail

test_2111:
lui	gp,0x1
addi	gp,gp,-1985 # _start-0x7ffff7c1
li	ra,-1
slli	a4,ra,0x1f
lui	t2,0x80000
beq	a4,t2,test_2112
j	fail

test_2112:
lui	gp,0x1
addi	gp,gp,-1984 # _start-0x7ffff7c0
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x0
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
beq	a4,t2,test_2113
j	fail

test_2113:
lui	gp,0x1
addi	gp,gp,-1983 # _start-0x7ffff7bf
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x1
lui	t2,0x42424
addi	t2,t2,578 # _start-0x3dbdbdbe
beq	a4,t2,test_2114
j	fail

test_2114:
lui	gp,0x1
addi	gp,gp,-1982 # _start-0x7ffff7be
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x7
lui	t2,0x90909
addi	t2,t2,128 # _end+0x108fefb0
beq	a4,t2,test_2115
j	fail

test_2115:
lui	gp,0x1
addi	gp,gp,-1981 # _start-0x7ffff7bd
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0xe
lui	t2,0x48484
beq	a4,t2,test_2116
j	fail

test_2116:
lui	gp,0x1
addi	gp,gp,-1980 # _start-0x7ffff7bc
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
slli	a4,ra,0x1f
lui	t2,0x80000
beq	a4,t2,test_2117
j	fail

test_2117:
lui	gp,0x1
addi	gp,gp,-1979 # _start-0x7ffff7bb
li	ra,1
slli	ra,ra,0x7
li	t2,128
beq	ra,t2,test_2118
j	fail

test_2118:
lui	gp,0x1
addi	gp,gp,-1978 # _start-0x7ffff7ba
li	tp,0
li	ra,1
slli	a4,ra,0x7
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2118+0xc
li	t2,128
beq	t1,t2,test_2119
j	fail

test_2119:
lui	gp,0x1
addi	gp,gp,-1977 # _start-0x7ffff7b9
li	tp,0
li	ra,1
slli	a4,ra,0xe
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2119+0xc
lui	t2,0x4
beq	t1,t2,test_2120
j	fail

test_2120:
lui	gp,0x1
addi	gp,gp,-1976 # _start-0x7ffff7b8
li	tp,0
li	ra,1
slli	a4,ra,0x1f
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2120+0xc
lui	t2,0x80000
beq	t1,t2,test_2121
j	fail

test_2121:
lui	gp,0x1
addi	gp,gp,-1975 # _start-0x7ffff7b7
li	tp,0
li	ra,1
slli	a4,ra,0x7
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2121+0xc
li	t2,128
beq	a4,t2,test_2122
j	fail

test_2122:
lui	gp,0x1
addi	gp,gp,-1974 # _start-0x7ffff7b6
li	tp,0
li	ra,1
nop
slli	a4,ra,0xe
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2122+0xc
lui	t2,0x4
beq	a4,t2,test_2123
j	fail

test_2123:
lui	gp,0x1
addi	gp,gp,-1973 # _start-0x7ffff7b5
li	tp,0
li	ra,1
nop
nop
slli	a4,ra,0x1f
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2123+0xc
lui	t2,0x80000
beq	a4,t2,test_2124
j	fail

test_2124:
lui	gp,0x1
addi	gp,gp,-1972 # _start-0x7ffff7b4
slli	ra,zero,0x1f
li	t2,0
beq	ra,t2,test_2125
j	fail

test_2125:
lui	gp,0x1
addi	gp,gp,-1971 # _start-0x7ffff7b3
li	ra,33
slli	zero,ra,0x14
li	t2,0
beq	zero,t2,test_2202
j	fail

test_2202:
lui	gp,0x1
addi	gp,gp,-1894 # _start-0x7ffff766
li	ra,0
li	sp,0
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2203
j	fail

test_2203:
lui	gp,0x1
addi	gp,gp,-1893 # _start-0x7ffff765
li	ra,1
li	sp,1
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2204
j	fail

test_2204:
lui	gp,0x1
addi	gp,gp,-1892 # _start-0x7ffff764
li	ra,3
li	sp,7
slt	a4,ra,sp
li	t2,1
beq	a4,t2,test_2205
j	fail

test_2205:
lui	gp,0x1
addi	gp,gp,-1891 # _start-0x7ffff763
li	ra,7
li	sp,3
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2206
j	fail

test_2206:
lui	gp,0x1
addi	gp,gp,-1890 # _start-0x7ffff762
li	ra,0
lui	sp,0xffff8
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2207
j	fail

test_2207:
lui	gp,0x1
addi	gp,gp,-1889 # _start-0x7ffff761
lui	ra,0x80000
li	sp,0
slt	a4,ra,sp
li	t2,1
beq	a4,t2,test_2208
j	fail

test_2208:
lui	gp,0x1
addi	gp,gp,-1888 # _start-0x7ffff760
lui	ra,0x80000
lui	sp,0xffff8
slt	a4,ra,sp
li	t2,1
beq	a4,t2,test_2209
j	fail

test_2209:
lui	gp,0x1
addi	gp,gp,-1887 # _start-0x7ffff75f
li	ra,0
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
slt	a4,ra,sp
li	t2,1
beq	a4,t2,test_2210
j	fail

test_2210:
lui	gp,0x1
addi	gp,gp,-1886 # _start-0x7ffff75e
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,0
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2211
j	fail

test_2211:
lui	gp,0x1
addi	gp,gp,-1885 # _start-0x7ffff75d
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2212
j	fail

test_2212:
lui	gp,0x1
addi	gp,gp,-1884 # _start-0x7ffff75c
lui	ra,0x80000
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
slt	a4,ra,sp
li	t2,1
beq	a4,t2,test_2213
j	fail

test_2213:
lui	gp,0x1
addi	gp,gp,-1883 # _start-0x7ffff75b
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0xffff8
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2214
j	fail

test_2214:
lui	gp,0x1
addi	gp,gp,-1882 # _start-0x7ffff75a
li	ra,0
li	sp,-1
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2215
j	fail

test_2215:
lui	gp,0x1
addi	gp,gp,-1881 # _start-0x7ffff759
li	ra,-1
li	sp,1
slt	a4,ra,sp
li	t2,1
beq	a4,t2,test_2216
j	fail

test_2216:
lui	gp,0x1
addi	gp,gp,-1880 # _start-0x7ffff758
li	ra,-1
li	sp,-1
slt	a4,ra,sp
li	t2,0
beq	a4,t2,test_2217
j	fail

test_2217:
lui	gp,0x1
addi	gp,gp,-1879 # _start-0x7ffff757
li	ra,14
li	sp,13
slt	ra,ra,sp
li	t2,0
beq	ra,t2,test_2218
j	fail

test_2218:
lui	gp,0x1
addi	gp,gp,-1878 # _start-0x7ffff756
li	ra,11
li	sp,13
slt	sp,ra,sp
li	t2,1
beq	sp,t2,test_2219
j	fail

test_2219:
lui	gp,0x1
addi	gp,gp,-1877 # _start-0x7ffff755
li	ra,13
slt	ra,ra,ra
li	t2,0
beq	ra,t2,test_2220
j	fail

test_2220:
lui	gp,0x1
addi	gp,gp,-1876 # _start-0x7ffff754
li	tp,0
li	ra,11
li	sp,13
slt	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2220+0xc
li	t2,1
beq	t1,t2,test_2221
j	fail

test_2221:
lui	gp,0x1
addi	gp,gp,-1875 # _start-0x7ffff753
li	tp,0
li	ra,14
li	sp,13
slt	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2221+0xc
li	t2,0
beq	t1,t2,test_2222
j	fail

test_2222:
lui	gp,0x1
addi	gp,gp,-1874 # _start-0x7ffff752
li	tp,0
li	ra,12
li	sp,13
slt	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2222+0xc
li	t2,1
beq	t1,t2,test_2223
j	fail

test_2223:
lui	gp,0x1
addi	gp,gp,-1873 # _start-0x7ffff751
li	tp,0
li	ra,14
li	sp,13
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2223+0xc
li	t2,0
beq	a4,t2,test_2224
j	fail

test_2224:
lui	gp,0x1
addi	gp,gp,-1872 # _start-0x7ffff750
li	tp,0
li	ra,11
li	sp,13
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2224+0xc
li	t2,1
beq	a4,t2,test_2225
j	fail

test_2225:
lui	gp,0x1
addi	gp,gp,-1871 # _start-0x7ffff74f
li	tp,0
li	ra,15
li	sp,13
nop
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2225+0xc
li	t2,0
beq	a4,t2,test_2226
j	fail

test_2226:
lui	gp,0x1
addi	gp,gp,-1870 # _start-0x7ffff74e
li	tp,0
li	ra,10
nop
li	sp,13
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2226+0xc
li	t2,1
beq	a4,t2,test_2227
j	fail

test_2227:
lui	gp,0x1
addi	gp,gp,-1869 # _start-0x7ffff74d
li	tp,0
li	ra,16
nop
li	sp,13
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2227+0xc
li	t2,0
beq	a4,t2,test_2228
j	fail

test_2228:
lui	gp,0x1
addi	gp,gp,-1868 # _start-0x7ffff74c
li	tp,0
li	ra,9
nop
nop
li	sp,13
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2228+0xc
li	t2,1
beq	a4,t2,test_2229
j	fail

test_2229:
lui	gp,0x1
addi	gp,gp,-1867 # _start-0x7ffff74b
li	tp,0
li	sp,13
li	ra,17
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2229+0xc
li	t2,0
beq	a4,t2,test_2230
j	fail

test_2230:
lui	gp,0x1
addi	gp,gp,-1866 # _start-0x7ffff74a
li	tp,0
li	sp,13
li	ra,8
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2230+0xc
li	t2,1
beq	a4,t2,test_2231
j	fail

test_2231:
lui	gp,0x1
addi	gp,gp,-1865 # _start-0x7ffff749
li	tp,0
li	sp,13
li	ra,18
nop
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2231+0xc
li	t2,0
beq	a4,t2,test_2232
j	fail

test_2232:
lui	gp,0x1
addi	gp,gp,-1864 # _start-0x7ffff748
li	tp,0
li	sp,13
nop
li	ra,7
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2232+0xc
li	t2,1
beq	a4,t2,test_2233
j	fail

test_2233:
lui	gp,0x1
addi	gp,gp,-1863 # _start-0x7ffff747
li	tp,0
li	sp,13
nop
li	ra,19
nop
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2233+0xc
li	t2,0
beq	a4,t2,test_2234
j	fail

test_2234:
lui	gp,0x1
addi	gp,gp,-1862 # _start-0x7ffff746
li	tp,0
li	sp,13
nop
nop
li	ra,6
slt	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2234+0xc
li	t2,1
beq	a4,t2,test_2235
j	fail

test_2235:
lui	gp,0x1
addi	gp,gp,-1861 # _start-0x7ffff745
li	ra,-1
sgtz	sp,ra
li	t2,0
beq	sp,t2,test_2236
j	fail

test_2236:
lui	gp,0x1
addi	gp,gp,-1860 # _start-0x7ffff744
li	ra,-1
sltz	sp,ra
li	t2,1
beq	sp,t2,test_2237
j	fail

test_2237:
lui	gp,0x1
addi	gp,gp,-1859 # _start-0x7ffff743
sltz	ra,zero
li	t2,0
beq	ra,t2,test_2238
j	fail

test_2238:
lui	gp,0x1
addi	gp,gp,-1858 # _start-0x7ffff742
li	ra,16
li	sp,30
slt	zero,ra,sp
li	t2,0
beq	zero,t2,test_2302
j	fail

test_2302:
lui	gp,0x1
addi	gp,gp,-1794 # _start-0x7ffff702
li	ra,0
slti	a4,ra,0
li	t2,0
beq	a4,t2,test_2303
j	fail

test_2303:
lui	gp,0x1
addi	gp,gp,-1793 # _start-0x7ffff701
li	ra,1
slti	a4,ra,1
li	t2,0
beq	a4,t2,test_2304
j	fail

test_2304:
lui	gp,0x1
addi	gp,gp,-1792 # _start-0x7ffff700
li	ra,3
slti	a4,ra,7
li	t2,1
beq	a4,t2,test_2305
j	fail

test_2305:
lui	gp,0x1
addi	gp,gp,-1791 # _start-0x7ffff6ff
li	ra,7
slti	a4,ra,3
li	t2,0
beq	a4,t2,test_2306
j	fail

test_2306:
lui	gp,0x1
addi	gp,gp,-1790 # _start-0x7ffff6fe
li	ra,0
slti	a4,ra,-2048
li	t2,0
beq	a4,t2,test_2307
j	fail

test_2307:
lui	gp,0x1
addi	gp,gp,-1789 # _start-0x7ffff6fd
lui	ra,0x80000
slti	a4,ra,0
li	t2,1
beq	a4,t2,test_2308
j	fail

test_2308:
lui	gp,0x1
addi	gp,gp,-1788 # _start-0x7ffff6fc
lui	ra,0x80000
slti	a4,ra,-2048
li	t2,1
beq	a4,t2,test_2309
j	fail

test_2309:
lui	gp,0x1
addi	gp,gp,-1787 # _start-0x7ffff6fb
li	ra,0
slti	a4,ra,2047
li	t2,1
beq	a4,t2,test_2310
j	fail

test_2310:
lui	gp,0x1
addi	gp,gp,-1786 # _start-0x7ffff6fa
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
slti	a4,ra,0
li	t2,0
beq	a4,t2,test_2311
j	fail

test_2311:
lui	gp,0x1
addi	gp,gp,-1785 # _start-0x7ffff6f9
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
slti	a4,ra,2047
li	t2,0
beq	a4,t2,test_2312
j	fail

test_2312:
lui	gp,0x1
addi	gp,gp,-1784 # _start-0x7ffff6f8
lui	ra,0x80000
slti	a4,ra,2047
li	t2,1
beq	a4,t2,test_2313
j	fail

test_2313:
lui	gp,0x1
addi	gp,gp,-1783 # _start-0x7ffff6f7
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
slti	a4,ra,-2048
li	t2,0
beq	a4,t2,test_2314
j	fail

test_2314:
lui	gp,0x1
addi	gp,gp,-1782 # _start-0x7ffff6f6
li	ra,0
slti	a4,ra,-1
li	t2,0
beq	a4,t2,test_2315
j	fail

test_2315:
lui	gp,0x1
addi	gp,gp,-1781 # _start-0x7ffff6f5
li	ra,-1
slti	a4,ra,1
li	t2,1
beq	a4,t2,test_2316
j	fail

test_2316:
lui	gp,0x1
addi	gp,gp,-1780 # _start-0x7ffff6f4
li	ra,-1
slti	a4,ra,-1
li	t2,0
beq	a4,t2,test_2317
j	fail

test_2317:
lui	gp,0x1
addi	gp,gp,-1779 # _start-0x7ffff6f3
li	ra,11
slti	ra,ra,13
li	t2,1
beq	ra,t2,test_2318
j	fail

test_2318:
lui	gp,0x1
addi	gp,gp,-1778 # _start-0x7ffff6f2
li	tp,0
li	ra,15
slti	a4,ra,10
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2318+0xc
li	t2,0
beq	t1,t2,test_2319
j	fail

test_2319:
lui	gp,0x1
addi	gp,gp,-1777 # _start-0x7ffff6f1
li	tp,0
li	ra,10
slti	a4,ra,16
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2319+0xc
li	t2,1
beq	t1,t2,test_2320
j	fail

test_2320:
lui	gp,0x1
addi	gp,gp,-1776 # _start-0x7ffff6f0
li	tp,0
li	ra,16
slti	a4,ra,9
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2320+0xc
li	t2,0
beq	t1,t2,test_2321
j	fail

test_2321:
lui	gp,0x1
addi	gp,gp,-1775 # _start-0x7ffff6ef
li	tp,0
li	ra,11
slti	a4,ra,15
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2321+0xc
li	t2,1
beq	a4,t2,test_2322
j	fail

test_2322:
lui	gp,0x1
addi	gp,gp,-1774 # _start-0x7ffff6ee
li	tp,0
li	ra,17
nop
slti	a4,ra,8
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2322+0xc
li	t2,0
beq	a4,t2,test_2323
j	fail

test_2323:
lui	gp,0x1
addi	gp,gp,-1773 # _start-0x7ffff6ed
li	tp,0
li	ra,12
nop
nop
slti	a4,ra,14
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2323+0xc
li	t2,1
beq	a4,t2,test_2324
j	fail

test_2324:
lui	gp,0x1
addi	gp,gp,-1772 # _start-0x7ffff6ec
slti	ra,zero,-1
li	t2,0
beq	ra,t2,test_2325
j	fail

test_2325:
lui	gp,0x1
addi	gp,gp,-1771 # _start-0x7ffff6eb
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
slti	zero,ra,-1
li	t2,0
beq	zero,t2,test_2402
j	fail

test_2402:
lui	gp,0x1
addi	gp,gp,-1694 # _start-0x7ffff69e
li	ra,0
li	sp,0
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2403
j	fail

test_2403:
lui	gp,0x1
addi	gp,gp,-1693 # _start-0x7ffff69d
li	ra,1
li	sp,1
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2404
j	fail

test_2404:
lui	gp,0x1
addi	gp,gp,-1692 # _start-0x7ffff69c
li	ra,3
li	sp,7
sltu	a4,ra,sp
li	t2,1
beq	a4,t2,test_2405
j	fail

test_2405:
lui	gp,0x1
addi	gp,gp,-1691 # _start-0x7ffff69b
li	ra,7
li	sp,3
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2406
j	fail

test_2406:
lui	gp,0x1
addi	gp,gp,-1690 # _start-0x7ffff69a
li	ra,0
lui	sp,0xffff8
sltu	a4,ra,sp
li	t2,1
beq	a4,t2,test_2407
j	fail

test_2407:
lui	gp,0x1
addi	gp,gp,-1689 # _start-0x7ffff699
lui	ra,0x80000
li	sp,0
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2408
j	fail

test_2408:
lui	gp,0x1
addi	gp,gp,-1688 # _start-0x7ffff698
lui	ra,0x80000
lui	sp,0xffff8
sltu	a4,ra,sp
li	t2,1
beq	a4,t2,test_2409
j	fail

test_2409:
lui	gp,0x1
addi	gp,gp,-1687 # _start-0x7ffff697
li	ra,0
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
sltu	a4,ra,sp
li	t2,1
beq	a4,t2,test_2410
j	fail

test_2410:
lui	gp,0x1
addi	gp,gp,-1686 # _start-0x7ffff696
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,0
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2411
j	fail

test_2411:
lui	gp,0x1
addi	gp,gp,-1685 # _start-0x7ffff695
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2412
j	fail

test_2412:
lui	gp,0x1
addi	gp,gp,-1684 # _start-0x7ffff694
lui	ra,0x80000
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2413
j	fail

test_2413:
lui	gp,0x1
addi	gp,gp,-1683 # _start-0x7ffff693
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0xffff8
sltu	a4,ra,sp
li	t2,1
beq	a4,t2,test_2414
j	fail

test_2414:
lui	gp,0x1
addi	gp,gp,-1682 # _start-0x7ffff692
li	ra,0
li	sp,-1
sltu	a4,ra,sp
li	t2,1
beq	a4,t2,test_2415
j	fail

test_2415:
lui	gp,0x1
addi	gp,gp,-1681 # _start-0x7ffff691
li	ra,-1
li	sp,1
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2416
j	fail

test_2416:
lui	gp,0x1
addi	gp,gp,-1680 # _start-0x7ffff690
li	ra,-1
li	sp,-1
sltu	a4,ra,sp
li	t2,0
beq	a4,t2,test_2417
j	fail

test_2417:
lui	gp,0x1
addi	gp,gp,-1679 # _start-0x7ffff68f
li	ra,14
li	sp,13
sltu	ra,ra,sp
li	t2,0
beq	ra,t2,test_2418
j	fail

test_2418:
lui	gp,0x1
addi	gp,gp,-1678 # _start-0x7ffff68e
li	ra,11
li	sp,13
sltu	sp,ra,sp
li	t2,1
beq	sp,t2,test_2419
j	fail

test_2419:
lui	gp,0x1
addi	gp,gp,-1677 # _start-0x7ffff68d
li	ra,13
sltu	ra,ra,ra
li	t2,0
beq	ra,t2,test_2420
j	fail

test_2420:
lui	gp,0x1
addi	gp,gp,-1676 # _start-0x7ffff68c
li	tp,0
li	ra,11
li	sp,13
sltu	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2420+0xc
li	t2,1
beq	t1,t2,test_2421
j	fail

test_2421:
lui	gp,0x1
addi	gp,gp,-1675 # _start-0x7ffff68b
li	tp,0
li	ra,14
li	sp,13
sltu	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2421+0xc
li	t2,0
beq	t1,t2,test_2422
j	fail

test_2422:
lui	gp,0x1
addi	gp,gp,-1674 # _start-0x7ffff68a
li	tp,0
li	ra,12
li	sp,13
sltu	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2422+0xc
li	t2,1
beq	t1,t2,test_2423
j	fail

test_2423:
lui	gp,0x1
addi	gp,gp,-1673 # _start-0x7ffff689
li	tp,0
li	ra,14
li	sp,13
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2423+0xc
li	t2,0
beq	a4,t2,test_2424
j	fail

test_2424:
lui	gp,0x1
addi	gp,gp,-1672 # _start-0x7ffff688
li	tp,0
li	ra,11
li	sp,13
nop
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2424+0xc
li	t2,1
beq	a4,t2,test_2425
j	fail

test_2425:
lui	gp,0x1
addi	gp,gp,-1671 # _start-0x7ffff687
li	tp,0
li	ra,15
li	sp,13
nop
nop
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2425+0xc
li	t2,0
beq	a4,t2,test_2426
j	fail

test_2426:
lui	gp,0x1
addi	gp,gp,-1670 # _start-0x7ffff686
li	tp,0
li	ra,10
nop
li	sp,13
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2426+0xc
li	t2,1
beq	a4,t2,test_2427
j	fail

test_2427:
lui	gp,0x1
addi	gp,gp,-1669 # _start-0x7ffff685
li	tp,0
li	ra,16
nop
li	sp,13
nop
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2427+0xc
li	t2,0
beq	a4,t2,test_2428
j	fail

test_2428:
lui	gp,0x1
addi	gp,gp,-1668 # _start-0x7ffff684
li	tp,0
li	ra,9
nop
nop
li	sp,13
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2428+0xc
li	t2,1
beq	a4,t2,test_2429
j	fail

test_2429:
lui	gp,0x1
addi	gp,gp,-1667 # _start-0x7ffff683
li	tp,0
li	sp,13
li	ra,17
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2429+0xc
li	t2,0
beq	a4,t2,test_2430
j	fail

test_2430:
lui	gp,0x1
addi	gp,gp,-1666 # _start-0x7ffff682
li	tp,0
li	sp,13
li	ra,8
nop
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2430+0xc
li	t2,1
beq	a4,t2,test_2431
j	fail

test_2431:
lui	gp,0x1
addi	gp,gp,-1665 # _start-0x7ffff681
li	tp,0
li	sp,13
li	ra,18
nop
nop
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2431+0xc
li	t2,0
beq	a4,t2,test_2432
j	fail

test_2432:
lui	gp,0x1
addi	gp,gp,-1664 # _start-0x7ffff680
li	tp,0
li	sp,13
nop
li	ra,7
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2432+0xc
li	t2,1
beq	a4,t2,test_2433
j	fail

test_2433:
lui	gp,0x1
addi	gp,gp,-1663 # _start-0x7ffff67f
li	tp,0
li	sp,13
nop
li	ra,19
nop
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2433+0xc
li	t2,0
beq	a4,t2,test_2434
j	fail

test_2434:
lui	gp,0x1
addi	gp,gp,-1662 # _start-0x7ffff67e
li	tp,0
li	sp,13
nop
nop
li	ra,6
sltu	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2434+0xc
li	t2,1
beq	a4,t2,test_2435
j	fail

test_2435:
lui	gp,0x1
addi	gp,gp,-1661 # _start-0x7ffff67d
li	ra,-1
snez	sp,ra
li	t2,1
beq	sp,t2,test_2436
j	fail

test_2436:
lui	gp,0x1
addi	gp,gp,-1660 # _start-0x7ffff67c
li	ra,-1
sltu	sp,ra,zero
li	t2,0
beq	sp,t2,test_2437
j	fail

test_2437:
lui	gp,0x1
addi	gp,gp,-1659 # _start-0x7ffff67b
snez	ra,zero
li	t2,0
beq	ra,t2,test_2438
j	fail

test_2438:
lui	gp,0x1
addi	gp,gp,-1658 # _start-0x7ffff67a
li	ra,16
li	sp,30
sltu	zero,ra,sp
li	t2,0
beq	zero,t2,test_2502
j	fail

test_2502:
lui	gp,0x1
addi	gp,gp,-1594 # _start-0x7ffff63a
li	ra,0
sltiu	a4,ra,0
li	t2,0
beq	a4,t2,test_2503
j	fail

test_2503:
lui	gp,0x1
addi	gp,gp,-1593 # _start-0x7ffff639
li	ra,1
seqz	a4,ra
li	t2,0
beq	a4,t2,test_2504
j	fail

test_2504:
lui	gp,0x1
addi	gp,gp,-1592 # _start-0x7ffff638
li	ra,3
sltiu	a4,ra,7
li	t2,1
beq	a4,t2,test_2505
j	fail

test_2505:
lui	gp,0x1
addi	gp,gp,-1591 # _start-0x7ffff637
li	ra,7
sltiu	a4,ra,3
li	t2,0
beq	a4,t2,test_2506
j	fail

test_2506:
lui	gp,0x1
addi	gp,gp,-1590 # _start-0x7ffff636
li	ra,0
sltiu	a4,ra,-2048
li	t2,1
beq	a4,t2,test_2507
j	fail

test_2507:
lui	gp,0x1
addi	gp,gp,-1589 # _start-0x7ffff635
lui	ra,0x80000
sltiu	a4,ra,0
li	t2,0
beq	a4,t2,test_2508
j	fail

test_2508:
lui	gp,0x1
addi	gp,gp,-1588 # _start-0x7ffff634
lui	ra,0x80000
sltiu	a4,ra,-2048
li	t2,1
beq	a4,t2,test_2509
j	fail

test_2509:
lui	gp,0x1
addi	gp,gp,-1587 # _start-0x7ffff633
li	ra,0
sltiu	a4,ra,2047
li	t2,1
beq	a4,t2,test_2510
j	fail

test_2510:
lui	gp,0x1
addi	gp,gp,-1586 # _start-0x7ffff632
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
sltiu	a4,ra,0
li	t2,0
beq	a4,t2,test_2511
j	fail

test_2511:
lui	gp,0x1
addi	gp,gp,-1585 # _start-0x7ffff631
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
sltiu	a4,ra,2047
li	t2,0
beq	a4,t2,test_2512
j	fail

test_2512:
lui	gp,0x1
addi	gp,gp,-1584 # _start-0x7ffff630
lui	ra,0x80000
sltiu	a4,ra,2047
li	t2,0
beq	a4,t2,test_2513
j	fail

test_2513:
lui	gp,0x1
addi	gp,gp,-1583 # _start-0x7ffff62f
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
sltiu	a4,ra,-2048
li	t2,1
beq	a4,t2,test_2514
j	fail

test_2514:
lui	gp,0x1
addi	gp,gp,-1582 # _start-0x7ffff62e
li	ra,0
sltiu	a4,ra,-1
li	t2,1
beq	a4,t2,test_2515
j	fail

test_2515:
lui	gp,0x1
addi	gp,gp,-1581 # _start-0x7ffff62d
li	ra,-1
seqz	a4,ra
li	t2,0
beq	a4,t2,test_2516
j	fail

test_2516:
lui	gp,0x1
addi	gp,gp,-1580 # _start-0x7ffff62c
li	ra,-1
sltiu	a4,ra,-1
li	t2,0
beq	a4,t2,test_2517
j	fail

test_2517:
lui	gp,0x1
addi	gp,gp,-1579 # _start-0x7ffff62b
li	ra,11
sltiu	ra,ra,13
li	t2,1
beq	ra,t2,test_2518
j	fail

test_2518:
lui	gp,0x1
addi	gp,gp,-1578 # _start-0x7ffff62a
li	tp,0
li	ra,15
sltiu	a4,ra,10
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2518+0xc
li	t2,0
beq	t1,t2,test_2519
j	fail

test_2519:
lui	gp,0x1
addi	gp,gp,-1577 # _start-0x7ffff629
li	tp,0
li	ra,10
sltiu	a4,ra,16
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2519+0xc
li	t2,1
beq	t1,t2,test_2520
j	fail

test_2520:
lui	gp,0x1
addi	gp,gp,-1576 # _start-0x7ffff628
li	tp,0
li	ra,16
sltiu	a4,ra,9
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2520+0xc
li	t2,0
beq	t1,t2,test_2521
j	fail

test_2521:
lui	gp,0x1
addi	gp,gp,-1575 # _start-0x7ffff627
li	tp,0
li	ra,11
sltiu	a4,ra,15
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2521+0xc
li	t2,1
beq	a4,t2,test_2522
j	fail

test_2522:
lui	gp,0x1
addi	gp,gp,-1574 # _start-0x7ffff626
li	tp,0
li	ra,17
nop
sltiu	a4,ra,8
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2522+0xc
li	t2,0
beq	a4,t2,test_2523
j	fail

test_2523:
lui	gp,0x1
addi	gp,gp,-1573 # _start-0x7ffff625
li	tp,0
li	ra,12
nop
nop
sltiu	a4,ra,14
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2523+0xc
li	t2,1
beq	a4,t2,test_2524
j	fail

test_2524:
lui	gp,0x1
addi	gp,gp,-1572 # _start-0x7ffff624
sltiu	ra,zero,-1
li	t2,1
beq	ra,t2,test_2525
j	fail

test_2525:
lui	gp,0x1
addi	gp,gp,-1571 # _start-0x7ffff623
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
sltiu	zero,ra,-1
li	t2,0
beq	zero,t2,test_2602
j	fail

test_2602:
lui	gp,0x1
addi	gp,gp,-1494 # _start-0x7ffff5d6
lui	ra,0x80000
li	sp,0
sra	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_2603
j	fail

test_2603:
lui	gp,0x1
addi	gp,gp,-1493 # _start-0x7ffff5d5
lui	ra,0x80000
li	sp,1
sra	a4,ra,sp
lui	t2,0xc0000
beq	a4,t2,test_2604
j	fail

test_2604:
lui	gp,0x1
addi	gp,gp,-1492 # _start-0x7ffff5d4
lui	ra,0x80000
li	sp,7
sra	a4,ra,sp
lui	t2,0xff000
beq	a4,t2,test_2605
j	fail

test_2605:
lui	gp,0x1
addi	gp,gp,-1491 # _start-0x7ffff5d3
lui	ra,0x80000
li	sp,14
sra	a4,ra,sp
lui	t2,0xfffe0
beq	a4,t2,test_2606
j	fail

test_2606:
lui	gp,0x1
addi	gp,gp,-1490 # _start-0x7ffff5d2
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
li	sp,31
sra	a4,ra,sp
li	t2,-1
beq	a4,t2,test_2607
j	fail

test_2607:
lui	gp,0x1
addi	gp,gp,-1489 # _start-0x7ffff5d1
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,0
sra	a4,ra,sp
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_2608
j	fail

test_2608:
lui	gp,0x1
addi	gp,gp,-1488 # _start-0x7ffff5d0
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,1
sra	a4,ra,sp
lui	t2,0x40000
addi	t2,t2,-1 # _start-0x40000001
beq	a4,t2,test_2609
j	fail

test_2609:
lui	gp,0x1
addi	gp,gp,-1487 # _start-0x7ffff5cf
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,7
sra	a4,ra,sp
lui	t2,0x1000
addi	t2,t2,-1 # _start-0x7f000001
beq	a4,t2,test_2610
j	fail

test_2610:
lui	gp,0x1
addi	gp,gp,-1486 # _start-0x7ffff5ce
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,14
sra	a4,ra,sp
lui	t2,0x20
addi	t2,t2,-1 # _start-0x7ffe0001
beq	a4,t2,test_2611
j	fail

test_2611:
lui	gp,0x1
addi	gp,gp,-1485 # _start-0x7ffff5cd
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,31
sra	a4,ra,sp
li	t2,0
beq	a4,t2,test_2612
j	fail

test_2612:
lui	gp,0x1
addi	gp,gp,-1484 # _start-0x7ffff5cc
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,0
sra	a4,ra,sp
lui	t2,0x81818
addi	t2,t2,385 # _end+0x180e0b1
beq	a4,t2,test_2613
j	fail

test_2613:
lui	gp,0x1
addi	gp,gp,-1483 # _start-0x7ffff5cb
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,1
sra	a4,ra,sp
lui	t2,0xc0c0c
addi	t2,t2,192 # _end+0x40c01ff0
beq	a4,t2,test_2614
j	fail

test_2614:
lui	gp,0x1
addi	gp,gp,-1482 # _start-0x7ffff5ca
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,7
sra	a4,ra,sp
lui	t2,0xff030
addi	t2,t2,771 # _end+0x7f026233
beq	a4,t2,test_2615
j	fail

test_2615:
lui	gp,0x1
addi	gp,gp,-1481 # _start-0x7ffff5c9
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,14
sra	a4,ra,sp
lui	t2,0xfffe0
addi	t2,t2,1542 # _end+0x7ffd6536
beq	a4,t2,test_2616
j	fail

test_2616:
lui	gp,0x1
addi	gp,gp,-1480 # _start-0x7ffff5c8
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,31
sra	a4,ra,sp
li	t2,-1
beq	a4,t2,test_2617
j	fail

test_2617:
lui	gp,0x1
addi	gp,gp,-1479 # _start-0x7ffff5c7
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,-64
sra	a4,ra,sp
lui	t2,0x81818
addi	t2,t2,385 # _end+0x180e0b1
beq	a4,t2,test_2618
j	fail

test_2618:
lui	gp,0x1
addi	gp,gp,-1478 # _start-0x7ffff5c6
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,-63
sra	a4,ra,sp
lui	t2,0xc0c0c
addi	t2,t2,192 # _end+0x40c01ff0
beq	a4,t2,test_2619
j	fail

test_2619:
lui	gp,0x1
addi	gp,gp,-1477 # _start-0x7ffff5c5
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,-57
sra	a4,ra,sp
lui	t2,0xff030
addi	t2,t2,771 # _end+0x7f026233
beq	a4,t2,test_2620
j	fail

test_2620:
lui	gp,0x1
addi	gp,gp,-1476 # _start-0x7ffff5c4
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,-50
sra	a4,ra,sp
lui	t2,0xfffe0
addi	t2,t2,1542 # _end+0x7ffd6536
beq	a4,t2,test_2621
j	fail

test_2621:
lui	gp,0x1
addi	gp,gp,-1475 # _start-0x7ffff5c3
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
li	sp,-1
sra	a4,ra,sp
li	t2,-1
beq	a4,t2,test_2622
j	fail

test_2622:
lui	gp,0x1
addi	gp,gp,-1474 # _start-0x7ffff5c2
lui	ra,0x80000
li	sp,7
sra	ra,ra,sp
lui	t2,0xff000
beq	ra,t2,test_2623
j	fail

test_2623:
lui	gp,0x1
addi	gp,gp,-1473 # _start-0x7ffff5c1
lui	ra,0x80000
li	sp,14
sra	sp,ra,sp
lui	t2,0xfffe0
beq	sp,t2,test_2624
j	fail

test_2624:
lui	gp,0x1
addi	gp,gp,-1472 # _start-0x7ffff5c0
li	ra,7
sra	ra,ra,ra
li	t2,0
beq	ra,t2,test_2625
j	fail

test_2625:
lui	gp,0x1
addi	gp,gp,-1471 # _start-0x7ffff5bf
li	tp,0
lui	ra,0x80000
li	sp,7
sra	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2625+0xc
lui	t2,0xff000
beq	t1,t2,test_2626
j	fail

test_2626:
lui	gp,0x1
addi	gp,gp,-1470 # _start-0x7ffff5be
li	tp,0
lui	ra,0x80000
li	sp,14
sra	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2626+0xc
lui	t2,0xfffe0
beq	t1,t2,test_2627
j	fail

test_2627:
lui	gp,0x1
addi	gp,gp,-1469 # _start-0x7ffff5bd
li	tp,0
lui	ra,0x80000
li	sp,31
sra	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2627+0xc
li	t2,-1
beq	t1,t2,test_2628
j	fail

test_2628:
lui	gp,0x1
addi	gp,gp,-1468 # _start-0x7ffff5bc
li	tp,0
lui	ra,0x80000
li	sp,7
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2628+0xc
lui	t2,0xff000
beq	a4,t2,test_2629
j	fail

test_2629:
lui	gp,0x1
addi	gp,gp,-1467 # _start-0x7ffff5bb
li	tp,0
lui	ra,0x80000
li	sp,14
nop
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2629+0xc
lui	t2,0xfffe0
beq	a4,t2,test_2630
j	fail

test_2630:
lui	gp,0x1
addi	gp,gp,-1466 # _start-0x7ffff5ba
li	tp,0
lui	ra,0x80000
li	sp,31
nop
nop
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2630+0xc
li	t2,-1
beq	a4,t2,test_2631
j	fail

test_2631:
lui	gp,0x1
addi	gp,gp,-1465 # _start-0x7ffff5b9
li	tp,0
lui	ra,0x80000
nop
li	sp,7
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2631+0xc
lui	t2,0xff000
beq	a4,t2,test_2632
j	fail

test_2632:
lui	gp,0x1
addi	gp,gp,-1464 # _start-0x7ffff5b8
li	tp,0
lui	ra,0x80000
nop
li	sp,14
nop
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2632+0xc
lui	t2,0xfffe0
beq	a4,t2,test_2633
j	fail

test_2633:
lui	gp,0x1
addi	gp,gp,-1463 # _start-0x7ffff5b7
li	tp,0
lui	ra,0x80000
nop
nop
li	sp,31
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2633+0xc
li	t2,-1
beq	a4,t2,test_2634
j	fail

test_2634:
lui	gp,0x1
addi	gp,gp,-1462 # _start-0x7ffff5b6
li	tp,0
li	sp,7
lui	ra,0x80000
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2634+0xc
lui	t2,0xff000
beq	a4,t2,test_2635
j	fail

test_2635:
lui	gp,0x1
addi	gp,gp,-1461 # _start-0x7ffff5b5
li	tp,0
li	sp,14
lui	ra,0x80000
nop
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2635+0xc
lui	t2,0xfffe0
beq	a4,t2,test_2636
j	fail

test_2636:
lui	gp,0x1
addi	gp,gp,-1460 # _start-0x7ffff5b4
li	tp,0
li	sp,31
lui	ra,0x80000
nop
nop
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2636+0xc
li	t2,-1
beq	a4,t2,test_2637
j	fail

test_2637:
lui	gp,0x1
addi	gp,gp,-1459 # _start-0x7ffff5b3
li	tp,0
li	sp,7
nop
lui	ra,0x80000
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2637+0xc
lui	t2,0xff000
beq	a4,t2,test_2638
j	fail

test_2638:
lui	gp,0x1
addi	gp,gp,-1458 # _start-0x7ffff5b2
li	tp,0
li	sp,14
nop
lui	ra,0x80000
nop
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2638+0xc
lui	t2,0xfffe0
beq	a4,t2,test_2639
j	fail

test_2639:
lui	gp,0x1
addi	gp,gp,-1457 # _start-0x7ffff5b1
li	tp,0
li	sp,31
nop
nop
lui	ra,0x80000
sra	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2639+0xc
li	t2,-1
beq	a4,t2,test_2640
j	fail

test_2640:
lui	gp,0x1
addi	gp,gp,-1456 # _start-0x7ffff5b0
li	ra,15
sra	sp,zero,ra
li	t2,0
beq	sp,t2,test_2641
j	fail

test_2641:
lui	gp,0x1
addi	gp,gp,-1455 # _start-0x7ffff5af
li	ra,32
sra	sp,ra,zero
li	t2,32
beq	sp,t2,test_2642
j	fail

test_2642:
lui	gp,0x1
addi	gp,gp,-1454 # _start-0x7ffff5ae
sra	ra,zero,zero
li	t2,0
beq	ra,t2,test_2643
j	fail

test_2643:
lui	gp,0x1
addi	gp,gp,-1453 # _start-0x7ffff5ad
li	ra,1024
lui	sp,0x1
addi	sp,sp,-2048 # _start-0x7ffff800
sra	zero,ra,sp
li	t2,0
beq	zero,t2,test_2702
j	fail

test_2702:
lui	gp,0x1
addi	gp,gp,-1394 # _start-0x7ffff572
li	ra,0
srai	a4,ra,0x0
li	t2,0
beq	a4,t2,test_2703
j	fail

test_2703:
lui	gp,0x1
addi	gp,gp,-1393 # _start-0x7ffff571
lui	ra,0x80000
srai	a4,ra,0x1
lui	t2,0xc0000
beq	a4,t2,test_2704
j	fail

test_2704:
lui	gp,0x1
addi	gp,gp,-1392 # _start-0x7ffff570
lui	ra,0x80000
srai	a4,ra,0x7
lui	t2,0xff000
beq	a4,t2,test_2705
j	fail

test_2705:
lui	gp,0x1
addi	gp,gp,-1391 # _start-0x7ffff56f
lui	ra,0x80000
srai	a4,ra,0xe
lui	t2,0xfffe0
beq	a4,t2,test_2706
j	fail

test_2706:
lui	gp,0x1
addi	gp,gp,-1390 # _start-0x7ffff56e
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
srai	a4,ra,0x1f
li	t2,-1
beq	a4,t2,test_2707
j	fail

test_2707:
lui	gp,0x1
addi	gp,gp,-1389 # _start-0x7ffff56d
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
srai	a4,ra,0x0
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_2708
j	fail

test_2708:
lui	gp,0x1
addi	gp,gp,-1388 # _start-0x7ffff56c
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
srai	a4,ra,0x1
lui	t2,0x40000
addi	t2,t2,-1 # _start-0x40000001
beq	a4,t2,test_2709
j	fail

test_2709:
lui	gp,0x1
addi	gp,gp,-1387 # _start-0x7ffff56b
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
srai	a4,ra,0x7
lui	t2,0x1000
addi	t2,t2,-1 # _start-0x7f000001
beq	a4,t2,test_2710
j	fail

test_2710:
lui	gp,0x1
addi	gp,gp,-1386 # _start-0x7ffff56a
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
srai	a4,ra,0xe
lui	t2,0x20
addi	t2,t2,-1 # _start-0x7ffe0001
beq	a4,t2,test_2711
j	fail

test_2711:
lui	gp,0x1
addi	gp,gp,-1385 # _start-0x7ffff569
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
srai	a4,ra,0x1f
li	t2,0
beq	a4,t2,test_2712
j	fail

test_2712:
lui	gp,0x1
addi	gp,gp,-1384 # _start-0x7ffff568
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
srai	a4,ra,0x0
lui	t2,0x81818
addi	t2,t2,385 # _end+0x180e0b1
beq	a4,t2,test_2713
j	fail

test_2713:
lui	gp,0x1
addi	gp,gp,-1383 # _start-0x7ffff567
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
srai	a4,ra,0x1
lui	t2,0xc0c0c
addi	t2,t2,192 # _end+0x40c01ff0
beq	a4,t2,test_2714
j	fail

test_2714:
lui	gp,0x1
addi	gp,gp,-1382 # _start-0x7ffff566
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
srai	a4,ra,0x7
lui	t2,0xff030
addi	t2,t2,771 # _end+0x7f026233
beq	a4,t2,test_2715
j	fail

test_2715:
lui	gp,0x1
addi	gp,gp,-1381 # _start-0x7ffff565
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
srai	a4,ra,0xe
lui	t2,0xfffe0
addi	t2,t2,1542 # _end+0x7ffd6536
beq	a4,t2,test_2716
j	fail

test_2716:
lui	gp,0x1
addi	gp,gp,-1380 # _start-0x7ffff564
lui	ra,0x81818
addi	ra,ra,385 # _end+0x180e0b1
srai	a4,ra,0x1f
li	t2,-1
beq	a4,t2,test_2717
j	fail

test_2717:
lui	gp,0x1
addi	gp,gp,-1379 # _start-0x7ffff563
lui	ra,0x80000
srai	ra,ra,0x7
lui	t2,0xff000
beq	ra,t2,test_2718
j	fail

test_2718:
lui	gp,0x1
addi	gp,gp,-1378 # _start-0x7ffff562
li	tp,0
lui	ra,0x80000
srai	a4,ra,0x7
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2718+0xc
lui	t2,0xff000
beq	t1,t2,test_2719
j	fail

test_2719:
lui	gp,0x1
addi	gp,gp,-1377 # _start-0x7ffff561
li	tp,0
lui	ra,0x80000
srai	a4,ra,0xe
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2719+0xc
lui	t2,0xfffe0
beq	t1,t2,test_2720
j	fail

test_2720:
lui	gp,0x1
addi	gp,gp,-1376 # _start-0x7ffff560
li	tp,0
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
srai	a4,ra,0x1f
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2720+0xc
li	t2,-1
beq	t1,t2,test_2721
j	fail

test_2721:
lui	gp,0x1
addi	gp,gp,-1375 # _start-0x7ffff55f
li	tp,0
lui	ra,0x80000
srai	a4,ra,0x7
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2721+0xc
lui	t2,0xff000
beq	a4,t2,test_2722
j	fail

test_2722:
lui	gp,0x1
addi	gp,gp,-1374 # _start-0x7ffff55e
li	tp,0
lui	ra,0x80000
nop
srai	a4,ra,0xe
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2722+0xc
lui	t2,0xfffe0
beq	a4,t2,test_2723
j	fail

test_2723:
lui	gp,0x1
addi	gp,gp,-1373 # _start-0x7ffff55d
li	tp,0
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
nop
nop
srai	a4,ra,0x1f
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2723+0xc
li	t2,-1
beq	a4,t2,test_2724
j	fail

test_2724:
lui	gp,0x1
addi	gp,gp,-1372 # _start-0x7ffff55c
srai	ra,zero,0x4
li	t2,0
beq	ra,t2,test_2725
j	fail

test_2725:
lui	gp,0x1
addi	gp,gp,-1371 # _start-0x7ffff55b
li	ra,33
srai	zero,ra,0xa
li	t2,0
beq	zero,t2,test_2802
j	fail

test_2802:
lui	gp,0x1
addi	gp,gp,-1294 # _start-0x7ffff50e
lui	ra,0x80000
li	sp,0
srl	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_2803
j	fail

test_2803:
lui	gp,0x1
addi	gp,gp,-1293 # _start-0x7ffff50d
lui	ra,0x80000
li	sp,1
srl	a4,ra,sp
lui	t2,0x40000
beq	a4,t2,test_2804
j	fail

test_2804:
lui	gp,0x1
addi	gp,gp,-1292 # _start-0x7ffff50c
lui	ra,0x80000
li	sp,7
srl	a4,ra,sp
lui	t2,0x1000
beq	a4,t2,test_2805
j	fail

test_2805:
lui	gp,0x1
addi	gp,gp,-1291 # _start-0x7ffff50b
lui	ra,0x80000
li	sp,14
srl	a4,ra,sp
lui	t2,0x20
beq	a4,t2,test_2806
j	fail

test_2806:
lui	gp,0x1
addi	gp,gp,-1290 # _start-0x7ffff50a
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
li	sp,31
srl	a4,ra,sp
li	t2,1
beq	a4,t2,test_2807
j	fail

test_2807:
lui	gp,0x1
addi	gp,gp,-1289 # _start-0x7ffff509
li	ra,-1
li	sp,0
srl	a4,ra,sp
li	t2,-1
beq	a4,t2,test_2808
j	fail

test_2808:
lui	gp,0x1
addi	gp,gp,-1288 # _start-0x7ffff508
li	ra,-1
li	sp,1
srl	a4,ra,sp
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_2809
j	fail

test_2809:
lui	gp,0x1
addi	gp,gp,-1287 # _start-0x7ffff507
li	ra,-1
li	sp,7
srl	a4,ra,sp
lui	t2,0x2000
addi	t2,t2,-1 # _start-0x7e000001
beq	a4,t2,test_2810
j	fail

test_2810:
lui	gp,0x1
addi	gp,gp,-1286 # _start-0x7ffff506
li	ra,-1
li	sp,14
srl	a4,ra,sp
lui	t2,0x40
addi	t2,t2,-1 # _start-0x7ffc0001
beq	a4,t2,test_2811
j	fail

test_2811:
lui	gp,0x1
addi	gp,gp,-1285 # _start-0x7ffff505
li	ra,-1
li	sp,31
srl	a4,ra,sp
li	t2,1
beq	a4,t2,test_2812
j	fail

test_2812:
lui	gp,0x1
addi	gp,gp,-1284 # _start-0x7ffff504
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,0
srl	a4,ra,sp
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
beq	a4,t2,test_2813
j	fail

test_2813:
lui	gp,0x1
addi	gp,gp,-1283 # _start-0x7ffff503
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,1
srl	a4,ra,sp
lui	t2,0x10909
addi	t2,t2,144 # _start-0x6f6f6f70
beq	a4,t2,test_2814
j	fail

test_2814:
lui	gp,0x1
addi	gp,gp,-1282 # _start-0x7ffff502
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,7
srl	a4,ra,sp
lui	t2,0x424
addi	t2,t2,578 # _start-0x7fbdbdbe
beq	a4,t2,test_2815
j	fail

test_2815:
lui	gp,0x1
addi	gp,gp,-1281 # _start-0x7ffff501
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,14
srl	a4,ra,sp
lui	t2,0x8
addi	t2,t2,1156 # _start-0x7fff7b7c
beq	a4,t2,test_2816
j	fail

test_2816:
lui	gp,0x1
addi	gp,gp,-1280 # _start-0x7ffff500
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,31
srl	a4,ra,sp
li	t2,0
beq	a4,t2,test_2817
j	fail

test_2817:
lui	gp,0x1
addi	gp,gp,-1279 # _start-0x7ffff4ff
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-64
srl	a4,ra,sp
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
beq	a4,t2,test_2818
j	fail

test_2818:
lui	gp,0x1
addi	gp,gp,-1278 # _start-0x7ffff4fe
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-63
srl	a4,ra,sp
lui	t2,0x10909
addi	t2,t2,144 # _start-0x6f6f6f70
beq	a4,t2,test_2819
j	fail

test_2819:
lui	gp,0x1
addi	gp,gp,-1277 # _start-0x7ffff4fd
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-57
srl	a4,ra,sp
lui	t2,0x424
addi	t2,t2,578 # _start-0x7fbdbdbe
beq	a4,t2,test_2820
j	fail

test_2820:
lui	gp,0x1
addi	gp,gp,-1276 # _start-0x7ffff4fc
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-50
srl	a4,ra,sp
lui	t2,0x8
addi	t2,t2,1156 # _start-0x7fff7b7c
beq	a4,t2,test_2821
j	fail

test_2821:
lui	gp,0x1
addi	gp,gp,-1275 # _start-0x7ffff4fb
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
li	sp,-1
srl	a4,ra,sp
li	t2,0
beq	a4,t2,test_2822
j	fail

test_2822:
lui	gp,0x1
addi	gp,gp,-1274 # _start-0x7ffff4fa
lui	ra,0x80000
li	sp,7
srl	ra,ra,sp
lui	t2,0x1000
beq	ra,t2,test_2823
j	fail

test_2823:
lui	gp,0x1
addi	gp,gp,-1273 # _start-0x7ffff4f9
lui	ra,0x80000
li	sp,14
srl	sp,ra,sp
lui	t2,0x20
beq	sp,t2,test_2824
j	fail

test_2824:
lui	gp,0x1
addi	gp,gp,-1272 # _start-0x7ffff4f8
li	ra,7
srl	ra,ra,ra
li	t2,0
beq	ra,t2,test_2825
j	fail

test_2825:
lui	gp,0x1
addi	gp,gp,-1271 # _start-0x7ffff4f7
li	tp,0
lui	ra,0x80000
li	sp,7
srl	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2825+0xc
lui	t2,0x1000
beq	t1,t2,test_2826
j	fail

test_2826:
lui	gp,0x1
addi	gp,gp,-1270 # _start-0x7ffff4f6
li	tp,0
lui	ra,0x80000
li	sp,14
srl	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2826+0xc
lui	t2,0x20
beq	t1,t2,test_2827
j	fail

test_2827:
lui	gp,0x1
addi	gp,gp,-1269 # _start-0x7ffff4f5
li	tp,0
lui	ra,0x80000
li	sp,31
srl	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2827+0xc
li	t2,1
beq	t1,t2,test_2828
j	fail

test_2828:
lui	gp,0x1
addi	gp,gp,-1268 # _start-0x7ffff4f4
li	tp,0
lui	ra,0x80000
li	sp,7
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2828+0xc
lui	t2,0x1000
beq	a4,t2,test_2829
j	fail

test_2829:
lui	gp,0x1
addi	gp,gp,-1267 # _start-0x7ffff4f3
li	tp,0
lui	ra,0x80000
li	sp,14
nop
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2829+0xc
lui	t2,0x20
beq	a4,t2,test_2830
j	fail

test_2830:
lui	gp,0x1
addi	gp,gp,-1266 # _start-0x7ffff4f2
li	tp,0
lui	ra,0x80000
li	sp,31
nop
nop
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2830+0xc
li	t2,1
beq	a4,t2,test_2831
j	fail

test_2831:
lui	gp,0x1
addi	gp,gp,-1265 # _start-0x7ffff4f1
li	tp,0
lui	ra,0x80000
nop
li	sp,7
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2831+0xc
lui	t2,0x1000
beq	a4,t2,test_2832
j	fail

test_2832:
lui	gp,0x1
addi	gp,gp,-1264 # _start-0x7ffff4f0
li	tp,0
lui	ra,0x80000
nop
li	sp,14
nop
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2832+0xc
lui	t2,0x20
beq	a4,t2,test_2833
j	fail

test_2833:
lui	gp,0x1
addi	gp,gp,-1263 # _start-0x7ffff4ef
li	tp,0
lui	ra,0x80000
nop
nop
li	sp,31
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2833+0xc
li	t2,1
beq	a4,t2,test_2834
j	fail

test_2834:
lui	gp,0x1
addi	gp,gp,-1262 # _start-0x7ffff4ee
li	tp,0
li	sp,7
lui	ra,0x80000
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2834+0xc
lui	t2,0x1000
beq	a4,t2,test_2835
j	fail

test_2835:
lui	gp,0x1
addi	gp,gp,-1261 # _start-0x7ffff4ed
li	tp,0
li	sp,14
lui	ra,0x80000
nop
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2835+0xc
lui	t2,0x20
beq	a4,t2,test_2836
j	fail

test_2836:
lui	gp,0x1
addi	gp,gp,-1260 # _start-0x7ffff4ec
li	tp,0
li	sp,31
lui	ra,0x80000
nop
nop
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2836+0xc
li	t2,1
beq	a4,t2,test_2837
j	fail

test_2837:
lui	gp,0x1
addi	gp,gp,-1259 # _start-0x7ffff4eb
li	tp,0
li	sp,7
nop
lui	ra,0x80000
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2837+0xc
lui	t2,0x1000
beq	a4,t2,test_2838
j	fail

test_2838:
lui	gp,0x1
addi	gp,gp,-1258 # _start-0x7ffff4ea
li	tp,0
li	sp,14
nop
lui	ra,0x80000
nop
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2838+0xc
lui	t2,0x20
beq	a4,t2,test_2839
j	fail

test_2839:
lui	gp,0x1
addi	gp,gp,-1257 # _start-0x7ffff4e9
li	tp,0
li	sp,31
nop
nop
lui	ra,0x80000
srl	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2839+0xc
li	t2,1
beq	a4,t2,test_2840
j	fail

test_2840:
lui	gp,0x1
addi	gp,gp,-1256 # _start-0x7ffff4e8
li	ra,15
srl	sp,zero,ra
li	t2,0
beq	sp,t2,test_2841
j	fail

test_2841:
lui	gp,0x1
addi	gp,gp,-1255 # _start-0x7ffff4e7
li	ra,32
srl	sp,ra,zero
li	t2,32
beq	sp,t2,test_2842
j	fail

test_2842:
lui	gp,0x1
addi	gp,gp,-1254 # _start-0x7ffff4e6
srl	ra,zero,zero
li	t2,0
beq	ra,t2,test_2843
j	fail

test_2843:
lui	gp,0x1
addi	gp,gp,-1253 # _start-0x7ffff4e5
li	ra,1024
lui	sp,0x1
addi	sp,sp,-2048 # _start-0x7ffff800
srl	zero,ra,sp
li	t2,0
beq	zero,t2,test_2902
j	fail

test_2902:
lui	gp,0x1
addi	gp,gp,-1194 # _start-0x7ffff4aa
lui	ra,0x80000
srli	a4,ra,0x0
lui	t2,0x80000
beq	a4,t2,test_2903
j	fail

test_2903:
lui	gp,0x1
addi	gp,gp,-1193 # _start-0x7ffff4a9
lui	ra,0x80000
srli	a4,ra,0x1
lui	t2,0x40000
beq	a4,t2,test_2904
j	fail

test_2904:
lui	gp,0x1
addi	gp,gp,-1192 # _start-0x7ffff4a8
lui	ra,0x80000
srli	a4,ra,0x7
lui	t2,0x1000
beq	a4,t2,test_2905
j	fail

test_2905:
lui	gp,0x1
addi	gp,gp,-1191 # _start-0x7ffff4a7
lui	ra,0x80000
srli	a4,ra,0xe
lui	t2,0x20
beq	a4,t2,test_2906
j	fail

test_2906:
lui	gp,0x1
addi	gp,gp,-1190 # _start-0x7ffff4a6
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
srli	a4,ra,0x1f
li	t2,1
beq	a4,t2,test_2907
j	fail

test_2907:
lui	gp,0x1
addi	gp,gp,-1189 # _start-0x7ffff4a5
li	ra,-1
srli	a4,ra,0x0
li	t2,-1
beq	a4,t2,test_2908
j	fail

test_2908:
lui	gp,0x1
addi	gp,gp,-1188 # _start-0x7ffff4a4
li	ra,-1
srli	a4,ra,0x1
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_2909
j	fail

test_2909:
lui	gp,0x1
addi	gp,gp,-1187 # _start-0x7ffff4a3
li	ra,-1
srli	a4,ra,0x7
lui	t2,0x2000
addi	t2,t2,-1 # _start-0x7e000001
beq	a4,t2,test_2910
j	fail

test_2910:
lui	gp,0x1
addi	gp,gp,-1186 # _start-0x7ffff4a2
li	ra,-1
srli	a4,ra,0xe
lui	t2,0x40
addi	t2,t2,-1 # _start-0x7ffc0001
beq	a4,t2,test_2911
j	fail

test_2911:
lui	gp,0x1
addi	gp,gp,-1185 # _start-0x7ffff4a1
li	ra,-1
srli	a4,ra,0x1f
li	t2,1
beq	a4,t2,test_2912
j	fail

test_2912:
lui	gp,0x1
addi	gp,gp,-1184 # _start-0x7ffff4a0
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x0
lui	t2,0x21212
addi	t2,t2,289 # _start-0x5edededf
beq	a4,t2,test_2913
j	fail

test_2913:
lui	gp,0x1
addi	gp,gp,-1183 # _start-0x7ffff49f
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x1
lui	t2,0x10909
addi	t2,t2,144 # _start-0x6f6f6f70
beq	a4,t2,test_2914
j	fail

test_2914:
lui	gp,0x1
addi	gp,gp,-1182 # _start-0x7ffff49e
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x7
lui	t2,0x424
addi	t2,t2,578 # _start-0x7fbdbdbe
beq	a4,t2,test_2915
j	fail

test_2915:
lui	gp,0x1
addi	gp,gp,-1181 # _start-0x7ffff49d
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0xe
lui	t2,0x8
addi	t2,t2,1156 # _start-0x7fff7b7c
beq	a4,t2,test_2916
j	fail

test_2916:
lui	gp,0x1
addi	gp,gp,-1180 # _start-0x7ffff49c
lui	ra,0x21212
addi	ra,ra,289 # _start-0x5edededf
srli	a4,ra,0x1f
li	t2,0
beq	a4,t2,test_2917
j	fail

test_2917:
lui	gp,0x1
addi	gp,gp,-1179 # _start-0x7ffff49b
lui	ra,0x80000
srli	ra,ra,0x7
lui	t2,0x1000
beq	ra,t2,test_2918
j	fail

test_2918:
lui	gp,0x1
addi	gp,gp,-1178 # _start-0x7ffff49a
li	tp,0
lui	ra,0x80000
srli	a4,ra,0x7
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2918+0xc
lui	t2,0x1000
beq	t1,t2,test_2919
j	fail

test_2919:
lui	gp,0x1
addi	gp,gp,-1177 # _start-0x7ffff499
li	tp,0
lui	ra,0x80000
srli	a4,ra,0xe
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2919+0xc
lui	t2,0x20
beq	t1,t2,test_2920
j	fail

test_2920:
lui	gp,0x1
addi	gp,gp,-1176 # _start-0x7ffff498
li	tp,0
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
srli	a4,ra,0x1f
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2920+0xc
li	t2,1
beq	t1,t2,test_2921
j	fail

test_2921:
lui	gp,0x1
addi	gp,gp,-1175 # _start-0x7ffff497
li	tp,0
lui	ra,0x80000
srli	a4,ra,0x7
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2921+0xc
lui	t2,0x1000
beq	a4,t2,test_2922
j	fail

test_2922:
lui	gp,0x1
addi	gp,gp,-1174 # _start-0x7ffff496
li	tp,0
lui	ra,0x80000
nop
srli	a4,ra,0xe
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2922+0xc
lui	t2,0x20
beq	a4,t2,test_2923
j	fail

test_2923:
lui	gp,0x1
addi	gp,gp,-1173 # _start-0x7ffff495
li	tp,0
lui	ra,0x80000
addi	ra,ra,1 # _end+0xffff5f31
nop
nop
srli	a4,ra,0x1f
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_2923+0xc
li	t2,1
beq	a4,t2,test_2924
j	fail

test_2924:
lui	gp,0x1
addi	gp,gp,-1172 # _start-0x7ffff494
srli	ra,zero,0x4
li	t2,0
beq	ra,t2,test_2925
j	fail

test_2925:
lui	gp,0x1
addi	gp,gp,-1171 # _start-0x7ffff493
li	ra,33
srli	zero,ra,0xa
li	t2,0
beq	zero,t2,test_3002
j	fail

test_3002:
lui	gp,0x1
addi	gp,gp,-1094 # _start-0x7ffff446
li	ra,0
li	sp,0
sub	a4,ra,sp
li	t2,0
beq	a4,t2,test_3003
j	fail

test_3003:
lui	gp,0x1
addi	gp,gp,-1093 # _start-0x7ffff445
li	ra,1
li	sp,1
sub	a4,ra,sp
li	t2,0
beq	a4,t2,test_3004
j	fail

test_3004:
lui	gp,0x1
addi	gp,gp,-1092 # _start-0x7ffff444
li	ra,3
li	sp,7
sub	a4,ra,sp
li	t2,-4
beq	a4,t2,test_3005
j	fail

test_3005:
lui	gp,0x1
addi	gp,gp,-1091 # _start-0x7ffff443
li	ra,0
lui	sp,0xffff8
sub	a4,ra,sp
lui	t2,0x8
beq	a4,t2,test_3006
j	fail

test_3006:
lui	gp,0x1
addi	gp,gp,-1090 # _start-0x7ffff442
lui	ra,0x80000
li	sp,0
sub	a4,ra,sp
lui	t2,0x80000
beq	a4,t2,test_3007
j	fail

test_3007:
lui	gp,0x1
addi	gp,gp,-1089 # _start-0x7ffff441
lui	ra,0x80000
lui	sp,0xffff8
sub	a4,ra,sp
lui	t2,0x80008
beq	a4,t2,test_3008
j	fail

test_3008:
lui	gp,0x1
addi	gp,gp,-1088 # _start-0x7ffff440
li	ra,0
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
sub	a4,ra,sp
lui	t2,0xffff8
addi	t2,t2,1 # _end+0x7ffedf31
beq	a4,t2,test_3009
j	fail

test_3009:
lui	gp,0x1
addi	gp,gp,-1087 # _start-0x7ffff43f
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
li	sp,0
sub	a4,ra,sp
lui	t2,0x80000
addi	t2,t2,-1 # _end+0xffff5f2f
beq	a4,t2,test_3010
j	fail

test_3010:
lui	gp,0x1
addi	gp,gp,-1086 # _start-0x7ffff43e
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
sub	a4,ra,sp
lui	t2,0x7fff8
beq	a4,t2,test_3011
j	fail

test_3011:
lui	gp,0x1
addi	gp,gp,-1085 # _start-0x7ffff43d
lui	ra,0x80000
lui	sp,0x8
addi	sp,sp,-1 # _start-0x7fff8001
sub	a4,ra,sp
lui	t2,0x7fff8
addi	t2,t2,1 # _start-0x7fff
beq	a4,t2,test_3012
j	fail

test_3012:
lui	gp,0x1
addi	gp,gp,-1084 # _start-0x7ffff43c
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0xffff8
sub	a4,ra,sp
lui	t2,0x80008
addi	t2,t2,-1 # _end+0xffffdf2f
beq	a4,t2,test_3013
j	fail

test_3013:
lui	gp,0x1
addi	gp,gp,-1083 # _start-0x7ffff43b
li	ra,0
li	sp,-1
sub	a4,ra,sp
li	t2,1
beq	a4,t2,test_3014
j	fail

test_3014:
lui	gp,0x1
addi	gp,gp,-1082 # _start-0x7ffff43a
li	ra,-1
li	sp,1
sub	a4,ra,sp
li	t2,-2
beq	a4,t2,test_3015
j	fail

test_3015:
lui	gp,0x1
addi	gp,gp,-1081 # _start-0x7ffff439
li	ra,-1
li	sp,-1
sub	a4,ra,sp
li	t2,0
beq	a4,t2,test_3016
j	fail

test_3016:
lui	gp,0x1
addi	gp,gp,-1080 # _start-0x7ffff438
li	ra,13
li	sp,11
sub	ra,ra,sp
li	t2,2
beq	ra,t2,test_3017
j	fail

test_3017:
lui	gp,0x1
addi	gp,gp,-1079 # _start-0x7ffff437
li	ra,14
li	sp,11
sub	sp,ra,sp
li	t2,3
beq	sp,t2,test_3018
j	fail

test_3018:
lui	gp,0x1
addi	gp,gp,-1078 # _start-0x7ffff436
li	ra,13
sub	ra,ra,ra
li	t2,0
beq	ra,t2,test_3019
j	fail

test_3019:
lui	gp,0x1
addi	gp,gp,-1077 # _start-0x7ffff435
li	tp,0
li	ra,13
li	sp,11
sub	a4,ra,sp
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3019+0xc
li	t2,2
beq	t1,t2,test_3020
j	fail

test_3020:
lui	gp,0x1
addi	gp,gp,-1076 # _start-0x7ffff434
li	tp,0
li	ra,14
li	sp,11
sub	a4,ra,sp
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3020+0xc
li	t2,3
beq	t1,t2,test_3021
j	fail

test_3021:
lui	gp,0x1
addi	gp,gp,-1075 # _start-0x7ffff433
li	tp,0
li	ra,15
li	sp,11
sub	a4,ra,sp
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3021+0xc
li	t2,4
beq	t1,t2,test_3022
j	fail

test_3022:
lui	gp,0x1
addi	gp,gp,-1074 # _start-0x7ffff432
li	tp,0
li	ra,13
li	sp,11
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3022+0xc
li	t2,2
beq	a4,t2,test_3023
j	fail

test_3023:
lui	gp,0x1
addi	gp,gp,-1073 # _start-0x7ffff431
li	tp,0
li	ra,14
li	sp,11
nop
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3023+0xc
li	t2,3
beq	a4,t2,test_3024
j	fail

test_3024:
lui	gp,0x1
addi	gp,gp,-1072 # _start-0x7ffff430
li	tp,0
li	ra,15
li	sp,11
nop
nop
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3024+0xc
li	t2,4
beq	a4,t2,test_3025
j	fail

test_3025:
lui	gp,0x1
addi	gp,gp,-1071 # _start-0x7ffff42f
li	tp,0
li	ra,13
nop
li	sp,11
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3025+0xc
li	t2,2
beq	a4,t2,test_3026
j	fail

test_3026:
lui	gp,0x1
addi	gp,gp,-1070 # _start-0x7ffff42e
li	tp,0
li	ra,14
nop
li	sp,11
nop
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3026+0xc
li	t2,3
beq	a4,t2,test_3027
j	fail

test_3027:
lui	gp,0x1
addi	gp,gp,-1069 # _start-0x7ffff42d
li	tp,0
li	ra,15
nop
nop
li	sp,11
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3027+0xc
li	t2,4
beq	a4,t2,test_3028
j	fail

test_3028:
lui	gp,0x1
addi	gp,gp,-1068 # _start-0x7ffff42c
li	tp,0
li	sp,11
li	ra,13
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3028+0xc
li	t2,2
beq	a4,t2,test_3029
j	fail

test_3029:
lui	gp,0x1
addi	gp,gp,-1067 # _start-0x7ffff42b
li	tp,0
li	sp,11
li	ra,14
nop
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3029+0xc
li	t2,3
beq	a4,t2,test_3030
j	fail

test_3030:
lui	gp,0x1
addi	gp,gp,-1066 # _start-0x7ffff42a
li	tp,0
li	sp,11
li	ra,15
nop
nop
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3030+0xc
li	t2,4
beq	a4,t2,test_3031
j	fail

test_3031:
lui	gp,0x1
addi	gp,gp,-1065 # _start-0x7ffff429
li	tp,0
li	sp,11
nop
li	ra,13
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3031+0xc
li	t2,2
beq	a4,t2,test_3032
j	fail

test_3032:
lui	gp,0x1
addi	gp,gp,-1064 # _start-0x7ffff428
li	tp,0
li	sp,11
nop
li	ra,14
nop
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3032+0xc
li	t2,3
beq	a4,t2,test_3033
j	fail

test_3033:
lui	gp,0x1
addi	gp,gp,-1063 # _start-0x7ffff427
li	tp,0
li	sp,11
nop
nop
li	ra,15
sub	a4,ra,sp
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3033+0xc
li	t2,4
beq	a4,t2,test_3034
j	fail

test_3034:
lui	gp,0x1
addi	gp,gp,-1062 # _start-0x7ffff426
li	ra,-15
neg	sp,ra
li	t2,15
beq	sp,t2,test_3035
j	fail

test_3035:
lui	gp,0x1
addi	gp,gp,-1061 # _start-0x7ffff425
li	ra,32
sub	sp,ra,zero
li	t2,32
beq	sp,t2,test_3036
j	fail

test_3036:
lui	gp,0x1
addi	gp,gp,-1060 # _start-0x7ffff424
neg	ra,zero
li	t2,0
beq	ra,t2,test_3037
j	fail

test_3037:
lui	gp,0x1
addi	gp,gp,-1059 # _start-0x7ffff423
li	ra,16
li	sp,30
sub	zero,ra,sp
li	t2,0
beq	zero,t2,test_3102
j	fail

test_3102:
lui	gp,0x1
addi	gp,gp,-994 # _start-0x7ffff3e2
lui	ra,0xff1
addi	ra,ra,-256 # _start-0x7f00f100
xori	a4,ra,-241
lui	t2,0xff00f
addi	t2,t2,15 # _end+0x7f004f3f
beq	a4,t2,test_3103
j	fail

test_3103:
lui	gp,0x1
addi	gp,gp,-993 # _start-0x7ffff3e1
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
xori	a4,ra,240
lui	t2,0xff01
addi	t2,t2,-256 # _start-0x700ff100
beq	a4,t2,test_3104
j	fail

test_3104:
lui	gp,0x1
addi	gp,gp,-992 # _start-0x7ffff3e0
lui	ra,0xff1
addi	ra,ra,-1793 # _start-0x7f00f701
xori	a4,ra,1807
lui	t2,0xff1
addi	t2,t2,-16 # _start-0x7f00f010
beq	a4,t2,test_3105
j	fail

test_3105:
lui	gp,0x1
addi	gp,gp,-991 # _start-0x7ffff3df
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
xori	a4,ra,240
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700f502f
beq	a4,t2,test_3106
j	fail

test_3106:
lui	gp,0x1
addi	gp,gp,-990 # _start-0x7ffff3de
lui	ra,0xff00f
addi	ra,ra,1792 # _end+0x7f005630
xori	ra,ra,1807
lui	t2,0xff00f
addi	t2,t2,15 # _end+0x7f004f3f
beq	ra,t2,test_3107
j	fail

test_3107:
lui	gp,0x1
addi	gp,gp,-989 # _start-0x7ffff3dd
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
xori	a4,ra,240
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3107+0xc
lui	t2,0xff01
addi	t2,t2,-256 # _start-0x700ff100
beq	t1,t2,test_3108
j	fail

test_3108:
lui	gp,0x1
addi	gp,gp,-988 # _start-0x7ffff3dc
li	tp,0
lui	ra,0xff1
addi	ra,ra,-1793 # _start-0x7f00f701
xori	a4,ra,1807
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3108+0xc
lui	t2,0xff1
addi	t2,t2,-16 # _start-0x7f00f010
beq	t1,t2,test_3109
j	fail

test_3109:
lui	gp,0x1
addi	gp,gp,-987 # _start-0x7ffff3db
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
xori	a4,ra,240
nop
nop
mv	t1,a4
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3109+0xc
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700f502f
beq	t1,t2,test_3110
j	fail

test_3110:
lui	gp,0x1
addi	gp,gp,-986 # _start-0x7ffff3da
li	tp,0
lui	ra,0xff01
addi	ra,ra,-16 # _start-0x700ff010
xori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3110+0xc
lui	t2,0xff01
addi	t2,t2,-256 # _start-0x700ff100
beq	a4,t2,test_3111
j	fail

test_3111:
lui	gp,0x1
addi	gp,gp,-985 # _start-0x7ffff3d9
li	tp,0
lui	ra,0xff1
addi	ra,ra,-1 # _start-0x7f00f001
nop
xori	a4,ra,15
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3111+0xc
lui	t2,0xff1
addi	t2,t2,-16 # _start-0x7f00f010
beq	a4,t2,test_3112
j	fail

test_3112:
lui	gp,0x1
addi	gp,gp,-984 # _start-0x7ffff3d8
li	tp,0
lui	ra,0xf00ff
addi	ra,ra,15 # _end+0x700f4f3f
nop
nop
xori	a4,ra,240
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3112+0xc
lui	t2,0xf00ff
addi	t2,t2,255 # _end+0x700f502f
beq	a4,t2,test_3113
j	fail

test_3113:
lui	gp,0x1
addi	gp,gp,-983 # _start-0x7ffff3d7
xori	ra,zero,240
li	t2,240
beq	ra,t2,test_3114
j	fail

test_3114:
lui	gp,0x1
addi	gp,gp,-982 # _start-0x7ffff3d6
lui	ra,0xff0
addi	ra,ra,255 # _start-0x7f00ff01
xori	zero,ra,1807
li	t2,0
beq	zero,t2,test_3202
j	fail

test_3202:
lui	gp,0x1
addi	gp,gp,-894 # _start-0x7ffff37e
li	ra,0
li	sp,0
bgeu	ra,sp,test_3202+0x20
beq	zero,gp,test_3202+0x1c
j	fail
bne	zero,gp,test_3203
bgeu	ra,sp,test_3202+0x1c
beq	zero,gp,test_3203
j	fail

test_3203:
lui	gp,0x1
addi	gp,gp,-893 # _start-0x7ffff37d
li	ra,1
li	sp,1
bgeu	ra,sp,test_3203+0x20
beq	zero,gp,test_3203+0x1c
j	fail
bne	zero,gp,test_3204
bgeu	ra,sp,test_3203+0x1c
beq	zero,gp,test_3204
j	fail

test_3204:
lui	gp,0x1
addi	gp,gp,-892 # _start-0x7ffff37c
li	ra,-1
li	sp,-1
bgeu	ra,sp,test_3204+0x20
beq	zero,gp,test_3204+0x1c
j	fail
bne	zero,gp,test_3205
bgeu	ra,sp,test_3204+0x1c
beq	zero,gp,test_3205
j	fail

test_3205:
lui	gp,0x1
addi	gp,gp,-891 # _start-0x7ffff37b
li	ra,1
li	sp,0
bgeu	ra,sp,test_3205+0x20
beq	zero,gp,test_3205+0x1c
j	fail
bne	zero,gp,test_3206
bgeu	ra,sp,test_3205+0x1c
beq	zero,gp,test_3206
j	fail

test_3206:
lui	gp,0x1
addi	gp,gp,-890 # _start-0x7ffff37a
li	ra,-1
li	sp,-2
bgeu	ra,sp,test_3206+0x20
beq	zero,gp,test_3206+0x1c
j	fail
bne	zero,gp,test_3207
bgeu	ra,sp,test_3206+0x1c
beq	zero,gp,test_3207
j	fail

test_3207:
lui	gp,0x1
addi	gp,gp,-889 # _start-0x7ffff379
li	ra,-1
li	sp,0
bgeu	ra,sp,test_3207+0x20
beq	zero,gp,test_3207+0x1c
j	fail
bne	zero,gp,test_3208
bgeu	ra,sp,test_3207+0x1c
beq	zero,gp,test_3208
j	fail

test_3208:
lui	gp,0x1
addi	gp,gp,-888 # _start-0x7ffff378
li	ra,0
li	sp,1
bgeu	ra,sp,test_3208+0x18
bne	zero,gp,test_3208+0x20
beq	zero,gp,test_3208+0x20
j	fail
bgeu	ra,sp,test_3208+0x18

test_3209:
lui	gp,0x1
addi	gp,gp,-887 # _start-0x7ffff377
li	ra,-2
li	sp,-1
bgeu	ra,sp,test_3209+0x18
bne	zero,gp,test_3209+0x20
beq	zero,gp,test_3209+0x20
j	fail
bgeu	ra,sp,test_3209+0x18

test_3210:
lui	gp,0x1
addi	gp,gp,-886 # _start-0x7ffff376
li	ra,0
li	sp,-1
bgeu	ra,sp,test_3210+0x18
bne	zero,gp,test_3210+0x20
beq	zero,gp,test_3210+0x20
j	fail
bgeu	ra,sp,test_3210+0x18

test_3211:
lui	gp,0x1
addi	gp,gp,-885 # _start-0x7ffff375
lui	ra,0x80000
addi	ra,ra,-1 # _end+0xffff5f2f
lui	sp,0x80000
bgeu	ra,sp,test_3211+0x1c
bne	zero,gp,test_3211+0x24
beq	zero,gp,test_3211+0x24
j	fail
bgeu	ra,sp,test_3211+0x1c

test_3212:
lui	gp,0x1
addi	gp,gp,-884 # _start-0x7ffff374
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
lui	sp,0xf0000
bltu	ra,sp,test_3212+0x20
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3212+0xc

test_3213:
lui	gp,0x1
addi	gp,gp,-883 # _start-0x7ffff373
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
lui	sp,0xf0000
nop
bltu	ra,sp,test_3213+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3213+0xc

test_3214:
lui	gp,0x1
addi	gp,gp,-882 # _start-0x7ffff372
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
lui	sp,0xf0000
nop
nop
bltu	ra,sp,test_3214+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3214+0xc

test_3215:
lui	gp,0x1
addi	gp,gp,-881 # _start-0x7ffff371
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
nop
lui	sp,0xf0000
bltu	ra,sp,test_3215+0x24
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3215+0xc

test_3216:
lui	gp,0x1
addi	gp,gp,-880 # _start-0x7ffff370
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
nop
lui	sp,0xf0000
nop
bltu	ra,sp,test_3216+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3216+0xc

test_3217:
lui	gp,0x1
addi	gp,gp,-879 # _start-0x7ffff36f
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
nop
nop
lui	sp,0xf0000
bltu	ra,sp,test_3217+0x28
j	fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3217+0xc

test_3218:
lui	gp,0x1
addi	gp,gp,-878 # _start-0x7ffff36e
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
lui	sp,0xf0000
bgeu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3218+0xc

test_3219:
lui	gp,0x1
addi	gp,gp,-877 # _start-0x7ffff36d
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
lui	sp,0xf0000
nop
bgeu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3219+0xc

test_3220:
lui	gp,0x1
addi	gp,gp,-876 # _start-0x7ffff36c
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
lui	sp,0xf0000
nop
nop
bgeu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3220+0xc

test_3221:
lui	gp,0x1
addi	gp,gp,-875 # _start-0x7ffff36b
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
nop
lui	sp,0xf0000
bgeu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3221+0xc

test_3222:
lui	gp,0x1
addi	gp,gp,-874 # _start-0x7ffff36a
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
nop
lui	sp,0xf0000
nop
bgeu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3222+0xc

test_3223:
lui	gp,0x1
addi	gp,gp,-873 # _start-0x7ffff369
li	tp,0
lui	ra,0xf0000
addi	ra,ra,-1 # _end+0x6fff5f2f
nop
nop
lui	sp,0xf0000
bgeu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3223+0xc

test_3224:
lui	gp,0x1
addi	gp,gp,-872 # _start-0x7ffff368
li	ra,1
bgeu	ra,zero,test_3224+0x20
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
li	t2,3
bne	ra,t2,fail

test_3302:
lui	gp,0x1
addi	gp,gp,-794 # _start-0x7ffff31a
li	ra,0
li	sp,1
bltu	ra,sp,test_3302+0x1c
bne	zero,gp,fail
bne	zero,gp,test_3303
bltu	ra,sp,test_3302+0x18
bne	zero,gp,fail

test_3303:
lui	gp,0x1
addi	gp,gp,-793 # _start-0x7ffff319
li	ra,-2
li	sp,-1
bltu	ra,sp,test_3303+0x1c
bne	zero,gp,fail
bne	zero,gp,test_3304
bltu	ra,sp,test_3303+0x18
bne	zero,gp,fail

test_3304:
lui	gp,0x1
addi	gp,gp,-792 # _start-0x7ffff318
li	ra,0
li	sp,-1
bltu	ra,sp,test_3304+0x1c
bne	zero,gp,fail
bne	zero,gp,test_3305
bltu	ra,sp,test_3304+0x18
bne	zero,gp,fail

test_3305:
lui	gp,0x1
addi	gp,gp,-791 # _start-0x7ffff317
li	ra,1
li	sp,0
bltu	ra,sp,test_3305+0x18
bne	zero,gp,test_3305+0x1c
bne	zero,gp,fail
bltu	ra,sp,test_3305+0x18

test_3306:
lui	gp,0x1
addi	gp,gp,-790 # _start-0x7ffff316
li	ra,-1
li	sp,-2
bltu	ra,sp,test_3306+0x18
bne	zero,gp,test_3306+0x1c
bne	zero,gp,fail
bltu	ra,sp,test_3306+0x18

test_3307:
lui	gp,0x1
addi	gp,gp,-789 # _start-0x7ffff315
li	ra,-1
li	sp,0
bltu	ra,sp,test_3307+0x18
bne	zero,gp,test_3307+0x1c
bne	zero,gp,fail
bltu	ra,sp,test_3307+0x18

test_3308:
lui	gp,0x1
addi	gp,gp,-788 # _start-0x7ffff314
lui	ra,0x80000
lui	sp,0x80000
addi	sp,sp,-1 # _end+0xffff5f2f
bltu	ra,sp,test_3308+0x1c
bne	zero,gp,test_3308+0x20
bne	zero,gp,fail
bltu	ra,sp,test_3308+0x1c

test_3309:
lui	gp,0x1
addi	gp,gp,-787 # _start-0x7ffff313
li	tp,0
lui	ra,0xf0000
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3309+0xc

test_3310:
lui	gp,0x1
addi	gp,gp,-786 # _start-0x7ffff312
li	tp,0
lui	ra,0xf0000
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
nop
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3310+0xc

test_3311:
lui	gp,0x1
addi	gp,gp,-785 # _start-0x7ffff311
li	tp,0
lui	ra,0xf0000
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
nop
nop
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3311+0xc

test_3312:
lui	gp,0x1
addi	gp,gp,-784 # _start-0x7ffff310
li	tp,0
lui	ra,0xf0000
nop
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3312+0xc

test_3313:
lui	gp,0x1
addi	gp,gp,-783 # _start-0x7ffff30f
li	tp,0
lui	ra,0xf0000
nop
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
nop
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3313+0xc

test_3314:
lui	gp,0x1
addi	gp,gp,-782 # _start-0x7ffff30e
li	tp,0
lui	ra,0xf0000
nop
nop
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3314+0xc

test_3315:
lui	gp,0x1
addi	gp,gp,-781 # _start-0x7ffff30d
li	tp,0
lui	ra,0xf0000
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3315+0xc

test_3316:
lui	gp,0x1
addi	gp,gp,-780 # _start-0x7ffff30c
li	tp,0
lui	ra,0xf0000
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
nop
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3316+0xc

test_3317:
lui	gp,0x1
addi	gp,gp,-779 # _start-0x7ffff30b
li	tp,0
lui	ra,0xf0000
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
nop
nop
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3317+0xc

test_3318:
lui	gp,0x1
addi	gp,gp,-778 # _start-0x7ffff30a
li	tp,0
lui	ra,0xf0000
nop
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3318+0xc

test_3319:
lui	gp,0x1
addi	gp,gp,-777 # _start-0x7ffff309
li	tp,0
lui	ra,0xf0000
nop
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
nop
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3319+0xc

test_3320:
lui	gp,0x1
addi	gp,gp,-776 # _start-0x7ffff308
li	tp,0
lui	ra,0xf0000
nop
nop
lui	sp,0xf0000
addi	sp,sp,-1 # _end+0x6fff5f2f
bltu	ra,sp,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3320+0xc

test_3321:
lui	gp,0x1
addi	gp,gp,-775 # _start-0x7ffff307
li	ra,1
bltu	zero,ra,test_3321+0x20
addi	ra,ra,1 # _end+0x6fff5f31
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
addi	ra,ra,1
li	t2,3
bne	ra,t2,fail

test_3402:
lui	gp,0x1
addi	gp,gp,-694 # _start-0x7ffff2b6
li	a5,255
auipc	ra,0x2
addi	ra,ra,820 # lbu_tdat
lbu	a4,0(ra)
li	t2,255
bne	a4,t2,fail

test_3403:
lui	gp,0x1
addi	gp,gp,-693 # _start-0x7ffff2b5
li	a5,0
auipc	ra,0x2
addi	ra,ra,788 # lbu_tdat
lbu	a4,1(ra)
li	t2,0
bne	a4,t2,fail

test_3404:
lui	gp,0x1
addi	gp,gp,-692 # _start-0x7ffff2b4
li	a5,240
auipc	ra,0x2
addi	ra,ra,756 # lbu_tdat
lbu	a4,2(ra)
li	t2,240
bne	a4,t2,fail

test_3405:
lui	gp,0x1
addi	gp,gp,-691 # _start-0x7ffff2b3
li	a5,15
auipc	ra,0x2
addi	ra,ra,724 # lbu_tdat
lbu	a4,3(ra)
li	t2,15
bne	a4,t2,fail

test_3406:
lui	gp,0x1
addi	gp,gp,-690 # _start-0x7ffff2b2
li	a5,255
auipc	ra,0x2
addi	ra,ra,695 # lbu_tdat4
lbu	a4,-3(ra)
li	t2,255
bne	a4,t2,fail

test_3407:
lui	gp,0x1
addi	gp,gp,-689 # _start-0x7ffff2b1
li	a5,0
auipc	ra,0x2
addi	ra,ra,663 # lbu_tdat4
lbu	a4,-2(ra)
li	t2,0
bne	a4,t2,fail

test_3408:
lui	gp,0x1
addi	gp,gp,-688 # _start-0x7ffff2b0
li	a5,240
auipc	ra,0x2
addi	ra,ra,631 # lbu_tdat4
lbu	a4,-1(ra)
li	t2,240
bne	a4,t2,fail

test_3409:
lui	gp,0x1
addi	gp,gp,-687 # _start-0x7ffff2af
li	a5,15
auipc	ra,0x2
addi	ra,ra,599 # lbu_tdat4
lbu	a4,0(ra)
li	t2,15
bne	a4,t2,fail

test_3410:
lui	gp,0x1
addi	gp,gp,-686 # _start-0x7ffff2ae
auipc	ra,0x2
addi	ra,ra,568 # lbu_tdat
addi	ra,ra,-32
lbu	t0,32(ra)
li	t2,255
bne	t0,t2,fail

test_3411:
lui	gp,0x1
addi	gp,gp,-685 # _start-0x7ffff2ad
auipc	ra,0x2
addi	ra,ra,536 # lbu_tdat
addi	ra,ra,-6
lbu	t0,7(ra)
li	t2,0
bne	t0,t2,fail

test_3412:
lui	gp,0x1
addi	gp,gp,-684 # _start-0x7ffff2ac
li	tp,0
auipc	ra,0x2
addi	ra,ra,501 # lbu_tdat2
lbu	a4,1(ra)
mv	t1,a4
li	t2,240
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3412+0xc

test_3413:
lui	gp,0x1
addi	gp,gp,-683 # _start-0x7ffff2ab
li	tp,0
auipc	ra,0x2
addi	ra,ra,454 # lbu_tdat3
lbu	a4,1(ra)
nop
mv	t1,a4
li	t2,15
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3413+0xc

test_3414:
lui	gp,0x1
addi	gp,gp,-682 # _start-0x7ffff2aa
li	tp,0
auipc	ra,0x2
addi	ra,ra,400 # lbu_tdat
lbu	a4,1(ra)
nop
nop
mv	t1,a4
li	t2,0
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3414+0xc

test_3415:
lui	gp,0x1
addi	gp,gp,-681 # _start-0x7ffff2a9
li	tp,0
auipc	ra,0x2
addi	ra,ra,345 # lbu_tdat2
lbu	a4,1(ra)
li	t2,240
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3415+0xc

test_3416:
lui	gp,0x1
addi	gp,gp,-680 # _start-0x7ffff2a8
li	tp,0
auipc	ra,0x2
addi	ra,ra,302 # lbu_tdat3
nop
lbu	a4,1(ra)
li	t2,15
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3416+0xc

test_3417:
lui	gp,0x1
addi	gp,gp,-679 # _start-0x7ffff2a7
li	tp,0
auipc	ra,0x2
addi	ra,ra,252 # lbu_tdat
nop
nop
lbu	a4,1(ra)
li	t2,0
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3417+0xc

test_3418:
lui	gp,0x1
addi	gp,gp,-678 # _start-0x7ffff2a6
auipc	t0,0x2
addi	t0,t0,204 # lbu_tdat
lbu	sp,0(t0)
li	sp,2
li	t2,2
bne	sp,t2,fail

test_3419:
lui	gp,0x1
addi	gp,gp,-677 # _start-0x7ffff2a5
auipc	t0,0x2
addi	t0,t0,172 # lbu_tdat
lbu	sp,0(t0)
nop
li	sp,2
li	t2,2
bne	sp,t2,fail

test_3502:
lui	gp,0x1
addi	gp,gp,-594 # _start-0x7ffff252
li	a5,255
auipc	ra,0x2
addi	ra,ra,148 # lhu_tdat
lhu	a4,0(ra)
li	t2,255
bne	a4,t2,fail

test_3503:
lui	gp,0x1
addi	gp,gp,-593 # _start-0x7ffff251
lui	a5,0x10
addi	a5,a5,-256 # _start-0x7fff0100
auipc	ra,0x2
addi	ra,ra,112 # lhu_tdat
lhu	a4,2(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	a4,t2,fail

test_3504:
lui	gp,0x1
addi	gp,gp,-592 # _start-0x7ffff250
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x2
addi	ra,ra,72 # lhu_tdat
lhu	a4,4(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail

test_3505:
lui	gp,0x1
addi	gp,gp,-591 # _start-0x7ffff24f
lui	a5,0xf
addi	a5,a5,15 # _start-0x7fff0ff1
auipc	ra,0x2
addi	ra,ra,32 # lhu_tdat
lhu	a4,6(ra)
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	a4,t2,fail

test_3506:
lui	gp,0x1
addi	gp,gp,-590 # _start-0x7ffff24e
li	a5,255
auipc	ra,0x2
addi	ra,ra,2 # lhu_tdat4
lhu	a4,-6(ra)
li	t2,255
bne	a4,t2,fail

test_3507:
lui	gp,0x1
addi	gp,gp,-589 # _start-0x7ffff24d
lui	a5,0x10
addi	a5,a5,-256 # _start-0x7fff0100
auipc	ra,0x2
addi	ra,ra,-34 # lhu_tdat4
lhu	a4,-4(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	a4,t2,fail

test_3508:
lui	gp,0x1
addi	gp,gp,-588 # _start-0x7ffff24c
lui	a5,0x1
addi	a5,a5,-16 # _start-0x7ffff010
auipc	ra,0x2
addi	ra,ra,-74 # lhu_tdat4
lhu	a4,-2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail

test_3509:
lui	gp,0x1
addi	gp,gp,-587 # _start-0x7ffff24b
lui	a5,0xf
addi	a5,a5,15 # _start-0x7fff0ff1
auipc	ra,0x2
addi	ra,ra,-114 # lhu_tdat4
lhu	a4,0(ra)
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	a4,t2,fail

test_3510:
lui	gp,0x1
addi	gp,gp,-586 # _start-0x7ffff24a
auipc	ra,0x2
addi	ra,ra,-152 # lhu_tdat
addi	ra,ra,-32
lhu	t0,32(ra)
li	t2,255
bne	t0,t2,fail

test_3511:
lui	gp,0x1
addi	gp,gp,-585 # _start-0x7ffff249
auipc	ra,0x2
addi	ra,ra,-184 # lhu_tdat
addi	ra,ra,-5
lhu	t0,7(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	t0,t2,fail

test_3512:
lui	gp,0x1
addi	gp,gp,-584 # _start-0x7ffff248
li	tp,0
auipc	ra,0x2
addi	ra,ra,-222 # lhu_tdat2
lhu	a4,2(ra)
mv	t1,a4
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3512+0xc

test_3513:
lui	gp,0x1
addi	gp,gp,-583 # _start-0x7ffff247
li	tp,0
auipc	ra,0x2
addi	ra,ra,-272 # lhu_tdat3
lhu	a4,2(ra)
nop
mv	t1,a4
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3513+0xc

test_3514:
lui	gp,0x1
addi	gp,gp,-582 # _start-0x7ffff246
li	tp,0
auipc	ra,0x2
addi	ra,ra,-332 # lhu_tdat
lhu	a4,2(ra)
nop
nop
mv	t1,a4
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	t1,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3514+0xc

test_3515:
lui	gp,0x1
addi	gp,gp,-581 # _start-0x7ffff245
li	tp,0
auipc	ra,0x2
addi	ra,ra,-390 # lhu_tdat2
lhu	a4,2(ra)
lui	t2,0x1
addi	t2,t2,-16 # _start-0x7ffff010
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3515+0xc

test_3516:
lui	gp,0x1
addi	gp,gp,-580 # _start-0x7ffff244
li	tp,0
auipc	ra,0x2
addi	ra,ra,-436 # lhu_tdat3
nop
lhu	a4,2(ra)
lui	t2,0xf
addi	t2,t2,15 # _start-0x7fff0ff1
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3516+0xc

test_3517:
lui	gp,0x1
addi	gp,gp,-579 # _start-0x7ffff243
li	tp,0
auipc	ra,0x2
addi	ra,ra,-492 # lhu_tdat
nop
nop
lhu	a4,2(ra)
lui	t2,0x10
addi	t2,t2,-256 # _start-0x7fff0100
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3517+0xc

test_3518:
lui	gp,0x1
addi	gp,gp,-578 # _start-0x7ffff242
auipc	t0,0x2
addi	t0,t0,-544 # lhu_tdat
lhu	sp,0(t0)
li	sp,2
li	t2,2
bne	sp,t2,fail

test_3519:
lui	gp,0x1
addi	gp,gp,-577 # _start-0x7ffff241
auipc	t0,0x2
addi	t0,t0,-576 # lhu_tdat
lhu	sp,0(t0)
nop
li	sp,2
li	t2,2
bne	sp,t2,fail

test_3602:
lui	gp,0x1
addi	gp,gp,-494 # _start-0x7ffff1ee
lui	ra,0x0
li	t2,0
bne	ra,t2,fail

test_3603:
lui	gp,0x1
addi	gp,gp,-493 # _start-0x7ffff1ed
lui	ra,0xfffff
srai	ra,ra,0x1
li	t2,-2048
bne	ra,t2,fail

test_3604:
lui	gp,0x1
addi	gp,gp,-492 # _start-0x7ffff1ec
lui	ra,0x7ffff
srai	ra,ra,0x14
li	t2,2047
bne	ra,t2,fail

test_3605:
lui	gp,0x1
addi	gp,gp,-491 # _start-0x7ffff1eb
lui	ra,0x80000
srai	ra,ra,0x14
li	t2,-2048
bne	ra,t2,fail

test_3606:
lui	gp,0x1
addi	gp,gp,-490 # _start-0x7ffff1ea
lui	zero,0x80000
li	t2,0
bne	zero,t2,fail

test_3702:
lui	gp,0x1
addi	gp,gp,-394 # _start-0x7ffff18a
auipc	ra,0x2
addi	ra,ra,-708 # sw_tdat
lui	sp,0xaa0
addi	sp,sp,170 # _start-0x7f55ff56
auipc	a5,0x0
addi	a5,a5,20 # test_3702+0x2c
sw	sp,0(ra)
lw	a4,0(ra)
j	test_3702+0x30
mv	a4,sp
lui	t2,0xaa0
addi	t2,t2,170 # _start-0x7f55ff56
bne	a4,t2,fail

test_3703:
lui	gp,0x1
addi	gp,gp,-393 # _start-0x7ffff189
auipc	ra,0x2
addi	ra,ra,-768 # sw_tdat
lui	sp,0xaa00b
addi	sp,sp,-1536 # _end+0x2a000930
auipc	a5,0x0
addi	a5,a5,20 # test_3703+0x2c
sw	sp,4(ra)
lw	a4,4(ra)
j	test_3703+0x30
mv	a4,sp
lui	t2,0xaa00b
addi	t2,t2,-1536 # _end+0x2a000930
bne	a4,t2,fail

test_3704:
lui	gp,0x1
addi	gp,gp,-392 # _start-0x7ffff188
auipc	ra,0x2
addi	ra,ra,-828 # sw_tdat
lui	sp,0xaa01
addi	sp,sp,-1376 # _start-0x755ff560
auipc	a5,0x0
addi	a5,a5,20 # test_3704+0x2c
sw	sp,8(ra)
lw	a4,8(ra)
j	test_3704+0x30
mv	a4,sp
lui	t2,0xaa01
addi	t2,t2,-1376 # _start-0x755ff560
bne	a4,t2,fail

test_3705:
lui	gp,0x1
addi	gp,gp,-391 # _start-0x7ffff187
auipc	ra,0x2
addi	ra,ra,-888 # sw_tdat
lui	sp,0xa00aa
addi	sp,sp,10 # _end+0x2009ff3a
auipc	a5,0x0
addi	a5,a5,20 # test_3705+0x2c
sw	sp,12(ra)
lw	a4,12(ra)
j	test_3705+0x30
mv	a4,sp
lui	t2,0xa00aa
addi	t2,t2,10 # _end+0x2009ff3a
bne	a4,t2,fail

test_3706:
lui	gp,0x1
addi	gp,gp,-390 # _start-0x7ffff186
auipc	ra,0x2
addi	ra,ra,-920 # sw_tdat8
lui	sp,0xaa0
addi	sp,sp,170 # _start-0x7f55ff56
auipc	a5,0x0
addi	a5,a5,20 # test_3706+0x2c
sw	sp,-12(ra)
lw	a4,-12(ra)
j	test_3706+0x30
mv	a4,sp
lui	t2,0xaa0
addi	t2,t2,170 # _start-0x7f55ff56
bne	a4,t2,fail

test_3707:
lui	gp,0x1
addi	gp,gp,-389 # _start-0x7ffff185
auipc	ra,0x2
addi	ra,ra,-980 # sw_tdat8
lui	sp,0xaa00b
addi	sp,sp,-1536 # _end+0x2a000930
auipc	a5,0x0
addi	a5,a5,20 # test_3707+0x2c
sw	sp,-8(ra)
lw	a4,-8(ra)
j	test_3707+0x30
mv	a4,sp
lui	t2,0xaa00b
addi	t2,t2,-1536 # _end+0x2a000930
bne	a4,t2,fail

test_3708:
lui	gp,0x1
addi	gp,gp,-388 # _start-0x7ffff184
auipc	ra,0x2
addi	ra,ra,-1040 # sw_tdat8
lui	sp,0xaa01
addi	sp,sp,-1376 # _start-0x755ff560
auipc	a5,0x0
addi	a5,a5,20 # test_3708+0x2c
sw	sp,-4(ra)
lw	a4,-4(ra)
j	test_3708+0x30
mv	a4,sp
lui	t2,0xaa01
addi	t2,t2,-1376 # _start-0x755ff560
bne	a4,t2,fail

test_3709:
lui	gp,0x1
addi	gp,gp,-387 # _start-0x7ffff183
auipc	ra,0x2
addi	ra,ra,-1100 # sw_tdat8
lui	sp,0xa00aa
addi	sp,sp,10 # _end+0x2009ff3a
auipc	a5,0x0
addi	a5,a5,20 # test_3709+0x2c
sw	sp,0(ra)
lw	a4,0(ra)
j	test_3709+0x30
mv	a4,sp
lui	t2,0xa00aa
addi	t2,t2,10 # _end+0x2009ff3a
bne	a4,t2,fail

test_3710:
lui	gp,0x1
addi	gp,gp,-386 # _start-0x7ffff182
auipc	ra,0x2
addi	ra,ra,-1156 # sw_tdat9
lui	sp,0x12345
addi	sp,sp,1656 # _start-0x6dcba988
addi	tp,ra,-32
sw	sp,32(tp) # _start-0x7fffffe0
lw	t0,0(ra)
lui	t2,0x12345
addi	t2,t2,1656 # _start-0x6dcba988
bne	t0,t2,fail

test_3711:
lui	gp,0x1
addi	gp,gp,-385 # _start-0x7ffff181
auipc	ra,0x2
addi	ra,ra,-1204 # sw_tdat9
lui	sp,0x58213
addi	sp,sp,152 # _start-0x27decf68
addi	ra,ra,-3
sw	sp,7(ra)
auipc	tp,0x2
addi	tp,tp,-1224 # sw_tdat10
lw	t0,0(tp) # _start-0x80000000
lui	t2,0x58213
addi	t2,t2,152 # _start-0x27decf68
bne	t0,t2,fail

test_3712:
lui	gp,0x1
addi	gp,gp,-384 # _start-0x7ffff180
li	tp,0
lui	ra,0xaabbd
addi	ra,ra,-803 # _end+0x2abb2c0d
auipc	sp,0x2
addi	sp,sp,-1304 # sw_tdat
sw	ra,0(sp)
lw	a4,0(sp)
lui	t2,0xaabbd
addi	t2,t2,-803 # _end+0x2abb2c0d
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3712+0xc

test_3713:
lui	gp,0x1
addi	gp,gp,-383 # _start-0x7ffff17f
li	tp,0
lui	ra,0xdaabc
addi	ra,ra,-819 # _end+0x5aab1bfd
auipc	sp,0x2
addi	sp,sp,-1364 # sw_tdat
nop
sw	ra,4(sp)
lw	a4,4(sp)
lui	t2,0xdaabc
addi	t2,t2,-819 # _end+0x5aab1bfd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3713+0xc

test_3714:
lui	gp,0x1
addi	gp,gp,-382 # _start-0x7ffff17e
li	tp,0
lui	ra,0xddaac
addi	ra,ra,-1076 # _end+0x5daa1afc
auipc	sp,0x2
addi	sp,sp,-1428 # sw_tdat
nop
nop
sw	ra,8(sp)
lw	a4,8(sp)
lui	t2,0xddaac
addi	t2,t2,-1076 # _end+0x5daa1afc
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3714+0xc

test_3715:
lui	gp,0x1
addi	gp,gp,-381 # _start-0x7ffff17d
li	tp,0
lui	ra,0xcddab
addi	ra,ra,-1092 # _end+0x4dda0aec
nop
auipc	sp,0x2
addi	sp,sp,-1500 # sw_tdat
sw	ra,12(sp)
lw	a4,12(sp)
lui	t2,0xcddab
addi	t2,t2,-1092 # _end+0x4dda0aec
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3715+0xc

test_3716:
lui	gp,0x1
addi	gp,gp,-380 # _start-0x7ffff17c
li	tp,0
lui	ra,0xccddb
addi	ra,ra,-1349 # _end+0x4cdd09eb
nop
auipc	sp,0x2
addi	sp,sp,-1564 # sw_tdat
nop
sw	ra,16(sp)
lw	a4,16(sp)
lui	t2,0xccddb
addi	t2,t2,-1349 # _end+0x4cdd09eb
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3716+0xc

test_3717:
lui	gp,0x1
addi	gp,gp,-379 # _start-0x7ffff17b
li	tp,0
lui	ra,0xbccde
addi	ra,ra,-1365 # _end+0x3ccd39db
nop
nop
auipc	sp,0x2
addi	sp,sp,-1636 # sw_tdat
sw	ra,20(sp)
lw	a4,20(sp)
lui	t2,0xbccde
addi	t2,t2,-1365 # _end+0x3ccd39db
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3717+0xc

test_3718:
lui	gp,0x1
addi	gp,gp,-378 # _start-0x7ffff17a
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1688 # sw_tdat
lui	ra,0x112
addi	ra,ra,563 # _start-0x7feeddcd
sw	ra,0(sp)
lw	a4,0(sp)
lui	t2,0x112
addi	t2,t2,563 # _start-0x7feeddcd
bne	a4,t2,fail
addi	tp,tp,1 # _start-0x7fffffff
li	t0,2
bne	tp,t0,test_3718+0xc

test_3719:
lui	gp,0x1
addi	gp,gp,-377 # _start-0x7ffff179
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1748 # sw_tdat
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
bne	tp,t0,test_3719+0xc

test_3720:
lui	gp,0x1
addi	gp,gp,-376 # _start-0x7ffff178
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1812 # sw_tdat
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
bne	tp,t0,test_3720+0xc

test_3721:
lui	gp,0x1
addi	gp,gp,-375 # _start-0x7ffff177
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1880 # sw_tdat
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
bne	tp,t0,test_3721+0xc

test_3722:
lui	gp,0x1
addi	gp,gp,-374 # _start-0x7ffff176
li	tp,0
auipc	sp,0x2
addi	sp,sp,-1944 # sw_tdat
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
bne	tp,t0,test_3722+0xc

test_3723:
lui	gp,0x1
addi	gp,gp,-373 # _start-0x7ffff175
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
bne	tp,t0,test_3723+0xc
bne	zero,gp,pass

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
.byte 0xef

sb_tdat2:
.byte 0xef

sb_tdat3:
.byte 0xef

sb_tdat4:
.byte 0xef

sb_tdat5:
.byte 0xef

sb_tdat6:
.byte 0xef

sb_tdat7:
.byte 0xef

sb_tdat8:
.byte 0xef

sb_tdat9:
.byte 0xef

sb_tdat10:
.byte 0xef

.zero 6

fence_i_insn:
addi	a3,a3,333
addi	a3,a3,222
jalr	a5,a6
addi	a3,a3,555
jalr	a5,a6

.zero 12

lh_tdat:
.half 0x00ff

lh_tdat2:
.half 0xff00

lh_tdat3:
.half 0x0ff0

lh_tdat4:
.half 0xf00f

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
.half 0xbeef

sh_tdat2:
.half 0xbeef

sh_tdat3:
.half 0xbeef

sh_tdat4:
.half 0xbeef

sh_tdat5:
.half 0xbeef

sh_tdat6:
.half 0xbeef

sh_tdat7:
.half 0xbeef

sh_tdat8:
.half 0xbeef

sh_tdat9:
.half 0xbeef

sh_tdat10:
.half 0xbeef

.zero 12

lbu_tdat:
.byte 0xff

lbu_tdat2:
.byte 0x00

lbu_tdat3:
.byte 0xf0

lbu_tdat4:
.byte 0x0f

.zero 12

lhu_tdat:
.half 0x00ff

lhu_tdat2:
.half 0xff00

lhu_tdat3:
.half 0x0ff0

lhu_tdat4:
.half 0xf00f

.zero 8

sw_tdat:
.word 0xdeadbeef

sw_tdat2:
.word 0xdeadbeef

sw_tdat3:
.word 0xdeadbeef

sw_tdat4:
.word 0xdeadbeef

sw_tdat5:
.word 0xdeadbeef

sw_tdat6:
.word 0xdeadbeef

sw_tdat7:
.word 0xdeadbeef

sw_tdat8:
.word 0xdeadbeef

sw_tdat9:
.word 0xdeadbeef

sw_tdat10:
.word 0xdeadbeef

.zero 8
