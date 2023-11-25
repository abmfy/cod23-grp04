package cod.lab5
import cod._
import cod.sim._

import spinal.core._
import spinal.lib.io._

class Lab5Top (
    simulation: Boolean = false,
) extends ThinPadTop {
    io.gpio.dpy0 := 0
    io.gpio.dpy1 := 0
    io.gpio.leds := 0

    // Lab5 Mux begin
    val mux = new WbMux(WbMuxConfig(
        slave_count = 3,
        slave_addr = List(
            0x80000000L,
            0x80400000L,
            0x10000000L,
        ),
        slave_addr_mask = List(
            0xffc00000L,
            0xffc00000L,
            0xffff0000L,
        ),
    ))

    // Lab5 Master begin
    val master = new Master
    master.io.addr := io.gpio.dip_sw.asUInt
    master.io.wb <> mux.io.wb

    // Lab5 Slaves begin
    val (base_ram, ext_ram) = if (simulation) {
        val base = new SramModel
        base.io.sram <> io.base_ram
        base.io.wb <> mux.io.slaves(0)

        val ext = new SramModel
        ext.io.sram <> io.ext_ram
        ext.io.wb <> mux.io.slaves(1)

        (base, ext)
    } else {
        val base = new SramController
        base.io.sram <> io.base_ram
        base.io.wb <> mux.io.slaves(0)

        val ext = new SramController
        ext.io.sram <> io.ext_ram
        ext.io.wb <> mux.io.slaves(1)

        (base, ext)
    }
    val uart = new cod.UartController
    uart.io.uart <> io.uart0
    uart.io.wb <> mux.io.slaves(2)
}

object GenerateLab5 extends App {
    Config.spinal.generate(InOutWrapper(new Lab5Top)).printPruned()
}