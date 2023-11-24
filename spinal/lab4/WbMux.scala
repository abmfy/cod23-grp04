package cod.lab4
import cod._

import spinal.core._
import spinal.lib._

case class WbMuxConfig (
    addr_width: Int = 32,
    data_width: Int = 32,
    slave_count: Int,
    slave_addr: Seq[Long],
    slave_addr_mask: Seq[Long],
) {
    val sel_width = data_width / 8
    assert(slave_count == slave_addr.length
        && slave_count == slave_addr_mask.length)
}

class WbMux(config: WbMuxConfig) extends Component {
    val io = new Bundle {
        val wb = slave(
            WishbonePorts(
                config.addr_width,
                config.data_width,
            )
        )
        val slaves = Vec(
            master(
                WishbonePorts(
                    config.addr_width,
                    config.data_width,
                )
            ), 
            config.slave_count,
        )
    }

    val slave_match = for (i <- 0 until config.slave_count) yield {
        ((io.wb.adr ^ config.slave_addr(i)) & config.slave_addr_mask(i)) === 0
    }

    val slave_sel = for (i <- 0 until config.slave_count) yield {
        slave_match(i) && slave_match.slice(0, i).fold(False)(_ || _) === False
    }

    // Master
    io.wb.dat_r := PriorityMux(slave_sel, io.slaves.map(_.dat_r))
    io.wb.ack := io.slaves.map(_.ack).reduce(_ || _)
    
    // Slave
    for ((slave, i) <- io.slaves.zipWithIndex) {
        slave.cyc := io.wb.cyc && slave_sel(i)
        slave.stb := io.wb.stb && slave_sel(i)
        slave.we := io.wb.we && slave_sel(i)
        slave.adr := io.wb.adr
        slave.dat_w := io.wb.dat_w
        slave.sel := io.wb.sel
    }
}