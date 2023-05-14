import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MemoryStageTest extends AnyFlatSpec with ChiselScalatestTester {

  "MemoryStage" should "work" in {
    test(new MemoryStage) { dut =>

      // Test sw
      dut.io.e2m.writeBack.poke(false.B)
      dut.io.e2m.store.poke(true.B)
      dut.io.e2m.load.poke(false.B)
      for (adress <- 6 until pow(2, 16)) {
        // Set adress & value
        dut.io.e2m.resultOrAdress.poke(adress.U)
        dut.io.e2m.rdAdressOrStoreValue.poke(adress.U)
        // Test data
        dut.io.data.adress.expect(adress.U)
        dut.io.data.read.expect(false.B)
        dut.io.data.write.expect(true.B)
        // Step clock
        dut.clock.step(1)
        // Check write back
        dut.io.m2w.writeBack.expect(false.B)
      }

      // Test lw
      dut.io.e2m.writeBack.poke(true.B)
      dut.io.e2m.store.poke(false.B)
      dut.io.e2m.load.poke(true.B)
      for (adress <- 6 until pow(2, 16)) {
        // Set adress & value
        dut.io.e2m.resultOrAdress.poke(adress.U)
        dut.io.e2m.rdAdressOrStoreValue.poke((adress % 16).U)
        // Test data
        dut.io.data.adress.expect(adress.U)
        dut.io.data.read.expect(true.B)
        dut.io.data.write.expect(false.B)
        // Step clock
        dut.clock.step(1)
        // Check read value
        dut.io.data.readValue.poke(adress.U)
        dut.io.m2w.writeBack.expect(true.B)
        dut.io.m2w.rd.expect(adress.U)
        dut.io.m2w.rdAdress.expect((adress % 16).U)
      }

      // test a write back instruction
      dut.io.e2m.writeBack.poke(true.B)
      dut.io.e2m.store.poke(false.B)
      dut.io.e2m.load.poke(false.B)
      // Set adress & value
      dut.io.e2m.resultOrAdress.poke(505.U)
      dut.io.e2m.rdAdressOrStoreValue.poke(10.U)
      // Test data
      dut.io.data.read.expect(false.B)
      dut.io.data.write.expect(false.B)
      // Step clock
      dut.clock.step(1)
      // Check write back
      dut.io.m2w.writeBack.expect(true.B)
      dut.io.m2w.rd.expect(505.U)
      dut.io.m2w.rdAdress.expect(10.U)

      // test a non write back instruction
      dut.io.e2m.writeBack.poke(false.B)
      dut.io.e2m.store.poke(false.B)
      dut.io.e2m.load.poke(false.B)
      // Set adress & value
      dut.io.e2m.resultOrAdress.poke(505.U)
      dut.io.e2m.rdAdressOrStoreValue.poke(10.U)
      // Test data
      dut.io.data.read.expect(false.B)
      dut.io.data.write.expect(false.B)
      // Step clock
      dut.clock.step(1)
      // Check write back
      dut.io.m2w.writeBack.expect(false.B)
    }
  }
}
