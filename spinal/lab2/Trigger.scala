package cod.lab2

import spinal.core._

class Trigger extends Component {
    val io = new Bundle {
        val push_btn = in Bool()
        val trigger = out Bool()
    }

    io.trigger := RegNext(io.push_btn.rise(initAt = False)) init(false)
}