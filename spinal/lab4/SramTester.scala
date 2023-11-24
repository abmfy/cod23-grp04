package cod.lab4
import cod._

import spinal.core._
import spinal.lib._

case class SramTesterConfig (
    addr_width: Int = 32,
    data_width: Int = 32,

    addr_base: UInt = U"32'h8000_0000",
    addr_mask: UInt = U"32'h007f_ffff",
    test_rounds: Int = 1000,
)

class SramTester(
    config: SramTesterConfig = SramTesterConfig()
) extends BlackBox {
    val generic = new Generic {
        val ADDR_WIDTH = config.addr_width
        val DATA_WIDTH = config.data_width
        val ADDR_BASE = config.addr_base
        val ADDR_MASK = config.addr_mask
        val TEST_ROUNDS = config.test_rounds
    }

    val io = new Bundle {
        val clk_i = in Bool()
        val rst_i = in Bool()
        
        val start = in Bool()
        val random_seed = in UInt(32 bits)

        // Wishbone master
        val wb = master port WishbonePorts(
            config.addr_width,
            config.data_width,
        )
        wb.cyc.setPartialName("cyc_o")
        wb.stb.setPartialName("stb_o")
        wb.ack.setPartialName("ack_i")
        wb.adr.setPartialName("adr_o")
        wb.dat_w.setPartialName("dat_o")
        wb.dat_r.setPartialName("dat_i")
        wb.sel.setPartialName("sel_o")
        wb.we.setPartialName("we_o")

        // Status signals
        val done = out Bool()
        val error = out Bool()
        val error_round = out UInt(32 bits)
        val error_addr = out UInt(config.addr_width bits)
        val error_read_data = out Bits(config.data_width bits)
        val error_expected_data = out Bits(config.data_width bits)
    }
    noIoPrefix()
    mapClockDomain(clock = io.clk_i, reset = io.rst_i)
    setBlackBoxName("sram_tester")
    addRTLPath("thinpad_top.srcs/sources_1/new/lab4/sram_tester.sv")
    addRTLPath("thinpad_top.srcs/sources_1/new/common/lfsr_prng.sv")
    addRTLPath("thinpad_top.srcs/sources_1/new/common/lfsr.v")
}