package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random

object Zicsr extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("asm/zicsr.bin"),
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

        var passed = false
        
        UartModel.decoder(dut.io.uart0.txd, baud_period) { char =>
            if (char == 'P') {
                println(s"Zicsr Passed")
                passed = true
            } else if (!passed) {
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

        // Wait for rdtime
        sleep(baud_period * 1000)
    }
}