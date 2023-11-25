package cod
import cod.sim._

import spinal.core._
import spinal.lib._
import spinal.lib.io._

class Top (
    simulation: Boolean = false
) extends ThinPadTop

object Generate extends App {
    Config.spinal.generate(InOutWrapper(new Top)).printPruned()
}