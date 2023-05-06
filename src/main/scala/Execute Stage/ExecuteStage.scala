import chisel3._
import chisel3.util._

class E2M extends Bundle {
  val resultOrAdress = UInt(16.W) // result to write back, or adress access in memory
  val rsdAdressOrStoreValue = UInt(16.W)
  val writeBack = Bool()
  val store = Bool()
  val load = Bool()
}

class ExecuteStage extends Module {
  val io = IO(new Bundle {
    val branch = Output(new Branch)
    val d2e = Input(new D2E)
    val e2m = Output(new E2M)
  })

  val e2mReg = RegInit(0.U.asTypeOf(new E2M))
  io.e2m := e2mReg

  // Default values:
  io.branch.enable := false.B
  io.branch.pc := 0.U
  
  e2mReg.resultOrAdress := 0.U
  e2mReg.rsdAdressOrStoreValue := 0.U
  e2mReg.writeBack := false.B
  e2mReg.store := false.B
  e2mReg.load := false.B
}