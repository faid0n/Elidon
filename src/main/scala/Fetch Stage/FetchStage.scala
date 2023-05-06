import chisel3._
import chisel3.util._

class F2D extends Bundle {
  val pc = UInt(16.W)
  val instruction = UInt(16.W)
}

class Branch extends Bundle {
  val enable = Bool()
  val pc = UInt(16.W)
}

class FetchStage extends Module {
  val io = IO(new Bundle {
    val branch = Input(new Branch)
    val f2d = Output(new F2D)
  })

  val pcReg = RegInit(0.U(16.W))

  when(io.branch.enable) {
    pcReg := io.branch.pc
  } .otherwise {
    pcReg := pcReg + 2.U
  }

  val instructionMemory = Module(new InstructionMemory)
  instructionMemory.io.pc := pcReg
  
  // TODO make bundle out of this somehow
  val f2dReg_pc = RegNext(pcReg)
  val f2dReg_instruction = RegNext(instructionMemory.io.instruction)
  io.f2d.pc := f2dReg_pc
  io.f2d.instruction := f2dReg_instruction
}