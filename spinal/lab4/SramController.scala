package cod.lab4
import cod._

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

    val offset = io.wb.adr(0, 2 bits)

    io.wb.dat_r := io.sram.data.read
    io.sram.data.write := io.wb.dat_w

    io.sram.addr := get_addr
    io.sram.ce_n := !(io.wb.cyc && io.wb.stb)
    io.sram.be_n := ~get_sel

    def get_sel: Bits = {
        io.wb.sel |<< offset
    }

    def get_addr: UInt = {
        io.wb.adr(2, SRAM_ADDR_WIDTH bits)
    }

    def get_read_data: Bits = {
        io.sram.data.read |>> offset * 8
    }

    def get_write_data: Bits = {
        io.wb.dat_w |<< offset * 8
    }

    val fsm = new StateMachine {
        io.wb.ack := False
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
            whenIsActive {
                exit()
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
            whenIsActive {
                io.sram.oe_n := True
                io.sram.data.writeEnable := True
                exit()
            }
        }
    }    
}