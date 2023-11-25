package cod.lab5
import cod._

import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

class Master extends Component {
    val io = new Bundle {
        val addr = in port Types.addr
        val wb = master port WishbonePorts()
    }

    val TEST_CNT = 10
    val UART_STATUS_ADDR = 0x10000005
    val UART_DATA_ADDR = 0x10000000

    val cnt = Reg(UInt(4 bits)) init(0)
    val cur_addr = RegInit(io.addr)

    val uart_status = Reg(Bool())
    val uart_data = Reg(Bits(8 bits))

    io.wb.cyc := io.wb.stb

    val fsm = new StateMachine {
        io.wb.stb := False
        io.wb.we := False
        io.wb.adr := 0
        io.wb.dat_w := 0
        io.wb.sel := 0
        val start: State = new State with EntryPoint {
            whenIsActive {
                when (cnt < TEST_CNT) {
                    goto(read_wait_action)
                } otherwise {
                    goto(done)
                }
            }
        }
        val read_wait_action: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.we := False
                io.wb.adr := UART_STATUS_ADDR
                io.wb.sel := B"0010"
                when (io.wb.ack) {
                    goto(read_wait_check)
                }
            }
        }
        val read_wait_check: State = new State {
            onEntry {
                uart_status := io.wb.dat_r(8)
            }
            whenIsActive {
                when (uart_status) {
                    goto(read_data_action)
                } otherwise {
                    goto(read_wait_action)
                }
            }
        }
        val read_data_action: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.we := False
                io.wb.adr := UART_DATA_ADDR
                io.wb.sel := B"0001"
                when (io.wb.ack) {
                    goto(read_data_done)
                }
            }
        }
        val read_data_done: State = new State {
            onEntry {
                uart_data := io.wb.dat_r(0, 8 bits)
            }
            whenIsActive {
                goto(write_sram_action)
            }
        }
        val write_sram_action: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.we := True
                io.wb.adr := cur_addr
                io.wb.dat_w := uart_data.resized
                io.wb.sel := B"0001"
                when (io.wb.ack) {
                    goto(write_sram_done)
                }
            }
        }
        val write_sram_done: State = new State {
            whenIsActive {
                goto(write_wait_action)
            }
        }
        val write_wait_action: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.we := False
                io.wb.adr := UART_STATUS_ADDR
                io.wb.sel := B"0010"
                when (io.wb.ack) {
                    goto(write_wait_check)
                }
            }
        }
        val write_wait_check: State = new State {
            onEntry {
                uart_status := io.wb.dat_r(13)
            }
            whenIsActive {
                when (uart_status) {
                    goto(write_data_action)
                } otherwise {
                    goto(write_wait_action)
                }
            }
        }
        val write_data_action: State = new State {
            whenIsActive {
                io.wb.stb := True
                io.wb.we := True
                io.wb.adr := UART_DATA_ADDR
                io.wb.dat_w := uart_data.resized
                io.wb.sel := B"0001"
                when (io.wb.ack) {
                    goto(write_data_done)
                }
            }
        }
        val write_data_done: State = new State {
            whenIsActive {
                cnt := cnt + 1
                cur_addr := cur_addr + 4
                goto(start)
            }
        }
        val done: State = new State
    }
}