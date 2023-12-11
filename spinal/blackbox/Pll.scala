package cod

import spinal.core._

class Pll extends BlackBox {
    val io = new Bundle {
        val clk_in1, reset = in Bool()
        val clk_out1, clk_out2, locked = out Bool()
    }
    noIoPrefix()
    setBlackBoxName("pll_example")
    spinalSimWhiteBox()

    io.clk_out2.allowPruning()

    io.clk_out1 := io.clk_in1
    io.clk_out2 := io.clk_in1
    io.locked := !io.reset
}