package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimThread

object Supervisor extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("supervisor/kernel_int.bin"),
    ))).doSim { dut =>
        val period = (1 sec) / dut.simulation_freq
        val baud_period = (1 sec) / dut.uart.config.baud
        
        // Initialization
        UartModel.init(dut.io.uart0.rxd)

        dut.clockDomain.forkStimulus(period)
        dut.clockDomain.waitSampling()

        // To clear txd buffer
        dut.clockDomain.assertReset()
        sleep(baud_period * 10)
        dut.clockDomain.deassertReset()
        
        UartModel.decoder(dut.io.uart0.txd, baud_period)()

        Tracer.init(dut.Wb, period)

        sleep(baud_period * 10000)

        println("Test jump")

        UartModel.encode(dut.io.uart0.rxd, baud_period, 'G'.toInt)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x00)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x10)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x00)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x80)
        sleep(baud_period * 1000)

        println("Test ecall")

        UartModel.encode(dut.io.uart0.rxd, baud_period, 'G'.toInt)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0xa8)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x10)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x00)
        sleep(baud_period * 10)
        UartModel.encode(dut.io.uart0.rxd, baud_period, 0x80)
        sleep(baud_period * 1000)
    }
}