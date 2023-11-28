package cod

import spinal.core._
import spinal.core.sim._
import spinal.lib._

import Instr._
import spinal.lib.cpu.riscv.impl.RegFileReadKind

class ID extends Component {
    val io = new Bundle {
        val i = slave port IF_ID()
        val o = master port ID_EXE()

        val stall = in Bool()
        val bubble = in Bool()

        // RegFile
        val reg = master port RegFileReadPorts()
    }

    val instr = io.i.instr

    def opcode = instr(6 downto 0)
    def funct3 = instr(14 downto 12)
    def funct7 = instr(31 downto 25)
    def rs1 = instr(19 downto 15).asUInt
    def rs2 = instr(24 downto 20).asUInt
    def rd = instr(11 downto 7).asUInt

    def instr_kind: Instr.C = {
        val res = Instr.UNK.craft()
        switch (opcode) {
            is (B"0110111") {
                res := LUI
            }
            is (B"0010111") {
                res := AUIPC
            }
            is (B"1101111") {
                res := JAL
            }
            is (B"1100111") {
                res := JALR
            }
            is (B"1100011") {
                switch (funct3) {
                    is (B"000") {
                        res := BEQ
                    }
                    is (B"001") {
                        res := BNE
                    }
                }
            }
            is (B"0000011") {
                switch (funct3) {
                    is (B"000") {
                        res := LB
                    }
                    is (B"010") {
                        res := LW
                    }
                }
            }
            is (B"0100011") {
                switch (funct3) {
                    is (B"000") {
                        res := SB
                    }
                    is (B"010") {
                        res := SW
                    }
                    default {
                        res := UNK
                    }
                }
            }
            is (B"0010011") {
                switch (funct3) {
                    is (B"000") {
                        res := ADDI
                    }
                    is (B"110") {
                        res := ORI
                    }
                    is (B"111") {
                        res := ANDI
                    }
                    is (B"001") {
                        res := SLLI
                    }
                    is (B"101") {
                        res := SRLI
                    }
                }
            }
            is (B"0110011") {
                switch (funct3) {
                    is (B"000") {
                        res := ADD
                    }
                    is (B"100") {
                        res := XOR
                    }
                    is (B"110") {
                        res := OR
                    }
                    is (B"111") {
                        res := AND
                    }
                }
            }
        }
        res
    }

    def instr_type: InstrType.C = {
        import InstrType._
        val res = InstrType.I.craft()
        switch (instr_kind) {
            is (
                ADD,
                XOR,
                OR,
                AND,
            ) {
                res := R
            }
            is (
                JALR,
                ADDI,
                ORI,
                ANDI,
                SLLI,
                SRLI,
                LB,
                LW,
            ) {
                res := I
            }
            is (
                SB,
                SW,
            ) {
                res := S
            }
            is (
                BEQ,
                BNE,
            ) {
                res := B
            }
            is (
                LUI,
                AUIPC,
            ) {
                res := U
            }
            is (
                JAL,
            ) {
                res := J
            }
        }
        res
    }

    def imm: Bits = {
        import InstrType._
        val res = Types.data
        switch (instr_type) {
            is (R) {
                res := 0
            }
            is (I) {
                res := Util.sign_extend(instr(31 downto 20))
            }
            is (S) {
                res := Util.sign_extend(instr(31 downto 25) ## instr(11 downto 7))
            }
            is (B) {
                res := Util.sign_extend(
                    instr(31) ##
                    instr(7) ##
                    instr(30 downto 25) ##
                    instr(11 downto 8) ##
                    B"0"
                )
            }
            is (U) {
                res := Util.sign_extend(instr(31 downto 12) ## B"12'0")
            }
            is (J) {
                res := Util.sign_extend(
                    instr(31) ##
                    instr(19 downto 12) ##
                    instr(20) ##
                    instr(30 downto 21) ##
                    B"0"
                )
            }
        }
        res
    }

    def alu_op: AluOp.C = {
        val res = AluOp.ADD.craft()
        switch (instr_kind) {
            is (
                AUIPC,
                JAL,
                JALR,
                BEQ,
                BNE,
                LB,
                LW,
                SB,
                SW,
                ADDI,
                ADD,
            ) {
                res := AluOp.ADD
            }
            is (
                ANDI,
                AND,
            ) {
                res := AluOp.AND
            }
            is (
                ORI,
                OR,
            ) {
                res := AluOp.OR
            }
            is (
                XOR,
            ) {
                res := AluOp.XOR
            }
            is (
                SLLI,
            ) {
                res := AluOp.SLL
            }
            is (
                SRLI,
            ) {
                res := AluOp.SRL
            }
            is (
                LUI,
            ) {
                res := AluOp.OP2
            }
        }
        res
    }

    def br_type: BrType.C = {
        val res = BrType.F.craft()
        switch (instr_kind) {
            is (
                JAL,
                JALR,
            ) {
                res := BrType.T
            }
            is (
                BEQ,
            ) {
                res := BrType.EQ
            }
            is (
                BNE,
            ) {
                res := BrType.NE
            }
        }
        res
    }

    def use_pc: Bool = {
        val res = False
        switch (instr_kind) {
            is (
                AUIPC,
                JAL,
                BEQ,
                BNE,
            ) {
                res := True
            }
        }
        res
    }

    def use_rs2: Bool = {
        val res = False
        switch (instr_kind) {
            is (
                ADD,
                XOR,
                OR,
                AND,
            ) {
                res := True
            }
        }
        res
    }

    def mem_en: Bool = {
        val res = False
        switch (instr_kind) {
            is (
                LB,
                LW,
                SB,
                SW,
            ) {
                res := True
            }
        }
        res
    }

    def mem_we: Bool = {
        val res = False
        switch (instr_kind) {
            is (
                SB,
                SW,
            ) {
                res := True
            }
        }
        res
    }

    def mem_sel: Bits = {
        val res = Sel.NONE
        switch (instr_kind) {
            is (
                LB,
                SB,
            ) {
                res := Sel.BYTE
            }
            is (
                LW,
                SW,
            ) {
                res := Sel.WORD
            }
        }
        res
    }

    def reg_we: Bool = {
        val res = False
        switch (instr_kind) {
            is (
                LUI,
                AUIPC,
                JAL,
                JALR,
                LB,
                LW,
                ADDI,
                ORI,
                ANDI,
                SLLI,
                SRLI,
                ADD,
                XOR,
                OR,
                AND,
            ) {
                res := True
            }
        }
        res
    }

    def reg_sel: RegSel.C = {
        val res = RegSel.ALU.craft()
        switch (instr_kind) {
            is (
                LB,
                LW,
            ) {
                res := RegSel.MEM
            }
            is (
                JAL,
                JALR,
            ) {
                res := RegSel.PC
            }
        }
        res
    }

    def bubble() = {
        io.o.br_type := BrType.F
        io.o.mem_en := False
        io.o.reg_we := False
    }

    io.o.pc.setAsReg() init(0)
    io.o.reg_data_a.setAsReg() init(0)
    io.o.reg_data_b.setAsReg() init(0)
    io.o.reg_addr_a.setAsReg() init(0)
    io.o.reg_addr_b.setAsReg() init(0)
    io.o.reg_addr_d.setAsReg() init(0)
    io.o.alu_op.setAsReg() init(AluOp.ADD)
    io.o.br_type.setAsReg() init(BrType.F)
    io.o.imm.setAsReg() init(0)
    io.o.use_pc.setAsReg() init(False)
    io.o.use_rs2.setAsReg() init(False)
    io.o.mem_en.setAsReg() init(False)
    io.o.mem_we.setAsReg() init(False)
    io.o.mem_sel.setAsReg() init(Sel.NONE)
    io.o.reg_we.setAsReg() init(False)
    io.o.reg_sel.setAsReg() init(RegSel.ALU)

    io.reg.addr_a := rs1
    io.reg.addr_b := rs2

    when (io.stall) {
        // Pass
    } elsewhen (io.bubble) {
        bubble()
    } otherwise {
        io.o.pc := io.i.pc
        
        io.o.reg_data_a := io.reg.data_a
        io.o.reg_data_b := io.reg.data_b
        io.o.reg_addr_a := rs1
        io.o.reg_addr_b := rs2
        io.o.reg_addr_d := rd
        io.o.alu_op := alu_op
        io.o.br_type := br_type
        io.o.imm := imm
        io.o.use_pc := use_pc
        io.o.use_rs2 := use_rs2
        io.o.mem_en := mem_en
        io.o.mem_we := mem_we
        io.o.mem_sel := mem_sel
        io.o.reg_we := reg_we
        io.o.reg_sel := reg_sel
    }
}