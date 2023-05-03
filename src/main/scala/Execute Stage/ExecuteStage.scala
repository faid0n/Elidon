import chisel3._
import chisel3.util._


class ExecuteStage extends Module {
  val io = IO(new Bundle {
    val branch = new Bundle {
      val enable = Output(Bool())
      val pc = Output(UInt(16.W))
    }
  })
}