package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimManagerContext

object Extra extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("asm/extra.bin"),
    ))).doSim { dut =>
        val sram = dut.base_ram.asInstanceOf[SramModel]

        val period = (1 sec) / dut.simulation_freq
        val baud_period = (1 sec) / dut.uart.config.baud

        // Initialization
        UartModel.init(dut.io.uart0.rxd)

        dut.clockDomain.forkStimulus(period)
        dut.clockDomain.waitSampling()

        val result = 0x55555555L
        // ANDN, CLZ, PACK
        val selection = 0x2a
        val rnd = Random.nextLong() % (1L << 32)

        println(f"Arguments: $result%x $selection%x $rnd%x")

        var param = BigInt(0)
        param = param << 32 | rnd
        param = param << 32 | selection
        param = param << 32 | result

        val ADDR = 0x80100000L / 4 % sram.SRAM_SIZE
        sram.mem.setBigInt(ADDR, result)
        sram.mem.setBigInt(ADDR + 1, selection)
        sram.mem.setBigInt(ADDR + 2, rnd)

        sleep(period * 100)

        print("Params: ")
        for (i <- 0 until 3) {
            printf("%x ", sram.mem.getBigInt(ADDR + i))
        }
        println()

        sleep(period * 10000)

        // Retrieve results
        val n = 4 + 3
        print("Results: ")
        for (i <- 0 until n) {
            printf("%x ", sram.mem.getBigInt(ADDR + i))
        }
        println()

        var passed = true

        val output = sram.mem.getBigInt(ADDR) ^ rnd
        if ((output & 0x2) != 0) {
            println("ANDN passed")
        } else {
            println("ANDN failed")
            passed = false

            val a = rnd
            val b = 0xffff
            val expected = a & ~b
            val got = sram.mem.getBigInt(ADDR + 4)
            println(f"Testing ANDN($a%x, $b%x), expected $expected%x, got $got%x")
        }
        if ((output & 0x8) != 0) {
            println("CLZ passed")
        } else {
            println("CLZ failed")
            passed = false

            val a = rnd
            val expected = if (a == 0) 32 else 32 - a.toBinaryString.length
            val got = sram.mem.getBigInt(ADDR + 5)
            println(f"Testing CLZ($a%x), expected $expected%x, got $got%x")
        }
        if ((output & 0x20) != 0) {
            println("PACK passed")
        } else {
            println("PACK failed")
            passed = false

            val a = rnd
            val b = 0xaaaa5555
            val expected = 0x55550000 | (a & 0xffff)
            val got = sram.mem.getBigInt(ADDR + 6)
            println(f"Testing PACK($a%x, $b%x), expected $expected%x, got $got%x")
        }

        if (!passed) {
            simFailure()
        }
    }
}