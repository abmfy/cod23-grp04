package cod

import spinal.core._
import spinal.lib._

class EXE extends Component {
    val io = new Bundle {
        val i = slave port ID_EXE()
        val o = master port EXE_MEM()

        val br = master port BranchPorts()

        // Forwarding
        val forward = Vec(slave port ForwardPorts(), 2)

        // Hazard handling
        val stall = in Bool()
        val bubble = in Bool()
        val flush_req = out Bool()

        // Branch prediction
        val branch = out Bool()
        val branch_addr = out port Types.addr

        // Trap
        val trap = out Bool()

        // Alu
        val alu = master port AluPorts()
    }

    def bubble() = {
        io.o.real := False
        io.o.pc := 0
        io.o.csr_op := CsrOp.N
        io.o.mem_en := False
        io.o.reg_we := False

        io.trap := False
        io.o.trap.epc := 0
        io.o.trap.cause := 0
        io.o.trap.tval := 0
    }

    io.o.real.setAsReg() init(False)
    io.o.pc.setAsReg() init(0)
    io.o.reg_data_b.setAsReg() init(0)
    io.o.reg_addr_d.setAsReg() init(0)
    io.o.csr_op.setAsReg() init(CsrOp.N)
    io.o.imm.setAsReg() init(0)
    io.o.mem_en.setAsReg() init(False)
    io.o.mem_we.setAsReg() init(False)
    io.o.mem_sel.setAsReg() init(0)
    io.o.mem_unsigned.setAsReg() init(False)
    io.o.reg_we.setAsReg() init(False)
    io.o.reg_sel.setAsReg() init(RegSel.ALU)
    io.o.alu_y.setAsReg() init(0)

    io.o.trap.trap.setAsReg() init(False)
    io.o.trap.epc.setAsReg() init(0)
    io.o.trap.cause.setAsReg() init(0)
    io.o.trap.tval.setAsReg() init(0)

    io.o.trap.trap := io.trap
    io.trap := io.o.trap.trap

    val reg_a = CombInit(io.i.reg_data_a)
    val reg_b = CombInit(io.i.reg_data_b)

    // Forwarding
    io.forward.reverse.foreach { forward => 
        when (forward.we && forward.addr =/= 0) {
            when (forward.addr === io.i.reg_addr_a) {
                reg_a := forward.data
            }
            when (forward.addr === io.i.reg_addr_b) {
                reg_b := forward.data
            }
        }
    }

    io.alu.a := io.i.use_pc ? io.i.pc.asBits | (
        io.i.use_uimm ? Util.zero_extend(io.i.reg_addr_a.asBits) | reg_a
    )
    io.alu.b := io.i.use_rs2 ? reg_b | io.i.imm
    io.alu.op := io.i.alu_op

    when (io.stall) {
        // Pass
    } elsewhen (io.bubble) {
        bubble()
    } elsewhen (io.i.trap.trap) {
        io.trap := True
        io.o.trap <> io.i.trap
        io.o.real := False
    } otherwise {
        io.o.alu_y := io.alu.y

        io.o.real := io.i.real
        io.o.pc := io.i.pc
        io.o.reg_data_b := reg_b
        io.o.reg_addr_d := io.i.reg_addr_d
        io.o.csr_op := io.i.csr_op
        io.o.imm := io.i.imm
        io.o.mem_en := io.i.mem_en
        io.o.mem_we := io.i.mem_we
        io.o.mem_sel := io.i.mem_sel
        io.o.mem_unsigned := io.i.mem_unsigned
        io.o.reg_we := io.i.reg_we
        io.o.reg_sel := io.i.reg_sel
    }

    val branch = Bool()
    io.branch := branch
    io.branch_addr := (io.alu.y ^ io.alu.y(0).asBits.resized).asUInt

    import BrType._
    switch (io.i.br_type) {
        is (F) {
            branch := False
        }
        is (T) {
            branch := True
        }
        is (EQ) {
            branch := reg_a === reg_b
        }
        is (NE) {
            branch := reg_a =/= reg_b
        }
        is (LT) {
            branch := reg_a.asSInt < reg_b.asSInt
        }
        is (GE) {
            branch := reg_a.asSInt >= reg_b.asSInt
        }
        is (LTU) {
            branch := reg_a.asUInt < reg_b.asUInt
        }
        is (GEU) {
            branch := reg_a.asUInt >= reg_b.asUInt
        }
    }

    // Prediction failure
    io.br.br := branch ^ io.i.next_taken
    io.br.pc := io.i.next_taken ? (io.i.pc + 4) | (io.alu.y ^ io.alu.y(0).asBits.resized).asUInt

    io.flush_req := !io.stall && (io.br.br || io.i.csr_op =/= CsrOp.N)

    // Trapped
    when (io.i.trap.trap) {
        io.br.br := False
    }

    // Do not branch when stalled
    when (io.stall) {
        io.br.br := False
    }
}