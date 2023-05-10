import chisel3._
import chisel3.util._

class M2W extends Bundle {
  val rsd = UInt(16.W)
  val rsdAdress = UInt(4.W)
  val writeBack = Bool()
}

class MemoryStage extends Module {
  val io = IO(new Bundle {
    val data = Flipped(new DataIO)
    val e2m = Input(new E2M)
    val m2w = Output(new M2W)
  })
  // Default values:
  io.data.adress := io.e2m.resultOrAdress
  io.data.writeValue := io.e2m.rsdAdressOrStoreValue
  io.data.write := io.e2m.store
  io.data.read := io.e2m.load
  val writeValueReg = RegNext(io.e2m.rsdAdressOrStoreValue)
  when(io.e2m.load) {
    io.m2w.rsd := io.data.readValue
  } .otherwise {
    io.m2w.rsd := writeValueReg
  }
  io.m2w.rsdAdress := io.e2m.rsdAdressOrStoreValue(3, 0)
  io.m2w.writeBack := io.e2m.load || io.e2m.writeBack
}