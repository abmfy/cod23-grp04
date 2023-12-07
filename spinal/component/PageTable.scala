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

case class PageTableTranslatePorts() extends Bundle with IMasterSlave {
    // virtual address
    val look_up_addr = Types.addr
    val look_up_req = Bool()
    val access_type = MemAccessType()
    val physical_addr = Types.addr
    val look_up_ack = Bool()
    val look_up_valid = Bool() // 是否发生异常
    // exception signal
    val exception_code = Types.data
    override def asMaster(): Unit = {
        in (
            physical_addr, look_up_ack, look_up_valid,
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

    // physical address
    def asMaster(): Unit = {
        out(
            satp,
            privilege_mode,
            mstatus_MXR, mstatus_SUM,
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
    
    val i = Reg(UInt(1 bits)) init(0)
    wb.cyc := wb.stb
    wb.we := False
    wb.dat_w := 0

    wb.stb.setAsReg() init(False)
    wb.adr.setAsReg() init(0)
    wb.sel.setAsReg() init(0)

    val pte = Reg(Types.data) init(0)
    val pte_v = pte(0)
    val pte_r = pte(1)
    val pte_w = pte(2)
    val pte_x = pte(3)
    val pte_u = pte(4)
    val pte_a = pte(6)
    val pte_d = pte(7)
    val pte_ppn_raw = pte(10, 22 bits).asUInt
    val pte_ppn = Vec(Types.addr(12), 2)
    pte_ppn(0) := pte(10, 10 bits).resize(12 bits).asUInt
    pte_ppn(1) := pte(20, 12 bits).asUInt

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
                    wb.adr := a(satp_ppn, i)
                    wb.stb := True
                    wb.sel := Sel.WORD
                    goto(read)
                }
            }
        }
        val read: State = new State {
            whenIsActive {
                when (wb.ack) {
                    wb.stb := False
                    pte := wb.dat_r
                    goto(translate)
                }
            }
        }
        val translate: State = new State {
            whenIsActive {
                when (!pte_v || !pte_r && pte_w) {
                    // raise page fault
                    raise_page_fault()
                    exit()
                } otherwise {
                    // pte valid step 5
                    when (pte_r || pte_x) { // leaf ppn
                        when (
                            !io.mstatus_MXR && !pte_r
                        ||  io.mstatus_MXR && !pte_r && !pte_x
                        ) {
                            // Prevent unaccessible page
                            raise_page_fault()
                            exit()
                        } elsewhen (
                            io.privilege_mode === PrivilegeMode.S
                        &&  trans_io.access_type === MemAccessType.Fetch
                        &&  pte_u
                        ) {
                            // Prevent user code execution in S mode
                            raise_page_fault()
                            exit()
                        } elsewhen (io.privilege_mode === PrivilegeMode.U && !pte_u) {
                            // Prevent user access supervisor page
                            raise_page_fault()
                            exit()
                        } elsewhen (io.privilege_mode === PrivilegeMode.S && pte_u && !io.mstatus_SUM) {
                            // Prevent supervisor access user page, when SUM = 0
                            raise_page_fault()
                            exit()
                        } elsewhen (trans_io.access_type === MemAccessType.Store && !pte_w) {
                            // Write denied
                            raise_page_fault()
                            exit()
                        } elsewhen (trans_io.access_type === MemAccessType.Fetch && !pte_x) {
                            // Execution denied
                            raise_page_fault()
                            exit()
                        } elsewhen (i > 0 && pte_ppn(i) =/= 0) {
                            // Misaligned superpage
                            raise_page_fault()
                            exit()
                        } elsewhen (!pte_a || trans_io.access_type === MemAccessType.Store && !pte_d) {
                            // step 7
                            raise_page_fault()
                            exit()
                        } otherwise { // success translation
                            // pa.pgoff = va.pgoff
                            trans_io.physical_addr(0, 12 bits) := trans_io.look_up_addr(0, 12 bits)
                            trans_io.look_up_ack := True
                            trans_io.look_up_valid := True
                            switch (i) {
                                is (1) {
                                    trans_io.physical_addr(12, 10 bits) := trans_io.look_up_addr(12, 10 bits)
                                    trans_io.physical_addr(22, 10 bits) := pte_ppn(1)(0, 10 bits)
                                }
                                is (0) {
                                    trans_io.physical_addr(12, 10 bits) := pte_ppn(0)(0, 10 bits)
                                    trans_io.physical_addr(22, 10 bits) := pte_ppn(1)(0, 10 bits)
                                }
                            }
                            exit()
                        }
                    } otherwise { // read next page
                        when (i > 0) {
                            i := i - 1
                            wb.adr := a(pte_ppn_raw, i - 1)
                            wb.stb := True
                            wb.sel := Sel.WORD
                            goto(read)
                        } otherwise { // page-fault
                            raise_page_fault()
                            exit()
                        }
                    }
                }
            }
        }
    }
}