package cod
import cod.sim._

import spinal.core._
import spinal.core.sim._
import spinal.lib.io._

import scala.util.Random
import spinal.sim.SimManagerContext

object Test extends App {
    Config.sim.compile(InOutWrapper(new Top(simulation = true))).doSim { dut =>
        
    }
}