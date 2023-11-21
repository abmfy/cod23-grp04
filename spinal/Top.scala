package cod

import spinal.core._

case class ThinPadTop(io_config: ThinPadIoConfig = ThinPadIoConfig()) extends Component {
    val io = ThinPadPorts(io_config)
    noIoPrefix()

    val clk = io.clock.clk_50M
    val reset = io.buttons.reset_btn
}