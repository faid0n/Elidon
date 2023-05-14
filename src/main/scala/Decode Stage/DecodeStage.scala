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
  val rs1Adress = Mux(opcode(3), instruction(11, 8), instruction(3, 0))
  val rs2Adress = instruction(7, 4)
  d2eReg.rs1 := registerFile(rs1Adress)
  d2eReg.rs2 := registerFile(rs2Adress)

  // write back & forwarding functionality
  when(io.m2w.writeBack &&  io.m2w.rdAdress =/= 0.U) {
    registerFile(io.m2w.rdAdress) := io.m2w.rd
    when(io.m2w.rdAdress === rs1Adress) {
      d2eReg.rs1 := io.m2w.rd
    }
    when(io.m2w.rdAdress === rs2Adress) {
      d2eReg.rs2 := io.m2w.rd
    }
  }
}