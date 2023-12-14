package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._
import spinal.lib.misc.test._

import scala.util.Random
import spinal.sim.SimThread

object UCore extends App {
    val compiled = Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("ucore/rbl.img"),
        ext_sram_init = Some("ucore/ucore_small.img"),
    )))
    
    DualSimTracer(compiled, window = 1000000, seed = 42) { dut =>
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

        var message = new StringBuilder
        
        UartModel.decoder(dut.io.uart0.txd, baud_period) { char =>
            message += char
            if (message.compare("Load page fault") == 0) {
                simFailure("Load page fault")
            }
            if (char == '\n') {
                println(message)
                message.clear()
            }
        }

        Tracer.init(dut.Wb, period)

        sleep(1 sec)
    }
}