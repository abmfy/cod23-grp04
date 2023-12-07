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

    def csr = UInt(12 bits)

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

object CsrOp extends SpinalEnum {
    val N, W, S, C = newElement()
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
        SRA,
        OR,
        AND,
        ECALL,
        EBREAK,
        // sfence.vma
        SFENCE_VMA,
        // Zifencei
        FENCE_I,
        // Zicsr,
        CSRRW,
        CSRRS,
        CSRRC,
        CSRRWI,
        CSRRSI,
        CSRRCI,
        // Trap-Return
        MRET,
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

object MemAccessType extends SpinalEnum {
    val Store, Read, Instruction = newElement()
}

object PrivilegeMode extends SpinalEnum {
    val U, S, M = newElement()
    defaultEncoding = SpinalEnumEncoding("staticEncoding")(
        U -> 0,
        S -> 1,
        M -> 3,
    )
}

object TrapVectorMode {
    val DIRECT = 0
    val VECTORED = 1
}

object InterruptField {
    val SSI = 1
    val MSI = 3
    val STI = 5
    val MTI = 7
    val SEI = 9
    val MEI = 11
}

object TrapCause {
    val INTERRUPT = 1L << 31
    val EXCEPTION = 0L << 31

    val MACHINE_TIMER_INTERRUPT = INTERRUPT | 7
    val UNKNOWN_INTERRUPT = INTERRUPT | 16

    val BREAKPOINT = EXCEPTION | 3
    val ENVIRONMENT_CALL_FROM_U_MODE = EXCEPTION | 8
    val RETURN_FROM_M_MODE = EXCEPTION | 24
    val INSTRUCTION_PAGE_FAULT = EXCEPTION | 12
    val LOAD_PAGE_FAULT = EXCEPTION | 13
    val STORE_PAGE_FAULT = EXCEPTION | 15
}