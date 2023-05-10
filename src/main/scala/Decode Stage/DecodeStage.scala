import chisel3._
import chisel3.util._

class D2E extends Bundle {
  val pc = UInt(16.W)
  val instruction = UInt(16.W)
  val rs1 = UInt(16.W)
  val rs2 = UInt(16.W)
}

class DecodeStage extends Module {
  val io = IO(new Bundle {
    val f2d = Input(new F2D)
    val d2e = Output(new D2E)
    val m2w = Input(new M2W)
  })

  val registerFile = RegInit(VecInit.fill(16)(0.U(16.W)))

  // aliases
  val instruction = io.f2d.instruction
  val opcode = instruction(15, 12)
  // TODO make bundle out of this somehow 

  val d2eReg = Reg(new D2E)
  io.d2e := d2eReg
  d2eReg.pc := io.f2d.pc
  d2eReg.instruction := instruction
  d2eReg.rs1 := registerFile(Mux(opcode(3), instruction(7, 4), instruction(11, 8)))
  d2eReg.rs2 := registerFile(instruction(3, 0))


  // TODO add forwarding

  // write back functionality
  when (io.m2w.writeBack) {
    registerFile(io.m2w.rsdAdress) := io.m2w.rsd
  }
}