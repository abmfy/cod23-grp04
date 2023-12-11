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
        val stvec = master port CsrPorts()
        val sepc, scause, stval = master port CsrPorts()
        val medeleg, mideleg = master port CsrPorts()
        val mstatus, mtvec = master port CsrPorts()
        val mepc, mcause, mtval = master port CsrPorts()

        // Privilege mode
        val prv = out port PrivilegeMode()
    }

    val cause = new Area {
        val interrupt = io.commit.cause(31)
        val exception_code = io.commit.cause(0, 31 bits)
    }

    val stvec = new Area {
        io.stvec.we := False
        io.stvec.w := 0

        val mode = io.stvec.r(0, 2 bits)
        val base = io.stvec.r(31 downto 2).asUInt @@ U"00"
    }

    val sepc = new Area {
        io.sepc.we := False
        io.sepc.w := 0

        val sepc = io.sepc.r.asUInt
        def set(x: UInt): Unit = {
            io.sepc.we := True
            io.sepc.w := x.asBits
        }
    }

    val scause = new Area {
        io.scause.we := False
        io.scause.w := 0

        // Unread
        io.scause.r allowPruning()
        def set(x: Bits): Unit = {
            io.scause.we := True
            io.scause.w := x
        }
    }

    val stval = new Area {
        io.stval.we := False
        io.stval.w := 0

        // Unread
        io.stval.r allowPruning()
        def set(x: Bits): Unit = {
            io.stval.we := True
            io.stval.w := x
        }
    }

    val medeleg = new Area {
        io.medeleg.we := False
        io.medeleg.w := 0
    }

    val mideleg = new Area {
        io.mideleg.we := False
        io.mideleg.w := 0
    }

    val mstatus = new Area {
        io.mstatus.w := io.mstatus.r
        io.mstatus.we := False
        io.mstatus.we.allowOverride()

        val sie = io.mstatus.r(StatusField.SIE)
        def set_sie(x: Bool): Unit = {
            io.mstatus.we := True
            io.mstatus.w(StatusField.SIE) := x
        }

        val mie = io.mstatus.r(StatusField.MIE)
        def set_mie(x: Bool): Unit = {
            io.mstatus.we := True
            io.mstatus.w(StatusField.MIE) := x
        }

        val spie = io.mstatus.r(StatusField.SPIE)
        def set_spie(x: Bool): Unit = {
            io.mstatus.we := True
            io.mstatus.w(StatusField.SPIE) := x
        }

        val mpie = io.mstatus.r(StatusField.MPIE)
        def set_mpie(x: Bool): Unit = {
            io.mstatus.we := True
            io.mstatus.w(StatusField.MPIE) := x
        }

        val spp = PrivilegeMode()
        spp.assignFromBits(B"0" ## io.mstatus.r(StatusField.SPP))
        def set_spp(x: PrivilegeMode.C): Unit = {
            io.mstatus.we := True
            io.mstatus.w(StatusField.SPP) := x.asBits.lsb
        }

        val mpp = PrivilegeMode()
        mpp.assignFromBits(io.mstatus.r(StatusField.MPP, 2 bits))
        def set_mpp(x: PrivilegeMode.C): Unit = {
            io.mstatus.we := True
            io.mstatus.w(StatusField.MPP, 2 bits) := x.asBits
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

    val mtval = new Area {
        io.mtval.we := False
        io.mtval.w := 0

        // Unread
        io.mtval.r allowPruning()
        def set(x: Bits): Unit = {
            io.mtval.we := True
            io.mtval.w := x
        }
    }

    def trap_m(): Unit = {
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
        mstatus.set_mpie(mstatus.mie)
        mstatus.set_mie(False)

        mepc.set(io.commit.epc)
        mcause.set(io.commit.cause)
        mtval.set(io.commit.tval)
    }

    def trap_s(): Unit = {
        switch (stvec.mode) {
            is (TrapVectorMode.DIRECT) {
                io.br.pc := stvec.base
            }
            is (TrapVectorMode.VECTORED) {
                when (cause.interrupt) {
                    io.br.pc := stvec.base + (cause.exception_code.asUInt * 4).resized
                } otherwise {
                    io.br.pc := stvec.base
                }
            }
        }

        io.prv := PrivilegeMode.S
        mstatus.set_spp(io.prv)
        mstatus.set_spie(mstatus.sie)
        mstatus.set_sie(False)

        sepc.set(io.commit.epc)
        scause.set(io.commit.cause)
        stval.set(io.commit.tval)
    }

    def ret_m(): Unit = {
        io.br.pc := mepc.mepc
        
        io.prv := mstatus.mpp
        mstatus.set_mpp(PrivilegeMode.U)
        mstatus.set_mpie(True)
        mstatus.set_mie(mstatus.mpie)
    }

    def ret_s(): Unit = {
        io.br.pc := sepc.sepc
        
        io.prv := mstatus.spp
        mstatus.set_spp(PrivilegeMode.U)
        mstatus.set_spie(True)
        mstatus.set_sie(mstatus.spie)
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
        when (io.commit.cause === TrapCause.TRAP_RETURN_FROM_M_MODE) {
            ret_m()
        } elsewhen (io.commit.cause === TrapCause.TRAP_RETURN_FROM_S_MODE) {
            ret_s()
        } otherwise {
            when ((io.commit.cause & TrapCause.INTERRUPT) =/= 0) {
                val interrupt = (io.commit.cause ^ TrapCause.INTERRUPT).asUInt
                when (io.prv === PrivilegeMode.M) {
                    trap_m()
                } elsewhen (io.mideleg.r(interrupt.resized)) {
                    trap_s()
                } otherwise {
                    trap_m()
                }
            } otherwise {
                val synchronous_exception = io.commit.cause.asUInt
                when (io.prv === PrivilegeMode.M) {
                    trap_m()
                } elsewhen (io.medeleg.r(synchronous_exception.resized)) {
                    trap_s()
                } otherwise {
                    trap_m()
                }
            }
        }
    }
}