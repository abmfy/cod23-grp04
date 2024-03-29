package cod

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

import Instr._

case class DCacheConfig (
    lineNums: Int = 8,
    dataWidth: Int = 32,
    linewordsNum: Int = 4,
    setsNum: Int = 4,
)

case class DCachePorts(
    addr_width: Int = 32,
    data_width: Int = 32,
) extends Bundle with IMasterSlave {
    val addr = UInt(addr_width bits)
    val ack = Bool()
    val data = Bits(data_width bits)
    val dcache_en = Bool()
    val dcache_we = Bool()
    val dcache_sel = Bits(4 bits)
    val data_w = Bits(data_width bits)

    override def asMaster(): Unit = {
        in (ack, data)
        out (addr, dcache_en, dcache_we, dcache_sel, data_w)
    }
}

class DCache(
    config: DCacheConfig = DCacheConfig()
) extends Component {
    val io = new Bundle {
        val toMEM = slave port DCachePorts()
        val wb = master port WishbonePorts()
    }

    io.wb.cyc := io.wb.stb
    io.wb.stb.setAsReg() init(False)
    io.wb.we.setAsReg() init(False)
    io.wb.adr.setAsReg() init(0)
    io.wb.dat_w.setAsReg() init(0)
    io.wb.sel.setAsReg() init(0)

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
    def req(): Unit = {
        io.wb.stb := True
        io.wb.we := io.toMEM.dcache_we
        io.wb.adr := io.toMEM.addr
        io.wb.sel := io.toMEM.dcache_sel
        io.wb.dat_w := io.toMEM.data_w
    }
    val caches = new CacheSets(tagBits = tagBitsNum, dataWidth = config.dataWidth, 
                                wordNums = linewordsNum, lineNums = config.lineNums, setNums = config.setsNum)

    // 是否命中
    val idx = getIndex(io.toMEM.addr)
    val tag = getTag(io.toMEM.addr).asBits
    val offset = getOffset(io.toMEM.addr)
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
    // 16字节对齐
    val alignAddr = (io.toMEM.addr(31 downto 4).asBits ## B"0000").asUInt
    // 判断读取的地址是否合法 , 必须大于等于 0x80000000 且 小于 32'h80800000
    val addrLegal = io.toMEM.addr >= U(0x80000000L, 32 bits) && io.toMEM.addr < U(0x80800000L, 32 bits)
    val addrCacheLegal = (addrLegal) && (io.toMEM.dcache_en) && !(io.toMEM.dcache_we)
    val cachedataraw = (caches.sets(set_idx).set(idx).data(offset))
    val data_sel = io.toMEM.dcache_sel
    val temp_data = Bits(32 bits)
    // 如果 sel 位为 1 ，则从 cachedataraw 中取出对应的数据，否则用 0 填充
    for (i <- 0 until 4){
        when(data_sel(i)){
            temp_data(8*(i+1)-1 downto 8*i) := cachedataraw(8*(i+1)-1 downto 8*i)
        }.otherwise{
            temp_data(8*(i+1)-1 downto 8*i) := B"8'h00"
        }
    }    
    io.toMEM.data := addrCacheLegal ? temp_data | io.wb.dat_r
    // io.toMEM.data := io.wb.dat_r
    var fsm = new StateMachine {
        io.toMEM.ack := False
        val start: State = new State with EntryPoint {
            whenIsActive {
                when(io.toMEM.dcache_en){
                    when(!io.toMEM.dcache_we){
                        // 如果进行的是读取操作
                        when(addrCacheLegal){
                            // 如果地址合法，进行正常的 Cache 操作
                            when(hit){
                                io.toMEM.ack := True
                            } otherwise {
                                goto(fetch_0)
                            }
                        } otherwise {
                            // 如果地址不合法，进行 Wishbone 操作
                            goto (wb_fetch)
                        }

                    } otherwise {
                        // 如果进行的是写入操作
                        when(hit){
                            // 如果命中，更新 Cache 中的数据，然后进行 Wishbone 操作 , 注意 sel 写入使能信号
                            // caches.sets(set_idx).set(idx).valid := False
                            for (i <- 0 until 4){
                                when(data_sel(i)){
                                    caches.sets(set_idx).set(idx).data(offset)(8*(i+1)-1 downto 8*i) := io.toMEM.data_w(8*(i+1)-1 downto 8*i)
                                }
                            }
                        }
                        // 进行 Wishbone 操作
                        goto(wb_fetch)
                    }
                    // req()
                    // goto(wb_fetch)
                }

            }
        }
        val fetch_0: State = new State {
            onEntry {
                io.wb.stb := True
                io.wb.adr := alignAddr
                io.wb.we := False
                io.wb.sel := Sel.WORD
            }
            whenIsActive {
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(0) := io.wb.dat_r
                    caches.sets(set_idx).set(idx).tag := getTag(io.toMEM.addr).asBits
                    caches.sets(set_idx).set(idx).valid := True
                    goto(fetch_1)
                }
            }
        }
        val fetch_1: State = new State {
            onEntry {
                io.wb.adr := alignAddr + 4
            }
            whenIsActive {
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(1) := io.wb.dat_r
                    goto(fetch_2)
                }
            }
        }
        val fetch_2: State = new State {
            onEntry {
                io.wb.adr := alignAddr + 8
            }
            whenIsActive {
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(2) := io.wb.dat_r
                    goto(fetch_3)
                }
            }
        }
        val fetch_3: State = new State {
            onEntry {
                io.wb.adr := alignAddr + 12
            }
            whenIsActive {
                when(io.wb.ack){
                    caches.sets(set_idx).set(idx).data(3) := io.wb.dat_r
                    goto(start)
                }
            }
            onExit {
                io.wb.stb := False
            }
        }
        val wb_fetch: State = new State {
            onEntry {
                req()
            }
            whenIsActive {
                when (io.wb.ack) {
                    io.toMEM.ack := True
                    goto(start)
                }
            }
            onExit {
                io.wb.stb := False
            }
        }
    }


}


