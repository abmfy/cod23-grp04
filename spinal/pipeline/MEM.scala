package cod

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

class MEM extends Component {
    val io = new Bundle {
        val i = slave port EXE_MEM()
        val o = master port MEM_WB()

        // Forwarding
        val forward = master port ForwardPorts()

        // Hazard handling
        val stall_req = out Bool()

        // // Wishbone master
        // val wb = master port WishbonePorts()
        val dcache = master port DCachePorts()
    }

    val mem_adr = io.i.alu_y.asUInt
    val offset = mem_adr(0, 2 bits)

    def mem_sel: Bits = io.i.mem_sel |<< offset
    def mem_data_read: Bits = io.dcache.data |>> (offset * 8)
    def mem_data_write: Bits = io.i.reg_data_b |<< (offset * 8)

    def reg_data: Bits = {
        val res = Types.data
        switch (io.i.reg_sel) {
            is (RegSel.ALU) {
                res := io.i.alu_y
            }
            is (RegSel.MEM) {
                res := Util.sign_extend(mem_data_read, io.i.mem_sel)
            }
            is (RegSel.PC) {
                res := (io.i.pc + 4).asBits
            }
        }
        res
    }

    def bubble(): Unit = {
        io.o.reg_we := False
    }

    def req(): Unit = {
        io.dcache.dcache_en := True
        io.dcache.dcache_we := io.i.mem_we
        io.dcache.addr := mem_adr
        io.dcache.dcache_sel := mem_sel
        io.dcache.data_w := mem_data_write
    }
    val debug_mem_data_read = mem_data_read
    val debug_reg_data = reg_data
    def proceed(): Unit = {
        io.o.reg_we := io.i.reg_we
        io.o.reg_addr_d := io.i.reg_addr_d
        io.o.reg_data_d := reg_data
    }

    io.o.reg_we.setAsReg() init(False)
    io.o.reg_addr_d.setAsReg() init(0)
    io.o.reg_data_d.setAsReg() init(0)

    // Forwarding
    io.forward.we := io.i.reg_we
    io.forward.addr := io.i.reg_addr_d
    io.forward.data := reg_data

    io.stall_req := io.i.mem_en && !io.dcache.ack


    val fsm = new StateMachine {
        // io.wb.stb := False
        // io.wb.we := False
        // io.wb.adr := 0
        // io.wb.dat_w := 0
        // io.wb.sel := 0
        io.dcache.dcache_en := False
        io.dcache.dcache_we := False
        io.dcache.addr := 0
        io.dcache.dcache_sel := 0
        io.dcache.data_w := 0

        val start: State = new State with EntryPoint {
            whenIsActive {
                when (io.i.mem_en) {
                    bubble()
                    req()
                    when (io.dcache.ack) {
                        proceed(); 
                        
                    } .otherwise{
                        goto(fetch) 
                    }
                } otherwise {
                    proceed()
                }
            }
        }
        val fetch: State = new State {
            whenIsActive {
                bubble()
                req()
                when (io.dcache.ack) {
                    proceed()
                    goto(start)
                }
            }
        }
    }
}