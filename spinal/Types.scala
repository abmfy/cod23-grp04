package cod

import spinal.core._

// Factory of common types
object Types {
    def data() = Bits(32 bits)
    def data(width: Int) = Bits(width bits)
    
    def addr() = UInt(32 bits)
    def addr(width: Int) = UInt(width bits)

    def opcode = Bits(7 bits)
    def funct3 = Bits(3 bits)
    def funct7 = Bits(7 bits)

    def reg() = UInt(5 bits)
    def reg(width: Int) = UInt(width bits)

    def sel = Bits(4 bits)
}

object Sel {
    def NONE = B"0000"
    def BYTE = B"0001"
    def HALF = B"0011"
    def WORD = B"1111"
}

object RegSel extends SpinalEnum {
    val ALU, MEM, PC = newElement()
}

object BrType extends SpinalEnum {
    val F, T, EQ, NE, LT, GE, LTU, GEU = newElement()
}

object AluOp extends SpinalEnum {
    val OP1,
        ADD,
        SUB,
        AND,
        OR,
        XOR,
        NOT,
        SLL,
        SRL,
        SRA,
        ROL,
        SLT,
        SLTU,
        OP2,
        ANDN,
        CLZ,
        PACK = newElement()
}

object Instr extends SpinalEnum {
    val UNK, 
        LUI,
        AUIPC,
        JAL,
        JALR,
        BEQ,
        BNE,
        BLT,
        BGE,
        BLTU,
        BGEU,
        LB,
        LH,
        LW,
        LBU,
        LHU,
        SB,
        SH,
        SW,
        ADDI,
        SLTI,
        SLTIU,
        XORI,
        ORI,
        ANDI,
        SLLI,
        SRLI,
        SRAI,
        ADD,
        SUB,
        SLL,
        SLT,
        SLTU,
        XOR,
        SRL,
        OR,
        AND,
        // Extra
        ANDN,
        CLZ,
        PACK
        = newElement()

    val NOP = 0x13
}

object InstrType extends SpinalEnum {
    val R, I, S, B, U, J = newElement()
}