package cod

import spinal.core._
import spinal.core.sim._
import spinal.lib._

class WB extends Component {
    val io = new Bundle {
        val i = slave port MEM_WB()

        // Forwarding
        val forward = master port ForwardPorts()

        // Trap commit
        val trap_commit = master port TrapPorts()

        // RegFile
        val reg = master port RegFileWritePorts()
    }

    io.i.simPublic()

    // Forwarding
    io.forward.we := io.i.reg_we
    io.forward.addr := io.i.reg_addr_d
    io.forward.data := io.i.reg_data_d

    io.reg.we := io.i.reg_we
    io.reg.addr := io.i.reg_addr_d
    io.reg.data := io.i.reg_data_d

    // Trapped
    when (io.i.trap.trap) {
        io.reg.we := False
        
        io.trap_commit.trap := True
        io.trap_commit.epc := io.i.trap.epc
        io.trap_commit.cause := io.i.trap.cause
    } otherwise {
        io.trap_commit.trap := False
        io.trap_commit.epc := 0
        io.trap_commit.cause := 0
    }
}