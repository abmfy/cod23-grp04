package cod

import spinal.core._
import spinal.lib._

case class BPConfig (
    BHT_WIDTH: Int = 2,
    count: Int = 16,
    BTB_WIDTH: Int = 32,
    TAG_WIDTH: Int = 32
)
case class BranchPredictPorts() extends Bundle with IMasterSlave {
    val exe_pc = Types.addr
    val br_we = Bool()
    val br_addr = Types.addr
    val exe_instr = Types.data
    val if_instr = Types.data
    val IF_pc = Types.addr
    val next_pc = Types.addr
    val next_taken = Bool()
    override def asMaster(): Unit = {
        out (
             br_we, br_addr, exe_instr, if_instr, IF_pc,exe_pc
        )
        in (
             next_pc, next_taken
        )
    }
}


class BranchPredict(config: BPConfig = BPConfig()) extends  Component {
    val BHT_WIDTH = config.BHT_WIDTH
    val count = config.count
    val BTB_WIDTH = config.BTB_WIDTH
    val TAG_WIDTH = config.TAG_WIDTH
    val io = slave port BranchPredictPorts()

    val BTB = Vec(Reg(Types.addr(BTB_WIDTH)) init(0), count)
    // val TAG = Vec(Reg(Types.addr(TAG_WIDTH)) init(0), count)
    val BHT = Vec(Reg(Types.addr(BHT_WIDTH)) init(0), count)

    val is_IF_branch_type = io.if_instr(0, 7 bits) === B"1101111" || io.if_instr(0, 7 bits) === B"1100011"  // 不涉及加减，可以不用buffer
    val is_EXE_branch_type = io.exe_instr(0, 7 bits) === B"1101111" || io.exe_instr(0, 7 bits) === B"1100011"
    val exe_branch_type_buffer = Reg(Bool()) init(False) // 一个周期只触发一次exe的结果回传
    val if_index = io.IF_pc(5 downto 2)
    // val next_taken_reg= is_IF_branch_type  && (BHT(if_index) >= 2)
    io.next_pc := BTB(if_index)
    io.next_taken := is_IF_branch_type  && (BHT(if_index) >= 2)
    val exe_index = io.exe_pc(5 downto 2)

    when (is_EXE_branch_type && !exe_branch_type_buffer) {
      
        // TAG(exe_index) := io.exe_pc
        switch (BHT(exe_index)) {
            is (0) {
                when (io.br_we) {
                    BHT(exe_index) := U"01"
                }
            }
            is (1) {
                when (io.br_we) {
                    BHT(exe_index) := U"10"
                } otherwise {
                    BHT(exe_index) := U"00"
                }
            }
            is (2) {
                when (io.br_we && (BTB(exe_index) === io.br_addr)) { // BTB会不会已经被改掉了? BTB的含义: 当前的index对应的目的地址，所以应该不用考虑
                    BHT(exe_index) := U"11"

                } otherwise {
                    BHT(exe_index) := U"01"
                }
            }
            is (3) {
                when( !(io.br_we && (BTB(exe_index) === io.br_addr))) {
                    BHT(exe_index) := U"10"
                }
            }
        }

        BTB(exe_index) := io.br_addr
        exe_branch_type_buffer := True

    } otherwise {
        exe_branch_type_buffer := is_EXE_branch_type
    }

}