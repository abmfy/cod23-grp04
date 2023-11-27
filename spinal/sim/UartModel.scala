// Adapted from https://github.com/SpinalHDL/SpinalHDL/tree/master/lib/src/main/scala/spinal/lib/com/uart/sim
//  to support time number

package cod.sim

import spinal.core._
import spinal.core.sim._

object UartModel {
    def init(uart_pin: Bool) = {
        uart_pin #= true
    }

    def encode(uart_pin: Bool, baud_period: TimeNumber, data: Int) = {
        uart_pin #= false
        sleep(baud_period)

        (0 to 7).foreach { bit_id =>
            uart_pin #= ((data >> bit_id) & 1) != 0
            sleep(baud_period)
        }

        uart_pin #= true
        sleep(baud_period)
    }

    def decode(uart_pin: Bool, baud_period: TimeNumber): Char = {
        sleep(baud_period)

        var buffer = 0
        (0 to 7).foreach { bit_id =>
            if (uart_pin.toBoolean) {
                buffer |= 1 << bit_id
            }
            sleep(baud_period)
        }

        if (uart_pin.toBoolean != true) {
            println("UART FRAME ERROR")
        }

        buffer.toChar
    }

    def encoder(uart_pin: Bool, baud_period: TimeNumber) = fork {
        uart_pin #= true
        while (true) {
            if (System.in.available() != 0) {
                val buffer = System.in.read()
                encode(uart_pin, baud_period, buffer)
            } else {
                sleep(baud_period * 1000)
            }
        }
    }

    def decoder(uart_pin: Bool, baud_period: TimeNumber)(action: Char => Unit) = fork {
        // Wait boot signals propagation
        sleep(1) 
        waitUntil(uart_pin.toBoolean == true)

        while (true) {
            waitUntil(uart_pin.toBoolean == false)
            sleep(baud_period / 2)

            if(uart_pin.toBoolean != false) {
                println("UART FRAME ERROR")
            } else {
                val buffer = decode(uart_pin, baud_period)
                println(s"Uart decoder received: $buffer")
                action(buffer)
            }
        }
    }
}
