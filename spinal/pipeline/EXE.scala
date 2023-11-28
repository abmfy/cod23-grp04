package cod

import spinal.core._
import spinal.lib._

class EXE extends Component {
    val io = new Bundle {
        val i = slave port ID_EXE()
        val o = master port EXE_MEM()

        val br = master port BranchPorts()

        // Forwarding
        val forward = slave port ForwardPorts()

        // Hazard handling
        val stall = in Bool()
        val flush_req = out Bool()

        // Alu
        val alu = master port AluPorts()
    }

    io.o.pc.setAsReg() init(0)
    io.o.reg_data_b.setAsReg() init(0)
    io.o.reg_addr_d.setAsReg() init(0)
    io.o.mem_en.setAsReg() init(False)
    io.o.mem_we.setAsReg() init(False)
    io.o.mem_sel.setAsReg() init(0)
    io.o.reg_we.setAsReg() init(False)
    io.o.reg_sel.setAsReg() init(RegSel.ALU)
    io.o.alu_y.setAsReg() init(0)

    val reg_a = CombInit(io.i.reg_data_a)
    val reg_b = CombInit(io.i.reg_data_b)

    // Forwarding
    when (io.forward.we && io.forward.addr =/= 0) {
        when (io.forward.addr === io.i.reg_addr_a) {
            reg_a := io.forward.data
        }
        when (io.forward.addr === io.i.reg_addr_b) {
            reg_b := io.forward.data
        }
    }

    io.alu.a := io.i.use_pc ? io.i.pc.asBits | reg_a
    io.alu.b := io.i.use_rs2 ? reg_b | io.i.imm
    io.alu.op := io.i.alu_op

    when (io.stall) {
        // Pass
    } otherwise {
        io.o.alu_y := io.alu.y

        io.o.pc := io.i.pc
        io.o.reg_data_b := reg_b
        io.o.reg_addr_d := io.i.reg_addr_d
        io.o.mem_en := io.i.mem_en
        io.o.mem_we := io.i.mem_we
        io.o.mem_sel := io.i.mem_sel
        io.o.reg_we := io.i.reg_we
        io.o.reg_sel := io.i.reg_sel
    }

    io.br.pc := (io.alu.y ^ io.alu.y(0).asBits.resized).asUInt

    import BrType._
    switch (io.i.br_type) {
        is (F) {
            io.br.br := False
        }
        is (T) {
            io.br.br := True
        }
        is (EQ) {
            io.br.br := reg_a === reg_b
        }
        is (NE) {
            io.br.br := reg_a =/= reg_b
        }
    }

    io.flush_req := io.br.br
}