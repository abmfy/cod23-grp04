package cod.lab3
import cod._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

class Lab3Top extends ThinPadTop(ThinPadIoConfig(
    enableBaseRam = false,
    enableExtRam = false,
    enableUart = false,
)) {
    val trigger = new Trigger
    trigger.io.push_btn := io.buttons.push_btn
    
    val reg_file = new RegFile
    val alu = new Alu

    val controller = new Controller
    controller.io.reg_file <> reg_file.io
    controller.io.alu <> alu.io
    controller.io.step := trigger.io.trigger
    controller.io.dip_sw := io.gpio.dip_sw
    io.gpio.leds := controller.io.leds

    io.gpio.dpy0 := 0
    io.gpio.dpy1 := 0 
}

object GenerateLab3 extends App {
    Config.spinal.generate(InOutWrapper(new Lab3Top)).printPruned()
}

object TestLab3 extends App {
    Config.sim.compile(InOutWrapper(new Lab3Top)).doSim { dut =>
        // dut.io.buttons.push_btn #= false

        // dut.clockDomain.forkStimulus(10 ns)
        // dut.clockDomain.waitSampling()

        // var count = 0

        // for (_ <- 0 until 20) {
        //     sleep(100 ns)
        //     dut.io.buttons.push_btn #= true
        //     sleep(100 ns)
        //     dut.io.buttons.push_btn #= false

        //     if (count < 15) {
        //         count += 1
        //     }
        //     val real = dut.counter.counter.toInt
        //     assert(real == count, s"Got $real, expected $count")
        // }
        // sleep(200 ns)
    }
}