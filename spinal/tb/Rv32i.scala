package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimManagerContext

object Rv32i extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("asm/rv32i.bin"),
    ))).doSim { dut =>
        SimTimeout(10 ms)

        val period = (1 sec) / dut.simulation_freq
        val baud_period = (1 sec) / BigDecimal(dut.uart.config.baud)

        // Initialization
        UartModel.init(dut.io.uart0.rxd)

        dut.clockDomain.forkStimulus(period)
        dut.clockDomain.waitSampling()

        // To clear txd buffer
        dut.clockDomain.assertReset()
        sleep(period * 100)
        dut.clockDomain.deassertReset()

        var passed = false
        
        UartModel.decoder(dut.io.uart0.txd, baud_period) { char =>
            if (char == 'P') {
                println(s"Rv32i Passed")
                passed = true
            } else {
                simFailure(s"Failed, received '$char'")
            }
        }

        Tracer.init(dut.Wb, period)

        var counter = 0

        fork {
            while (true) {
                dut.clockDomain.waitSampling()
                counter += 1
            }
        }

        // Testbench
        waitUntil(passed)

        println(f"Clocks elapsed: $counter")
    }
}