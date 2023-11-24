package cod

import spinal.core._
import spinal.lib._

case class WishbonePorts(
    addr_width: Int = 32,
    data_width: Int = 32,
) extends Bundle with IMasterSlave {
    val sel_width = data_width / 8

    val cyc, stb, ack, we = Bool()
    val adr = UInt(addr_width bits)
    val dat_r, dat_w = Bits(data_width bits)
    val sel = Bits(sel_width bits)

    override def asMaster(): Unit = {
        in (ack, dat_r)
        out (cyc, stb, we, adr, dat_w, sel)
    }
}