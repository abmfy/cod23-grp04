package cod

import spinal.core._
import spinal.lib._

case class RegFilePorts(width: Int = 16) extends Bundle with IMasterSlave {
    val raddr_a = Types.reg
    val rdata_a = Types.data(width)
    val raddr_b = Types.reg
    val rdata_b = Types.data(width)

    val waddr = Types.reg
    val wdata = Types.data(width)
    val we = Bool()

    override def asMaster(): Unit = {
        in (rdata_a, rdata_b)
        out (raddr_a, raddr_b, waddr, wdata, we)
    }
}

class RegFile(
    width: Int = 16,
    count: Int = 32,
) extends Component {
    val io = slave port RegFilePorts(width)

    val mem = Vec(Reg(Types.data(width)) init(0), count)

    io.rdata_a := mem(io.raddr_a)
    io.rdata_b := mem(io.raddr_b)

    when (io.we && io.waddr =/= 0) {
        mem(io.waddr) := io.wdata
    }
}