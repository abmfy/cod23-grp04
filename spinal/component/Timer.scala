package cod

import spinal.core._
import spinal.lib._

case class TimerPorts() extends Bundle with IMasterSlave {
    val mtime, mtimeh, mtimecmp, mtimecmph = CsrPorts()

    override def asMaster(): Unit = {
        master (mtime, mtimeh, mtimecmp, mtimecmph)
    }
}

object Timer {
    val CLINT = 0x2000000
    val CLINT_MTIME = CLINT + 0xbff8
    val CLINT_MTIMEH = CLINT_MTIME + 4
    val CLINT_MTIMECMP = CLINT + 0x4000
    val CLINT_MTIMECMPH = CLINT_MTIMECMP + 4
}

class Timer extends Component {
    val io = new Bundle {
        val timer = slave port TimerPorts()
        val timeout = out Bool()
    }

    val mtime, mtimecmp = Reg(UInt(64 bits)) init(0)

    io.timer.mtime.r := mtime(0, 32 bits).asBits
    io.timer.mtimeh.r := mtime(32, 32 bits).asBits
    io.timer.mtimecmp.r := mtimecmp(0, 32 bits).asBits
    io.timer.mtimecmph.r := mtimecmp(32, 32 bits).asBits

    when (io.timer.mtime.we) {
        mtime(0, 32 bits) := io.timer.mtime.w.asUInt
    }
    when (io.timer.mtimeh.we) {
        mtime(32, 32 bits) := io.timer.mtimeh.w.asUInt
    }
    when (!io.timer.mtime.we && !io.timer.mtimeh.we) {
        mtime := mtime + 1
    }

    when (io.timer.mtimecmp.we) {
        mtimecmp(0, 32 bits) := io.timer.mtimecmp.w.asUInt
    }
    when (io.timer.mtimecmph.we) {
        mtimecmp(32, 32 bits) := io.timer.mtimecmph.w.asUInt
    }

    io.timeout := mtime >= mtimecmp
}