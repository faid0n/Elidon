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
  val executeStage = Module(new ExecuteStage)
  val memoryStage = Module(new MemoryStage)
  val writeBackStage = Module(new WriteBackStage)

  // Connect stage pipelines:
  fetchStage.io.f2d <> decodeStage.io.f2d
  decodeStage.io.d2e <> executeStage.io.d2e

  // Connect other stage communications
  // TODO figure out why this does't work and replace the 2 lines below
    // fetchStage.io.branch <> executeStage.io.branch
  fetchStage.io.branch.enable := executeStage.io.branch.enable
  fetchStage.io.branch.pc := executeStage.io.branch.pc

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