package cod.lab5
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimManagerContext

object TestLab5 extends App {
    Config.sim.compile(InOutWrapper(new Lab5Top(simulation = true))).doSim { dut =>
        val sram = dut.base_ram.asInstanceOf[SramModel]

        // Initialization

        UartModel.init(dut.io.uart0.rxd)

        val ADDR = 0x80000000L
        dut.io.gpio.dip_sw #= ADDR

        dut.clockDomain.forkStimulus(100 ns)
        dut.clockDomain.waitSampling()

        sleep(100 us)

        val baud_period = (1 sec) / dut.uart.config.baud
        
        UartModel.decoder(dut.io.uart0.txd, baud_period) { _ => () }

        // Testbench

        val input = List.fill(10)(Random.nextInt())

        for ((data, i) <- input.zipWithIndex) {
            println(f"data $i%2d: $data%x")
            UartModel.encode(dut.io.uart0.rxd, baud_period, data)
            sleep(100 us)
        }

        for ((data, i) <- input.zipWithIndex) {
            val data_expected = data & 0xff
            
            // Note: SRAM addr counts in word (4 bytes)
            val addr = ADDR / 4 + i
            val data_read = sram.mem.getBigInt(addr % sram.SRAM_SIZE)
            printf("%x: %x\n", addr,
                data_read
            )
            assert(data_read == data_expected, f"Expected $data_expected%x, but get $data_read%x")
        }

        sleep(100 us)
    }
}