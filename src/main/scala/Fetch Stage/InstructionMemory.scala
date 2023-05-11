import chisel3._
import chisel3.util._

class InstructionMemory(filename: String) extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(16.W))
    val instruction = Output(UInt(16.W))
  })

  // Import machine code:
  val path = os.pwd/"Machine Code"/filename
  val lines = os.read.lines(path).map("b"+_)
  val machineCode = lines.map(_.asUInt(16.W))

  val rom = VecInit(machineCode)
  io.instruction := rom(io.pc(7, 1));
}
