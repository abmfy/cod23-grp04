package cod

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

case class IFConfig (
    start: Long = 0x80000000L
)

class IF(config: IFConfig = IFConfig()) extends Component {
    val io = new Bundle {
        val o = master port IF_ID()
        
        // Branching
        val br = slave port BranchPorts()
        
        // Hazard handling
        val stall = in Bool()
        val bubble = in Bool()

        // Trap
        val trap = out Bool()
        val sie, mie = in Bool()
        val ie, ip = in port Types.data
        val mideleg = in port Types.data

        // Privilege mode
        val prv = in port PrivilegeMode()

        // Address translation mode
        val satp_mode = in Bool()

        // Wishbone master
        val wb = master port WishbonePorts()
        
        // branchPredict
        val instr = out port Types.data
        val pc = out port Types.addr
        val next_taken = in Bool()
        val next_pc = in port Types.addr

        // Page table master
        val pt = master port PageTableTranslatePorts()
    }

    val pc = Reg(Types.addr) init(config.start)
    io.pc := pc

    val va = pc
    val pa = io.pt.physical_addr

    // Delayed branch signal
    val delay_br = Reg(Bool()) init(False)

    // Delayed ack signal
    val delay_ack = Reg(Bool()) init(False)
    val delay_instr = Reg(Types.data) init(Instr.NOP)

    // Interrupt
    val interrupt = io.ie & io.ip
    val interrupt_delegated = interrupt & io.mideleg
    val interrupt_masked = interrupt & ~io.mideleg

    // Paging enabled
    val page_en = io.prv =/= PrivilegeMode.M && io.satp_mode

    io.o.real.setAsReg() init(False)
    io.o.pc.setAsReg() init(config.start)
    io.o.instr.setAsReg() init(Instr.NOP)
    io.o.next_pc.setAsReg() init(0)
    io.o.next_taken.setAsReg() init(False)

    io.instr := 0

    io.o.trap.trap.setAsReg() init(False)
    io.o.trap.epc.setAsReg() init(0)
    io.o.trap.cause.setAsReg() init(0)
    io.o.trap.tval.setAsReg() init(0)

    io.trap := io.o.trap.trap
    io.o.trap.trap := io.trap

    io.wb.cyc := io.wb.stb
    io.wb.we := False
    io.wb.dat_w := 0

    io.wb.stb.setAsReg() init(False)
    io.wb.adr.setAsReg() init(0)
    io.wb.sel.setAsReg() init(0)

    io.pt.look_up_req.setAsReg() init(False)
    io.pt.look_up_addr.setAsReg() init(0)
    
    io.pt.access_type := MemAccessType.Fetch

    def bubble(): Unit = {
        io.o.real := False
        io.o.pc := 0
        io.o.instr := Instr.NOP

        io.trap := False
        io.o.trap.epc := 0
        io.o.trap.cause := 0
        io.o.trap.tval := 0
    }
    
    def trap(interrupt: Bits): Unit = {
        io.trap := True
        io.o.trap.epc := pc
        
        when (interrupt(InterruptField.MTI)) {
            io.o.trap.cause := TrapCause.MACHINE_TIMER_INTERRUPT
        } elsewhen (interrupt(InterruptField.STI)) {
            io.o.trap.cause := TrapCause.SUPERVISOR_TIMER_INTERRUPT
        } otherwise {
            io.o.trap.cause := TrapCause.UNKNOWN_INTERRUPT
        }
        io.o.trap.tval := 0
    }

    def output(instr: Bits): Unit = {
        io.o.pc := pc
        io.o.instr := instr
        io.o.next_pc := io.next_pc
        io.o.next_taken := io.next_taken
        io.instr := instr
        when (io.next_taken) {
            pc := io.next_pc
        } otherwise {
            pc := pc + 4
        }
        // Mask out delegated interrupts
        when (interrupt_masked.orR && (
            io.prv === PrivilegeMode.M && io.mie
            || io.prv === PrivilegeMode.S
            || io.prv === PrivilegeMode.U
        )) {
            trap(interrupt_masked)
        } elsewhen (interrupt_delegated.orR && (
            io.prv === PrivilegeMode.S && io.sie
            || io.prv === PrivilegeMode.U
        )) {
            trap(interrupt_delegated)
        } otherwise {
            io.trap := False
            io.o.real := True
            io.o.pc := pc
            io.o.instr := instr
            pc := pc + 4
        }
    }

    def raise_page_fault(): Unit = {
        io.trap := True
        io.o.trap.epc := pc
        io.o.trap.cause := io.pt.exception_code
        io.o.trap.tval := va.asBits
    }

    val fsm = new StateMachine {
        // Delayed branching
        when (io.br.br && io.br.pc =/= pc) {
            delay_br := True
            pc := io.br.pc
        }
        val start: State = new State with EntryPoint {
            whenIsActive {
                when (io.stall) {
                    // Pass
                } elsewhen (io.bubble) {
                    bubble()
                } otherwise {
                    bubble()
                    // Branch immediately when idle
                    when (io.br.br || delay_br) {
                        delay_br := False
                    }
                    when (page_en) {
                        goto(translate)
                    } otherwise {
                        goto(fetch)
                    }
                }
            }
        }
        val translate: State = new State {
            onEntry {
                io.pt.look_up_addr := va
                io.pt.look_up_req := True
            }
            whenIsActive {
                when (io.pt.look_up_ack) {
                    when (io.pt.look_up_valid) {
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
            onEntry {
                io.wb.stb := True
                io.wb.adr := page_en ? pa | pc
                io.wb.sel := Sel.WORD
            }
            whenIsActive {
                bubble()

                // Fetch complete
                when (io.wb.ack || delay_ack) {
                    delay_ack := False

                    // If stalled, store ack for next cycle
                    when (io.stall) {
                        delay_ack := True
                        // Store instruction and stop requesting when first acked
                        when (io.wb.ack) {
                            io.wb.stb := False
                            delay_instr := io.wb.dat_r
                        }
                    } elsewhen (io.br.br || delay_br) {
                        // Don't proceed when branching
                        delay_br := False
                        goto(start)
                    } otherwise {
                        output(delay_ack ? delay_instr | io.wb.dat_r)
                        goto(start)
                    }
                }
            }
            onExit {
                io.wb.stb := False
            }
        }
    }
}