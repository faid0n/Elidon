import chisel3._
import chisel3.util._

class FetchStage extends Module {
  // val io = IO(new Bundle {
  // })

  val pcReg = RegInit(0.U(16.W))

  val instructionMemory = Module(new InstructionMemory)
  instructionMemory.io.pc := pcReg
  
  
}