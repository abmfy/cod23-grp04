// Adapted from https://github.com/alexforencich/verilog-wishbone/blob/master/rtl/wb_ram.v
// ... with modifications and Spinal tricks

/*

Copyright (c) 2015-2016 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

package cod.sim
import cod._

import spinal.core._
import spinal.lib._

import scala.collection.mutable.ArrayBuffer
import java.nio.file.Files
import java.nio.file.Paths

case class SramModelConfig (
    // Width of data bus in bits (8, 16, 32, or 64)
    data_width: Int = 32,
    // Width of address bus in bits
    addr_width: Int = 22,
    // Initial content
    init_file: Option[String] = None,
) {
    // Width of word select bus (1, 2, 4, 8)
    val select_width = data_width / 8
}

class SramModel(
    config: SramModelConfig = SramModelConfig()
) extends Component {
    val io = slave port WishbonePorts()

    val DATA_WIDTH = config.data_width
    val ADDR_WIDTH = config.addr_width
    val SELECT_WIDTH = config.select_width

    // For interfaces that are more than one word wide, disable address lines
    val VALID_ADDR_WIDTH = ADDR_WIDTH - log2Up(SELECT_WIDTH)
    // Width of data port in words (1, 2, 4, or 8)
    val WORD_WIDTH = SELECT_WIDTH
    // Size of words (8, 16, 32, or 64 bits)
    val WORD_SIZE = DATA_WIDTH / WORD_WIDTH

    val dat_o_reg = Reg(Bits(DATA_WIDTH bits)) init(0)
    val ack_o_reg = Reg(Bool()) init(False)

    val mem = Mem(Bits(DATA_WIDTH bits), 1 << VALID_ADDR_WIDTH)

    val adr_i_valid = (io.adr >> (ADDR_WIDTH - VALID_ADDR_WIDTH)).resized

    io.dat_r := dat_o_reg
    io.ack := ack_o_reg

    val init_content = config.init_file match {
        case Some(filename) => {
            val buffer = ArrayBuffer.fill(1 << VALID_ADDR_WIDTH)(B(0, DATA_WIDTH bits))
            val bytes = Files.readAllBytes(Paths.get(filename))
            for (i <- 0 until bytes.length by WORD_WIDTH) {
                val word = B(0, DATA_WIDTH bits)
                for (j <- 0 until WORD_WIDTH) {
                    if (i + j < bytes.length) {
                        word(j * 8, 8 bits) := B(bytes(i + j))
                    }
                }
                buffer(i) = word
            }
            buffer.toArray
        }
        case None => {
            Array.fill(1 << VALID_ADDR_WIDTH)(B(0, DATA_WIDTH bits))
        }
    }

    mem.init(init_content)

    ack_o_reg := False

    when (io.cyc && io.stb && !io.ack) {
        dat_o_reg := mem.readWriteSync(
            address = adr_i_valid,
            data = io.dat_w,
            enable = True,
            write = io.we,
            mask = io.sel,
        )
        ack_o_reg := True
    }
}