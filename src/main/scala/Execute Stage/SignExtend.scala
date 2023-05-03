  // import chisel3._

  // class SignExtend {
  //   def from4(a: UInt): UInt = {
  //     val b = Wire(Vec(16, UInt(1.W)))
  //     b(3, 0) := a
  //     var i = 0
  //     for (i <- 4 to 15) b(i) := a(3)
  //     return b.asUInt
  //   }
  //   def from8(a: UInt): UInt = {
  //     val b = Wire(Vec(16, UInt(1.W)))
  //     b(7, 0) := a
  //     var i = 0
  //     for (i <- 8 to 15) b(i) := a(7)
  //     return b.asUInt
  //   }
  //   def from12(a: UInt): UInt = {
  //     val b = Wire(Vec(16, UInt(1.W)))
  //     b(11, 0) := a
  //     var i = 0
  //     for (i <- 12 to 15) b(i) := a(11)
  //     return b.asUInt
  //   }

  // }
