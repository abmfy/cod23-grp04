package cod

import spinal.core._
import spinal.lib._
import spinal.lib.io._

case class ThinPadIoConfig (
    enableCpldUart: Boolean = false,
    enableBaseRam: Boolean = true,
    enableExtRam: Boolean = true,
    enableUart: Boolean = true,
    enableFlash: Boolean = false,
    enableSl811: Boolean = false,
    enableDm9k: Boolean = false,
    enableVga: Boolean = false,
)

case class ThinPadPorts(config: ThinPadIoConfig) extends Bundle {
    val clock = ClockPorts()
    val buttons = ButtonPorts()
    val gpio = GpioPorts()
    val uart = config.enableCpldUart generate master(CpldUartPorts())
    val base_ram = config.enableBaseRam generate master(SramPorts())
    val ext_ram = config.enableExtRam generate master(SramPorts())
    val uart0 = config.enableUart generate master(UartPorts())
    val flash = config.enableFlash generate master(FlashPorts())
    val sl811 = config.enableSl811 generate master(Sl811UsbPorts())
    val dm9k = config.enableDm9k generate master(Dm9kEthPorts())
    val video = config.enableVga generate master(VgaPorts())
}

case class ClockPorts() extends Bundle {
    val clk_50M = in Bool()
    val clk_11M0592 = in Bool()
    setName("")
}

case class ButtonPorts() extends Bundle {
    val push_btn = in Bool()
    val reset_btn = in Bool()
    setName("")
}

case class GpioPorts() extends Bundle {
    val touch_btn = in Bits(4 bits)
    val dip_sw = in Bits(32 bits)
    val leds = out Bits(16 bits)
    val dpy0, dpy1 = out Bits(8 bits)
    setName("")
}

case class CpldUartPorts() extends Bundle with IMasterSlave {
    val rdn, wrn, dataready, tbre, tsre = Bool()

    override def asMaster(): Unit = {
        in (dataready, tbre, tsre)
        out (rdn, wrn, dataready)
    }
}

case class SramPorts() extends Bundle with IMasterSlave {
    val data = TriState(Bits(32 bits))
    val addr = UInt(20 bits)
    val be_n = Bits(4 bits)
    val ce_n, oe_n, we_n = Bool()

    override def asMaster(): Unit = {
        out (addr, be_n, ce_n, oe_n, we_n)
        master (data)
    }
}

case class UartPorts() extends Bundle with IMasterSlave {
    val txd = Bool() setName("txd")
    val rxd = Bool() setName("rxd")

    override def asMaster(): Unit = {
        in (rxd)
        out (txd)
    }
}

case class FlashPorts() extends Bundle with IMasterSlave {
    val a = UInt(23 bits)
    val d = TriState(Bits(16 bits))
    val rp_n, vpen, ce_n, oe_n, we_n, byte_n = Bool()

    override def asMaster(): Unit = {
        out (a, rp_n, vpen, ce_n, oe_n, we_n, byte_n)
        master (d)
    }
}

case class Sl811UsbPorts() extends Bundle with IMasterSlave {
    val a0, wr_n, rd_n, cs_n, rst_n, dack_n, intrq, drq_n = Bool()

    override def asMaster(): Unit = {
        in (intrq, drq_n)
        out (a0, wr_n, rd_n, cs_n, rst_n, dack_n)
    }
}

case class Dm9kEthPorts() extends Bundle with IMasterSlave {
    val cmd = out Bool()
    val sd = TriState(Bits(16 bits))
    val iow_n, ior_n, cs_n, pwrst_n, int = Bool()

    override def asMaster(): Unit = {
        in (int)
        out (cmd, iow_n, ior_n, cs_n, pwrst_n)
        master (sd)
    }
}

case class VgaPorts() extends Bundle with IMasterSlave {
    val red, green = Bits(3 bits)
    val blue = Bits(2 bits)
    val hsync, vsync, clk, de = Bool()

    override def asMaster(): Unit = {
        out (red, green, blue, hsync, vsync, clk, de)
    }
}