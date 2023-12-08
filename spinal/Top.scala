package cod
import cod.sim._

import spinal.core._
import spinal.lib._
import spinal.lib.io._
import java.io.ObjectInputFilter.Status

class Top (
    simulation: Boolean = false,
    base_sram_init: Option[String] = None,
    ext_sram_init: Option[String] = None,
) extends ThinPadTop {
    // Components
    val reg_file = new RegFile
    val alu = new Alu
    val csr = new CsrFile
    val trap = new Trap
    val timer = new Timer
    val IF_page_table = new PageTable
    val MEM_page_table = new PageTable    

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

    If.io.br.br := trap.io.br.br || Exe.io.br.br
    If.io.br.pc := trap.io.br.br ? trap.io.br.pc | Exe.io.br.pc

    If.io.stall := !trap.io.flush_req(0) && !Exe.io.flush_req && Mem.io.stall_req
    If.io.bubble := trap.io.flush_req(0) || Exe.io.flush_req

    If.io.mie := csr.io.mie.r
    If.io.mip := csr.io.mip.r

    If.io.prv := trap.io.prv
    If.io.satp_mode := csr.io.satp.r.msb
    
    If.io.pt <> IF_page_table.trans_io

    IF_page_table.io.satp := csr.io.satp.r
    IF_page_table.io.privilege_mode := trap.io.prv
    IF_page_table.io.mstatus_SUM := csr.io.mstatus.r(StatusField.SUM)
    IF_page_table.io.mstatus_MXR := csr.io.mstatus.r(StatusField.MXR)

    // ID
    Id.io.reg <> reg_file.io.r

    Id.io.stall := !trap.io.flush_req(1) && !Exe.io.flush_req && Mem.io.stall_req
    Id.io.bubble := trap.io.flush_req(1) || Exe.io.flush_req

    trap.io.trap(0) := Id.io.trap

    // EXE
    Exe.io.alu <> alu.io

    Exe.io.forward(0) <> Mem.io.forward
    Exe.io.forward(1) <> Wb.io.forward

    Exe.io.stall := Mem.io.stall_req
    Exe.io.bubble := trap.io.flush_req(2)

    trap.io.trap(1) := Exe.io.trap

    // MEM
    Mem.io.csr <> csr.io.csr

    trap.io.trap(2) := Mem.io.trap

    Mem.io.timer <> timer.io.timer

    Mem.io.prv := trap.io.prv
    Mem.io.satp_mode := csr.io.satp.r.msb

    Mem.io.pt <> MEM_page_table.trans_io

    MEM_page_table.io.satp := csr.io.satp.r
    MEM_page_table.io.privilege_mode := trap.io.prv
    MEM_page_table.io.mstatus_SUM := csr.io.mstatus.r(StatusField.SUM)
    MEM_page_table.io.mstatus_MXR := csr.io.mstatus.r(StatusField.MXR)

    // WB
    Wb.io.reg <> reg_file.io.w

    Wb.io.trap_commit <> trap.io.commit

    // Trap
    trap.io.mstatus <> csr.io.mstatus
    trap.io.mtvec <> csr.io.mtvec
    trap.io.mepc <> csr.io.mepc
    trap.io.mcause <> csr.io.mcause

    // Csr
    csr.io.time.we := False
    csr.io.time.w := 0

    csr.io.timeh.we := False
    csr.io.timeh.w := 0

    csr.io.mscratch.we := False
    csr.io.mscratch.w := 0

    csr.io.mip.we := False
    csr.io.mip.w := 0

    csr.io.mie.we := False
    csr.io.mie.w := 0

    csr.io.satp.we := False
    csr.io.satp.w := 0

    csr.io.timer := timer.io.time
    csr.io.timeout := timer.io.timeout

    // Wishbone IO
    val muxes = List.fill(4)(new WbMux(WbMuxConfig(
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
    )))
    val arbiters = List.fill(3)(new WbArbiter(WbArbiterConfig(
        master_count = 4
    )))
    for ((mux, i) <- muxes.zipWithIndex;
         (arbiter, j) <- arbiters.zipWithIndex) {
        mux.io.slaves(j) <> arbiter.io.masters(i)
    }

    // Masters
    muxes(0).io.wb <> MEM_page_table.wb
    muxes(1).io.wb <> Mem.io.wb
    muxes(2).io.wb <> IF_page_table.wb
    muxes(3).io.wb <> If.io.wb

    // Slaves
    val (base_ram, ext_ram) = if (simulation) {
        val base = new SramModel(SramModelConfig(init_file = base_sram_init))
        base.io.sram <> io.base_ram
        base.io.wb <> arbiters(0).io.wb

        val ext = new SramModel(SramModelConfig(init_file = ext_sram_init))
        ext.io.sram <> io.ext_ram
        ext.io.wb <> arbiters(1).io.wb

        (base, ext)
    } else {
        val base = new SramController
        base.io.sram <> io.base_ram
        base.io.wb <> arbiters(0).io.wb

        val ext = new SramController
        ext.io.sram <> io.ext_ram
        ext.io.wb <> arbiters(1).io.wb

        (base, ext)
    }
    val uart = new UartController(UartControllerConfig(
        clk_freq = if (simulation) 100000000 else ClockDomain.current.frequency.getValue.toInt,
        baud = if (simulation) 10000000 else 115200,
    ))
    uart.io.uart <> io.uart0
    uart.io.wb <> arbiters(2).io.wb
}

object Generate extends App {
    Config.spinal.generate(InOutWrapper(new Top)).printPruned()
}