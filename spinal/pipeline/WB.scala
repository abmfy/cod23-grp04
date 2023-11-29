package cod

import spinal.core._
import spinal.lib._

class WB extends Component {
    val io = new Bundle {
        val i = slave port MEM_WB()

        // Forwarding
        val forward = master port ForwardPorts()

        val reg = master port RegFileWritePorts()
    }

    // Forwarding
    io.forward.we := io.i.reg_we
    io.forward.addr := io.i.reg_addr_d
    io.forward.data := io.i.reg_data_d

    io.reg.we := io.i.reg_we
    io.reg.addr := io.i.reg_addr_d
    io.reg.data := io.i.reg_data_d
}