package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimThread

object SupervisorPaging extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("supervisor/kernel_paging.bin"),
    ))).doSim { dut =>

        // Initialization
        UartModel.init(dut.io.uart0.rxd)

        dut.clockDomain.forkStimulus(10 ns)
        dut.clockDomain.waitSampling()

        // To clear txd buffer
        dut.clockDomain.assertReset()
        sleep(1 us)
        dut.clockDomain.deassertReset()

        val baud_period = (1 sec) / dut.uart.config.baud
        
        UartModel.decoder(dut.io.uart0.txd, baud_period)()

        Tracer.init(dut.Wb, 10 ns)

        sleep(100 us)

        println("Test print table")

        UartModel.encode(dut.io.uart0.rxd, baud_period, 'T'.toInt)
        sleep(1 ms)

        println("Test ecall")

        UartModel.encode(dut.io.uart0.rxd, baud_period, 'G'.toInt)
        sleep(1 us)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0xa8)
        sleep(1 us)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x10)
        sleep(1 us)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x00)
        sleep(1 us)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x80)
        sleep(1 ms)
    }
}