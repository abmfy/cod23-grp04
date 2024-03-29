package cod.tb
import cod._
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random

object Exception extends App {
    Config.sim.compile(InOutWrapper(new Top(
        simulation = true,
        base_sram_init = Some("asm/exception.bin"),
    ))).doSim { dut =>
        SimTimeout(1 ms)

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
        
        val string_received = new StringBuilder
        
        UartModel.decoder(dut.io.uart0.txd, baud_period) { char =>
            string_received += char
        }

        Tracer.init(dut.Wb, period)

        var counter = 0

        fork {
            while (true) {
                dut.clockDomain.waitSampling()
                counter += 1
            }
        }

        val string_expected = "idhP"
        waitUntil (
            string_expected == string_received.result ||
            !string_expected.startsWith(string_received)
        )
        assert (
            string_expected == string_received.result,
            f"Expected $string_expected, but get $string_received",
        )

        println(f"Clocks elapsed: $counter")
    }
}