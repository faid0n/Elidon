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

class SevenSegDec extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))
    val out = Output(UInt(7.W))
  })

  val sevSeg = WireDefault(0.U)

  switch (io.in) {
    is (0.U) { sevSeg := "b0111111".U } // 0
    is (1.U) { sevSeg := "b0000110".U } // 1
    is (2.U) { sevSeg := "b1011011".U } // 2
    is (3.U) { sevSeg := "b1001111".U } // 3
    is (4.U) { sevSeg := "b1100110".U } // 4
    is (5.U) { sevSeg := "b1101101".U } // 5
    is (6.U) { sevSeg := "b1111101".U } // 6
    is (7.U) { sevSeg := "b0000111".U } // 7
    is (8.U) { sevSeg := "b1111111".U } // 8
    is (9.U) { sevSeg := "b1101111".U } // 9
    is (10.U) { sevSeg := "b1110111".U } // A
    is (11.U) { sevSeg := "b1111100".U } // b
    is (12.U) { sevSeg := "b0111001".U } // C
    is (13.U) { sevSeg := "b1011110".U } // d
    is (14.U) { sevSeg := "b1111001".U } // E
    is (15.U) { sevSeg := "b1110001".U } // F
  }

  io.out := sevSeg
}