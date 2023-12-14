package cod

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._
import spinal.lib.io.InOutWrapper

class SramController extends Component {
    val SRAM_ADDR_WIDTH = 20

    val io = new Bundle {
        val wb = slave port WishbonePorts()
        val sram = master port SramPorts()
    }

    io.wb.ack.setAsReg() init(False)

    io.wb.dat_r := io.sram.data.read
    io.sram.data.write := io.wb.dat_w

    io.sram.addr := io.wb.adr(2, SRAM_ADDR_WIDTH bits)
    io.sram.ce_n := !(io.wb.cyc && io.wb.stb && !io.wb.ack)
    io.sram.be_n := ~io.wb.sel

    val fsm = new StateMachine {
        io.sram.oe_n := False
        io.sram.we_n := True
        io.sram.data.writeEnable := False
        val idle: State = new State with EntryPoint {
            onEntry {
                io.wb.ack := False
            }
            whenIsActive {
                when (io.wb.cyc && io.wb.stb) {
                    when (io.wb.we) {
                        goto(write)
                    } otherwise {
                        goto(read)
                    }
                }
            }
        }
        val read: State = new State {
            onEntry {
                io.wb.ack := True
            }
            whenIsActive {
                goto(idle)
            }
        }
        val write: State = new State {
            onEntry {
                io.sram.oe_n := True
                io.sram.data.writeEnable := True
            }
            whenIsActive {
                io.sram.oe_n := True
                io.sram.we_n := False
                io.sram.data.writeEnable := True
                goto(write_2)
            }
        }
        val write_2: State = new State {
            onEntry {
                io.wb.ack := True
            }
            whenIsActive {
                io.sram.oe_n := True
                io.sram.data.writeEnable := True
                goto(idle)
            }
        }
    }    
}