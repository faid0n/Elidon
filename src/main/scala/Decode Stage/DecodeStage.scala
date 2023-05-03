import chisel3._
import chisel3.util._

class D2EIO extends Bundle {
  val pc = Output(UInt(16.W))
  val instruction = Output(UInt(16.W))
  val rs1 = Output(UInt(16.W))
  val rs2 = Output(UInt(16.W))
}

class DecodeStage extends Module {
  val io = IO(new Bundle {
    val f2d = Flipped(new F2DIO)
    val d2e = new D2EIO
  })

  val registerFile = RegInit(VecInit.fill(16)(0.U(16.W)))

  // aliases
  val instruction = io.f2d.instruction
  val opcode = instruction(15, 12)
  // TODO make bundle out of this somehow 
  val d2eReg_pc = RegNext(io.f2d.pc)
  val d2eReg_instruction = RegNext(instruction)
  val d2eReg_rs1 = RegNext(registerFile(Mux(opcode(3), instruction(7, 4), instruction(11, 8))))
  val d2eReg_rs2 = RegNext(registerFile(instruction(3, 0)))

  // TODO fix with new bundle notation
  io.d2e.pc := d2eReg_pc
  io.d2e.instruction := d2eReg_instruction
  io.d2e.rs1 := d2eReg_rs1
  io.d2e.rs2 := d2eReg_rs2

  // TODO add forwarding
}