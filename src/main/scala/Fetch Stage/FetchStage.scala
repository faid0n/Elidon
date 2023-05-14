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

  val f2dReg = RegInit(((-2).S(16.W).asUInt ## 0.U(16.W)).asTypeOf(new F2D))
  io.f2d := f2dReg
  val pc = Mux(io.branch.enable, io.branch.pc, f2dReg.pc + 2.U)
  f2dReg.pc := pc

  val instructionMemory = Module(new InstructionMemory(filename))
  instructionMemory.io.pc := pc
  f2dReg.instruction := instructionMemory.io.instruction
}