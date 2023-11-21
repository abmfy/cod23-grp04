package cod

import spinal.core._
import spinal.core.sim._

object Config {
  def spinal = SpinalConfig(
    mode = SystemVerilog,
    targetDirectory = "thinpad_top.srcs/sources_1/spinal",
  )

  def sim = SimConfig.withConfig(spinal).withVcdWave
}
