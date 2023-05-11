FIRRTL version 1.1.0
circuit FetchStage :
  module InstructionMemory :
    input clock : Clock
    input reset : UInt<1>
    input io_pc : UInt<16>
    output io_instruction : UInt<16>

    node _io_instruction_T = bits(io_pc, 7, 1) @[InstructionMemory.scala 17:30]
    node _io_instruction_T_1 = bits(_io_instruction_T, 4, 0)
    node rom_0 = UInt<16>("hdb04") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_0 = validif(eq(UInt<1>("h0"), _io_instruction_T_1), rom_0) @[InstructionMemory.scala 17:{18,18}]
    node rom_1 = UInt<16>("h9c03") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _io_instruction_T_1), rom_1, _GEN_0) @[InstructionMemory.scala 17:{18,18}]
    node rom_2 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), _io_instruction_T_1), rom_2, _GEN_1) @[InstructionMemory.scala 17:{18,18}]
    node rom_3 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), _io_instruction_T_1), rom_3, _GEN_2) @[InstructionMemory.scala 17:{18,18}]
    node rom_4 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_4 = mux(eq(UInt<3>("h4"), _io_instruction_T_1), rom_4, _GEN_3) @[InstructionMemory.scala 17:{18,18}]
    node rom_5 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_5 = mux(eq(UInt<3>("h5"), _io_instruction_T_1), rom_5, _GEN_4) @[InstructionMemory.scala 17:{18,18}]
    node rom_6 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_6 = mux(eq(UInt<3>("h6"), _io_instruction_T_1), rom_6, _GEN_5) @[InstructionMemory.scala 17:{18,18}]
    node rom_7 = UInt<16>("h4dbc") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_7 = mux(eq(UInt<3>("h7"), _io_instruction_T_1), rom_7, _GEN_6) @[InstructionMemory.scala 17:{18,18}]
    node rom_8 = UInt<16>("h2ebc") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_8 = mux(eq(UInt<4>("h8"), _io_instruction_T_1), rom_8, _GEN_7) @[InstructionMemory.scala 17:{18,18}]
    node rom_9 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_9 = mux(eq(UInt<4>("h9"), _io_instruction_T_1), rom_9, _GEN_8) @[InstructionMemory.scala 17:{18,18}]
    node rom_10 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_10 = mux(eq(UInt<4>("ha"), _io_instruction_T_1), rom_10, _GEN_9) @[InstructionMemory.scala 17:{18,18}]
    node rom_11 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_11 = mux(eq(UInt<4>("hb"), _io_instruction_T_1), rom_11, _GEN_10) @[InstructionMemory.scala 17:{18,18}]
    node rom_12 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_12 = mux(eq(UInt<4>("hc"), _io_instruction_T_1), rom_12, _GEN_11) @[InstructionMemory.scala 17:{18,18}]
    node rom_13 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_13 = mux(eq(UInt<4>("hd"), _io_instruction_T_1), rom_13, _GEN_12) @[InstructionMemory.scala 17:{18,18}]
    node rom_14 = UInt<16>("hed00") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_14 = mux(eq(UInt<4>("he"), _io_instruction_T_1), rom_14, _GEN_13) @[InstructionMemory.scala 17:{18,18}]
    node rom_15 = UInt<16>("hee02") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_15 = mux(eq(UInt<4>("hf"), _io_instruction_T_1), rom_15, _GEN_14) @[InstructionMemory.scala 17:{18,18}]
    node rom_16 = UInt<16>("hf000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_16 = mux(eq(UInt<5>("h10"), _io_instruction_T_1), rom_16, _GEN_15) @[InstructionMemory.scala 17:{18,18}]
    node rom_17 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_17 = mux(eq(UInt<5>("h11"), _io_instruction_T_1), rom_17, _GEN_16) @[InstructionMemory.scala 17:{18,18}]
    node rom_18 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_18 = mux(eq(UInt<5>("h12"), _io_instruction_T_1), rom_18, _GEN_17) @[InstructionMemory.scala 17:{18,18}]
    node rom_19 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_19 = mux(eq(UInt<5>("h13"), _io_instruction_T_1), rom_19, _GEN_18) @[InstructionMemory.scala 17:{18,18}]
    node rom_20 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_20 = mux(eq(UInt<5>("h14"), _io_instruction_T_1), rom_20, _GEN_19) @[InstructionMemory.scala 17:{18,18}]
    node rom_21 = UInt<16>("h2000") @[InstructionMemory.scala 15:{20,20}]
    node _GEN_21 = mux(eq(UInt<5>("h15"), _io_instruction_T_1), rom_21, _GEN_20) @[InstructionMemory.scala 17:{18,18}]
    node _rom_io_instruction_T_1 = _GEN_21 @[InstructionMemory.scala 17:18]
    io_instruction <= _rom_io_instruction_T_1 @[InstructionMemory.scala 17:18]

  module FetchStage :
    input clock : Clock
    input reset : UInt<1>
    input io_branch_enable : UInt<1>
    input io_branch_pc : UInt<16>
    output io_f2d_pc : UInt<16>
    output io_f2d_instruction : UInt<16>

    inst instructionMemory of InstructionMemory @[FetchStage.scala 24:33]
    node _pcReg_T = asUInt(asSInt(UInt<16>("hfffe"))) @[FetchStage.scala 20:36]
    reg pcReg : UInt<16>, clock with :
      reset => (UInt<1>("h0"), pcReg) @[FetchStage.scala 20:22]
    node _pc_T = add(pcReg, UInt<2>("h2")) @[FetchStage.scala 21:54]
    node _pc_T_1 = tail(_pc_T, 1) @[FetchStage.scala 21:54]
    node pc = mux(io_branch_enable, io_branch_pc, _pc_T_1) @[FetchStage.scala 21:15]
    reg io_f2d_instruction_REG : UInt<16>, clock with :
      reset => (UInt<1>("h0"), io_f2d_instruction_REG) @[FetchStage.scala 28:32]
    io_f2d_pc <= pcReg @[FetchStage.scala 27:13]
    io_f2d_instruction <= io_f2d_instruction_REG @[FetchStage.scala 28:22]
    pcReg <= mux(reset, _pcReg_T, pc) @[FetchStage.scala 20:{22,22} 22:9]
    instructionMemory.clock <= clock
    instructionMemory.reset <= reset
    instructionMemory.io_pc <= pc @[FetchStage.scala 25:27]
    io_f2d_instruction_REG <= instructionMemory.io_instruction @[FetchStage.scala 28:32]
