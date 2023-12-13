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
        val flush_req = out Bool()

        // Trap
        val trap = out Bool()

        // Privilege mode
        val prv = in port PrivilegeMode()

        // Address translation mode
        val satp_mode = in Bool()

        // Csr file
        val csr = master port CsrFilePorts()

        // Timer
        val timer = master port TimerPorts()

        // val wb = master port WishbonePorts()
        val dcache = master port DCachePorts()

        // PageTable master
        val pt = master port PageTableTranslatePorts()
    }

    val mem_adr = io.i.alu_y.asUInt
    val offset = mem_adr(0, 2 bits)

    val va = mem_adr
    val pa = io.pt.physical_addr

    val mem_sel: Bits = io.i.mem_sel |<< offset
    val mem_data_read: Bits = io.dcache.data |>> (offset * 8)
    val mem_data_write: Bits = io.i.reg_data_b |<< (offset * 8)

    // Paging enable
    val page_en = io.prv =/= PrivilegeMode.M && io.satp_mode

    val reg_data: Bits = {
        val res = Types.data
        switch (io.i.reg_sel) {
            is (RegSel.ALU) {
                res := io.i.alu_y
            }
            is (RegSel.MEM) {
                when (io.i.mem_unsigned) {
                    res := Util.zero_extend(mem_data_read, io.i.mem_sel)
                } otherwise {
                    res := Util.sign_extend(mem_data_read, io.i.mem_sel)
                }
            }
            is (RegSel.PC) {
                res := (io.i.pc + 4).asBits
            }
        }
        when (io.i.csr_op =/= CsrOp.N) {
            res := io.csr.r
        }
        res
    }

    def bubble(): Unit = {
        io.o.real := False
        io.o.pc := 0

        io.trap := False
        io.o.trap.epc := 0
        io.o.trap.cause := 0
    }

    def req(): Unit = {
        io.dcache.dcache_en := True
        io.dcache.dcache_we := io.i.mem_we
        io.dcache.addr := page_en ? pa | mem_adr
        io.dcache.dcache_sel := mem_sel
        io.dcache.data_w := mem_data_write
    }
    
    def proceed(): Unit = {
        io.o.real := io.i.real
        io.o.pc := io.i.pc
        io.o.reg_we := io.i.reg_we
        io.o.reg_addr_d := io.i.reg_addr_d
        io.o.reg_data_d := reg_data

        io.trap := False
        io.o.trap.epc := 0
        io.o.trap.cause := 0
    }

    io.o.real.setAsReg() init(False)
    io.o.pc.setAsReg() init(0)
    io.o.reg_we.setAsReg() init(False)
    io.o.reg_addr_d.setAsReg() init(0)
    io.o.reg_data_d.setAsReg() init(0)

    io.o.trap.trap.setAsReg() init(False)
    io.o.trap.epc.setAsReg() init(0)
    io.o.trap.cause.setAsReg() init(0)
    io.o.trap.tval.setAsReg() init(0)

    io.o.trap.trap := io.trap
    io.trap := io.o.trap.trap

    // Forwarding
    io.forward.we := io.i.reg_we
    io.forward.addr := io.i.reg_addr_d
    io.forward.data := reg_data

    // Timer
    val timer = new Area {
        val adr = page_en ? pa | mem_adr
        val mtime_req = adr === Timer.CLINT_MTIME
        val mtimeh_req = adr === Timer.CLINT_MTIMEH
        val mtimecmp_req = adr === Timer.CLINT_MTIMECMP
        val mtimecmph_req = adr === Timer.CLINT_MTIMECMPH

        val req = mtime_req || mtimeh_req || mtimecmp_req || mtimecmph_req

        when (mtime_req) {
            mem_data_read := io.timer.mtime.r |>> (offset * 8)
        }
        when (mtimeh_req) {
            mem_data_read := io.timer.mtimeh.r |>> (offset * 8)
        }
        when (mtimecmp_req) {
            mem_data_read := io.timer.mtimecmp.r |>> (offset * 8)
        }
        when (mtimecmph_req) {
            mem_data_read := io.timer.mtimecmph.r |>> (offset * 8)
        }

        io.timer.mtime.we := False
        io.timer.mtimeh.we := False
        io.timer.mtimecmp.we := False
        io.timer.mtimecmph.we := False

        io.timer.mtime.w := 0
        io.timer.mtimeh.w := 0
        io.timer.mtimecmp.w := 0
        io.timer.mtimecmph.w := 0

        when (io.i.mem_en && io.i.mem_we) {
            when (mtime_req) {
                io.timer.mtime.we := True
                io.timer.mtime.w := mem_data_write
            }
            when (mtimeh_req) {
                io.timer.mtimeh.we := True
                io.timer.mtimeh.w := mem_data_write
            }
            when (mtimecmp_req) {
                io.timer.mtimecmp.we := True
                io.timer.mtimecmp.w := mem_data_write
            }
            when (mtimecmph_req) {
                io.timer.mtimecmph.we := True
                io.timer.mtimecmph.w := mem_data_write
            }
        }
    }

    // Csr
    val csr = new Area {
        val rs1 = io.i.alu_y

        io.csr.addr := 0
        io.csr.w := 0
        io.csr.we := False

        when (io.i.csr_op =/= CsrOp.N) {
            io.csr.addr := io.i.imm(0, 12 bits).asUInt
            io.csr.we := True
        }

        switch (io.i.csr_op) {
            is (CsrOp.W) {
                io.csr.w := rs1
            }
            is (CsrOp.S) {
                io.csr.w := io.csr.r | rs1
            }
            is (CsrOp.C) {
                io.csr.w := io.csr.r & ~rs1
            }
        }
    }

    io.stall_req := io.i.mem_en && !timer.req && !io.dcache.ack
    io.flush_req := io.i.csr_op =/= CsrOp.N

    io.pt.look_up_addr.setAsReg() init(0)
    io.pt.look_up_req.setAsReg() init(False)

    def raise_page_fault(): Unit = {
        io.trap := True
        io.o.trap.epc := io.i.pc
        io.o.trap.cause := io.pt.exception_code
        io.o.trap.tval := va.asBits

        io.o.real := False
    }

    val fsm = new StateMachine {
        io.dcache.dcache_en := False
        io.dcache.dcache_we := False
        io.dcache.addr := 0
        io.dcache.dcache_sel := 0
        io.dcache.data_w := 0
    
        io.pt.access_type := io.i.mem_we ? MemAccessType.Store | MemAccessType.Load
        val start: State = new State with EntryPoint {
            whenIsActive {
                // Trapped
                when (io.i.trap.trap) {
                    io.trap := True
                    io.o.trap <> io.i.trap
                    io.o.real := False
                } elsewhen (io.i.mem_en) {
                    bubble()

                    when (timer.req) {
                        proceed()
                    } otherwise {
                        when (page_en) {
                            goto(translate)
                        } otherwise {
                            req()
                            when (io.dcache.ack) {
                                proceed()
                            } otherwise {
                                goto(fetch) 
                            }
                        }
                    }
                } otherwise {
                    proceed()
                }
            }
        }
        val translate : State = new State {
            onEntry {
                io.pt.look_up_addr := va
                io.pt.look_up_req := True
            }
            whenIsActive {
                when (io.pt.look_up_ack) {
                    when (io.pt.look_up_valid) {
                        req()
                        when (io.dcache.ack) {
                            proceed()
                            goto(start)
                        } otherwise {
                            goto(fetch) 
                        }
                    } otherwise {
                        raise_page_fault()
                        goto(start)
                    }
                }
            }
            onExit {
                io.pt.look_up_req := False
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