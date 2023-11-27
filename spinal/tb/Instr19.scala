package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimManagerContext

object Instr19 extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("asm/test19.bin"),
    ))).doSim { dut =>
        SimTimeout(10 ms)

        // Initialization
        UartModel.init(dut.io.uart0.rxd)

        dut.clockDomain.forkStimulus(100 ns)
        dut.clockDomain.waitSampling()

        sleep(100 us)

        val baud_period = (1 sec) / dut.uart.config.baud

        var passed = false
        
        UartModel.decoder(dut.io.uart0.txd, baud_period) { char =>
            if (char == 'F') {
                simFailure(s"Failed")
            } else {
                println(s"Passed")
                passed = true
            }
        }

        // Testbench
        waitUntil(passed)
    }
}