/*
 * Dummy tester to start a Chisel project.
 *
 * Author: Martin Schoeberl (martin@jopdesign.com)
 * 
 */

package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class InstructionMemoryTest extends AnyFlatSpec with ChiselScalatestTester {

  "InstructionMemory" should "work" in {
    test(new InstructionMemory("test")) { dut =>
      dut.io.pc.poke(0.U)
      dut.io.instruction.expect("b1101101100000100".U)
      dut.io.pc.poke(8.U)
      dut.io.instruction.expect("b0010111010111100".U)
      dut.io.pc.poke(15.U)
      dut.io.instruction.expect("b1110111000000010".U)
    }
  }
}
