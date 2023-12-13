package cod.sim
import cod._

import spinal.core._
import spinal.core.sim._

import java.io.{BufferedWriter, FileWriter}

object Tracer {
    def init(wb: WB, clock_period: TimeNumber) = {
        val writer = new FileWriter("simWorkspace/trace.txt")
        fork {
            while (true) {
                if (wb.io.i.real.toBoolean) {
                    val pc = wb.io.i.pc.toLong
                    var reg_we = wb.io.i.reg_we.toBoolean.toInt
                    val reg_addr = if (reg_we != 0) wb.io.i.reg_addr_d.toLong else 0
                    val reg_data = if (reg_we != 0 && reg_addr != 0) wb.io.i.reg_data_d.toLong else 0
                    if (reg_addr == 0) reg_we = 0
                    writer.write(f"$pc%08x $reg_we $reg_addr%02x $reg_data%08x\n")
                    writer.flush()
                }
                sleep(clock_period)
            }
        }
    }
}