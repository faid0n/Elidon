circuit Elidon :
  module InstructionMemory :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<16>, instruction : UInt<16>}

    wire rom : UInt<16>[20] @[InstructionMemory.scala 13:20]
    rom[0] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[1] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[2] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[3] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[4] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[5] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[6] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[7] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[8] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[9] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[10] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[11] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[12] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[13] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[14] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[15] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[16] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[17] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[18] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    rom[19] <= UInt<16>("h8000") @[InstructionMemory.scala 13:20]
    node _io_instruction_T = bits(io.pc, 7, 1) @[InstructionMemory.scala 14:30]
    node _io_instruction_T_1 = bits(_io_instruction_T, 4, 0)
    io.instruction <= rom[_io_instruction_T_1] @[InstructionMemory.scala 14:18]

  module FetchStage :
    input clock : Clock
    input reset : Reset
    output io : { branch : { flip enable : UInt<1>, flip pc : UInt<16>}, f2d : { pc : UInt<16>, instruction : UInt<16>}}

    reg pcReg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[FetchStage.scala 18:22]
    when io.branch.enable : @[FetchStage.scala 20:26]
      pcReg <= io.branch.pc @[FetchStage.scala 21:11]
    else :
      node _pcReg_T = add(pcReg, UInt<2>("h2")) @[FetchStage.scala 23:20]
      node _pcReg_T_1 = tail(_pcReg_T, 1) @[FetchStage.scala 23:20]
      pcReg <= _pcReg_T_1 @[FetchStage.scala 23:11]
    inst instructionMemory of InstructionMemory @[FetchStage.scala 26:33]
    instructionMemory.clock <= clock
    instructionMemory.reset <= reset
    instructionMemory.io.pc <= pcReg @[FetchStage.scala 27:27]
    reg f2dReg_pc : UInt, clock with :
      reset => (UInt<1>("h0"), f2dReg_pc) @[FetchStage.scala 30:26]
    f2dReg_pc <= pcReg @[FetchStage.scala 30:26]
    reg f2dReg_instruction : UInt, clock with :
      reset => (UInt<1>("h0"), f2dReg_instruction) @[FetchStage.scala 31:35]
    f2dReg_instruction <= instructionMemory.io.instruction @[FetchStage.scala 31:35]
    io.f2d.pc <= f2dReg_pc @[FetchStage.scala 32:13]
    io.f2d.instruction <= f2dReg_instruction @[FetchStage.scala 33:22]

  module DecodeStage :
    input clock : Clock
    input reset : Reset
    output io : { flip f2d : { pc : UInt<16>, instruction : UInt<16>}, d2e : { pc : UInt<16>, instruction : UInt<16>, rs1 : UInt<16>, rs2 : UInt<16>}}

    wire _registerFile_WIRE : UInt<16>[16] @[DecodeStage.scala 17:46]
    _registerFile_WIRE[0] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[1] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[2] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[3] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[4] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[5] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[6] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[7] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[8] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[9] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[10] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[11] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[12] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[13] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[14] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    _registerFile_WIRE[15] <= UInt<16>("h0") @[DecodeStage.scala 17:46]
    reg registerFile : UInt<16>[16], clock with :
      reset => (reset, _registerFile_WIRE) @[DecodeStage.scala 17:29]
    node opcode = bits(io.f2d.instruction, 15, 12) @[DecodeStage.scala 21:27]
    reg d2eReg : { pc : UInt<16>, instruction : UInt<16>, rs1 : UInt<16>, rs2 : UInt<16>}, clock with :
      reset => (UInt<1>("h0"), d2eReg) @[DecodeStage.scala 24:19]
    io.d2e <= d2eReg @[DecodeStage.scala 25:10]
    d2eReg.pc <= io.f2d.pc @[DecodeStage.scala 26:13]
    d2eReg.instruction <= io.f2d.instruction @[DecodeStage.scala 27:22]
    node _d2eReg_rs1_T = bits(opcode, 3, 3) @[DecodeStage.scala 28:40]
    node _d2eReg_rs1_T_1 = bits(io.f2d.instruction, 7, 4) @[DecodeStage.scala 28:56]
    node _d2eReg_rs1_T_2 = bits(io.f2d.instruction, 11, 8) @[DecodeStage.scala 28:75]
    node _d2eReg_rs1_T_3 = mux(_d2eReg_rs1_T, _d2eReg_rs1_T_1, _d2eReg_rs1_T_2) @[DecodeStage.scala 28:33]
    d2eReg.rs1 <= registerFile[_d2eReg_rs1_T_3] @[DecodeStage.scala 28:14]
    node _d2eReg_rs2_T = bits(io.f2d.instruction, 3, 0) @[DecodeStage.scala 29:41]
    d2eReg.rs2 <= registerFile[_d2eReg_rs2_T] @[DecodeStage.scala 29:14]

  module ExecuteStage :
    input clock : Clock
    input reset : Reset
    output io : { branch : { enable : UInt<1>, pc : UInt<16>}, flip d2e : { pc : UInt<16>, instruction : UInt<16>, rs1 : UInt<16>, rs2 : UInt<16>}}

    io.branch.enable <= UInt<1>("h0") @[ExecuteStage.scala 21:20]
    io.branch.pc <= UInt<1>("h0") @[ExecuteStage.scala 22:16]

  module MemoryStage :
    input clock : Clock
    input reset : Reset
    output io : { data : { readAdress : UInt<16>, writeAdress : UInt<16>, writeEnable : UInt<1>, writeValue : UInt<16>, flip readValue : UInt<16>}}

    wire _io_data_readAdress_WIRE : UInt @[MemoryStage.scala 15:36]
    _io_data_readAdress_WIRE <= UInt<1>("h0") @[MemoryStage.scala 15:36]
    io.data.readAdress <= _io_data_readAdress_WIRE @[MemoryStage.scala 15:22]
    wire _io_data_writeAdress_WIRE : UInt @[MemoryStage.scala 16:37]
    _io_data_writeAdress_WIRE <= UInt<1>("h0") @[MemoryStage.scala 16:37]
    io.data.writeAdress <= _io_data_writeAdress_WIRE @[MemoryStage.scala 16:23]
    wire _io_data_writeEnable_WIRE : UInt<1> @[MemoryStage.scala 17:37]
    _io_data_writeEnable_WIRE <= UInt<1>("h0") @[MemoryStage.scala 17:37]
    io.data.writeEnable <= _io_data_writeEnable_WIRE @[MemoryStage.scala 17:23]
    wire _io_data_writeValue_WIRE : UInt @[MemoryStage.scala 18:36]
    _io_data_writeValue_WIRE <= UInt<1>("h0") @[MemoryStage.scala 18:36]
    io.data.writeValue <= _io_data_writeValue_WIRE @[MemoryStage.scala 18:22]

  module WriteBackStage :
    input clock : Clock
    input reset : Reset

    skip

  module DataMemory :
    input clock : Clock
    input reset : Reset
    output io : { data : { flip readAdress : UInt<16>, flip writeAdress : UInt<16>, flip writeEnable : UInt<1>, flip writeValue : UInt<16>, readValue : UInt<16>}, leds : UInt<16>, displayValue : UInt<16>, flip switches : UInt<16>}

    smem evenMem : UInt<8> [13] @[DataMemory.scala 24:28]
    smem oddMem : UInt<8> [13] @[DataMemory.scala 25:27]
    wire readBundle : { msB : UInt<8>, lsB : UInt<8>} @[DataMemory.scala 35:24]
    node _readAdressOdd_T = bits(io.data.readAdress, 15, 1) @[DataMemory.scala 36:53]
    wire readAdressOdd : UInt @[DataMemory.scala 36:34]
    readAdressOdd <= _readAdressOdd_T @[DataMemory.scala 36:34]
    wire readAdressEven : UInt<15> @[DataMemory.scala 37:28]
    node _T = bits(io.data.readAdress, 0, 0) @[DataMemory.scala 39:26]
    when _T : @[DataMemory.scala 39:31]
      node _readAdressEven_T = add(readAdressOdd, UInt<1>("h1")) @[DataMemory.scala 40:37]
      node _readAdressEven_T_1 = tail(_readAdressEven_T, 1) @[DataMemory.scala 40:37]
      readAdressEven <= _readAdressEven_T_1 @[DataMemory.scala 40:20]
      wire _readBundle_msB_WIRE : UInt @[DataMemory.scala 41:35]
      _readBundle_msB_WIRE is invalid @[DataMemory.scala 41:35]
      when UInt<1>("h1") : @[DataMemory.scala 41:35]
        _readBundle_msB_WIRE <= readAdressOdd @[DataMemory.scala 41:35]
        node _readBundle_msB_T = or(_readBundle_msB_WIRE, UInt<4>("h0")) @[DataMemory.scala 41:35]
        node _readBundle_msB_T_1 = bits(_readBundle_msB_T, 3, 0) @[DataMemory.scala 41:35]
        read mport readBundle_msB_MPORT = evenMem[_readBundle_msB_T_1], clock @[DataMemory.scala 41:35]
      readBundle.msB <= readBundle_msB_MPORT @[DataMemory.scala 41:20]
      wire _readBundle_lsB_WIRE : UInt @[DataMemory.scala 42:34]
      _readBundle_lsB_WIRE is invalid @[DataMemory.scala 42:34]
      when UInt<1>("h1") : @[DataMemory.scala 42:34]
        _readBundle_lsB_WIRE <= readAdressEven @[DataMemory.scala 42:34]
        node _readBundle_lsB_T = or(_readBundle_lsB_WIRE, UInt<4>("h0")) @[DataMemory.scala 42:34]
        node _readBundle_lsB_T_1 = bits(_readBundle_lsB_T, 3, 0) @[DataMemory.scala 42:34]
        read mport readBundle_lsB_MPORT = oddMem[_readBundle_lsB_T_1], clock @[DataMemory.scala 42:34]
      readBundle.lsB <= readBundle_lsB_MPORT @[DataMemory.scala 42:20]
    else :
      readAdressEven <= readAdressOdd @[DataMemory.scala 44:20]
      wire _readBundle_msB_WIRE_1 : UInt @[DataMemory.scala 45:35]
      _readBundle_msB_WIRE_1 is invalid @[DataMemory.scala 45:35]
      when UInt<1>("h1") : @[DataMemory.scala 45:35]
        _readBundle_msB_WIRE_1 <= readAdressEven @[DataMemory.scala 45:35]
        node _readBundle_msB_T_2 = or(_readBundle_msB_WIRE_1, UInt<4>("h0")) @[DataMemory.scala 45:35]
        node _readBundle_msB_T_3 = bits(_readBundle_msB_T_2, 3, 0) @[DataMemory.scala 45:35]
        read mport readBundle_msB_MPORT_1 = evenMem[_readBundle_msB_T_3], clock @[DataMemory.scala 45:35]
      readBundle.msB <= readBundle_msB_MPORT_1 @[DataMemory.scala 45:20]
      wire _readBundle_lsB_WIRE_1 : UInt @[DataMemory.scala 46:34]
      _readBundle_lsB_WIRE_1 is invalid @[DataMemory.scala 46:34]
      when UInt<1>("h1") : @[DataMemory.scala 46:34]
        _readBundle_lsB_WIRE_1 <= readAdressOdd @[DataMemory.scala 46:34]
        node _readBundle_lsB_T_2 = or(_readBundle_lsB_WIRE_1, UInt<4>("h0")) @[DataMemory.scala 46:34]
        node _readBundle_lsB_T_3 = bits(_readBundle_lsB_T_2, 3, 0) @[DataMemory.scala 46:34]
        read mport readBundle_lsB_MPORT_1 = oddMem[_readBundle_lsB_T_3], clock @[DataMemory.scala 46:34]
      readBundle.lsB <= readBundle_lsB_MPORT_1 @[DataMemory.scala 46:20]
    wire writeBundle : { even : UInt<8>, odd : UInt<8>} @[DataMemory.scala 57:25]
    node _writeAdressOdd_T = bits(io.data.writeAdress, 15, 1) @[DataMemory.scala 58:55]
    wire writeAdressOdd : UInt @[DataMemory.scala 58:35]
    writeAdressOdd <= _writeAdressOdd_T @[DataMemory.scala 58:35]
    wire writeAdressEven : UInt<15> @[DataMemory.scala 59:29]
    node _T_1 = bits(io.data.writeAdress, 0, 0) @[DataMemory.scala 61:27]
    when _T_1 : @[DataMemory.scala 61:32]
      node _writeAdressEven_T = add(writeAdressOdd, UInt<1>("h1")) @[DataMemory.scala 62:39]
      node _writeAdressEven_T_1 = tail(_writeAdressEven_T, 1) @[DataMemory.scala 62:39]
      writeAdressEven <= _writeAdressEven_T_1 @[DataMemory.scala 62:21]
      node _writeBundle_even_T = bits(io.data.writeValue, 7, 0) @[DataMemory.scala 63:43]
      writeBundle.even <= _writeBundle_even_T @[DataMemory.scala 63:22]
      node _writeBundle_odd_T = bits(io.data.writeValue, 15, 8) @[DataMemory.scala 64:42]
      writeBundle.odd <= _writeBundle_odd_T @[DataMemory.scala 64:21]
    else :
      writeAdressEven <= writeAdressOdd @[DataMemory.scala 66:21]
      node _writeBundle_even_T_1 = bits(io.data.writeValue, 15, 8) @[DataMemory.scala 67:43]
      writeBundle.even <= _writeBundle_even_T_1 @[DataMemory.scala 67:22]
      node _writeBundle_odd_T_1 = bits(io.data.writeValue, 7, 0) @[DataMemory.scala 68:42]
      writeBundle.odd <= _writeBundle_odd_T_1 @[DataMemory.scala 68:21]
    when io.data.writeEnable : @[DataMemory.scala 71:29]
      node _T_2 = bits(writeAdressEven, 3, 0)
      write mport MPORT = evenMem[_T_2], clock
      MPORT <= writeBundle.even
      node _T_3 = or(writeAdressOdd, UInt<4>("h0"))
      node _T_4 = bits(_T_3, 3, 0)
      write mport MPORT_1 = oddMem[_T_4], clock
      MPORT_1 <= writeBundle.odd
    reg leds : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[DataMemory.scala 84:21]
    reg displayValue : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[DataMemory.scala 85:29]
    reg switches : UInt, clock with :
      reset => (UInt<1>("h0"), switches) @[DataMemory.scala 86:25]
    switches <= io.switches @[DataMemory.scala 86:25]
    io.leds <= leds @[DataMemory.scala 89:11]
    io.displayValue <= displayValue @[DataMemory.scala 90:19]
    when io.data.writeEnable : @[DataMemory.scala 94:29]
      node _T_5 = eq(io.data.writeAdress, UInt<1>("h0")) @[DataMemory.scala 95:30]
      when _T_5 : @[DataMemory.scala 95:39]
        leds <= io.data.writeValue @[DataMemory.scala 96:12]
      node _T_6 = eq(io.data.writeAdress, UInt<2>("h2")) @[DataMemory.scala 98:30]
      when _T_6 : @[DataMemory.scala 98:39]
        displayValue <= io.data.writeValue @[DataMemory.scala 99:20]
    node _T_7 = eq(io.data.readAdress, UInt<3>("h4")) @[DataMemory.scala 107:27]
    when _T_7 : @[DataMemory.scala 107:36]
      io.data.readValue <= switches @[DataMemory.scala 108:23]
    else :
      node _T_8 = eq(io.data.readAdress, io.data.writeAdress) @[DataMemory.scala 109:34]
      when _T_8 : @[DataMemory.scala 109:59]
        io.data.readValue <= io.data.writeValue @[DataMemory.scala 110:23]
      else :
        node _io_data_readValue_T = cat(readBundle.msB, readBundle.lsB) @[DataMemory.scala 112:37]
        io.data.readValue <= _io_data_readValue_T @[DataMemory.scala 112:23]


  module SevenSegDec :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire sevSeg : UInt @[DisplayMultiplexer.scala 65:27]
    sevSeg <= UInt<1>("h0") @[DisplayMultiplexer.scala 65:27]
    node _T = eq(UInt<1>("h0"), io.in) @[DisplayMultiplexer.scala 67:18]
    when _T : @[DisplayMultiplexer.scala 67:18]
      sevSeg <= UInt<6>("h3f") @[DisplayMultiplexer.scala 68:23]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[DisplayMultiplexer.scala 67:18]
      when _T_1 : @[DisplayMultiplexer.scala 67:18]
        sevSeg <= UInt<3>("h6") @[DisplayMultiplexer.scala 69:23]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[DisplayMultiplexer.scala 67:18]
        when _T_2 : @[DisplayMultiplexer.scala 67:18]
          sevSeg <= UInt<7>("h5b") @[DisplayMultiplexer.scala 70:23]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[DisplayMultiplexer.scala 67:18]
          when _T_3 : @[DisplayMultiplexer.scala 67:18]
            sevSeg <= UInt<7>("h4f") @[DisplayMultiplexer.scala 71:23]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[DisplayMultiplexer.scala 67:18]
            when _T_4 : @[DisplayMultiplexer.scala 67:18]
              sevSeg <= UInt<7>("h66") @[DisplayMultiplexer.scala 72:23]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[DisplayMultiplexer.scala 67:18]
              when _T_5 : @[DisplayMultiplexer.scala 67:18]
                sevSeg <= UInt<7>("h6d") @[DisplayMultiplexer.scala 73:23]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[DisplayMultiplexer.scala 67:18]
                when _T_6 : @[DisplayMultiplexer.scala 67:18]
                  sevSeg <= UInt<7>("h7d") @[DisplayMultiplexer.scala 74:23]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[DisplayMultiplexer.scala 67:18]
                  when _T_7 : @[DisplayMultiplexer.scala 67:18]
                    sevSeg <= UInt<3>("h7") @[DisplayMultiplexer.scala 75:23]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[DisplayMultiplexer.scala 67:18]
                    when _T_8 : @[DisplayMultiplexer.scala 67:18]
                      sevSeg <= UInt<7>("h7f") @[DisplayMultiplexer.scala 76:23]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[DisplayMultiplexer.scala 67:18]
                      when _T_9 : @[DisplayMultiplexer.scala 67:18]
                        sevSeg <= UInt<7>("h6f") @[DisplayMultiplexer.scala 77:23]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[DisplayMultiplexer.scala 67:18]
                        when _T_10 : @[DisplayMultiplexer.scala 67:18]
                          sevSeg <= UInt<7>("h77") @[DisplayMultiplexer.scala 78:24]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[DisplayMultiplexer.scala 67:18]
                          when _T_11 : @[DisplayMultiplexer.scala 67:18]
                            sevSeg <= UInt<7>("h7c") @[DisplayMultiplexer.scala 79:24]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[DisplayMultiplexer.scala 67:18]
                            when _T_12 : @[DisplayMultiplexer.scala 67:18]
                              sevSeg <= UInt<6>("h39") @[DisplayMultiplexer.scala 80:24]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[DisplayMultiplexer.scala 67:18]
                              when _T_13 : @[DisplayMultiplexer.scala 67:18]
                                sevSeg <= UInt<7>("h5e") @[DisplayMultiplexer.scala 81:24]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[DisplayMultiplexer.scala 67:18]
                                when _T_14 : @[DisplayMultiplexer.scala 67:18]
                                  sevSeg <= UInt<7>("h79") @[DisplayMultiplexer.scala 82:24]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[DisplayMultiplexer.scala 67:18]
                                  when _T_15 : @[DisplayMultiplexer.scala 67:18]
                                    sevSeg <= UInt<7>("h71") @[DisplayMultiplexer.scala 83:24]
    io.out <= sevSeg @[DisplayMultiplexer.scala 86:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : Reset
    output io : { flip value : UInt<16>, display : { segments : UInt<7>, selector : UInt<4>}}

    wire sevSeg : UInt<7> @[DisplayMultiplexer.scala 14:27]
    sevSeg <= UInt<7>("h7f") @[DisplayMultiplexer.scala 14:27]
    wire select : UInt<4> @[DisplayMultiplexer.scala 15:27]
    select <= UInt<4>("h1") @[DisplayMultiplexer.scala 15:27]
    reg countReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[DisplayMultiplexer.scala 19:25]
    node _countReg_T = add(countReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 20:24]
    node _countReg_T_1 = tail(_countReg_T, 1) @[DisplayMultiplexer.scala 20:24]
    countReg <= _countReg_T_1 @[DisplayMultiplexer.scala 20:12]
    node tick = eq(countReg, UInt<17>("h1869f")) @[DisplayMultiplexer.scala 21:23]
    when tick : @[DisplayMultiplexer.scala 23:15]
      countReg <= UInt<1>("h0") @[DisplayMultiplexer.scala 24:14]
    reg digitReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[DisplayMultiplexer.scala 27:25]
    node _digitReg_T = add(digitReg, tick) @[DisplayMultiplexer.scala 28:24]
    node _digitReg_T_1 = tail(_digitReg_T, 1) @[DisplayMultiplexer.scala 28:24]
    digitReg <= _digitReg_T_1 @[DisplayMultiplexer.scala 28:12]
    inst sevenSegDec of SevenSegDec @[DisplayMultiplexer.scala 30:27]
    sevenSegDec.clock <= clock
    sevenSegDec.reset <= reset
    sevenSegDec.io.in <= UInt<4>("h0") @[DisplayMultiplexer.scala 32:21]
    node _T = eq(UInt<1>("h0"), digitReg) @[DisplayMultiplexer.scala 34:20]
    when _T : @[DisplayMultiplexer.scala 34:20]
      node _sevenSegDec_io_in_T = bits(io.value, 3, 0) @[DisplayMultiplexer.scala 36:36]
      sevenSegDec.io.in <= _sevenSegDec_io_in_T @[DisplayMultiplexer.scala 36:25]
      select <= UInt<1>("h1") @[DisplayMultiplexer.scala 37:14]
    else :
      node _T_1 = eq(UInt<1>("h1"), digitReg) @[DisplayMultiplexer.scala 34:20]
      when _T_1 : @[DisplayMultiplexer.scala 34:20]
        node _sevenSegDec_io_in_T_1 = bits(io.value, 7, 4) @[DisplayMultiplexer.scala 40:36]
        sevenSegDec.io.in <= _sevenSegDec_io_in_T_1 @[DisplayMultiplexer.scala 40:25]
        select <= UInt<2>("h2") @[DisplayMultiplexer.scala 41:14]
      else :
        node _T_2 = eq(UInt<2>("h2"), digitReg) @[DisplayMultiplexer.scala 34:20]
        when _T_2 : @[DisplayMultiplexer.scala 34:20]
          node _sevenSegDec_io_in_T_2 = bits(io.value, 11, 8) @[DisplayMultiplexer.scala 44:36]
          sevenSegDec.io.in <= _sevenSegDec_io_in_T_2 @[DisplayMultiplexer.scala 44:25]
          select <= UInt<3>("h4") @[DisplayMultiplexer.scala 45:14]
        else :
          node _T_3 = eq(UInt<2>("h3"), digitReg) @[DisplayMultiplexer.scala 34:20]
          when _T_3 : @[DisplayMultiplexer.scala 34:20]
            node _sevenSegDec_io_in_T_3 = bits(io.value, 15, 12) @[DisplayMultiplexer.scala 48:36]
            sevenSegDec.io.in <= _sevenSegDec_io_in_T_3 @[DisplayMultiplexer.scala 48:25]
            select <= UInt<4>("h8") @[DisplayMultiplexer.scala 49:14]
    sevSeg <= sevenSegDec.io.out @[DisplayMultiplexer.scala 53:10]
    node _io_display_segments_T = not(sevSeg) @[DisplayMultiplexer.scala 55:26]
    io.display.segments <= _io_display_segments_T @[DisplayMultiplexer.scala 55:23]
    node _io_display_selector_T = not(select) @[DisplayMultiplexer.scala 56:26]
    io.display.selector <= _io_display_selector_T @[DisplayMultiplexer.scala 56:23]

  module Elidon :
    input clock : Clock
    input reset : UInt<1>
    output io : { leds : UInt<16>, display : { segments : UInt<7>, selector : UInt<4>}, flip switches : UInt<16>}

    inst fetchStage of FetchStage @[Main.scala 15:26]
    fetchStage.clock <= clock
    fetchStage.reset <= reset
    inst decodeStage of DecodeStage @[Main.scala 16:27]
    decodeStage.clock <= clock
    decodeStage.reset <= reset
    inst executeStage of ExecuteStage @[Main.scala 17:28]
    executeStage.clock <= clock
    executeStage.reset <= reset
    inst memoryStage of MemoryStage @[Main.scala 18:27]
    memoryStage.clock <= clock
    memoryStage.reset <= reset
    inst writeBackStage of WriteBackStage @[Main.scala 19:30]
    writeBackStage.clock <= clock
    writeBackStage.reset <= reset
    decodeStage.io.f2d <= fetchStage.io.f2d @[Main.scala 22:21]
    executeStage.io.d2e <= decodeStage.io.d2e @[Main.scala 23:22]
    fetchStage.io.branch.enable <= executeStage.io.branch.enable @[Main.scala 28:31]
    fetchStage.io.branch.pc <= executeStage.io.branch.pc @[Main.scala 29:27]
    inst dataMemory of DataMemory @[Main.scala 32:26]
    dataMemory.clock <= clock
    dataMemory.reset <= reset
    memoryStage.io.data.readValue <= dataMemory.io.data.readValue @[Main.scala 33:23]
    dataMemory.io.data.writeValue <= memoryStage.io.data.writeValue @[Main.scala 33:23]
    dataMemory.io.data.writeEnable <= memoryStage.io.data.writeEnable @[Main.scala 33:23]
    dataMemory.io.data.writeAdress <= memoryStage.io.data.writeAdress @[Main.scala 33:23]
    dataMemory.io.data.readAdress <= memoryStage.io.data.readAdress @[Main.scala 33:23]
    dataMemory.io.switches <= io.switches @[Main.scala 36:26]
    io.leds <= dataMemory.io.leds @[Main.scala 37:11]
    inst displayMultiplexer of DisplayMultiplexer @[Main.scala 38:34]
    displayMultiplexer.clock <= clock
    displayMultiplexer.reset <= reset
    displayMultiplexer.io.value <= dataMemory.io.displayValue @[Main.scala 39:31]
    io.display <= displayMultiplexer.io.display @[Main.scala 40:14]

