package cod.lab2

import spinal.core._
import spinal.core.sim._

class Counter extends Component {
    val io = new Bundle {
        val trigger = in Bool()
        val count = out UInt(4 bits)
    }

    val counter = Reg(UInt(4 bits)) init(0) simPublic()
    when (io.trigger) {
        counter := counter +| 1
    }
    io.count := counter
}