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

        // Wishbone master
        val wb = master port WishbonePorts()

        // PageTable master
        val pt = master port PageTableTranslatePorts()
    }

    val mem_adr = io.i.alu_y.asUInt
    val offset = mem_adr(0, 2 bits)

    val mem_sel: Bits = io.i.mem_sel |<< offset
    val mem_data_read: Bits = io.wb.dat_r |>> (offset * 8)
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
        io.o.reg_we := False

        io.trap := False
        io.o.trap.epc := 0
        io.o.trap.cause := 0
    }

    def req(): Unit = {
        io.wb.stb := True
        io.wb.we := io.i.mem_we
        io.wb.adr := page_en ? pa | mem_adr
        io.wb.sel := mem_sel
        io.wb.dat_w := mem_data_write
    }

    def done(): Unit = {
        io.wb.stb := False
        io.wb.we := False
        io.wb.adr := 0
        io.wb.sel := 0
        io.wb.dat_w := 0
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

    io.wb.stb.setAsReg() init(False)
    io.wb.we.setAsReg() init(False)
    io.wb.adr.setAsReg() init(0)
    io.wb.dat_w.setAsReg() init(0)
    io.wb.sel.setAsReg() init(0)

    io.o.trap.trap := io.trap
    io.trap := io.o.trap.trap

    // Forwarding
    io.forward.we := io.i.reg_we
    io.forward.addr := io.i.reg_addr_d
    io.forward.data := reg_data

    // Timer
    val timer = new Area {
        val mtime_req = mem_adr === Timer.CLINT_MTIME
        val mtimeh_req = mem_adr === Timer.CLINT_MTIMEH
        val mtimecmp_req = mem_adr === Timer.CLINT_MTIMECMP
        val mtimecmph_req = mem_adr === Timer.CLINT_MTIMECMPH

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

    io.stall_req := io.i.mem_en && !timer.req && !io.wb.ack

    io.wb.cyc := io.wb.stb

    val va = mem_adr
    val pa = io.pt.physical_addr

    io.pt.look_up_addr.setAsReg() init(0)
    io.pt.look_up_req.setAsReg() init(False)

    def raise_page_fault(): Unit = {
        io.trap := True
        io.o.trap.epc := io.i.pc
        io.o.trap.cause := io.pt.exception_code
    }

    val fsm = new StateMachine {
        io.pt.access_type := io.i.mem_we ? MemAccessType.Store | MemAccessType.Load
        val start: State = new State with EntryPoint {
            whenIsActive {
                // Trapped
                when (io.i.trap.trap) {
                    io.trap := True
                    io.o.trap.epc := io.i.trap.epc
                    io.o.trap.cause := io.i.trap.cause
                } elsewhen (io.i.mem_en) {
                    bubble()

                    when (timer.req) {
                        proceed()
                    } otherwise {
                        when (page_en) {
                            goto(translate)
                        } otherwise {
                            req()
                            goto(fetch)
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
                        goto(fetch)
                    } otherwise {
                        raise_page_fault()
                        exit()
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
                when (io.wb.ack) {
                    proceed()
                    done()
                    goto(start)
                }
            }
        }
    }
}