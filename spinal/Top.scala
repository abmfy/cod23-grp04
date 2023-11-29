package cod
import cod.sim._

import spinal.core._
import spinal.lib._
import spinal.lib.io._

class Top (
    simulation: Boolean = false,
    base_sram_init: Option[String] = None,
    ext_sram_init: Option[String] = None,
) extends ThinPadTop {
    // Components
    val reg_file = new RegFile
    val alu = new Alu
    
    // Pipelines
    val If = new IF
    val Id = new ID
    val Exe = new EXE
    val Mem = new MEM
    val Wb = new WB

    If.io.o <> Id.io.i
    Id.io.o <> Exe.io.i
    Exe.io.o <> Mem.io.i
    Mem.io.o <> Wb.io.i

    // IF
    val seg_l, seg_h = new Seg7
    seg_l.io.iDIG := If.io.o.pc(0, 4 bits)
    seg_h.io.iDIG := If.io.o.pc(4, 4 bits)
    io.gpio.dpy0 := seg_l.io.oSEG1
    io.gpio.dpy1 := seg_h.io.oSEG1

    io.gpio.leds := If.io.o.instr.resized

    If.io.br <> Exe.io.br

    If.io.stall := !Exe.io.flush_req && Mem.io.stall_req
    If.io.bubble := Exe.io.flush_req

    // ID
    Id.io.reg <> reg_file.io.r

    Id.io.stall := Exe.io.flush_req && Mem.io.stall_req
    Id.io.bubble := Exe.io.flush_req

    // EXE
    Exe.io.alu <> alu.io

    Exe.io.forward(0) <> Mem.io.forward
    Exe.io.forward(1) <> Wb.io.forward

    Exe.io.stall := Mem.io.stall_req

    // WB
    Wb.io.reg <> reg_file.io.w

    // Wishbone IO
    val arbiter = new WbArbiter(WbArbiterConfig(master_count = 2))
    val mux = new WbMux(WbMuxConfig(
        slave_count = 3,
        slave_addr = List(
            0x80000000L,
            0x80400000L,
            0x10000000L,
        ),
        slave_addr_mask = List(
            0xffc00000L,
            0xffc00000L,
            0xffff0000L,
        ),
    ))
    arbiter.io.wb <> mux.io.wb

    // Masters
    arbiter.io.masters(0) <> Mem.io.wb
    arbiter.io.masters(1) <> If.io.wb

    // Slaves
    val (base_ram, ext_ram) = if (simulation) {
        val base = new SramModel(SramModelConfig(init_file = base_sram_init))
        base.io.sram <> io.base_ram
        base.io.wb <> mux.io.slaves(0)

        val ext = new SramModel(SramModelConfig(init_file = ext_sram_init))
        ext.io.sram <> io.ext_ram
        ext.io.wb <> mux.io.slaves(1)

        (base, ext)
    } else {
        val base = new SramController
        base.io.sram <> io.base_ram
        base.io.wb <> mux.io.slaves(0)

        val ext = new SramController
        ext.io.sram <> io.ext_ram
        ext.io.wb <> mux.io.slaves(1)

        (base, ext)
    }
    val uart = new UartController
    uart.io.uart <> io.uart0
    uart.io.wb <> mux.io.slaves(2)
}

object Generate extends App {
    Config.spinal.generate(InOutWrapper(new Top)).printPruned()
}