package cod

import spinal.core._

object Util {
    def zero_extend(data: Bits): Bits = {
        data.resize(32 bits)
    }
    
    def zero_extend(data: Bits, sel: Bits): Bits = {
        val res = B"32'0"
        // Expanded due to Spinal's constraints on bit width
        switch (sel) {
            is (Sel.BYTE) {
                res := data(0, 8 bits).resized
            }
            is (Sel.HALF) {
                res := data(0, 16 bits).resized
            }
            is (Sel.WORD) {
                res := data(0, 32 bits).resized
            }
        }
        res
    }

    def sign_extend(data: Bits): Bits = {
        data.asSInt.resize(32 bits).asBits
    }

    def sign_extend(data: Bits, sel: Bits): Bits = {
        val res = B"32'0"
        // Expanded due to Spinal's constraints on bit width
        switch (sel) {
            is (Sel.BYTE) {
                res := data(0, 8 bits).asSInt.resize(32 bits).asBits
            }
            is (Sel.HALF) {
                res := data(0, 16 bits).asSInt.resize(32 bits).asBits
            }
            is (Sel.WORD) {
                res := data(0, 32 bits).asSInt.resize(32 bits).asBits
            }
        }
        res
    }
}