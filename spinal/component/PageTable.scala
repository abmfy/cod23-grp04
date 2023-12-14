package cod

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

case class PageTableConfig (
    PPN_LENGTH: Int = 22,
    LEVELS: Int = 2, // 二级页表
    PAGE_SIZE: Int = 0x1000,
    PTE_SIZE: Int = 4,
)

case class TLBEntry() extends Bundle {
    val valid = Reg(Bool()) init(False)
    val vpn = Reg(UInt(20 bits)) init(0)
    val pte = Reg(Bits(32 bits)) init(0)
}

case class PageTableTranslatePorts() extends Bundle with IMasterSlave {
    // virtual address
    val look_up_addr = Types.addr
    val look_up_req = Bool()
    val access_type = MemAccessType()
    val physical_addr = Types.addr
    val look_up_ack = Bool()
    val look_up_valid = Bool() // 是否发生异常
    val tlb_hit = Bool()
    // exception signal
    val exception_code = Types.data
    override def asMaster(): Unit = {
        in (
            physical_addr, look_up_ack, look_up_valid, tlb_hit,
            exception_code,
        )
        out (
            look_up_addr, look_up_req,
            access_type,
        )
    }
}

case class PageTablePorts() extends Bundle with IMasterSlave { 
    // satp
    val satp = Types.data

    // privilege status
    val privilege_mode = PrivilegeMode()

    // mstatus state
    val mstatus_SUM = Bool() // 0: S-mode memory access by U-mode will fault if va is in effect
    val mstatus_MXR = Bool() // 0: only load from r=1; 1: only load from r or x = 1

    val clear_tlb = Bool() // clear TLB
    // physical address
    def asMaster(): Unit = {
        out(
            satp,
            privilege_mode,
            mstatus_MXR, mstatus_SUM,
            clear_tlb,
        )
    }
}

class PageTable(config: PageTableConfig = PageTableConfig()) extends Component {
    val io = slave port PageTablePorts()
    val trans_io = slave port PageTableTranslatePorts()
    val wb = master port WishbonePorts()

    val satp_ppn = io.satp(0, config.PPN_LENGTH bits).asUInt
    val va_vpn = Vec(Types.addr(10), 2) // va.vpn
    va_vpn(1) := trans_io.look_up_addr(22, 10 bits)
    va_vpn(0) := trans_io.look_up_addr(12, 10 bits)
    // ADD TLB 64 entries full associative
    val TLBTable = Vec(TLBEntry() , 64) 

    val TLBIndex  = trans_io.look_up_addr(12, 6 bits)

    def raise_page_fault() {
        trans_io.look_up_ack := True
        trans_io.look_up_valid := False
        switch (trans_io.access_type) {
            is (MemAccessType.Load) {
                trans_io.exception_code := TrapCause.LOAD_PAGE_FAULT
            }
            is (MemAccessType.Store) {
                trans_io.exception_code := TrapCause.STORE_AMO_PAGE_FAULT
            }
            is (MemAccessType.Fetch) {
                trans_io.exception_code := TrapCause.INSTRUCTION_PAGE_FAULT
            }
        }
    }

    // Very good function name, love from RISC-V spec
    def a(ppn: UInt, i: UInt) = {
        (ppn * config.PAGE_SIZE + va_vpn(i) * config.PTE_SIZE).resized
    }

    def TLBEntryValid(i: UInt) :Bool = {
        TLBTable(i).valid && TLBTable(i).vpn === trans_io.look_up_addr(12, 20 bits)
    }

    trans_io.tlb_hit := TLBEntryValid(TLBIndex)
    
    val i = Reg(UInt(1 bits)) init(0)
    wb.cyc := wb.stb
    wb.we := False
    wb.dat_w := 0

    wb.stb.setAsReg() init(False)
    wb.adr.setAsReg() init(0)
    wb.sel.setAsReg() init(0)

    when (io.clear_tlb) {
        for (i <- 0 until 64) {
            TLBTable(i).valid := False
        }
    }

    // Return True if translation completes
    def translate(pte: Bits): Bool = {
        val pte_v = pte(0)
        val pte_r = pte(1)
        val pte_w = pte(2)
        val pte_x = pte(3)
        val pte_u = pte(4)
        val pte_a = pte(6) allowPruning()
        val pte_d = pte(7) allowPruning()
        val pte_ppn_raw = pte(10, 22 bits).asUInt
        val pte_ppn = Vec(Types.addr(12), 2)
        pte_ppn(0) := pte(10, 10 bits).resize(12 bits).asUInt
        pte_ppn(1) := pte(20, 12 bits).asUInt

        val res = True
        when (!pte_v || !pte_r && pte_w) {
            // raise page fault
            raise_page_fault()
        } otherwise {
            // pte valid step 5
            when (pte_r || pte_x) { // leaf ppn
                when (
                    !io.mstatus_MXR && !pte_r
                ||  io.mstatus_MXR && !pte_r && !pte_x
                ) {
                    // Prevent unaccessible page
                    raise_page_fault()
                } elsewhen (
                    io.privilege_mode === PrivilegeMode.S
                &&  trans_io.access_type === MemAccessType.Fetch
                &&  pte_u
                ) {
                    // Prevent user code execution in S mode
                    raise_page_fault()
                } elsewhen (io.privilege_mode === PrivilegeMode.U && !pte_u) {
                    // Prevent user access supervisor page
                    raise_page_fault()
                } elsewhen (io.privilege_mode === PrivilegeMode.S && pte_u && !io.mstatus_SUM) {
                    // Prevent supervisor access user page, when SUM = 0
                    raise_page_fault()
                } elsewhen (trans_io.access_type === MemAccessType.Store && !pte_w) {
                    // Write denied
                    raise_page_fault()
                } elsewhen (trans_io.access_type === MemAccessType.Fetch && !pte_x) {
                    // Execution denied
                    raise_page_fault()
                } elsewhen (!trans_io.tlb_hit && i > 0 && pte_ppn(i) =/= 0) {
                    // Misaligned superpage
                    raise_page_fault()
                // uCore does not use a and d bits
                // } elsewhen (!pte_a || trans_io.access_type === MemAccessType.Store && !pte_d) {
                //     // step 7
                //     raise_page_fault()
                } otherwise { // success translation
                    // pa.pgoff = va.pgoff
                    trans_io.physical_addr(0, 12 bits) := trans_io.look_up_addr(0, 12 bits)
                    trans_io.look_up_ack := True
                    trans_io.look_up_valid := True
                    switch (trans_io.tlb_hit ? U"0" | i) {
                        is (1) {
                            trans_io.physical_addr(12, 10 bits) := trans_io.look_up_addr(12, 10 bits)
                            trans_io.physical_addr(22, 10 bits) := pte_ppn(1)(0, 10 bits)
                        }
                        is (0) {
                            trans_io.physical_addr(12, 10 bits) := pte_ppn(0)(0, 10 bits)
                            trans_io.physical_addr(22, 10 bits) := pte_ppn(1)(0, 10 bits)
                        }
                    }
                }
            } otherwise { // read next page
                when (!trans_io.tlb_hit && i > 0) {
                    i := i - 1
                    wb.adr := a(pte_ppn_raw, i - 1)
                    wb.stb := True
                    wb.sel := Sel.WORD
                    res := False
                } otherwise { // page-fault
                    raise_page_fault()
                }
            }
        }
        res
    }

    val fsm = new StateMachine {
        trans_io.exception_code := 0
        trans_io.look_up_valid := False
        trans_io.look_up_ack := False
        trans_io.physical_addr := 0
        val idle: State = new State with EntryPoint {
            onEntry {
                i := config.LEVELS - 1
            }
            whenIsActive {
                trans_io.look_up_ack := False
                trans_io.look_up_valid := False
                when (trans_io.look_up_req) {
                    //  wb.adr := a(satp_ppn, i)
                    //     wb.stb := True
                    //     wb.sel := Sel.WORD
                    //     goto(read)
                    when (TLBEntryValid(TLBIndex)) { // TLB hit
                        translate(TLBTable(TLBIndex).pte)
                    } otherwise {
                        wb.adr := a(satp_ppn, i)
                        wb.stb := True
                        wb.sel := Sel.WORD
                        goto(read)
                    }
                }
            }
        }
        val read: State = new State {
            whenIsActive {
                when (wb.ack) {
                    wb.stb := False
                    // update TLB
                    when (i === 0) {
                        TLBTable(TLBIndex).pte := wb.dat_r
                        TLBTable(TLBIndex).vpn := trans_io.look_up_addr(12, 20 bits)
                        TLBTable(TLBIndex).valid := True
                    }
                    when (translate(wb.dat_r)) {
                        goto(idle)
                    }
                }
            }
        }
    }
}