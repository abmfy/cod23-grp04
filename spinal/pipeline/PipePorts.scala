package cod

import spinal.core._
import spinal.lib._

case class IF_ID() extends Bundle with IMasterSlave {
    val real = Bool() allowPruning()
    val pc = Types.addr
    val instr = Types.data
    val next_taken = Bool()
    val next_pc = Types.addr

    val trap = TrapPorts()

    override def asMaster(): Unit = {
        out (real, pc, instr, next_taken, next_pc)
        master (trap)
    }
}

case class ID_EXE() extends Bundle with IMasterSlave {
    val real = Bool() allowPruning()
    val pc = Types.addr
    val reg_data_a, reg_data_b = Types.data
    val reg_addr_a, reg_addr_b, reg_addr_d = Types.reg
    val alu_op = AluOp()
    val csr_op = CsrOp()
    val br_type = BrType()
    val imm = Types.data
    val use_pc, use_uimm, use_rs2 = Bool()
    val mem_en, mem_we = Bool()
    val mem_sel = Types.sel
    val mem_unsigned = Bool()
    val reg_we = Bool()
    val reg_sel = RegSel()
    val next_taken = Bool()
    val next_pc = Types.addr
    
    val trap = TrapPorts()

    override def asMaster(): Unit = {
        out (
            real,
            pc,
            reg_data_a, reg_data_b,
            reg_addr_a, reg_addr_b, reg_addr_d,
            alu_op,
            csr_op,
            br_type,
            imm,
            use_pc, use_uimm, use_rs2,
            mem_en, mem_we,
            mem_sel,
            mem_unsigned,
            reg_we,
            reg_sel,
            next_taken,
            next_pc,
        )
        master(trap)
    }
}

case class EXE_MEM() extends Bundle with IMasterSlave {
    val real = Bool() allowPruning()
    val pc = Types.addr
    val reg_data_b = Types.data
    val reg_addr_d = Types.reg
    val csr_op = CsrOp()
    val imm = Types.data
    val mem_en, mem_we = Bool()
    val mem_sel = Types.sel
    val mem_unsigned = Bool()
    val reg_we = Bool()
    val reg_sel = RegSel()
    val alu_y = Types.data

    val trap = TrapPorts()

    override def asMaster(): Unit = {
        out (
            real,
            pc,
            reg_data_b,
            reg_addr_d,
            csr_op,
            imm,
            mem_en, mem_we,
            mem_sel,
            mem_unsigned,
            reg_we,
            reg_sel,
            alu_y,
        )
        master(trap)
    }
}

case class MEM_WB() extends Bundle with IMasterSlave {
    val real = Bool() allowPruning()
    val pc = Types.addr allowPruning()
    val reg_we = Bool()
    val reg_addr_d = Types.reg
    val reg_data_d = Types.data

    val trap = TrapPorts()

    override def asMaster(): Unit = {
        out (
            real,
            pc,
            reg_we,
            reg_addr_d,
            reg_data_d,
        )
        master(trap)
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

case class TrapPorts() extends Bundle with IMasterSlave {
    val trap = Bool()

    val epc = Types.addr
    val cause = Types.data
    val tval = Types.data

    override def asMaster(): Unit = {
        out (trap, epc, cause, tval)
    }
}