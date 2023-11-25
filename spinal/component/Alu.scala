package cod

import spinal.core._
import spinal.lib._

case class AluPorts(width: Int = 16) extends Bundle with IMasterSlave {
    val a = Types.data(width)
    val b = Types.data(width)
    val op = AluOp()
    val y = Types.data(width)

    override def asMaster(): Unit = {
        in (y)
        out (a, b, op)
    }
}

class Alu(width: Int = 16) extends Component {
    val io = slave port AluPorts(width)

    val s_a = io.a asSInt
    val s_b = io.b asSInt

    val high_bit = log2Up(width) - 1
    val shamt = io.b(high_bit downto 0).asUInt

    switch (io.op) {
        is (AluOp.OP1) {
            io.y := io.a
        }
        is (AluOp.ADD) {
            io.y := (s_a + s_b).asBits
        }
        is (AluOp.SUB) {
            io.y := (s_a - s_b).asBits
        }
        is (AluOp.AND) {
            io.y := io.a & io.b
        }
        is (AluOp.OR) {
            io.y := io.a | io.b
        }
        is (AluOp.XOR) {
            io.y := io.a ^ io.b
        }
        is (AluOp.NOT) {
            io.y := ~io.a
        }
        is (AluOp.SLL) {
            io.y := io.a |<< shamt
        }
        is (AluOp.SRL) {
            io.y := io.a |>> shamt
        }
        is (AluOp.SRA) {
            io.y := (s_a >> shamt).asBits
        }
        is (AluOp.ROL) {
            io.y := io.a rotateLeft shamt
        }
        is (AluOp.OP2) {
            io.y := io.b
        }
    }
}