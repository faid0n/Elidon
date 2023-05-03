import chisel3._
import chisel3.util._


class DisplayMultiplexer() extends Module {
  val io = IO(new Bundle {
    val value = Input(UInt(16.W))
    val display = new Bundle {
      val segments = Output(UInt(7.W))
      val selector = Output(UInt(4.W))
    }
  })

  val sevSeg = WireDefault("b1111111".U(7.W))
  val select = WireDefault("b0001".U(4.W))

  // val countMax = clockFrequency / tickFrequency - 1;
  val countMax = 99999.U(17.W)
  val countReg = RegInit(0.U(17.W))
  countReg := countReg + 1.U
  val tick = countReg === countMax

  when (tick) {
    countReg := 0.U
  }

  val digitReg = RegInit(0.U(2.W))
  digitReg := digitReg + tick

  val sevenSegDec = Module(new SevenSegDec())

  sevenSegDec.io.in := 0.U(4.W);

  switch(digitReg) {
    is(0.U) {
      sevenSegDec.io.in := io.value(3, 0)
      select := "b0001".U
    }
    is(1.U) {
      sevenSegDec.io.in := io.value(7, 4)
      select := "b0010".U
    }
    is(2.U) {
      sevenSegDec.io.in := io.value(11, 8)
      select := "b0100".U
    }
    is(3.U) {
      sevenSegDec.io.in := io.value(15, 12)
      select := "b1000".U
    }
  }

  sevSeg := sevenSegDec.io.out

  io.display.segments := ~sevSeg
  io.display.selector := ~select
}