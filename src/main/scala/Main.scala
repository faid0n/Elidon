import chisel3._
import chisel3.util._

class Elidon extends Module {
  val io = IO(new Bundle {
    val leds = Output(UInt(16.W))
    val display = new Bundle {
      val segments = Output(UInt(7.W))
      val selector = Output(UInt(4.W))
    }
    val switches = Input(UInt(16.W))
  })

  // Initialise Pipeline Stages
  val fetchStage = Module(new FetchStage)
  val decodeStage = Module(new DecodeStage)
  val executeStage = Module(new FetchStage)
  val memoryStage = Module(new MemoryStage)
  val writeBackStage = Module(new WriteBackStage)

  // Initialise communication of Memory stage with data segment
  val dataMemory = Module(new DataMemory)
  memoryStage.io.data <> dataMemory.io.data
  
  // Connect data memory segment to board IO:
  dataMemory.io.switches := io.switches
  io.leds := dataMemory.io.leds
  val displayMultiplexer = Module(new DisplayMultiplexer)
  displayMultiplexer.io.value := dataMemory.io.displayValue
  io.display := displayMultiplexer.io.display
}

object Main extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Elidon())
}