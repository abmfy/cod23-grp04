package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimThread

object UCore extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("ucore/rbl.img"),
        ext_sram_init = Some("ucore/ucore.img"),
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

        sleep(100 ms)
    }
}