package cod

import spinal.core._

case class LfsrPrngConfig (
    data_width: Int = 32,
    invert: Boolean = false,
)

class LfsrPrng(
    config: LfsrPrngConfig = LfsrPrngConfig(),
) extends BlackBox {
    val generic = new Generic {
        val DATA_WIDTH = config.data_width
        val INVERT = config.invert
    }

    val io = new Bundle {
        val clk = in Bool()
        val load = in Bool()
        val seed = in Bits(config.data_width bits)

        val enable = in Bool()
        val data_out = out Bits(config.data_width bits)
    }
    noIoPrefix()
    mapClockDomain(clock = io.clk)
    setBlackBoxName("lfsr_prng")
    addRTLPath("thinpad_top.srcs/sources_1/new/common/lfsr_prng.sv")
}