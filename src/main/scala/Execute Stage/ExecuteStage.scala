import chisel3._
import chisel3.util._

class E2M extends Bundle {
  val result = UInt(16.W)
  val rsdAdress = UInt(4.W)
}

class ExecuteStage extends Module {
  val io = IO(new Bundle {
    val branch = new Bundle {
      val enable = Output(Bool())
      val pc = Output(UInt(16.W))
    }
    val d2e = Input(new D2E)
  })



  // Default values:
  io.branch.enable := false.B
  io.branch.pc := 0.U
}