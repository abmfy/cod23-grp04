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

        val mstatus, mie, mtvec = slave port CsrPorts()

        val mscratch, mepc, mcause, mip = slave port CsrPorts()
        
        val satp = slave port CsrPorts()

        // Timer
        val timeout = in Bool()
    }

    val mstatus = new Mstatus
    val mie = new Mie
    val mtvec = new Mtvec

    val mscratch = new Mscratch
    val mepc = new Mepc
    val mcause = new Mcause
    val mip = new Mip

    val satp = new Satp

    mip.timeout := io.timeout

    val csr_file = Seq (
        mstatus -> io.mstatus,
        mie -> io.mie,
        mtvec -> io.mtvec,

        mscratch -> io.mscratch,
        mepc -> io.mepc,
        mcause -> io.mcause,
        mip -> io.mip,

        satp -> io.satp,
    )

    io.mscratch.r allowPruning()
    io.mcause.r allowPruning()
    io.mip.w allowPruning()

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
}

class Csr(val addr: Int) extends Component {
    val io = slave port CsrPorts()
    val reg = Reg(Types.data) init(0)
    io.r := reg
}

// Supervisor Protection and Translation

class Satp extends Csr(0x180) {
    val ppn = reg(0, 22 bits) allowPruning()
    val ppn_w = io.w(0, 22 bits)

    val asid = reg(22, 9 bits) allowPruning()
    val asid_w = io.w(22, 9 bits)

    val mode = reg(31, 1 bits) allowPruning()
    val mode_w = io.w(31, 1 bits)

    when (io.we) {
       when (mode_w === 1 || (mode_w === 0 && ppn_w === 0))
        {
        ppn := ppn_w
        mode := mode_w
        asid := asid_w
    }
    }
}

// Machine Trap Setup

class Mstatus extends Csr(0x300) {
    // WARL
    val mpp = reg(11, 2 bits) allowPruning()
    val mpp_w = io.w(11, 2 bits)
    // RW
    val sum = reg(18) allowPruning()
    val sum_w = io.w(18)
    // RW
    val mxr = reg(19) allowPruning()
    val mxr_w = io.w(19)
    when (io.we) {
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
    val mtie = reg(InterruptField.MTI) allowPruning()
    val mtie_w = io.w(InterruptField.MTI)

    when (io.we) {
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

class Mip extends Csr(0x344) {
    io.w allowPruning()
    io.we allowPruning()

    val timeout = in Bool()

    // RO
    io.r(InterruptField.MTI) := timeout

    reg := 0
}
