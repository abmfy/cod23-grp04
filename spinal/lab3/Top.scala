package cod.lab3
import cod._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random

class Lab3Top extends ThinPadTop(ThinPadIoConfig(
    enableBaseRam = false,
    enableExtRam = false,
    enableUart = false,
)) {
    val trigger = new Trigger
    trigger.io.push_btn := io.buttons.push_btn
    
    val reg_file = new RegFile
    val alu = new Alu

    val controller = new Controller
    controller.io.reg_file <> reg_file.io
    controller.io.alu <> alu.io
    controller.io.step := trigger.io.trigger
    controller.io.dip_sw := io.gpio.dip_sw
    io.gpio.leds := controller.io.leds

    io.gpio.dpy0 := 0
    io.gpio.dpy1 := 0 
}

object GenerateLab3 extends App {
    Config.spinal.generate(InOutWrapper(new Lab3Top))
}

object TestLab3 extends App {
    def get_opcode(op: AluOp.E): Long = {
        op.position
    }

    def inst_rtype(rd: Long, rs1: Long, rs2: Long, op: Long): Long = {
        var inst = 0L
        inst = inst << 5 | rs2
        inst = inst << 5 | rs1
        inst = inst << 3 | 0
        inst = inst << 5 | rd
        inst = inst << 4 | op
        inst = inst << 3 | 1
        inst
    }

    def inst_itype(rd: Long, imm: Long, op: Long): Long = {
        var inst = imm
        inst = inst << 4 | 0
        inst = inst << 5 | rd
        inst = inst << 4 | op
        inst = inst << 3 | 2
        inst
    }

    def inst_poke(rd: Long, imm: Long): Long = {
        println(s"Poke $rd $imm")
        inst_itype(rd, imm, 1)
    }

    def inst_peek(rd: Long): Long = {
        println(s"Peek $rd")
        inst_itype(rd, 0, 2)
    }

    def exec(instr: Long)(implicit dut: Lab3Top): Unit = {
        dut.io.gpio.dip_sw #= instr
        dut.io.buttons.push_btn #= true
        sleep(100 ns)
        dut.io.buttons.push_btn #= false
        sleep(1000 ns)
    }

    def read(rd: Long)(implicit dut: Lab3Top): Long = {
        exec(inst_peek(rd))
        dut.io.gpio.leds.toLong
    }
    
    Config.sim.compile(InOutWrapper(new Lab3Top)).doSim { dut =>
        implicit val _ = dut

        dut.io.buttons.push_btn #= false

        dut.clockDomain.forkStimulus(10 ns)
        dut.clockDomain.waitSampling()

        // Randomly initialize reg file
        for (i <- 1 to 32) {
            exec(inst_poke(i, Random.nextInt(1 << 16)))
        }

        {
            // To short to take into account sign
            val a = read(2).toShort
            val b = read(3).toShort
            exec(inst_rtype(1, 2, 3, get_opcode(AluOp.ADD)))
            val y = read(1).toShort
            println(s"$a + $b = $y")
            val expected = (a + b).toShort
            assert(y == expected)
        }

        {
            val a = read(5)
            val b = read(6)
            exec(inst_rtype(4, 5, 6, get_opcode(AluOp.XOR)))
            val y = read(4)
            println(s"$a ^ $b = $y")
            val expected = a ^ b
            assert(y == expected)
        }

        {
            val a = read(8).toShort
            val b = read(9) % 16
            exec(inst_rtype(7, 8, 9, get_opcode(AluOp.SRA)))
            val y = read(7).toShort
            println(s"$a >> $b = $y")
            val expected = (a >> b).toShort
            assert(y == expected)
        }

        {
            val a = read(11)
            val b = read(12) % 16
            exec(inst_rtype(10, 11, 12, get_opcode(AluOp.ROL)))
            val y = read(10)
            println(s"$a rotateLeft $b = $y")
            val expected = ((a << b) % (1 << 16) | a >> (16 - b))
            assert(y == expected)
        }

        {
            exec(inst_peek(13))
            val y = read(13)
            println(s"Peek 13 = $y")
        }

        {
            // Test SRA
            exec(inst_poke(14, 0x8000))
            exec(inst_poke(15, 1))
            
            val a = read(14)
            val b = read(15)
            exec(inst_rtype(16, 14, 15, get_opcode(AluOp.SRA)))
            val y = read(16)
            println(s"$a >> $b = $y")
            val expected = 0xc000
            assert(y == expected)
        }
    }
}