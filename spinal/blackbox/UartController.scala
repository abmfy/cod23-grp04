package cod

import spinal.core._
import spinal.lib._

case class UartControllerConfig (
    addr_width: Int = 32,
    data_width: Int = 32,

    clk_freq: Int = 10000000,
    baud: Int = 115200,
)

class UartController(
    val config: UartControllerConfig = UartControllerConfig(),
) extends BlackBox {
    val generic = new Generic {
        val ADDR_WIDTH = config.addr_width
        val DATA_WIDTH = config.data_width
        val CLK_FREQ = config.clk_freq
        val BAUD = config.baud
    }

    val io = new Bundle {
        // clk and reset
        val clk_i = in Bool()
        val rst_i = in Bool()

        // Wishbone slave interface
        val wb = slave port WishbonePorts(
            config.addr_width,
            config.data_width,
        )
        wb.cyc.setPartialName("cyc_i")
        wb.stb.setPartialName("stb_i")
        wb.ack.setPartialName("ack_o")
        wb.adr.setPartialName("adr_i")
        wb.dat_w.setPartialName("dat_i")
        wb.dat_r.setPartialName("dat_o")
        wb.sel.setPartialName("sel_i")
        wb.we.setPartialName("we_i")

        // Uart interface
        val uart = master port UartPorts()
        uart.txd.setPartialName("txd_o")
        uart.rxd.setPartialName("rxd_i")
    }
    
    noIoPrefix()
    mapClockDomain(clock = io.clk_i, reset = io.rst_i)
    setBlackBoxName("uart_controller")
    addRTLPath("thinpad_top.srcs/sources_1/new/lab5/uart_controller.sv")
    addRTLPath("thinpad_top.srcs/sources_1/new/async.v")
}