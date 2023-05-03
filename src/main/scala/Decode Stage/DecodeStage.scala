import chisel3._
import chisel3.util._

class DecodeStage extends Module {
  val io = IO(new Bundle {
    val f2d = new Bundle {
      val pc = Input(UInt(16.W))
      val instruction = Input(UInt(16.W))
    }
    val d2e = new Bundle {
      val pc = Output(UInt(16.W))
      val opcode = Output(UInt(4.W))
      val rdAddress = Output(UInt(4.W))
      val rs1 = Output(UInt(16.W))
      val rs2OrImmediate = Output(UInt(16.W))
    }
  })

  val registerFile = RegInit(Vec.fill(16, 0.U(16.W)))

  val pc = Reg(UInt(16.W))
  when()
}