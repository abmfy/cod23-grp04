package cod.lab2
import cod._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

class Lab2Top extends ThinPadTop(ThinPadIoConfig(
    enableBaseRam = false,
    enableExtRam = false,
    enableUart = false,
)) {
    val counter = new Counter
    val trigger = new Trigger
    val seg_7 = new Seg7

    trigger.io.push_btn := io.buttons.push_btn
    counter.io.trigger := trigger.io.trigger
    seg_7.io.iDIG := counter.io.count
    io.gpio.dpy0 := seg_7.io.oSEG1

    io.gpio.dpy1 := 0
    io.gpio.leds := 0
}

object GenerateLab2 extends App {
    Config.spinal.generate(InOutWrapper(new Lab2Top))
}

object TestLab2 extends App {
    Config.sim.compile(InOutWrapper(new Lab2Top)).doSim { dut =>
        dut.io.buttons.push_btn #= false

        dut.clockDomain.forkStimulus(10 ns)
        dut.clockDomain.waitSampling()

        var count = 0

        for (_ <- 0 until 20) {
            sleep(100 ns)
            dut.io.buttons.push_btn #= true
            sleep(100 ns)
            dut.io.buttons.push_btn #= false

            if (count < 15) {
                count += 1
            }
            val real = dut.counter.counter.toInt
            assert(real == count, s"Got $real, expected $count")
        }
        sleep(200 ns)
    }
}