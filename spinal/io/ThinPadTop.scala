package cod

import spinal.core._
import spinal.lib._

case class ThinPadTop(
    io_config: ThinPadIoConfig = ThinPadIoConfig(),
    simulation: Boolean = false,
) extends Component {
    val io = ThinPadPorts(io_config)
    noIoPrefix()

    ClockDomain.current.renamePulledWires(
        clock = "clk_50M",
        reset = "reset_btn",
    )

    val clkCtrl = new Area {
        // PLL blackbox
        val pll = new Pll
        pll.io.clk_in1 := ClockDomain.current.readClockWire
        pll.io.reset := ClockDomain.current.readResetWire

        // Clock domains
        val sysClkDomain = ClockDomain.internal(
            name = "sys",
            frequency = FixedFrequency(10 MHz),
        )
        sysClkDomain.clock := pll.io.clk_out1
        sysClkDomain.reset := ResetCtrl.asyncAssertSyncDeassert(
            input = pll.io.locked,
            clockDomain = sysClkDomain,
            inputPolarity = LOW,
            outputPolarity = HIGH,
        )
    }

    ClockDomain.push(clkCtrl.sysClkDomain)
}