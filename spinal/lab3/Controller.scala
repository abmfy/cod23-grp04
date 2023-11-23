package cod.lab3
import cod._

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

class Controller(width: Int = 16) extends Component {
    val io = new Bundle {
        val reg_file = master port RegFilePorts()
        val alu = master port AluPorts()

        val step = in Bool()
        val dip_sw = in port Types.data
        val leds = out port Types.data(width)
    }

    io.reg_file.raddr_a.setAsReg
    io.reg_file.raddr_b.setAsReg
    io.reg_file.waddr.setAsReg
    io.reg_file.wdata.setAsReg
    io.reg_file.we.setAsReg init(False)

    io.alu.a.setAsReg
    io.alu.b.setAsReg
    io.alu.op.setAsReg

    io.leds.setAsReg

    val inst_reg = Reg(Types.data) init(0)

    val instr = new Area {
        val is_rtype = inst_reg(2 downto 0) === B"001"
        val is_itype = inst_reg(2 downto 0) === B"010"
        val is_peek = is_itype && inst_reg(6 downto 3) === B"0010"
        val is_poke = is_itype && inst_reg(6 downto 3) === B"0001"

        val imm = inst_reg(31 downto 16) asBits
        val rd = inst_reg(11 downto 7) asUInt
        val rs1 = inst_reg(19 downto 15) asUInt
        val rs2 = inst_reg(24 downto 20) asUInt
        val opcode = AluOp()
        opcode.assignFromBits(inst_reg(6 downto 3))
    }

    val fsm = new StateMachine {
        val init: State = new State with EntryPoint {
            whenIsActive {
                io.reg_file.we := False
                when (io.step) {
                    inst_reg := io.dip_sw
                    goto(decode)
                }
            }
        }
        val decode: State = new State {
            whenIsActive {
                when (instr.is_rtype) {
                    io.reg_file.raddr_a := instr.rs1
                    io.reg_file.raddr_b := instr.rs2
                    goto(calc)
                } elsewhen (instr.is_peek) {
                    io.reg_file.raddr_a := instr.rd
                    goto(read_reg)
                } elsewhen (instr.is_poke) {
                    goto(write_reg)
                } otherwise {
                    exit()
                }
            }
        }
        val calc: State = new State {
            whenIsActive {
                io.alu.a := io.reg_file.rdata_a
                io.alu.b := io.reg_file.rdata_b
                io.alu.op := instr.opcode
                goto(write_reg)
            }
        }
        val read_reg: State = new State {
            whenIsActive {
                io.leds := io.reg_file.rdata_a
                exit()
            }
        }
        val write_reg: State = new State {
            whenIsActive {
                io.reg_file.we.set
                io.reg_file.waddr := instr.rd
                io.reg_file.wdata := instr.is_rtype ? io.alu.y | instr.imm.asBits
                exit()
            }
        }
    }
}