import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DecodeStageTest extends AnyFlatSpec with ChiselScalatestTester {

  "DecodeStage" should "work" in {
    test(new DecodeStage) { dut =>

      // Test r-Type and write on registers 1-7 the values 1-7
      for (i <- 1 to 7) {
        // write on a register: r1 = 1;
        dut.io.m2w.rd.poke(i.U)
        dut.io.m2w.rdAdress.poke(i.U)
        dut.io.m2w.writeBack.poke(true.B);
        // pass isntruction
        dut.io.f2d.pc.poke(i.U)
        val instruction = ((i << 12) + (5 << 8) + ((i-1) << 4) + (i)).U(16.W) // 
        dut.io.f2d.instruction.poke(instruction)
        // check registers & forwarding
        dut.clock.step(1)
        dut.io.d2e.instruction.expect(instruction)
        dut.io.d2e.pc.expect(i.U)
        dut.io.d2e.rs1.expect((i).U)
        dut.io.d2e.rs2.expect((i-1).U)
      }

      // Set rest of registers and don't check forwarding from now on
      for (i <- 8 to 15) {
        dut.io.m2w.rdAdress.poke(i.U)
        dut.io.m2w.rd.poke(i.U)
        dut.io.m2w.writeBack.poke(true.B)
        dut.clock.step(1)
      }
      dut.io.m2w.writeBack.poke(false.B)

      // Test m-Type
      for (i <- 8 to 9) {
        dut.io.f2d.pc.poke(i.U)
        val instruction = ((i << 12) + (i << 8) + ((i-1) << 4) + (5)).U(16.W)
        dut.io.f2d.instruction.poke(instruction)
        // check results
        dut.clock.step(1)
        dut.io.d2e.instruction.expect(instruction)
        dut.io.d2e.pc.expect(i.U)
        dut.io.d2e.rs1.expect((i).U)
        dut.io.d2e.rs2.expect((i-1).U)
      }

      // Test wI-Type, rI-type
      for (i <- 10 to 14) {
        dut.io.f2d.pc.poke(i.U)
        val instruction = ((i << 12) + (i << 8) + ((i-1) << 4) + (5)).U(16.W)
        dut.io.f2d.instruction.poke(instruction)
        // check, we care about rd/rs1
        dut.clock.step(1)
        dut.io.d2e.pc.expect(i.U)
        dut.io.d2e.instruction.expect(instruction)
        dut.io.d2e.rs1.expect(i.U)
      }

      val i = 15
      // Test j-Type`
      dut.io.f2d.pc.poke(i.U)
      val instruction = ((i << 12) + 255).U(16.W)
      dut.io.f2d.instruction.poke(instruction) 
      // check results (we don't care about resisters)
      dut.clock.step(1)
      dut.io.d2e.instruction.expect(instruction)
      dut.io.d2e.pc.expect(i.U)
    }
  }
}
