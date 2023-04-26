import chisel3._

class PC extends Module {
  val io = IO(new Bundle {
    val clk       = Input(Clock())
    val reset_n   = Input(Bool())
    val sel_a     = Input(Bool())
    val sel_imm   = Input(Bool())
    val branch    = Input(Bool())
    val a         = Input(UInt(16.W))
    val d_imm     = Input(UInt(16.W))
    val e_imm     = Input(UInt(16.W))
    val pc_addr   = Input(UInt(16.W))
    val addr      = Output(UInt(16.W))
    val next_addr = Output(UInt(16.W))
  })

  val reg   = RegInit(0.U(16.W))
  val mux1  = Wire(UInt(16.W))
  val mux2  = Wire(UInt(16.W))
  val mux3  = Wire(UInt(16.W))

  io.addr      := mux3
  io.next_addr := reg

  mux1 := Mux(io.branch === false.B, reg, io.pc_addr)
  mux2 := Mux(io.branch === false.B, 2.U, e_imm + 2.U)

  when(io.sel_imm === false.B && io.sel_a === false.B) {
    mux3 := mux1 + mux2
  }.elsewhen(io.sel_imm === false.B && io.sel_a === true.B) {
    mux3 := 4.U + io.a
  }.elsewhen(io.sel_imm === true.B && io.sel_a === false.B) {
    mux3 := Cat(io.d_imm(13, 0), 0.U(2.W))
  }.otherwise {
    mux3 := 0.U
  }

  when(!io.reset_n) {
    reg := 0.U
  }.elsewhen (risingEdge(io.clk)) {
    reg := mux3
  }
}
