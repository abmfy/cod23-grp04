package cod

import spinal.core._
import spinal.lib._

case class RegFileReadPorts(width: Int = 32) extends Bundle with IMasterSlave {
    val addr_a = Types.reg
    val data_a = Types.data(width)
    val addr_b = Types.reg
    val data_b = Types.data(width)

    override def asMaster(): Unit = {
        in (data_a, data_b)
        out (addr_a, addr_b)
    }
}

case class RegFileWritePorts(width: Int = 32) extends Bundle with IMasterSlave {
    val addr = Types.reg
    val data = Types.data(width)
    val we = Bool()

    override def asMaster(): Unit = {
        out (addr, data, we)
    }
}

case class RegFilePorts(width: Int = 32) extends Bundle with IMasterSlave {
    val r = RegFileReadPorts(width)
    val w = RegFileWritePorts(width)

    override def asMaster(): Unit = {
        master (r, w)
    }
}

class RegFile(
    width: Int = 32,
    count: Int = 32,
) extends Component {
    val io = slave port RegFilePorts(width)

    val mem = Vec(Reg(Types.data(width)) init(0), count)

    io.r.data_a := mem(io.r.addr_a)
    io.r.data_b := mem(io.r.addr_b)

    when (io.w.we && io.w.addr =/= 0) {
        mem(io.w.addr) := io.w.data
    }
}