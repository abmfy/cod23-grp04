package cod

import spinal.core._
import spinal.lib._

class Trap extends Component {
    val io = new Bundle {
        // Trap signals from ID, EXE, MEM
        val trap = Vec(in Bool(), 3)

        // Flush signals for IF, ID, EXE
        val flush_req = Vec(out Bool(), 3)

        // Trap commit signals
        val commit = slave port TrapPorts()

        // Trap branching
        val br = master port BranchPorts()

        // Csr
        val mstatus, mtvec = master port CsrPorts()
        val mepc, mcause = master port CsrPorts()

        // Privilege mode
        val prv = out port PrivilegeMode()
    }

    val cause = new Area {
        val interrupt = io.commit.cause(31)
        val exception_code = io.commit.cause(0, 31 bits)
    }

    val mstatus = new Area {
        io.mstatus.we := False
        io.mstatus.w := 0

        val mpp = PrivilegeMode()
        mpp.assignFromBits(io.mstatus.r(12 downto 11))
        def set_mpp(x: PrivilegeMode.C): Unit = {
            io.mstatus.we := True
            io.mstatus.w(12 downto 11) := x.asBits
        }
    }

    val mtvec = new Area {
        io.mtvec.we := False
        io.mtvec.w := 0

        val mode = io.mtvec.r(0, 2 bits)
        val base = io.mtvec.r(31 downto 2).asUInt @@ U"00"
    }

    val mepc = new Area {
        io.mepc.we := False
        io.mepc.w := 0

        val mepc = io.mepc.r.asUInt
        def set(x: UInt): Unit = {
            io.mepc.we := True
            io.mepc.w := x.asBits
        }
    }

    val mcause = new Area {
        io.mcause.we := False
        io.mcause.w := 0

        // Unread
        io.mcause.r allowPruning()
        def set(x: Bits): Unit = {
            io.mcause.we := True
            io.mcause.w := x
        }
    }

    io.prv.setAsReg() init(PrivilegeMode.M)

    io.br.br := False
    io.br.pc := 0

    io.flush_req.foreach { _ := False }

    // ID trapped
    when (io.trap(0)) {
        io.flush_req(0) := True
    }

    // EXE trapped
    when (io.trap(1)) {
        io.flush_req(0) := True
        io.flush_req(1) := True
    }

    // MEM trapped
    when (io.trap(2)) {
        io.flush_req(0) := True
        io.flush_req(1) := True
        io.flush_req(2) := True
    }

    // Trap commit
    when (io.commit.trap) {
        io.flush_req(0) := True
        io.flush_req(1) := True
        io.flush_req(2) := True
        
        io.br.br := True
    
        // MRET
        when (io.commit.cause === TrapCause.RETURN_FROM_M_MODE) {
            io.br.pc := mepc.mepc
            
            io.prv := mstatus.mpp
            mstatus.set_mpp(PrivilegeMode.U)
        } otherwise {
            switch (mtvec.mode) {
                is (TrapVectorMode.DIRECT) {
                    io.br.pc := mtvec.base
                }
                is (TrapVectorMode.VECTORED) {
                    when (cause.interrupt) {
                        io.br.pc := mtvec.base + (cause.exception_code.asUInt * 4).resized
                    } otherwise {
                        io.br.pc := mtvec.base
                    }
                }
            }

            io.prv := PrivilegeMode.M
            mstatus.set_mpp(io.prv)

            mepc.set(io.commit.epc)
            mcause.set(io.commit.cause)
        }
    }
}