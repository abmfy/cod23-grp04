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

    def sel = UInt(4 bits)

    val NONE = B"0000"
    val BYTE = B"0001"
    val HALF = B"0011"
    val WORD = B"1111"
}

object AluOp extends SpinalEnum {
    val OP1, ADD, SUB, AND, OR, XOR, NOT, SLL, SRL, SRA, ROL, OP2 = newElement()
}