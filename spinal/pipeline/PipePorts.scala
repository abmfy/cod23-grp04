package cod

import spinal.core._
import spinal.lib._

case class IF_ID() extends Bundle with IMasterSlave {
    val pc = Types.addr
    val instr = Types.data

    override def asMaster(): Unit = {
        out (pc, instr)
    }
}

case class ID_EXE() extends Bundle with IMasterSlave {
    val pc = Types.addr
    val reg_data_a, reg_data_b = Types.data
    val reg_addr_a, reg_addr_b, reg_addr_d = Types.reg
    val alu_op = AluOp()
    val br_type = BrType()
    val imm = Types.data
    val use_pc, use_rs2 = Bool()
    val mem_en, mem_we = Bool()
    val mem_sel = Types.sel
    val reg_we = Bool()
    val reg_sel = RegSel()

    override def asMaster(): Unit = {
        out (
            pc,
            reg_data_a, reg_data_b,
            reg_addr_a, reg_addr_b, reg_addr_d,
            alu_op,
            br_type,
            imm,
            use_pc, use_rs2,
            mem_en, mem_we,
            mem_sel,
            reg_we,
            reg_sel,
        )
    }
}

case class EXE_MEM() extends Bundle with IMasterSlave {
    val pc = Types.addr
    val reg_data_b = Types.data
    val reg_addr_d = Types.reg
    val mem_en, mem_we = Bool()
    val mem_sel = Types.sel
    val reg_we = Bool()
    val reg_sel = RegSel()
    val alu_y = Types.data

    override def asMaster(): Unit = {
        out (
            pc,
            reg_data_b,
            reg_addr_d,
            mem_en, mem_we,
            mem_sel,
            reg_we,
            reg_sel,
            alu_y,
        )
    }
}

case class MEM_WB() extends Bundle with IMasterSlave {
    val reg_we = Bool()
    val reg_addr_d = Types.reg
    val reg_data_d = Types.data

    override def asMaster(): Unit = {
        out (
            reg_we,
            reg_addr_d,
            reg_data_d,
        )
    }
}

case class BranchPorts() extends Bundle with IMasterSlave {
    val br = Bool()
    val pc = Types.addr

    override def asMaster(): Unit = {
        out (br, pc)
    }
}

case class ForwardPorts() extends Bundle with IMasterSlave {
    val we = Bool()
    val addr = Types.reg
    val data = Types.data

    override def asMaster(): Unit = {
        out (we, addr, data)
    }
}