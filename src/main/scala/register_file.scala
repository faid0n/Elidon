import chisel3._

class RegisterFile extends Module {
  val io = IO(new Bundle {
    val aAddr = Input(UInt(4.W))
    val bAddr = Input(UInt(4.W))
    val rdAddr = Input(UInt(4.W))
    val wrAddr = Input(UInt(4.W))
    val wrData = Input(UInt(16.W))
    val wrEna = Input(Bool())
    val rs1Data = Output(UInt(16.W))
    val rs2Data = Output(UInt(16.W))
  })

  val regFile = SyncReadMem(16, Vec(2, UInt(16.W)))

  when(io.wrEna) {
    regFile.write(io.wrAddr, VecInit(Seq(io.wrData, 0.U)))
  }

  io.rs1Data := regFile.read(io.aAddr, 0.U)(0)
  io.rs2Data := regFile.read(io.bAddr, 0.U)(0)
}
/**
  *  The wrEna input controls whether a write occurs, and the wrData input specifies the data to be written. The rs1Addr, rs2Addr, and rdAddr inputs specify the addresses of the source and destination registers, and the rs1Data and rs2Data outputs provide the data from the source registers.
  */