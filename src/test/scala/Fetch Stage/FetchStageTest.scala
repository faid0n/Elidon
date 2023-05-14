import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FetchStageTest extends AnyFlatSpec with ChiselScalatestTester {

  "FetchStage" should "work" in {
    test(new FetchStage("test")) { dut =>
      val path = os.pwd/"Machine Code"/"test"
      val lines = os.read.lines(path).map("b"+_)
      val machineCode = lines.map(_.asUInt(16.W))

      // Testing normal operation (pc <- pc + 2)
      dut.io.branch.enable.poke(false.B)
      dut.io.branch.pc.poke(10.U)
      for (i <- 0 until machineCode.length) {
        dut.clock.step(1)
        dut.io.f2d.instruction.expect(machineCode(i))
        dut.io.f2d.pc.expect((2*i).U)
      }

      // Testing branching capacity
      dut.io.branch.enable.poke(true.B)
      for (i <- (machineCode.length - 2) to 0 by -2) {
        dut.io.branch.pc.poke((2*i).U)
        dut.clock.step(1)
        dut.io.f2d.instruction.expect(machineCode(i))
        dut.io.f2d.pc.expect((2*i).U)
      }
    }
  }
}

