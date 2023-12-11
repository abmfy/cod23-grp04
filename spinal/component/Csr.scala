package cod

import spinal.core._
import spinal.lib._

case class CsrPorts() extends Bundle with IMasterSlave {
    val r = Types.data
    val w = Types.data
    val we = Bool()

    override def asMaster(): Unit = {
        in (r)
        out (w, we)
    }
}

case class CsrFilePorts() extends Bundle with IMasterSlave {
    val addr = Types.csr
    val r = Types.data
    val w = Types.data
    val we = Bool()

    override def asMaster(): Unit = {
        in (r)
        out (addr, w, we)
    }
}

class CsrFile extends Component {
    val io = new Bundle {
        val csr = slave port CsrFilePorts()

        val time, timeh = slave port CsrPorts()

        val sstatus, sie, stvec = slave port CsrPorts()

        val sscratch, sepc, scause, stval, sip = slave port CsrPorts()

        val satp = slave port CsrPorts()

        val mhartid, medeleg, mideleg = slave port CsrPorts()

        val mstatus, mie, mtvec = slave port CsrPorts()

        val mscratch, mepc, mcause, mtval, mip = slave port CsrPorts()

        // Timer
        val timer = in port UInt(64 bits)
        val timeout = in Bool()
    }

    // CSRs

    val time = new Time
    val timeh = new Timeh

    val sstatus = new Sstatus
    val sie = new Sie
    val stvec = new Stvec

    val sscratch = new Sscratch
    val sepc = new Sepc
    val scause = new Scause
    val stval = new Stval
    val sip = new Sip

    val satp = new Satp

    val mhartid = new Mhartid
    val medeleg = new Medeleg
    val mideleg = new Mideleg

    val mstatus = new Mstatus
    val mie = new Mie
    val mtvec = new Mtvec

    val mscratch = new Mscratch
    val mepc = new Mepc
    val mcause = new Mcause
    val mtval = new Mtval
    val mip = new Mip

    time.time := io.timer(0, 32 bits)
    timeh.timeh := io.timer(32, 32 bits)

    mip.timeout := io.timeout

    val csr_file = Seq (
        time -> io.time,
        timeh -> io.timeh,

        sstatus -> io.sstatus,
        sie -> io.sie,
        stvec -> io.stvec,

        sscratch -> io.sscratch,
        sepc -> io.sepc,
        scause -> io.scause,
        stval -> io.stval,
        sip -> io.sip,

        satp -> io.satp,

        mhartid -> io.mhartid,
        medeleg -> io.medeleg,
        mideleg -> io.mideleg,

        mstatus -> io.mstatus,
        mie -> io.mie,
        mtvec -> io.mtvec,

        mscratch -> io.mscratch,
        mepc -> io.mepc,
        mcause -> io.mcause,
        mtval -> io.mtval,
        mip -> io.mip,
    )

    val shadow = Seq (
        sstatus -> mstatus,
        sie -> mie,

        sip -> mip,
    )

    io.time.r allowPruning()
    io.time.w allowPruning()
    io.timeh.r allowPruning()
    io.timeh.w allowPruning()

    io.sstatus.r allowPruning()
    io.sie.r allowPruning()

    io.sscratch.r allowPruning()
    io.scause.r allowPruning()
    io.stval.r allowPruning()
    io.sip.r allowPruning()
    io.sip.w allowPruning()

    io.mhartid.r allowPruning()
    io.mhartid.w allowPruning()

    io.mscratch.r allowPruning()
    io.mcause.r allowPruning()
    io.mtval.r allowPruning()

    io.csr.r := 0

    csr_file.foreach { case (csr, ports) =>
        ports.r := csr.io.r
        when (ports.we) {
            csr.io.we := True
            csr.io.w := ports.w
        } elsewhen (io.csr.addr === csr.addr) {
            io.csr.r := csr.io.r
            csr.io.w := io.csr.w
            csr.io.we := io.csr.we
        } otherwise {
            csr.io.w := 0
            csr.io.we := False
        }
    }

    shadow.foreach { case (csr, shadowed) =>
        csr.shadow.r := shadowed.io.r
        when (csr.shadow.we) {
            shadowed.io.we := True
            shadowed.io.w := csr.shadow.w
        }
    }
}

class Csr(val addr: Int) extends Component {
    val io = slave port CsrPorts()
    val reg = Reg(Types.data) init(0)
    io.r := reg
}

class ShadowCsr(override val addr: Int) extends Csr(addr) {
    io.r allowOverride()

    val shadow = master port CsrPorts()
    io.r := shadow.r
    shadow.w := shadow.r
    shadow.we := io.we

    reg := 0
}

// Unprivileged Counter/Timers

class Time extends Csr(0xc01) {
    io.r allowOverride()
    io.w allowPruning()
    io.we allowPruning()

    val time = in port UInt(32 bits)

    // RO
    io.r := time.asBits

    reg := 0
}

class Timeh extends Csr(0xc81) {
    io.r allowOverride()
    io.w allowPruning()
    io.we allowPruning()

    val timeh = in port UInt(32 bits)

    // RO
    io.r := timeh.asBits

    reg := 0
}

// Supervisor Trap Setup

class Sstatus extends ShadowCsr(0x100) {
    // RW
    val sie = shadow.w(StatusField.SIE) allowPruning()
    val sie_w = io.w(StatusField.SIE)
    // RW
    val spie = shadow.w(StatusField.SPIE) allowPruning()
    val spie_w = io.w(StatusField.SPIE)
    // WARL
    val spp = shadow.w(StatusField.SPP) allowPruning()
    val spp_w = io.w(StatusField.SPP)
    // RW
    val sum = shadow.w(StatusField.SUM) allowPruning()
    val sum_w = io.w(StatusField.SUM)
    // RW
    val mxr = shadow.w(StatusField.MXR) allowPruning()
    val mxr_w = io.w(StatusField.MXR)

    when (io.we) {
        sie := sie_w
        spie := spie_w
        spp := spp_w
        sum := sum_w
        mxr := mxr_w
    }
}

class Sie extends ShadowCsr(0x104) {
    // RW
    val stie = shadow.w(InterruptField.STI) allowPruning()
    val stie_w = io.w(InterruptField.STI)

    // RO0
    io.r := 0
    // RW
    io.r(InterruptField.STI) := shadow.r(InterruptField.STI)

    when (io.we) {
        stie := stie_w
    }
}

class Stvec extends Csr(0x105) {
    // WARL
    val mode = reg(0, 2 bits) allowPruning()
    val mode_w = io.w(0, 2 bits)
    // WARL
    val base = reg(2, 30 bits) allowPruning()
    val base_w = io.w(2, 30 bits)

    when (io.we) {
        mode := mode_w
        base := base_w
    }
}

// Supervisor Trap Handling

class Sscratch extends Csr(0x140) {
    // RW
    val sscratch = reg(0, 32 bits) allowPruning()
    val sscratch_w = io.w(0, 32 bits)

    when (io.we) {
        sscratch := sscratch_w
    }
}

class Sepc extends Csr(0x141) {
    // WARL
    val sepc = reg(0, 32 bits) allowPruning()
    val sepc_w = io.w(0, 32 bits)

    when (io.we) {
        sepc := sepc_w
    }
}

class Scause extends Csr(0x142) {
    // RW
    val interrupt = reg(31) allowPruning()
    val interrupt_w = io.w(31)
    // WLRL
    val exception_code = reg(0, 31 bits) allowPruning()
    val exception_code_w = io.w(0, 31 bits)

    when (io.we) {
        interrupt := interrupt_w
        exception_code := exception_code_w
    }
}

class Stval extends Csr(0x143) {
    // RW
    val stval = reg(0, 32 bits) allowPruning()
    val stval_w = io.w(0, 32 bits)

    when (io.we) {
        stval := stval_w
    }
}

class Sip extends ShadowCsr(0x144) {
    io.w allowPruning()
    io.we allowPruning()

    // RO0
    io.r := 0
    // RO
    io.r(InterruptField.STI) := shadow.r(InterruptField.STI)
}

// Supervisor Protection and Translation

class Satp extends Csr(0x180) {
    // WARL
    val ppn = reg(0, 22 bits) allowPruning()
    val ppn_w = io.w(0, 22 bits)
    // WARL
    val asid = reg(22, 9 bits) allowPruning()
    val asid_w = io.w(22, 9 bits)
    // WARL
    val mode = reg(31, 1 bits) allowPruning()
    val mode_w = io.w(31, 1 bits)

    when (io.we) {
        when (mode_w === 1 || (mode_w === 0 && ppn_w === 0)) {
            ppn := ppn_w
            mode := mode_w
            asid := asid_w
        }
    }
}

// Machine Information Registers

class Mhartid extends Csr(0xf14) {
    io.r.allowOverride()
    io.w.allowPruning()
    io.we.allowPruning()

    // RO
    io.r := 0

    reg := 0
}

class Medeleg extends Csr(0x302) {
    val delegatable = Seq (
        TrapCause.ILLEGAL_INSTRUCTION,
        TrapCause.BREAKPOINT,
        TrapCause.ENVIRONMENT_CALL_FROM_U_MODE,
        TrapCause.ENVIRONMENT_CALL_FROM_S_MODE,
        TrapCause.ENVIRONMENT_CALL_FROM_M_MODE,
        TrapCause.INSTRUCTION_PAGE_FAULT,
        TrapCause.LOAD_PAGE_FAULT,
        TrapCause.STORE_AMO_PAGE_FAULT,
    )

    for (e <- delegatable) {
        // WARL
        val synchronous_exception = reg(e) allowPruning()
        val synchronous_exception_w = io.w(e)

        when (io.we) {
            synchronous_exception := synchronous_exception_w
        }
    }
}

class Mideleg extends Csr(0x303) {
    val delegatable = Seq (
        TrapCause.SUPERVISOR_TIMER_INTERRUPT,
        TrapCause.MACHINE_TIMER_INTERRUPT,
    )

    for (e <- delegatable) {
        val i =  e ^ TrapCause.INTERRUPT

        // WARL
        val interrupt = reg(i) allowPruning()
        val interrupt_w = io.w(i)

        when (io.we) {
            interrupt := interrupt_w
        }
    }
}

// Machine Trap Setup

class Mstatus extends Csr(0x300) {
    // RW
    val sie = reg(StatusField.SIE) allowPruning()
    val sie_w = io.w(StatusField.SIE)
    // RW
    val mie = reg(StatusField.MIE) allowPruning()
    val mie_w = io.w(StatusField.MIE)
    // RW
    val spie = reg(StatusField.SPIE) allowPruning()
    val spie_w = io.w(StatusField.SPIE)
    // RW
    val mpie = reg(StatusField.MPIE) allowPruning()
    val mpie_w = io.w(StatusField.MPIE)
    // WARL
    val spp = reg(StatusField.SPP) allowPruning()
    val spp_w = io.w(StatusField.SPP)
    // WARL
    val mpp = reg(StatusField.MPP, 2 bits) allowPruning()
    val mpp_w = io.w(StatusField.MPP, 2 bits)
    // RW
    val sum = reg(StatusField.SUM) allowPruning()
    val sum_w = io.w(StatusField.SUM)
    // RW
    val mxr = reg(StatusField.MXR) allowPruning()
    val mxr_w = io.w(StatusField.MXR)

    when (io.we) {
        sie := sie_w
        mie := mie_w
        spie := spie_w
        mpie := mpie_w
        spp := spp_w
        switch (mpp_w) {
            is (
                PrivilegeMode.U.asBits,
                PrivilegeMode.S.asBits,
                PrivilegeMode.M.asBits,
            ) {
                mpp := mpp_w
            }
        }
        sum := sum_w
        mxr := mxr_w
    }
}

class Mie extends Csr(0x304) {
    // WARL
    val stie = reg(InterruptField.STI) allowPruning()
    val stie_w = io.w(InterruptField.STI)
    // WARL
    val mtie = reg(InterruptField.MTI) allowPruning()
    val mtie_w = io.w(InterruptField.MTI)

    when (io.we) {
        stie := stie_w
        mtie := mtie_w
    }
}

class Mtvec extends Csr(0x305) {
    // WARL
    val mode = reg(0, 2 bits) allowPruning()
    val mode_w = io.w(0, 2 bits)
    // WARL
    val base = reg(2, 30 bits) allowPruning()
    val base_w = io.w(2, 30 bits)

    when (io.we) {
        mode := mode_w
        base := base_w
    }
}

// Machine Trap Handling

class Mscratch extends Csr(0x340) {
    // RW
    val mscratch = reg(0, 32 bits) allowPruning()
    val mscratch_w = io.w(0, 32 bits)

    when (io.we) {
        mscratch := mscratch_w
    }
}

class Mepc extends Csr(0x341) {
    // WARL
    val mepc = reg(0, 32 bits) allowPruning()
    val mepc_w = io.w(0, 32 bits)

    when (io.we) {
        mepc := mepc_w
    }
}

class Mcause extends Csr(0x342) {
    // RW
    val interrupt = reg(31) allowPruning()
    val interrupt_w = io.w(31)
    // WLRL
    val exception_code = reg(0, 31 bits) allowPruning()
    val exception_code_w = io.w(0, 31 bits)

    when (io.we) {
        interrupt := interrupt_w
        exception_code := exception_code_w
    }
}

class Mtval extends Csr(0x343) {
    // RW
    val mtval = reg(0, 32 bits) allowPruning()
    val mtval_w = io.w(0, 32 bits)

    when (io.we) {
        mtval := mtval_w
    }
}

class Mip extends Csr(0x344) {
    val timeout = in Bool()

    // RW
    val sti = reg(InterruptField.STI) allowPruning()
    val sti_w = io.w(InterruptField.STI)
    // RO
    val mti = reg(InterruptField.MTI) allowPruning()

    when (io.we) {
        sti := sti_w
    }

    mti := timeout
}
