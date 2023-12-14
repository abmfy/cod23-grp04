package cod

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

import Instr._

case class ICacheConfig (
    lineNums: Int = 8,
    dataWidth: Int = 32,
    linewordsNum: Int = 4,
    setsNum: Int = 4,
)

case class ICachePorts(
    addr_width: Int = 32,
    data_width: Int = 32,
) extends Bundle with IMasterSlave {
    val addr = UInt(addr_width bits)
    val ack = Bool()
    val data = Bits(data_width bits)
    val icache_en = Bool()
    override def asMaster(): Unit = {
        in (ack, data)
        out (addr, icache_en)
    }
}

class ICache(
    config: ICacheConfig = ICacheConfig()
) extends Component {
    val io = new Bundle {
        val toIF = slave port ICachePorts()
        val wb = master port WishbonePorts()

        val fence = in Bool()
    }
    val offsetBitsNum = log2Up(config.linewordsNum)
    val indexBitsNum = log2Up(config.lineNums)
    val tagBitsNum = config.dataWidth - offsetBitsNum - indexBitsNum - 2
    val linewordsNum = config.linewordsNum
    def getTag(addr: UInt): Bits = {
        addr(config.dataWidth - 1 downto config.dataWidth - tagBitsNum).asBits
    }
    def getOffset(addr: UInt): UInt = {
        addr(2 + offsetBitsNum - 1 downto 2)
    }
    def getIndex(addr: UInt): UInt = {
        addr(2 + offsetBitsNum + indexBitsNum - 1 downto 2 + offsetBitsNum)
    }
    def clear(): Unit = {
        for (i <- 0 until config.setsNum){
            for (j <- 0 until config.lineNums){
                caches.sets(i).set(j).valid := False
            }
        }
    }
    val caches = new CacheSets(tagBits = tagBitsNum, dataWidth = config.dataWidth, 
                                wordNums = linewordsNum, lineNums = config.lineNums, setNums = config.setsNum)
    io.wb.stb.setAsReg() init(False)
    io.wb.cyc := io.wb.stb
    // 是否命中
    val idx = getIndex(io.toIF.addr)
    val tag = getTag(io.toIF.addr).asBits
    val offset = getOffset(io.toIF.addr)
    // hits 中的每一位表示对应的组是否命中
    // 初始值为 0
    val hits = Vec(Bool , config.setsNum)
    val empty = Vec(Bool , config.setsNum)
    // val valids = Vec(Bool , config.setsNum)
    for (i <- 0 until config.setsNum){
        hits(i) := caches.sets(i).set(idx).valid && caches.sets(i).set(idx).tag === tag
        empty(i) := !caches.sets(i).set(idx).valid
        // valids(i) := caches.sets(i).set(idx).valid
    }
    // 查看是否 hits 中有 1
    val hitted = hits.asBits.orR
    // 是否有空位
    val emptyed = empty.asBits.orR
    // 获得 hits 中最高位的索引
    val hits_idx = hits(0) ? U(0, log2Up(config.setsNum) bits) | 
                    (hits(1) ? U(1, log2Up(config.setsNum) bits) | 
                    (hits(2) ? U(2, log2Up(config.setsNum) bits) |
                    (hits(3) ? U(3, log2Up(config.setsNum) bits) | U(0, log2Up(config.setsNum) bits))))
    // val empty_idx = empty(0) ? U(0, ) | (empty(1) ? U(1) | U(0))
    val empty_idx = empty(0) ? U(0, log2Up(config.setsNum) bits) | 
                    (empty(1) ? U(1, log2Up(config.setsNum) bits) | 
                    (empty(2) ? U(2, log2Up(config.setsNum) bits) |
                    (empty(3) ? U(3, log2Up(config.setsNum) bits) | U(0, log2Up(config.setsNum) bits))))
    // val set_idx = hitted ? hits_idx | (emptyed ? empty_idx | U(0))
    val set_idx = hitted ? hits_idx | (emptyed ? empty_idx | caches.getmaxcounteridx(idx))
    // val set_idx = OHToUInt(hits.asBits) + OHToUInt(valids.asBits)
    val hit = caches.sets(set_idx).set(idx).valid && caches.sets(set_idx).set(idx).tag === tag
    caches.counterUpdate(idx, hit, emptyed, set_idx)
    io.toIF.data := caches.sets(set_idx).set(idx).data(offset)
    // 16字节对齐
    val alignAddr = (io.toIF.addr(31 downto 4).asBits ## B"0000").asUInt
    var fsm = new StateMachine {
        io.wb.we := False
        io.wb.adr := 0
        io.wb.dat_w := 0
        io.wb.sel := 0
        io.toIF.ack := False
        val start: State = new State with EntryPoint {
            whenIsActive {
                when (io.fence) {
                    clear()
                } elsewhen (io.toIF.icache_en){
                    when(hit){
                        io.toIF.ack := True
                        goto(start)
                    }.otherwise{
                        goto(fetch_0)
                    }
                }
            }
        }
        val fetch_0: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.adr := alignAddr
                io.wb.we := False
                io.wb.sel := Sel.WORD
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(0) := io.wb.dat_r
                    caches.sets(set_idx).set(idx).tag := getTag(io.toIF.addr).asBits
                    caches.sets(set_idx).set(idx).valid := True
                    io.wb.stb := False
                    goto(fetch_1)
                }
            }
        }
        val fetch_1: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.adr := alignAddr + 4
                io.wb.we := False
                io.wb.sel := Sel.WORD
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(1) := io.wb.dat_r
                    goto(fetch_2)
                    io.wb.stb := False
                }
            }
        }
        val fetch_2: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.adr := alignAddr + 8
                io.wb.we := False
                io.wb.sel := Sel.WORD
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(2) := io.wb.dat_r
                    goto(fetch_3)
                    io.wb.stb := False
                }
            }
        }
        val fetch_3: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.adr := alignAddr + 12
                io.wb.we := False
                io.wb.sel := Sel.WORD
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(3) := io.wb.dat_r
                    goto(start)
                    io.wb.stb := False
                }
            }
        }

    }


}


