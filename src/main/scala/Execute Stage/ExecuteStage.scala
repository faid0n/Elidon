import chisel3._
import chisel3.util._

class E2M extends Bundle {
  val resultOrAdress = UInt(16.W) // result to write back, or adress access in memory
  val rsdAdressOrStoreValue = UInt(16.W)
  val writeBack = Bool()
  val store = Bool()
  val load = Bool()
}

object Opcode {
  val and = 0.U(4.W)
  val nor = 1.U(4.W)
  val add = 2.U(4.W)
  val sub = 3.U(4.W)
  val sll = 4.U(4.W)
  val slt = 5.U(4.W)
  val div = 6.U(4.W)
  val mul = 7.U(4.W)
  val lw = 8.U(4.W)
  val sw = 9.U(4.W)
  val lui = 10.U(4.W)
  val lli = 11.U(4.W)
  val bez = 12.U(4.W)
  val jr = 13.U(4.W)
  val jalr = 14.U(4.W)
  val j = 15.U(4.W)
}

class ExecuteStage extends Module {
  val io = IO(new Bundle {
    val branch = Output(new Branch)
    val d2e = Input(new D2E)
    val e2m = Output(new E2M)
  })

  val e2mReg = RegInit(0.U.asTypeOf(new E2M))
  io.e2m := e2mReg

  val opcode = io.d2e.instruction(15, 12)
  
  // Result of adder, will get overwritten in most cases
  val toAdd1 = WireDefault(0.U(16.W))
  val toAdd2 = WireDefault(0.U(16.W))
  val added = WireDefault(toAdd1 + toAdd2)

    // Is true when it's a branch operation, but will overwrite
  // with false if bez doesn't branch
  io.branch.enable := 
      opcode === Opcode.jr || 
      opcode === Opcode.jalr ||
      opcode === Opcode.j ||
      opcode === Opcode.bez &&
      io.d2e.rs1 === 0.U

  // Get pc from register if jalr,jar otherwise from the resulting addition
  io.branch.pc := Mux(opcode === Opcode.jalr || opcode === Opcode.jr, added, io.d2e.rs1)
  e2mReg.resultOrAdress := added
  
  // This is either the destination register (adress) or it's the value
  // to store in memory
  when(opcode === Opcode.sw) {
    e2mReg.rsdAdressOrStoreValue := io.d2e.rs1
  } .elsewhen(opcode === Opcode.jalr) {
    e2mReg.rsdAdressOrStoreValue := 1.U // ra
  } .otherwise {
    e2mReg.rsdAdressOrStoreValue := io.d2e.instruction(11, 8)
  }
  
  // Only false only in sw, non linking branch instructions
  e2mReg.writeBack := !(opcode === Opcode.sw || opcode === Opcode.j || opcode === Opcode.jr || opcode === Opcode.bez)

  // Only true in sw
  e2mReg.store := opcode === Opcode.sw
  // Only true in lw
  e2mReg.load := opcode === Opcode.lw

  // Sitch on the opcode to calculate result (or set operands of addition)
  switch(io.d2e.instruction(15, 12)) {
    is(Opcode.and) {
      e2mReg.resultOrAdress := io.d2e.rs1 & io.d2e.rs2
    }
    is(Opcode.nor) {
      e2mReg.resultOrAdress := ~(io.d2e.rs1 | io.d2e.rs2)
    }
    is(Opcode.add) {
      toAdd1 := io.d2e.rs1
      toAdd2 := io.d2e.rs2
    }
    is(Opcode.sub) {
      toAdd1 := io.d2e.rs2
      toAdd2 := (- io.d2e.rs1.asSInt).asUInt
    }
    is(Opcode.sll) {
      // If rs1 < 0 then shift right. otherwise shift left
      e2mReg.resultOrAdress := Mux(io.d2e.rs1(15), io.d2e.rs2 >> (-io.d2e.rs1).asUInt, io.d2e.rs2 << io.d2e.rs1)
    }
    is(Opcode.slt) {
      e2mReg.resultOrAdress := (io.d2e.rs2.asSInt < io.d2e.rs1.asSInt).asUInt
    }
    // TODO: Add remainder
    is(Opcode.div) { 
      e2mReg.resultOrAdress := (io.d2e.rs2.asSInt / io.d2e.rs1.asSInt).asUInt
    }
    is(Opcode.mul) {
      e2mReg.resultOrAdress := (io.d2e.rs1.asSInt * io.d2e.rs2.asSInt).asUInt
    }
    is(Opcode.lw, Opcode.sw) {
      toAdd1 := io.d2e.rs2
      toAdd2 := io.d2e.instruction(3, 0)
    }
    is(Opcode.lui) {
      e2mReg.resultOrAdress := io.d2e.instruction(7, 0) ## io.d2e.rs1(7, 0)
    }
    is(Opcode.lli) {
      e2mReg.resultOrAdress := io.d2e.rs1(15, 8) ## io.d2e.instruction(7, 0)
    }
    is(Opcode.jalr) {
      toAdd1 := io.d2e.pc
      toAdd2 := 2.U
    }
    is(Opcode.bez) {
      toAdd1 := io.d2e.pc
      // Used to cast with correct sign extension
      val toAdd2Temp = Wire(SInt(16.W))
      toAdd2Temp := io.d2e.instruction(7, 0).asSInt
      toAdd2 := toAdd2Temp.asUInt
    }
    is(Opcode.j) {
      toAdd1 := io.d2e.pc
      // Used to cast with correct sign extension
      val toAdd2Temp = Wire(SInt(16.W))
      toAdd2Temp := io.d2e.instruction(11, 0).asSInt
      toAdd2 := toAdd2Temp.asUInt
    }
  }


}