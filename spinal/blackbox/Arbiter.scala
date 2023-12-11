package cod

import spinal.core._

case class ArbiterConfig (
    ports: Int = 4,
    // Select round robin arbitration
    arb_type_round_robin: Boolean = false,
    // Blocking arbiter enable
    arb_block: Boolean = false,
    // Block on acknowledge assert when nonzero, request deassert when 0
    arb_block_ack: Boolean = true,
    // LSB priority selection
    arb_lsb_high_priority: Boolean = false,
)

class Arbiter (
    config: ArbiterConfig = ArbiterConfig(),
) extends BlackBox {
    val generic = new Generic {
        val PORTS = config.ports
        val ARB_TYPE_ROUND_ROBIN = config.arb_type_round_robin
        val ARB_BLOCK = config.arb_block
        val ARB_BLOCK_ACK = config.arb_block_ack
        val ARB_LSB_HIGH_PRIORITY = config.arb_lsb_high_priority
    }

    val io = new Bundle {
        val clk, rst = in Bool()

        val request, acknowledge = in Bits(config.ports bits)

        val grant = out Bits(config.ports bits)
        val grant_valid = out Bool()
        val grant_encoded = out UInt(log2Up(config.ports) bits) allowPruning()
    }

    noIoPrefix()
    mapClockDomain(clock = io.clk, reset = io.rst)
    setBlackBoxName("arbiter")
    addRTLPath("thinpad_top.srcs/sources_1/new/common/arbiter.v")
    addRTLPath("thinpad_top.srcs/sources_1/new/common/priority_encoder.v")
}