package cod.lab4
import cod._

import spinal.core._
import spinal.lib._
import spinal.lib.io._

class Lab4Top extends ThinPadTop(ThinPadIoConfig(
    enableUart = false,
)) {
    io.gpio.dpy0 := 0
    io.gpio.dpy1 := 0

    // Test control signals
    val test_start = io.buttons.push_btn
    val random_seed = io.gpio.dip_sw.asUInt

    // Output test results to LED
    val test_done, test_error = Bool()
    io.gpio.leds := 0
    io.gpio.leds(0) := test_done
    io.gpio.leds(1) := test_error

    // Detailed results info
    val test_error_round = UInt(32 bits)
    val test_error_addr = UInt(32 bits)
    val test_error_read_data = Bits(32 bits)
    val test_error_expected_data = Bits(32 bits)

    // Lab4 Mux begin
    val mux = new WbMux(WbMuxConfig(
        slave_count = 2,
        slave_addr = List(
            0x80000000L,
            0x80400000L,
        ),
        slave_addr_mask = List(
            0xffc00000L,
            0xffc00000L,
        ),
    ))

    val tester = new SramTester
    // Control input
    tester.io.start := test_start
    tester.io.random_seed := random_seed
    // Status output
    test_done := tester.io.done
    test_error := tester.io.error
    // Detailed status for simulation
    test_error_round := tester.io.error_round
    test_error_addr := tester.io.error_addr
    test_error_read_data := tester.io.error_read_data
    test_error_expected_data := tester.io.error_expected_data

    // Master interface (to SRAM Tester)
    mux.io.wb <> tester.io.wb

    // Lab4 Slaves begin

    // Slave interface 0 (to BaseRAM controller)
    // Address range: 0x8000_0000 ~ 0x803f_ffff
    val base = new SramController
    base.io.sram <> io.base_ram
    base.io.wb <> mux.io.slaves(0)

    // Slave interface 1 (to ExtRAM SRAM)
    // Address range: 0x8040_0000 ~ 0x807f_ffff
    val ext = new SramController
    ext.io.sram <> io.ext_ram
    ext.io.wb <> mux.io.slaves(1)
}

object GenerateLab4 extends App {
    Config.spinal.generate(InOutWrapper(new Lab4Top)).printPruned()
}