circuit Elidon :
  module InstructionMemory :
    input clock : Clock
    input reset : Reset

    skip

  module FetchStage :
    input clock : Clock
    input reset : Reset

    inst instructionMemory of InstructionMemory @[FetchStage.scala 7:33]
    instructionMemory.clock <= clock
    instructionMemory.reset <= reset

  module DecodeStage :
    input clock : Clock
    input reset : Reset

    skip

  module InstructionMemory_1 :
    input clock : Clock
    input reset : Reset

    skip

  module FetchStage_1 :
    input clock : Clock
    input reset : Reset

    inst instructionMemory of InstructionMemory_1 @[FetchStage.scala 7:33]
    instructionMemory.clock <= clock
    instructionMemory.reset <= reset

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

    smem evenMem : UInt<8> [13] @[DataMemory.scala 23:28]
    smem oddMem : UInt<8> [13] @[DataMemory.scala 24:27]
    wire readBundle : { msB : UInt<8>, lsB : UInt<8>} @[DataMemory.scala 34:24]
    node _readAdressOdd_T = bits(io.data.readAdress, 15, 1) @[DataMemory.scala 35:53]
    wire readAdressOdd : UInt @[DataMemory.scala 35:34]
    readAdressOdd <= _readAdressOdd_T @[DataMemory.scala 35:34]
    wire readAdressEven : UInt<15> @[DataMemory.scala 36:28]
    node _T = bits(io.data.readAdress, 0, 0) @[DataMemory.scala 38:26]
    when _T : @[DataMemory.scala 38:31]
      node _readAdressEven_T = add(readAdressOdd, UInt<1>("h1")) @[DataMemory.scala 39:37]
      node _readAdressEven_T_1 = tail(_readAdressEven_T, 1) @[DataMemory.scala 39:37]
      readAdressEven <= _readAdressEven_T_1 @[DataMemory.scala 39:20]
      wire _readBundle_msB_WIRE : UInt @[DataMemory.scala 40:35]
      _readBundle_msB_WIRE is invalid @[DataMemory.scala 40:35]
      when UInt<1>("h1") : @[DataMemory.scala 40:35]
        _readBundle_msB_WIRE <= readAdressOdd @[DataMemory.scala 40:35]
        node _readBundle_msB_T = or(_readBundle_msB_WIRE, UInt<4>("h0")) @[DataMemory.scala 40:35]
        node _readBundle_msB_T_1 = bits(_readBundle_msB_T, 3, 0) @[DataMemory.scala 40:35]
        read mport readBundle_msB_MPORT = evenMem[_readBundle_msB_T_1], clock @[DataMemory.scala 40:35]
      readBundle.msB <= readBundle_msB_MPORT @[DataMemory.scala 40:20]
      wire _readBundle_lsB_WIRE : UInt @[DataMemory.scala 41:34]
      _readBundle_lsB_WIRE is invalid @[DataMemory.scala 41:34]
      when UInt<1>("h1") : @[DataMemory.scala 41:34]
        _readBundle_lsB_WIRE <= readAdressEven @[DataMemory.scala 41:34]
        node _readBundle_lsB_T = or(_readBundle_lsB_WIRE, UInt<4>("h0")) @[DataMemory.scala 41:34]
        node _readBundle_lsB_T_1 = bits(_readBundle_lsB_T, 3, 0) @[DataMemory.scala 41:34]
        read mport readBundle_lsB_MPORT = oddMem[_readBundle_lsB_T_1], clock @[DataMemory.scala 41:34]
      readBundle.lsB <= readBundle_lsB_MPORT @[DataMemory.scala 41:20]
    else :
      readAdressEven <= readAdressOdd @[DataMemory.scala 43:20]
      wire _readBundle_msB_WIRE_1 : UInt @[DataMemory.scala 44:35]
      _readBundle_msB_WIRE_1 is invalid @[DataMemory.scala 44:35]
      when UInt<1>("h1") : @[DataMemory.scala 44:35]
        _readBundle_msB_WIRE_1 <= readAdressEven @[DataMemory.scala 44:35]
        node _readBundle_msB_T_2 = or(_readBundle_msB_WIRE_1, UInt<4>("h0")) @[DataMemory.scala 44:35]
        node _readBundle_msB_T_3 = bits(_readBundle_msB_T_2, 3, 0) @[DataMemory.scala 44:35]
        read mport readBundle_msB_MPORT_1 = evenMem[_readBundle_msB_T_3], clock @[DataMemory.scala 44:35]
      readBundle.msB <= readBundle_msB_MPORT_1 @[DataMemory.scala 44:20]
      wire _readBundle_lsB_WIRE_1 : UInt @[DataMemory.scala 45:34]
      _readBundle_lsB_WIRE_1 is invalid @[DataMemory.scala 45:34]
      when UInt<1>("h1") : @[DataMemory.scala 45:34]
        _readBundle_lsB_WIRE_1 <= readAdressOdd @[DataMemory.scala 45:34]
        node _readBundle_lsB_T_2 = or(_readBundle_lsB_WIRE_1, UInt<4>("h0")) @[DataMemory.scala 45:34]
        node _readBundle_lsB_T_3 = bits(_readBundle_lsB_T_2, 3, 0) @[DataMemory.scala 45:34]
        read mport readBundle_lsB_MPORT_1 = oddMem[_readBundle_lsB_T_3], clock @[DataMemory.scala 45:34]
      readBundle.lsB <= readBundle_lsB_MPORT_1 @[DataMemory.scala 45:20]
    wire writeBundle : { even : UInt<8>, odd : UInt<8>} @[DataMemory.scala 56:25]
    node _writeAdressOdd_T = bits(io.data.writeAdress, 15, 1) @[DataMemory.scala 57:55]
    wire writeAdressOdd : UInt @[DataMemory.scala 57:35]
    writeAdressOdd <= _writeAdressOdd_T @[DataMemory.scala 57:35]
    wire writeAdressEven : UInt<15> @[DataMemory.scala 58:29]
    node _T_1 = bits(io.data.writeAdress, 0, 0) @[DataMemory.scala 60:27]
    when _T_1 : @[DataMemory.scala 60:32]
      node _writeAdressEven_T = add(writeAdressOdd, UInt<1>("h1")) @[DataMemory.scala 61:39]
      node _writeAdressEven_T_1 = tail(_writeAdressEven_T, 1) @[DataMemory.scala 61:39]
      writeAdressEven <= _writeAdressEven_T_1 @[DataMemory.scala 61:21]
      node _writeBundle_even_T = bits(io.data.writeValue, 7, 0) @[DataMemory.scala 62:43]
      writeBundle.even <= _writeBundle_even_T @[DataMemory.scala 62:22]
      node _writeBundle_odd_T = bits(io.data.writeValue, 15, 8) @[DataMemory.scala 63:42]
      writeBundle.odd <= _writeBundle_odd_T @[DataMemory.scala 63:21]
    else :
      writeAdressEven <= writeAdressOdd @[DataMemory.scala 65:21]
      node _writeBundle_even_T_1 = bits(io.data.writeValue, 15, 8) @[DataMemory.scala 66:43]
      writeBundle.even <= _writeBundle_even_T_1 @[DataMemory.scala 66:22]
      node _writeBundle_odd_T_1 = bits(io.data.writeValue, 7, 0) @[DataMemory.scala 67:42]
      writeBundle.odd <= _writeBundle_odd_T_1 @[DataMemory.scala 67:21]
    when io.data.writeEnable : @[DataMemory.scala 70:29]
      node _T_2 = bits(writeAdressEven, 3, 0)
      write mport MPORT = evenMem[_T_2], clock
      MPORT <= writeBundle.even
      node _T_3 = or(writeAdressOdd, UInt<4>("h0"))
      node _T_4 = bits(_T_3, 3, 0)
      write mport MPORT_1 = oddMem[_T_4], clock
      MPORT_1 <= writeBundle.odd
    reg ledsReg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[DataMemory.scala 83:24]
    reg displayValueReg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[DataMemory.scala 84:32]
    reg switchesReg : UInt, clock with :
      reset => (UInt<1>("h0"), switchesReg) @[DataMemory.scala 85:28]
    switchesReg <= io.switches @[DataMemory.scala 85:28]
    io.leds <= ledsReg @[DataMemory.scala 88:11]
    io.displayValue <= displayValueReg @[DataMemory.scala 89:19]
    when io.data.writeEnable : @[DataMemory.scala 93:29]
      node _T_5 = eq(io.data.writeAdress, UInt<1>("h0")) @[DataMemory.scala 94:30]
      when _T_5 : @[DataMemory.scala 94:39]
        ledsReg <= io.data.writeValue @[DataMemory.scala 95:15]
      node _T_6 = eq(io.data.writeAdress, UInt<2>("h2")) @[DataMemory.scala 97:30]
      when _T_6 : @[DataMemory.scala 97:39]
        displayValueReg <= io.data.writeValue @[DataMemory.scala 98:23]
    node _T_7 = eq(io.data.readAdress, UInt<3>("h4")) @[DataMemory.scala 106:27]
    when _T_7 : @[DataMemory.scala 106:36]
      io.data.readValue <= switchesReg @[DataMemory.scala 107:23]
    else :
      node _T_8 = eq(io.data.readAdress, io.data.writeAdress) @[DataMemory.scala 108:34]
      when _T_8 : @[DataMemory.scala 108:59]
        io.data.readValue <= io.data.writeValue @[DataMemory.scala 109:23]
      else :
        node _io_data_readValue_T = cat(readBundle.msB, readBundle.lsB) @[DataMemory.scala 111:37]
        io.data.readValue <= _io_data_readValue_T @[DataMemory.scala 111:23]


  module SevenSegDec :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire sevSeg : UInt @[SevenSegDec.scala 10:27]
    sevSeg <= UInt<1>("h0") @[SevenSegDec.scala 10:27]
    node _T = eq(UInt<1>("h0"), io.in) @[SevenSegDec.scala 12:18]
    when _T : @[SevenSegDec.scala 12:18]
      sevSeg <= UInt<6>("h3f") @[SevenSegDec.scala 13:23]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[SevenSegDec.scala 12:18]
      when _T_1 : @[SevenSegDec.scala 12:18]
        sevSeg <= UInt<3>("h6") @[SevenSegDec.scala 14:23]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[SevenSegDec.scala 12:18]
        when _T_2 : @[SevenSegDec.scala 12:18]
          sevSeg <= UInt<7>("h5b") @[SevenSegDec.scala 15:23]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[SevenSegDec.scala 12:18]
          when _T_3 : @[SevenSegDec.scala 12:18]
            sevSeg <= UInt<7>("h4f") @[SevenSegDec.scala 16:23]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[SevenSegDec.scala 12:18]
            when _T_4 : @[SevenSegDec.scala 12:18]
              sevSeg <= UInt<7>("h66") @[SevenSegDec.scala 17:23]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[SevenSegDec.scala 12:18]
              when _T_5 : @[SevenSegDec.scala 12:18]
                sevSeg <= UInt<7>("h6d") @[SevenSegDec.scala 18:23]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[SevenSegDec.scala 12:18]
                when _T_6 : @[SevenSegDec.scala 12:18]
                  sevSeg <= UInt<7>("h7d") @[SevenSegDec.scala 19:23]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[SevenSegDec.scala 12:18]
                  when _T_7 : @[SevenSegDec.scala 12:18]
                    sevSeg <= UInt<3>("h7") @[SevenSegDec.scala 20:23]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[SevenSegDec.scala 12:18]
                    when _T_8 : @[SevenSegDec.scala 12:18]
                      sevSeg <= UInt<7>("h7f") @[SevenSegDec.scala 21:23]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[SevenSegDec.scala 12:18]
                      when _T_9 : @[SevenSegDec.scala 12:18]
                        sevSeg <= UInt<7>("h6f") @[SevenSegDec.scala 22:23]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[SevenSegDec.scala 12:18]
                        when _T_10 : @[SevenSegDec.scala 12:18]
                          sevSeg <= UInt<7>("h77") @[SevenSegDec.scala 23:24]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[SevenSegDec.scala 12:18]
                          when _T_11 : @[SevenSegDec.scala 12:18]
                            sevSeg <= UInt<7>("h7c") @[SevenSegDec.scala 24:24]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[SevenSegDec.scala 12:18]
                            when _T_12 : @[SevenSegDec.scala 12:18]
                              sevSeg <= UInt<6>("h39") @[SevenSegDec.scala 25:24]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[SevenSegDec.scala 12:18]
                              when _T_13 : @[SevenSegDec.scala 12:18]
                                sevSeg <= UInt<7>("h5e") @[SevenSegDec.scala 26:24]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[SevenSegDec.scala 12:18]
                                when _T_14 : @[SevenSegDec.scala 12:18]
                                  sevSeg <= UInt<7>("h79") @[SevenSegDec.scala 27:24]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[SevenSegDec.scala 12:18]
                                  when _T_15 : @[SevenSegDec.scala 12:18]
                                    sevSeg <= UInt<7>("h71") @[SevenSegDec.scala 28:24]
    io.out <= sevSeg @[SevenSegDec.scala 31:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : Reset
    output io : { flip value : UInt<16>, display : { segments : UInt<7>, selector : UInt<4>}}

    wire sevSeg : UInt<7> @[DisplayMultiplexer.scala 13:27]
    sevSeg <= UInt<7>("h7f") @[DisplayMultiplexer.scala 13:27]
    wire select : UInt<4> @[DisplayMultiplexer.scala 14:27]
    select <= UInt<4>("h1") @[DisplayMultiplexer.scala 14:27]
    reg countReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[DisplayMultiplexer.scala 18:25]
    node _countReg_T = add(countReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 19:24]
    node _countReg_T_1 = tail(_countReg_T, 1) @[DisplayMultiplexer.scala 19:24]
    countReg <= _countReg_T_1 @[DisplayMultiplexer.scala 19:12]
    node tick = eq(countReg, UInt<17>("h1869f")) @[DisplayMultiplexer.scala 20:23]
    when tick : @[DisplayMultiplexer.scala 22:15]
      countReg <= UInt<1>("h0") @[DisplayMultiplexer.scala 23:14]
    reg digitReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[DisplayMultiplexer.scala 26:25]
    node _digitReg_T = add(digitReg, tick) @[DisplayMultiplexer.scala 27:24]
    node _digitReg_T_1 = tail(_digitReg_T, 1) @[DisplayMultiplexer.scala 27:24]
    digitReg <= _digitReg_T_1 @[DisplayMultiplexer.scala 27:12]
    inst sevenSegDec of SevenSegDec @[DisplayMultiplexer.scala 29:27]
    sevenSegDec.clock <= clock
    sevenSegDec.reset <= reset
    sevenSegDec.io.in <= UInt<4>("h0") @[DisplayMultiplexer.scala 31:21]
    node _T = eq(UInt<1>("h0"), digitReg) @[DisplayMultiplexer.scala 33:20]
    when _T : @[DisplayMultiplexer.scala 33:20]
      node _sevenSegDec_io_in_T = bits(io.value, 3, 0) @[DisplayMultiplexer.scala 35:36]
      sevenSegDec.io.in <= _sevenSegDec_io_in_T @[DisplayMultiplexer.scala 35:25]
      select <= UInt<1>("h1") @[DisplayMultiplexer.scala 36:14]
    else :
      node _T_1 = eq(UInt<1>("h1"), digitReg) @[DisplayMultiplexer.scala 33:20]
      when _T_1 : @[DisplayMultiplexer.scala 33:20]
        node _sevenSegDec_io_in_T_1 = bits(io.value, 7, 4) @[DisplayMultiplexer.scala 39:36]
        sevenSegDec.io.in <= _sevenSegDec_io_in_T_1 @[DisplayMultiplexer.scala 39:25]
        select <= UInt<2>("h2") @[DisplayMultiplexer.scala 40:14]
      else :
        node _T_2 = eq(UInt<2>("h2"), digitReg) @[DisplayMultiplexer.scala 33:20]
        when _T_2 : @[DisplayMultiplexer.scala 33:20]
          node _sevenSegDec_io_in_T_2 = bits(io.value, 11, 8) @[DisplayMultiplexer.scala 43:36]
          sevenSegDec.io.in <= _sevenSegDec_io_in_T_2 @[DisplayMultiplexer.scala 43:25]
          select <= UInt<3>("h4") @[DisplayMultiplexer.scala 44:14]
        else :
          node _T_3 = eq(UInt<2>("h3"), digitReg) @[DisplayMultiplexer.scala 33:20]
          when _T_3 : @[DisplayMultiplexer.scala 33:20]
            node _sevenSegDec_io_in_T_3 = bits(io.value, 15, 12) @[DisplayMultiplexer.scala 47:36]
            sevenSegDec.io.in <= _sevenSegDec_io_in_T_3 @[DisplayMultiplexer.scala 47:25]
            select <= UInt<4>("h8") @[DisplayMultiplexer.scala 48:14]
    sevSeg <= sevenSegDec.io.out @[DisplayMultiplexer.scala 52:10]
    node _io_display_segments_T = not(sevSeg) @[DisplayMultiplexer.scala 54:26]
    io.display.segments <= _io_display_segments_T @[DisplayMultiplexer.scala 54:23]
    node _io_display_selector_T = not(select) @[DisplayMultiplexer.scala 55:26]
    io.display.selector <= _io_display_selector_T @[DisplayMultiplexer.scala 55:23]

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
    inst executeStage of FetchStage_1 @[Main.scala 17:28]
    executeStage.clock <= clock
    executeStage.reset <= reset
    inst memoryStage of MemoryStage @[Main.scala 18:27]
    memoryStage.clock <= clock
    memoryStage.reset <= reset
    inst writeBackStage of WriteBackStage @[Main.scala 19:30]
    writeBackStage.clock <= clock
    writeBackStage.reset <= reset
    inst dataMemory of DataMemory @[Main.scala 22:26]
    dataMemory.clock <= clock
    dataMemory.reset <= reset
    memoryStage.io.data.readValue <= dataMemory.io.data.readValue @[Main.scala 23:23]
    dataMemory.io.data.writeValue <= memoryStage.io.data.writeValue @[Main.scala 23:23]
    dataMemory.io.data.writeEnable <= memoryStage.io.data.writeEnable @[Main.scala 23:23]
    dataMemory.io.data.writeAdress <= memoryStage.io.data.writeAdress @[Main.scala 23:23]
    dataMemory.io.data.readAdress <= memoryStage.io.data.readAdress @[Main.scala 23:23]
    dataMemory.io.switches <= io.switches @[Main.scala 26:26]
    io.leds <= dataMemory.io.leds @[Main.scala 27:11]
    inst displayMultiplexer of DisplayMultiplexer @[Main.scala 28:34]
    displayMultiplexer.clock <= clock
    displayMultiplexer.reset <= reset
    displayMultiplexer.io.value <= dataMemory.io.displayValue @[Main.scala 29:31]
    io.display <= displayMultiplexer.io.display @[Main.scala 30:14]

