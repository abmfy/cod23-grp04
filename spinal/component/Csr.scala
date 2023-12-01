package cod

import spinal.core._
import spinal.lib._

case class CsrPorts() extends Bundle with IMasterSlave {
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
    val io = slave port CsrPorts()

    val csr_file = Seq(
        new Mstatus,
        new Mie,
        new Mtvec,

        new Mscratch,
        new Mepc,
        new Mcause,
        new Mip,
    )

    io.r := 0

    csr_file.foreach { csr =>
        when (io.addr === csr.addr) {
            io.r := csr.io.r
            csr.io.w := io.w
            csr.io.we := io.we
        } otherwise {
            csr.io.w := 0
            csr.io.we := False
        }
    }
}

class Csr(val addr: Int) extends Component {
    val io = new Bundle {
        val r = out port Types.data
        val w = in port Types.data
        val we = in Bool()
    }
    val reg = Reg(Types.data) init(0)
    io.r := reg
}

// Machine Trap Setup

class Mstatus extends Csr(0x300) {
    val mpp = reg(11, 2 bits)
    val mpp_w = io.w(11, 2 bits)

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
    }
}

class Mie extends Csr(0x304) {
    val mtie = reg(7)
    val mtie_w = io.w(7)

    when (io.we) {
        mtie := mtie_w
    }
}

class Mtvec extends Csr(0x305) {
    val mode = reg(0, 2 bits)
    val mode_w = io.w(0, 2 bits)
    val base = reg(2, 30 bits)
    val base_w = io.w(2, 30 bits)

    when (io.we) {
        base := base_w
    }
}

// Machine Trap Handling

class Mscratch extends Csr(0x340) {
    when (io.we) {
        reg := io.w
    }
}

class Mepc extends Csr(0x341) {
    when (io.we) {
        reg := io.w
    }
}

class Mcause extends Csr(0x342) {
    when (io.we) {
        reg := io.w
    }
}

class Mip extends Csr(0x344) {
    val mtip = reg(7)
    val mtip_w = io.w(7)

    when (io.we) {
        mtip := mtip_w
    }
}
