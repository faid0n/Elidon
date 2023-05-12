import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DecodeStageTest extends AnyFlatSpec with ChiselScalatestTester {

  "DecodeStage" should "work" in {
    test(new DecodeStage) { dut =>

      // Test r-Type and write on registers 1-7 the values 1-7
      for (i <- 1 to 7) {
        // write on a register: r1 = 1;
        dut.io.m2w.rsd.poke(i.U)
        dut.io.m2w.rsdAdress.poke(i.U)
        // pass isntruction
        dut.io.f2d.pc.poke(i.U)
        val instruction = i.U(4.W) ## i.U(4.W) ## (i-1).U(4.W) ## i.U(4.W) // 
        dut.io.f2d.instruction.poke(instruction)
        // check results
        dut.clock.step(1)
        dut.io.d2e.instruction.expect(instruction)
        dut.io.d2e.pc.expect(i.U)
        dut.io.d2e.rs1.expect((i-1).U)
        dut.io.d2e.rs2.expect((i).U)
      }

      // Test m-Type
      for (i <- 8 to 9) {
        dut.io.f2d.pc.poke(i.U)
        // val isntruction = i.U(4.W) ## i.U(4.W) ## (i-1).U(4.W) ## i.U(4.W) // 
        // dut.io.f2d.instruction.poke(instruction) 
        // // check results
        // dut.clock.step(1)
        // dut.io.d2e.instruction.expect(instruction)
        // dut.io.d2e.pc.expect(i.U)
        // dut.io.d2e.rs1.expect((i).U)
        // dut.io.d2e.rs2.expect((i-1).U)
      }

      // Test wI-Type
      for (i <- 10 to 11) {
        dut.io.f2d.pc.poke(i.U)
      }

      // Test rI-Type
      for (i <- 12 to 14) {
        dut.io.f2d.pc.poke(i.U)
      }

      // Test j-Type
      for (i <-  15 to 15) {
        dut.io.f2d.pc.poke(i.U)
      }
    }
  }
}