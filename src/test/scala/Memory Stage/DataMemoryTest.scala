import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class DataMemoryTest extends AnyFlatSpec with ChiselScalatestTester {

  "DataMemory" should "work" in {
    test(new DataMemory) { dut =>
      dut.io.leds.expect(0.U)
      dut.io.displayValue.expect(0.U)
      dut.io.data.read.poke(true.B)
      dut.io.data.write.poke(false.B)
      dut.io.data.writeValue.poke(11.U)
      
      // Check switches
      dut.io.data.adress.poke(4.U)
      dut.io.switches.poke(22.U)
      dut.clock.step(1)
      dut.io.data.readValue.expect(22.U)
      dut.io.switches.poke(33.U)
      dut.clock.step(1)
      dut.io.data.readValue.expect(33.U)

      // Check Leds
      dut.io.data.adress.poke(0.U)
      dut.io.data.write.poke(true.B)
      dut.io.data.writeValue.poke("hF0F0".U)
      dut.clock.step(1)
      dut.io.leds.expect("hF0F0".U)
      
      // Check display value
      dut.io.data.adress.poke(2.U)
      dut.io.data.writeValue.poke("hABAB".U)
      dut.clock.step(1)
      dut.io.displayValue.expect("hABAB".U)

      // Write a bunch of stuff
      for (i <- 3 until pow(2, 15)) {
        dut.io.data.write.poke(true.B)
        dut.io.data.read.poke(false.B)
        dut.io.data.adress.poke((i*2).U)
        dut.io.data.writeValue.poke(i.U)
        dut.clock.step(1)
      }

      // Read that bunch of stuff
      dut.io.data.write.poke(false.B)
      dut.io.data.read.poke(true.B)
      for (i <- 3 until pow(2, 15)) {
        dut.io.data.adress.poke((i*2).U)
        dut.clock.step(1)
        dut.io.data.readValue.expect(i.U)
      }
    }
  }
}
