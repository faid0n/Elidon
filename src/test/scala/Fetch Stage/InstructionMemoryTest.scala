import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class InstructionMemoryTest extends AnyFlatSpec with ChiselScalatestTester {

  "InstructionMemory" should "work" in {
    test(new InstructionMemory("test")) { dut =>
      val path = os.pwd/"Machine Code"/"test"
      val lines = os.read.lines(path).map("b"+_)
      val machineCode = lines.map(_.asUInt(16.W))
      for (i <- 0 until machineCode.length) {
        dut.io.pc.poke((2*i).U)
        dut.io.instruction.expect(machineCode(i))
      }
    }
  }
}
