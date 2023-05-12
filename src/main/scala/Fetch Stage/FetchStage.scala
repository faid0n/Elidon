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

class FetchStage(filename: String) extends Module {
  val io = IO(new Bundle {
    val branch = Input(new Branch)
    val f2d = Output(new F2D)
  })

  val pcReg = RegInit((-2).S(16.W).asUInt)
  val pc = Mux(io.branch.enable, pcReg + 2.U, io.branch.pc)
  pcReg := pc

  val instructionMemory = Module(new InstructionMemory(filename))
  instructionMemory.io.pc := pc
  
  io.f2d.pc := pcReg
  io.f2d.instruction := RegNext(instructionMemory.io.instruction)
}