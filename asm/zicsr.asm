
zicsr.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
   0:	04000663          	beqz	zero,0x4c
   4:	00000063          	beqz	zero,0x4
   8:	100002b7          	lui	t0,0x10000
   c:	00528303          	lb	t1,5(t0) # 0x10000005
  10:	02037313          	andi	t1,t1,32
  14:	fe030ae3          	beqz	t1,0x8
  18:	04600513          	li	a0,70
  1c:	00a28023          	sb	a0,0(t0)
  20:	fe0002e3          	beqz	zero,0x4
  24:	100002b7          	lui	t0,0x10000
  28:	00528303          	lb	t1,5(t0) # 0x10000005
  2c:	02037313          	andi	t1,t1,32
  30:	fe030ae3          	beqz	t1,0x24
  34:	05000513          	li	a0,80
  38:	00a28023          	sb	a0,0(t0)
  3c:	fc0004e3          	beqz	zero,0x4
  40:	00000013          	nop
  44:	00000013          	nop
  48:	00000013          	nop
  4c:	001142b7          	lui	t0,0x114
  50:	51428293          	addi	t0,t0,1300 # 0x114514
  54:	34029073          	csrw	mscratch,t0
  58:	34002373          	csrr	t1,mscratch
  5c:	fa6296e3          	bne	t0,t1,0x8
  60:	01400193          	li	gp,20
  64:	14001073          	csrw	sscratch,zero
  68:	14002573          	csrr	a0,sscratch
  6c:	00000393          	li	t2,0
  70:	f8751ce3          	bne	a0,t2,0x8
  74:	01500193          	li	gp,21
  78:	14005573          	csrrwi	a0,sscratch,0
  7c:	1407d573          	csrrwi	a0,sscratch,15
  80:	00000393          	li	t2,0
  84:	f87512e3          	bne	a0,t2,0x8
  88:	01600193          	li	gp,22
  8c:	14086073          	csrsi	sscratch,16
  90:	14002573          	csrr	a0,sscratch
  94:	01f00393          	li	t2,31
  98:	f67518e3          	bne	a0,t2,0x8
  9c:	1401d073          	csrwi	sscratch,3
  a0:	00200193          	li	gp,2
  a4:	14002573          	csrr	a0,sscratch
  a8:	00300393          	li	t2,3
  ac:	f4751ee3          	bne	a0,t2,0x8
  b0:	00300193          	li	gp,3
  b4:	1400f5f3          	csrrci	a1,sscratch,1
  b8:	00300393          	li	t2,3
  bc:	f47596e3          	bne	a1,t2,0x8
  c0:	00400193          	li	gp,4
  c4:	14026673          	csrrsi	a2,sscratch,4
  c8:	00200393          	li	t2,2
  cc:	f2761ee3          	bne	a2,t2,0x8
  d0:	00500193          	li	gp,5
  d4:	140156f3          	csrrwi	a3,sscratch,2
  d8:	00600393          	li	t2,6
  dc:	f27696e3          	bne	a3,t2,0x8
  e0:	00600193          	li	gp,6
  e4:	0bad2537          	lui	a0,0xbad2
  e8:	dea50513          	addi	a0,a0,-534 # 0xbad1dea
  ec:	140515f3          	csrrw	a1,sscratch,a0
  f0:	00200393          	li	t2,2
  f4:	f0759ae3          	bne	a1,t2,0x8
  f8:	00700193          	li	gp,7
  fc:	00002537          	lui	a0,0x2
 100:	dea50513          	addi	a0,a0,-534 # 0x1dea
 104:	140535f3          	csrrc	a1,sscratch,a0
 108:	0bad23b7          	lui	t2,0xbad2
 10c:	dea38393          	addi	t2,t2,-534 # 0xbad1dea
 110:	ee759ce3          	bne	a1,t2,0x8
 114:	00800193          	li	gp,8
 118:	0000c537          	lui	a0,0xc
 11c:	eef50513          	addi	a0,a0,-273 # 0xbeef
 120:	140525f3          	csrrs	a1,sscratch,a0
 124:	0bad03b7          	lui	t2,0xbad0
 128:	ee7590e3          	bne	a1,t2,0x8
 12c:	00900193          	li	gp,9
 130:	0bad2537          	lui	a0,0xbad2
 134:	dea50513          	addi	a0,a0,-534 # 0xbad1dea
 138:	14051573          	csrrw	a0,sscratch,a0
 13c:	0badc3b7          	lui	t2,0xbadc
 140:	eef38393          	addi	t2,t2,-273 # 0xbadbeef
 144:	ec7512e3          	bne	a0,t2,0x8
 148:	00a00193          	li	gp,10
 14c:	00002537          	lui	a0,0x2
 150:	dea50513          	addi	a0,a0,-534 # 0x1dea
 154:	14053573          	csrrc	a0,sscratch,a0
 158:	0bad23b7          	lui	t2,0xbad2
 15c:	dea38393          	addi	t2,t2,-534 # 0xbad1dea
 160:	ea7514e3          	bne	a0,t2,0x8
 164:	00b00193          	li	gp,11
 168:	0000c537          	lui	a0,0xc
 16c:	eef50513          	addi	a0,a0,-273 # 0xbeef
 170:	14052573          	csrrs	a0,sscratch,a0
 174:	0bad03b7          	lui	t2,0xbad0
 178:	e87518e3          	bne	a0,t2,0x8
 17c:	00c00193          	li	gp,12
 180:	14002573          	csrr	a0,sscratch
 184:	0badc3b7          	lui	t2,0xbadc
 188:	eef38393          	addi	t2,t2,-273 # 0xbadbeef
 18c:	e6751ee3          	bne	a0,t2,0x8
