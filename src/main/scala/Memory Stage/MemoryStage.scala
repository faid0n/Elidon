import chisel3._
import chisel3.util._

class MemoryStage extends Module {
  val io = IO(new Bundle {
    val data = new Bundle {
      val readAdress = Output(UInt(16.W))
      val writeAdress = Output(UInt(16.W))
      val writeEnable = Output(Bool())
      val writeValue = Output(UInt(16.W))
      val readValue = Input(UInt(16.W))
    }
  })
  // Default values:
  io.data.readAdress := WireDefault(0.U)
  io.data.writeAdress := WireDefault(0.U)
  io.data.writeEnable := WireDefault(false.B)
  io.data.writeValue := WireDefault(0.U)
}