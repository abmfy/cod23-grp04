package cod

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

import Instr._
import spinal.lib.cpu.riscv.impl.RegFileReadKind

// 定义缓存条目
case class CacheLine(
    tagBits: Int = 25,
    dataWidth: Int = 32,
    wordNums: Int = 4,
    setNums: Int = 4
) extends Bundle {
  val valid = Reg(Bool) init(False)
  val tag = Reg(Bits(tagBits bits)) init(0)
  val data = Vec(Reg(Bits(dataWidth bits)) init(0) allowUnsetRegToAvoidLatch, wordNums)
  val counter = Reg(UInt(log2Up(setNums) bits)) init(0)
}

// 定义缓存组
case class CacheSet(
    tagBits: Int = 25,
    dataWidth: Int = 32,
    wordNums: Int = 4,
    lineNums: Int = 8,
    setNums: Int = 4
) extends Bundle {
  val set = Vec(CacheLine(tagBits, dataWidth, wordNums, setNums), lineNums)
}

// 定义缓存
case class CacheSets(
    tagBits: Int = 25,
    dataWidth: Int = 32,
    wordNums: Int = 4,
    lineNums: Int = 8,
    setNums: Int = 4
) extends Bundle {

    val sets = Vec(CacheSet(tagBits, dataWidth, wordNums, lineNums, setNums), setNums)

    def counterUpdate(lineIdx: UInt, hitted: Bool, fillempty: Bool, setIdx: UInt): Unit = {
        when (fillempty) {
            sets(setIdx).set(lineIdx).counter := U(0, log2Up(setNums) bits)
            for (i<-0 until setNums) {
                when (sets(i).set(lineIdx).valid===True && i=/=lineIdx){
                    sets(i).set(lineIdx).counter := sets(i).set(lineIdx).counter + 1
                }
            }
        } elsewhen (hitted) {
            sets(setIdx).set(lineIdx).counter := U(0, log2Up(setNums) bits)
            val temp = sets(setIdx).set(lineIdx).counter
            for (i<-0 until setNums) {
                when (sets(i).set(lineIdx).valid===True && i=/=lineIdx ){
                    // 如果其他行的counter小于当前行的counter，则加1
                    when (sets(i).set(lineIdx).counter < temp) {
                        sets(i).set(lineIdx).counter := sets(i).set(lineIdx).counter + 1
                    }
                }
            }
        } otherwise {
            // 此时选择了 setIdx 的 set 的 lineIdx 行进行替换，所以其他行的 counter 都要加1，而 setIdx 的 set 的 lineIdx 行的 counter 要置0
            for (i<-0 until setNums) {
                when(i=/=setIdx){
                    sets(i).set(lineIdx).counter := sets(i).set(lineIdx).counter + 1
                } otherwise {
                    sets(i).set(lineIdx).counter := U(0, log2Up(setNums) bits)
                }
            }
        }
    }
    def getmaxcounteridx(lineIdx: UInt): UInt = {
        val temp = Vec(UInt(log2Up(setNums) bits), setNums)
        for (i <- 0 until setNums) {
            temp(i) := sets(i).set(lineIdx).counter
        }
        val max01 = (temp(0) > temp(1)) ? U(0, log2Up(setNums) bits) | U(1, log2Up(setNums) bits)
        val max23 = (temp(2) > temp(3)) ? U(2, log2Up(setNums) bits) | U(3, log2Up(setNums) bits)
        val max0123 = (temp(max01) > temp(max23)) ? max01 | max23
        return max01
    }
}

