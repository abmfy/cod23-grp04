package cod

import spinal.core._

case class ThinPadTop(io_config: ThinPadIoConfig = ThinPadIoConfig()) extends Component {
    val io = ThinPadPorts(io_config)
    noIoPrefix()

    ClockDomain.current.renamePulledWires(
        clock = "clk_50M",
        reset = "reset_btn",
    )
}