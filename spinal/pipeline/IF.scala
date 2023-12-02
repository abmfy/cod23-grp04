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
        val mie = in port Types.data
        val mip = in port Types.data

        // Privilege mode
        val prv = in port PrivilegeMode()

        // Wishbone master
        val wb = master port WishbonePorts()
    }

    val pc = Reg(Types.addr) init(config.start)

    // Delayed branch signal
    val delay_br = Reg(Bool()) init(False)

    // Delayed ack signal
    val delay_ack = Reg(Bool()) init(False)
    val delay_instr = Reg(Types.data) init(Instr.NOP)

    // Interrupt
    val interrupt = io.mie & io.mip

    io.o.real.setAsReg() init(False)
    io.o.pc.setAsReg() init(config.start)
    io.o.instr.setAsReg() init(Instr.NOP)

    io.o.trap.trap.setAsReg() init(False)
    io.o.trap.epc.setAsReg() init(0)
    io.o.trap.cause.setAsReg() init(0)

    io.trap := io.o.trap.trap
    io.o.trap.trap := io.trap

    // To break combinatorial loop
    io.wb.stb.setAsReg() init(False)
    io.wb.cyc := io.wb.stb

    def bubble(): Unit = {
        io.o.real := False
        io.o.pc := 0
        io.o.instr := Instr.NOP

        io.trap := False
        io.o.trap.epc := 0
        io.o.trap.cause := 0
    }

    def output(instr: Bits): Unit = {
        when ((io.prv !== PrivilegeMode.M) && interrupt =/= 0) {
            io.trap := True
            io.o.trap.epc := pc
            
            when (interrupt(InterruptField.MTI)) {
                io.o.trap.cause := TrapCause.MACHINE_TIMER_INTERRUPT
            } otherwise {
                io.o.trap.cause := TrapCause.UNKNOWN_INTERRUPT
            }
        } otherwise {
            io.trap := False
            io.o.real := True
            io.o.pc := pc
            io.o.instr := instr
            pc := pc + 4
        }
    }

    val fsm = new StateMachine {
        io.wb.we := False
        io.wb.adr := 0
        io.wb.dat_w := 0
        io.wb.sel := 0

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
                    goto(fetch)
                }
            }
        }
        val fetch: State = new State {
            onEntry {
                io.wb.stb := True
            }
            whenIsActive {
                bubble()
                io.wb.we := False
                io.wb.adr := pc
                io.wb.sel := Sel.WORD

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