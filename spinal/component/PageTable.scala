package cod

import spinal.core._
import spinal.lib._
import spinal.lib.fsm.StateMachine
import spinal.lib.fsm._
import spinal.lib.io.InOutWrapper

case class PageTableConfigs (
    PPN_LENGTH : Int =  22,
    LEVELS : Int =  2, // 二级页表
    PAGE_SIZE : Int = 0x1000,
    PTE_SIZE : Int =  4,
)


case class PageTableTranslatePorts() extends Bundle with IMasterSlave{
    // virtual address
    val look_up_addr = Types.addr
    val look_up_req = Bool()
    val access_type = MemAccessType()
    val physical_addr = Types.addr
    val look_up_ack = Bool()
    val look_up_vaild = Bool() // 是否发生异常
    // exception signal
    val exception_we = Bool()
    val exception_code = Types.data
    override def asMaster(): Unit = {
        in(   
        exception_code, exception_we,
        physical_addr, look_up_ack, look_up_vaild,
        )
        out(
        look_up_addr, look_up_req,
        access_type
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
        in(
           
        )
        out(
            satp,
            privilege_mode,
            mstatus_MXR, mstatus_SUM,
            
        )
    }
}

class PageTable(config: PageTableConfigs = PageTableConfigs()) extends Component {
    val io = slave port PageTablePorts()
    val trans_io = slave port PageTableTranslatePorts()
    val wb = master port WishbonePorts()

    val satp_ppn = io.satp(0, 22 bits) 
    val satp_mode = io.satp(31, 1 bits).asBool
    val a = Reg(Types.addr) init(0)
    val va_ppn = Vec(Types.addr(10), 2) // va.ppn
    va_ppn(1) := trans_io.look_up_addr(22, 10 bits)
    va_ppn(0) := trans_io.look_up_addr(12, 10 bits)
    

    def raise_page_fault () {
        trans_io.exception_we := True
        trans_io.look_up_ack := True
        trans_io.look_up_vaild := False
        switch (trans_io.access_type) {
            is (MemAccessType.Store) {
                trans_io.exception_code := TrapCause.STORE_PAGE_FAULT
            }
            is (MemAccessType.Read) {
                trans_io.exception_code := TrapCause.LOAD_PAGE_FAULT
            }
            is (MemAccessType.Instruction) {
                trans_io.exception_code := TrapCause.INSTRUCTION_PAGE_FAULT
            }
        }
    }
    
    val i = Reg(Types.addr(1)) init(0)
    wb.cyc := wb.stb
    wb.we := False
    wb.dat_w := 0

    wb.stb.setAsReg() init(False)
    wb.adr.setAsReg() init(0)
    wb.sel.setAsReg() init(0)

    val pte = Reg(Types.data) init(0)
    val pte_v = pte(0, 1 bits)    
    val pte_r = pte(1, 1 bits)
    val pte_w = pte(2, 1 bits)
    val pte_x = pte(3, 1 bits)
    val pte_u = pte(4, 1 bits)
    val pte_g = pte(5, 1 bits)
    val pte_a = pte(6, 1 bits)
    val pte_d = pte(7, 1 bits)
    val pte_rsw = pte(8, 2 bits)
    val pte_ppn = Vec(Types.data(12), 2)
    val pte_ppn_raw = pte(10, 22 bits)
    pte_ppn(0) := pte(10, 10 bits).resize(12 bits)
    pte_ppn(1) := pte(20, 12 bits) 
    val fsm = new StateMachine {
        trans_io.exception_code := 0
        trans_io.exception_we := False
        trans_io.look_up_vaild := False
        trans_io.look_up_ack := False
        trans_io.physical_addr := 0
        val idle: State = new State with EntryPoint {
            onEntry {
                
                i := 1 // ! hardcode 
                a := (satp_ppn.asUInt * config.PAGE_SIZE).resize(32)
            }
            whenIsActive {
                
                trans_io.look_up_ack := False
                trans_io.look_up_vaild := False
                trans_io.exception_we := False 
                when(trans_io.look_up_req && satp_mode) {
                    // TODO: PMA or PMP check
                    when (trans_io.look_up_req && ! satp_mode) {
                        trans_io.physical_addr := trans_io.look_up_addr
                        trans_io.look_up_ack := True
                        trans_io.look_up_vaild := True
                    } otherwise {
                        wb.adr := ((satp_ppn.asUInt * config.PAGE_SIZE).resize(32) + va_ppn(i) * config.PTE_SIZE).resize(32)
                        wb.stb := True
                        wb.sel := Sel.WORD
                        goto(read)
                    }
                }
            }
        }

        val waitClk: State = new State {
            onEntry{

            }
            whenIsActive {
                  when (pte_v === 0 || (pte_r === 0 && pte_w === 1)) {
                        // raise page fault
                        raise_page_fault()
                        goto(idle)

                    } otherwise {
                    // pte vaild step 5
                    when (pte_r === 1 || pte_x === 1) { // leaf ppn
                        when (
                           (!io.mstatus_SUM && io.privilege_mode === PrivilegeMode.U && pte_u === 0)
                        || (!io.mstatus_MXR && pte_r === 0)
                        || (io.mstatus_MXR && pte_r === 0 && pte_x === 0)
                        ) {
                            raise_page_fault()
                            goto(idle)
                        } elsewhen (i > 0 && pte_ppn(i) =/= 0) {
                            raise_page_fault()
                            goto(idle)
                        } elsewhen (pte_a === 0 || (trans_io.access_type === MemAccessType.Store && pte_d === 0)) {
                            // TODO: step 7 choice 
                            raise_page_fault()
                            goto(idle)
                        } otherwise { // success translation
                            // pa.pgoff = va.pgoff
                            trans_io.physical_addr(0, 12 bits) := trans_io.look_up_addr(0, 12 bits)
                            trans_io.look_up_ack := True
                            trans_io.look_up_vaild := True
                            switch(i) {
                                is(1) {
                                    trans_io.physical_addr(12, 10 bits) := trans_io.look_up_addr(12, 10 bits)
                                    trans_io.physical_addr(22, 10 bits) := pte_ppn(1)(0, 10 bits).asUInt
                                }
                                is(0) {
                                    trans_io.physical_addr(12, 10 bits) := pte_ppn(0)(0, 10 bits).asUInt
                                    trans_io.physical_addr(22, 10 bits) := pte_ppn(1)(0, 10 bits).asUInt
                                }
                            }
                            goto(idle)
                        }
                    } otherwise { // read next page
                        when (i > 0) {
                            a := (pte_ppn_raw.asUInt * config.PAGE_SIZE).resize(32)
                            i := 0 // ! hardcode
                            wb.adr := (pte_ppn_raw.asUInt * config.PAGE_SIZE + va_ppn(i-1) * config.PTE_SIZE).resize(32)
                            wb.stb := True
                            wb.sel := Sel.WORD
                            goto(read)
                        } otherwise { // page-fault
                            raise_page_fault()
                            goto(idle)
                        }
                    }
                }
                
            }
        }
        val read: State = new State {
            onEntry {
               
            }
            whenIsActive {
                when (wb.ack) {
                    wb.stb := False
                    pte := wb.dat_r
                    goto(waitClk)
                  } 
                  
            }
        }
    }
}