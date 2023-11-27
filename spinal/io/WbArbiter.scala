package cod

import spinal.core._
import spinal.lib._

case class WbArbiterConfig (
    addr_width: Int = 32,
    data_width: Int = 32,
    arb_type_round_robin: Boolean = false,
    arb_lsb_high_priority: Boolean = true,
    master_count: Int,
) {
    val sel_width = data_width / 8
}

class WbArbiter(config: WbArbiterConfig) extends Component {
    val io = new Bundle {
        val masters = Vec (
            slave (
                WishbonePorts (
                    config.addr_width,
                    config.data_width,
                )
            ),
            config.master_count,
        )
        val wb = master (
            WishbonePorts (
                config.addr_width,
                config.data_width,
            )
        )
    }

    val arbiter = new Arbiter(ArbiterConfig (
        ports = config.master_count,
        arb_type_round_robin = config.arb_type_round_robin,
        arb_block = true,
        arb_block_ack = false,
        arb_lsb_high_priority = config.arb_lsb_high_priority,
    ))

    arbiter.io.acknowledge := 0

    arbiter.io.request := io.masters.map(_.cyc).asBits
    val grant = arbiter.io.grant
    val grant_valid = arbiter.io.grant_valid

    val wbm_sel = Vec((0 until config.master_count).map(grant(_) && grant_valid))
    val enable = wbm_sel.sContains(True)

    // Masters
    for ((master, i) <- io.masters.zipWithIndex) {
        master.dat_r := io.wb.dat_r
        master.ack := io.wb.ack && wbm_sel(i)
    }

    // Slave
    io.wb.adr := enable ? PriorityMux(wbm_sel, io.masters.map(_.adr)) | 0
    io.wb.dat_w := enable ? PriorityMux(wbm_sel, io.masters.map(_.dat_w)) | 0
    io.wb.we := enable ? PriorityMux(wbm_sel, io.masters.map(_.we)) | False
    io.wb.sel := enable ? PriorityMux(wbm_sel, io.masters.map(_.sel)) | 0
    io.wb.stb := enable ? PriorityMux(wbm_sel, io.masters.map(_.stb)) | False
    io.wb.cyc := enable ? PriorityMux(wbm_sel, io.masters.map(_ => True)) | False
}