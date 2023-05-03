import chisel3._
import chisel3.util._


class FetchStage extends Module {
  val io = IO(new Bundle {
    val branch = new Bundle {
      val enable = Input(Bool())
      val pc = Input(UInt(16.W))
    }
    val f2d = new Bundle {
      val pc = Output(UInt(16.W))
      val instruction = Output(UInt(16.W))
    }
  })

  val pcReg = RegInit(0.U(16.W))

  when(io.branch.enable) {
    pcReg := io.branch.pc
  } .otherwise {
    pcReg := pcReg + 2.U
  }

  val instructionMemory = Module(new InstructionMemory)
  instructionMemory.io.pc := pcReg
  
  io.f2d.instruction := instructionMemory.io.instruction
  io.f2d.pc := pcReg
}