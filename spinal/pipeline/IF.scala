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

        // ICache
        val cache = master port ICachePorts()
        
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

    // In case that branch signal is asserted as ICache is refilling
    val cache_addr = Reg(Types.addr) init(0)

    // Delayed branch signal
    val delay_br = Reg(Bool()) init(False)

    // Delayed ack signal
    val delay_ack = Reg(Bool()) init(False)
    val delay_instr = Reg(Types.data) init(Instr.NOP)
    val delay_pa = Reg(Types.addr) init(0)
    val delay_valid = Reg(Bool()) init(False)

    // Interrupt
    val interrupt = io.ie & io.ip
    val interrupt_delegated = interrupt & io.mideleg
    val interrupt_masked = interrupt & ~io.mideleg

    // Paging enabled
    val page_en = io.prv =/= PrivilegeMode.M && io.satp_mode
    val pt_addr = Reg(Types.addr) init(0)

    io.o.real.setAsReg() init(False)
    io.o.pc.setAsReg() init(config.start)
    io.o.instr.setAsReg() init(Instr.NOP)
    io.o.next_taken.setAsReg() init(False)

    io.instr := 0

    io.o.trap.trap.setAsReg() init(False)
    io.o.trap.epc.setAsReg() init(0)
    io.o.trap.cause.setAsReg() init(0)
    io.o.trap.tval.setAsReg() init(0)

    io.trap := io.o.trap.trap
    io.o.trap.trap := io.trap
    
    io.pt.access_type := MemAccessType.Fetch

    def bubble(): Unit = {
        io.o.real := False
        io.o.pc := 0
        io.o.instr := Instr.NOP

        io.o.next_taken := False

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

        io.o.real := False
    }

    def output(instr: Bits): Unit = {
        io.o.next_taken := io.next_taken
        io.instr := instr
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
            when (io.next_taken) {
                pc := io.next_pc
            } otherwise {
                pc := pc + 4
            }
        }
    }

    def raise_page_fault(): Unit = {
        io.trap := True
        io.o.trap.epc := io.pt.look_up_addr
        io.o.trap.cause := TrapCause.INSTRUCTION_PAGE_FAULT
        io.o.trap.tval := io.pt.look_up_addr.asBits

        io.o.real := False
    }

    val fsm = new StateMachine {
        io.cache.icache_en := False
        io.cache.addr := 0

        io.pt.look_up_req := False
        io.pt.look_up_addr := 0

        // Delayed branching
        when (io.br.br) {
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
                        io.pt.look_up_req := True
                        io.pt.look_up_addr := va
                        when (io.pt.tlb_hit) {
                            when (io.pt.look_up_valid) {
                                io.cache.icache_en := True
                                cache_addr := pa
                                io.cache.addr := pa
                                when (io.cache.ack) {
                                    output(io.cache.data)
                                } otherwise {
                                    goto(fetch)
                                }
                            } otherwise {
                                raise_page_fault()
                            }
                        } otherwise {
                            goto(translate)
                        }
                    } otherwise {
                        io.cache.icache_en := True
                        cache_addr := io.br.br ? io.br.pc | pc
                        io.cache.addr := io.br.br ? io.br.pc | pc
                        when (io.cache.ack) {
                            output(io.cache.data)
                        } otherwise {
                            goto(fetch)
                        }
                    }
                }
            }
        }
        val translate: State = new State {
            onEntry {
                pt_addr := va
                
                delay_ack := False
                delay_valid := False
            }
            whenIsActive {
                io.pt.look_up_req := !delay_ack
                io.pt.look_up_addr := pt_addr

                bubble()
                when (io.pt.look_up_ack || delay_ack) {
                    // If stalled, store ack for next cycle
                    when (io.stall || io.bubble) {
                        // Store physical address and stop request when first acked
                        when (!delay_ack) {
                            delay_ack := True
                            delay_valid := io.pt.look_up_valid
                            delay_pa := pa
                        }
                    } elsewhen (io.br.br || delay_br) {
                        // Don't proceed when branching
                        delay_br := False
                        goto(start)
                    } otherwise {
                        when (!delay_ack && io.pt.look_up_valid || delay_valid) {
                            io.cache.icache_en := True
                            cache_addr := page_en ? (delay_ack ? delay_pa | pa) | pc
                            io.cache.addr := page_en ? (delay_ack ? delay_pa | pa) | pc
                            when (io.cache.ack) {
                                output(io.cache.data)
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
            }
        }
        val fetch: State = new State {
            onEntry {
                delay_ack := False
            }
            whenIsActive {
                bubble()
                io.cache.icache_en := True
                io.cache.addr := cache_addr
                // Fetch complete
                when (io.cache.ack || delay_ack) {
                    // If stalled, store ack for next cycle
                    when (io.stall || io.bubble) {
                        delay_ack := True
                        // Store instruction and stop requesting when first acked
                        when (!delay_ack) {
                            delay_instr := io.cache.data
                        }
                    } elsewhen (io.br.br || delay_br) {
                        // Don't proceed when branching
                        delay_br := False
                        goto(start)
                    } otherwise {
                        output(delay_ack ? delay_instr | io.cache.data)
                        goto(start)
                    }
                }
            }
        }
    }
}