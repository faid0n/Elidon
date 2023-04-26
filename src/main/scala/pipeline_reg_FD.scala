import chisel3._

class PipelineRegFD extends Module {
  val io = IO(new Bundle {
    val clk = Input(Bool())
    val reset_n = Input(Bool())
    val I_rddata_in = Input(UInt(32.W))
    val next_addr_in = Input(UInt(16.W))
    val I_rddata_out = Output(UInt(32.W))
    val next_addr_out = Output(UInt(16.W))
  })

  val I_rddata_reg = RegInit(0.U(32.W))
  val next_addr_reg = RegInit(0.U(16.W))

  io.I_rddata_out := I_rddata_reg
  io.next_addr_out := next_addr_reg

  when (io.reset_n === false.B) {
    I_rddata_reg := 0.U
    next_addr_reg := 0.U
  } .elsewhen (risingEdge(io.clk)) {
    I_rddata_reg := io.I_rddata_in
    next_addr_reg := io.next_addr_in
  }
}

