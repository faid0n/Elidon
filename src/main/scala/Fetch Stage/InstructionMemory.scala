import chisel3._
import chisel3.util._

class InstructionMemory extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(8.W))
    val instruction = Output(UInt(16.W))
  })
  val instructionMem = RegInit(Vec())
}