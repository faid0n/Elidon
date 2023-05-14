import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec




class ExecuteStageTest extends AnyFlatSpec with ChiselScalatestTester {

  "ExecuteStage" should "work" in {
    test(new ExecuteStage) { dut =>

      // Instruction parts used:
      val rs1Adress = 11
      val rs2Adress = 9
      val rdAdress = 7
      val imm12 = 1501
      val imm8 = 101
      val imm4 = 6

      // Source Register values
      val pc = 23
      val rs2 = 1892
      val rs1 = 5

      // Testing:
      dut.io.d2e.pc.poke(pc.U)
      dut.io.d2e.rs1.poke(rs1.U)
      dut.io.d2e.rs2.poke(rs2.U)

      // Our instructions
      val and = ((0 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(and)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 & rs1).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      // DOESNT WORK
      val nor = ((1 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(nor)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect(((~(rs1 | rs2)) & (pow(2, 16) - 1)).U(16.W)) // doesn't work
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val add = ((2 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(add)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs1 + rs2).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val sub = ((3 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(sub)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 - rs1).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      // Shift left (rs1 > 0)
      val sll = ((4 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(sll)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 << rs1).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)
      // Shift Right (rs2 < 0)
      dut.io.d2e.rs1.poke((-rs1 & (pow(2, 16) - 1)).U)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect(((rs2 >> rs1) & (pow(2, 16)-1)).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)
      // Restore rs1 for other tests
      dut.io.d2e.rs1.poke(rs1.U)

      val slt = ((5 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(slt)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect(if (rs2 < rs1) 1.U else 0.U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val div = ((6 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(div)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 / rs1).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val mul = ((7 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (rs1Adress)).U
      dut.io.d2e.instruction.poke(mul)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 * rs1).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val lw = ((8 << 12) + (rdAdress << 8) + (rs2Adress << 4) + (imm4)).U
      dut.io.d2e.instruction.poke(lw)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 + imm4).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rdAdress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(true.B)
      dut.io.branch.enable.expect(false.B)

      val sw = ((9 << 12) + (rs1Adress << 8) + (rs2Adress << 4) + (imm4)).U
      dut.io.d2e.instruction.poke(sw)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect((rs2 + imm4).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rs1.U)
      dut.io.e2m.writeBack.expect(false.B)
      dut.io.e2m.store.expect(true.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val lui = ((10 << 12) + (rs1Adress << 8) + (imm8)).U
      dut.io.d2e.instruction.poke(lui)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect(((rs1 & 255) + (imm8 << 8)).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rs1Adress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val lli = ((11 << 12) + (rs1Adress << 8) + (imm8)).U
      dut.io.d2e.instruction.poke(lli)
      dut.clock.step(1)
      dut.io.e2m.resultOrAdress.expect(((rs1 & ~255) + (imm8)).U)
      dut.io.e2m.rdAdressOrStoreValue.expect(rs1Adress.U)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      // Is equal to zero
      val bez = ((12 << 12) + (rs1Adress << 8) + (imm8)).U
      dut.io.d2e.rs1.poke(0.U)
      dut.io.d2e.instruction.poke(bez)
      dut.clock.step(1)
      dut.io.e2m.writeBack.expect(false.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(true.B)
      dut.io.branch.pc.expect((pc + imm8).U)
      // Is unequal to zero
      dut.io.d2e.rs1.poke(rs1.U)
      dut.clock.step(1)
      dut.io.e2m.writeBack.expect(false.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(false.B)

      val jr = ((13 << 12) + (rs1Adress << 8)).U
      dut.io.d2e.instruction.poke(jr)
      dut.clock.step(1)
      dut.io.e2m.writeBack.expect(false.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(true.B)
      dut.io.branch.pc.expect(rs1.U)

      val jalr = ((14 << 12) + (rs1Adress << 8)).U
      dut.io.d2e.instruction.poke(jalr)
      dut.clock.step(1)
      dut.io.e2m.writeBack.expect(true.B)
      dut.io.e2m.rdAdressOrStoreValue.expect(1.U) // ra
      dut.io.e2m.resultOrAdress.expect((pc + 2).U)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(true.B)
      dut.io.branch.pc.expect(rs1.U)

      val j = ((15 << 12) + (imm12)).U
      dut.io.d2e.instruction.poke(j)
      dut.clock.step(1)
      dut.io.e2m.writeBack.expect(false.B)
      dut.io.e2m.store.expect(false.B)
      dut.io.e2m.load.expect(false.B)
      dut.io.branch.enable.expect(true.B)
      dut.io.branch.pc.expect((pc + imm12).U)
    }
  }
}