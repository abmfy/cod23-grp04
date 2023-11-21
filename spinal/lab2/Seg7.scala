package cod.lab2

import spinal.core._

class Seg7 extends BlackBox {
    val io = new Bundle {
        val iDIG = in UInt(4 bits)
        val oSEG1 = out Bits(8 bits)
    }
    noIoPrefix()
    setBlackBoxName("SEG7_LUT")
    addRTLPath("thinpad_top.srcs/sources_1/new/SEG7_LUT.v")
}