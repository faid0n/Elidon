import chisel3._
import chisel3.util._

class ExecuteStage extends Module {
  val io = IO(new Bundle {
    val branch = new Bundle {
      val enable = Output(Bool())
      val pc = Output(UInt(16.W))
    }
    val d2e = Flipped(new D2EIO)
  })

  // Default values:
  io.branch.enable := false.B
  io.branch.pc := 0.U
}