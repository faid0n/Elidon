module InstructionMemory(
  input  [15:0] io_pc,
  output [15:0] io_instruction
);
  wire [15:0] _GEN_1 = 5'h1 == io_pc[5:1] ? 16'h9c03 : 16'hdb04; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_2 = 5'h2 == io_pc[5:1] ? 16'h2000 : _GEN_1; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_3 = 5'h3 == io_pc[5:1] ? 16'h2000 : _GEN_2; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_4 = 5'h4 == io_pc[5:1] ? 16'h2000 : _GEN_3; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_5 = 5'h5 == io_pc[5:1] ? 16'h2000 : _GEN_4; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_6 = 5'h6 == io_pc[5:1] ? 16'h2000 : _GEN_5; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_7 = 5'h7 == io_pc[5:1] ? 16'h4dbc : _GEN_6; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_8 = 5'h8 == io_pc[5:1] ? 16'h2ebc : _GEN_7; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_9 = 5'h9 == io_pc[5:1] ? 16'h2000 : _GEN_8; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_10 = 5'ha == io_pc[5:1] ? 16'h2000 : _GEN_9; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_11 = 5'hb == io_pc[5:1] ? 16'h2000 : _GEN_10; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_12 = 5'hc == io_pc[5:1] ? 16'h2000 : _GEN_11; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_13 = 5'hd == io_pc[5:1] ? 16'h2000 : _GEN_12; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_14 = 5'he == io_pc[5:1] ? 16'hed00 : _GEN_13; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_15 = 5'hf == io_pc[5:1] ? 16'hee02 : _GEN_14; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_16 = 5'h10 == io_pc[5:1] ? 16'hf000 : _GEN_15; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_17 = 5'h11 == io_pc[5:1] ? 16'h2000 : _GEN_16; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_18 = 5'h12 == io_pc[5:1] ? 16'h2000 : _GEN_17; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_19 = 5'h13 == io_pc[5:1] ? 16'h2000 : _GEN_18; // @[InstructionMemory.scala 17:{18,18}]
  wire [15:0] _GEN_20 = 5'h14 == io_pc[5:1] ? 16'h2000 : _GEN_19; // @[InstructionMemory.scala 17:{18,18}]
  assign io_instruction = 5'h15 == io_pc[5:1] ? 16'h2000 : _GEN_20; // @[InstructionMemory.scala 17:{18,18}]
endmodule
module FetchStage(
  input         clock,
  input         reset,
  input         io_branch_enable,
  input  [15:0] io_branch_pc,
  output [15:0] io_f2d_pc,
  output [15:0] io_f2d_instruction
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] instructionMemory_io_pc; // @[FetchStage.scala 24:33]
  wire [15:0] instructionMemory_io_instruction; // @[FetchStage.scala 24:33]
  reg [15:0] pcReg; // @[FetchStage.scala 20:22]
  wire [15:0] _pc_T_1 = pcReg + 16'h2; // @[FetchStage.scala 21:54]
  reg [15:0] io_f2d_instruction_REG; // @[FetchStage.scala 28:32]
  InstructionMemory instructionMemory ( // @[FetchStage.scala 24:33]
    .io_pc(instructionMemory_io_pc),
    .io_instruction(instructionMemory_io_instruction)
  );
  assign io_f2d_pc = pcReg; // @[FetchStage.scala 27:13]
  assign io_f2d_instruction = io_f2d_instruction_REG; // @[FetchStage.scala 28:22]
  assign instructionMemory_io_pc = io_branch_enable ? io_branch_pc : _pc_T_1; // @[FetchStage.scala 21:15]
  always @(posedge clock) begin
    if (reset) begin // @[FetchStage.scala 20:22]
      pcReg <= 16'hfffe; // @[FetchStage.scala 20:22]
    end else if (io_branch_enable) begin // @[FetchStage.scala 21:15]
      pcReg <= io_branch_pc;
    end else begin
      pcReg <= _pc_T_1;
    end
    io_f2d_instruction_REG <= instructionMemory_io_instruction; // @[FetchStage.scala 28:32]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcReg = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_f2d_instruction_REG = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DecodeStage(
  input         clock,
  input         reset,
  input  [15:0] io_f2d_pc,
  input  [15:0] io_f2d_instruction,
  output [15:0] io_d2e_pc,
  output [15:0] io_d2e_instruction,
  output [15:0] io_d2e_rs1,
  output [15:0] io_d2e_rs2,
  input  [15:0] io_m2w_rd,
  input  [3:0]  io_m2w_rdAdress,
  input         io_m2w_writeBack
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] registerFile_0; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_1; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_2; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_3; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_4; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_5; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_6; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_7; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_8; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_9; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_10; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_11; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_12; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_13; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_14; // @[DecodeStage.scala 18:29]
  reg [15:0] registerFile_15; // @[DecodeStage.scala 18:29]
  wire [3:0] opcode = io_f2d_instruction[15:12]; // @[DecodeStage.scala 22:27]
  reg [15:0] d2eReg_pc; // @[DecodeStage.scala 25:19]
  reg [15:0] d2eReg_instruction; // @[DecodeStage.scala 25:19]
  reg [15:0] d2eReg_rs1; // @[DecodeStage.scala 25:19]
  reg [15:0] d2eReg_rs2; // @[DecodeStage.scala 25:19]
  wire [3:0] _d2eReg_rs1_T_3 = opcode[3] ? io_f2d_instruction[7:4] : io_f2d_instruction[11:8]; // @[DecodeStage.scala 29:33]
  wire [15:0] _GEN_1 = 4'h1 == _d2eReg_rs1_T_3 ? registerFile_1 : registerFile_0; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_2 = 4'h2 == _d2eReg_rs1_T_3 ? registerFile_2 : _GEN_1; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_3 = 4'h3 == _d2eReg_rs1_T_3 ? registerFile_3 : _GEN_2; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_4 = 4'h4 == _d2eReg_rs1_T_3 ? registerFile_4 : _GEN_3; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_5 = 4'h5 == _d2eReg_rs1_T_3 ? registerFile_5 : _GEN_4; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_6 = 4'h6 == _d2eReg_rs1_T_3 ? registerFile_6 : _GEN_5; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_7 = 4'h7 == _d2eReg_rs1_T_3 ? registerFile_7 : _GEN_6; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_8 = 4'h8 == _d2eReg_rs1_T_3 ? registerFile_8 : _GEN_7; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_9 = 4'h9 == _d2eReg_rs1_T_3 ? registerFile_9 : _GEN_8; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_10 = 4'ha == _d2eReg_rs1_T_3 ? registerFile_10 : _GEN_9; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_11 = 4'hb == _d2eReg_rs1_T_3 ? registerFile_11 : _GEN_10; // @[DecodeStage.scala 29:{14,14}]
  wire [15:0] _GEN_17 = 4'h1 == io_f2d_instruction[3:0] ? registerFile_1 : registerFile_0; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_18 = 4'h2 == io_f2d_instruction[3:0] ? registerFile_2 : _GEN_17; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_19 = 4'h3 == io_f2d_instruction[3:0] ? registerFile_3 : _GEN_18; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_20 = 4'h4 == io_f2d_instruction[3:0] ? registerFile_4 : _GEN_19; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_21 = 4'h5 == io_f2d_instruction[3:0] ? registerFile_5 : _GEN_20; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_22 = 4'h6 == io_f2d_instruction[3:0] ? registerFile_6 : _GEN_21; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_23 = 4'h7 == io_f2d_instruction[3:0] ? registerFile_7 : _GEN_22; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_24 = 4'h8 == io_f2d_instruction[3:0] ? registerFile_8 : _GEN_23; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_25 = 4'h9 == io_f2d_instruction[3:0] ? registerFile_9 : _GEN_24; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_26 = 4'ha == io_f2d_instruction[3:0] ? registerFile_10 : _GEN_25; // @[DecodeStage.scala 30:{14,14}]
  wire [15:0] _GEN_27 = 4'hb == io_f2d_instruction[3:0] ? registerFile_11 : _GEN_26; // @[DecodeStage.scala 30:{14,14}]
  assign io_d2e_pc = d2eReg_pc; // @[DecodeStage.scala 26:10]
  assign io_d2e_instruction = d2eReg_instruction; // @[DecodeStage.scala 26:10]
  assign io_d2e_rs1 = d2eReg_rs1; // @[DecodeStage.scala 26:10]
  assign io_d2e_rs2 = d2eReg_rs2; // @[DecodeStage.scala 26:10]
  always @(posedge clock) begin
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_0 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h0 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_0 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_1 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h1 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_1 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_2 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h2 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_2 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_3 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h3 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_3 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_4 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h4 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_4 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_5 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h5 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_5 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_6 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h6 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_6 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_7 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h7 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_7 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_8 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h8 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_8 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_9 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'h9 == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_9 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_10 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'ha == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_10 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_11 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'hb == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_11 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_12 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'hc == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_12 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_13 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'hd == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_13 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_14 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'he == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_14 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    if (reset) begin // @[DecodeStage.scala 18:29]
      registerFile_15 <= 16'h0; // @[DecodeStage.scala 18:29]
    end else if (io_m2w_writeBack) begin // @[DecodeStage.scala 36:27]
      if (4'hf == io_m2w_rdAdress) begin // @[DecodeStage.scala 37:36]
        registerFile_15 <= io_m2w_rd; // @[DecodeStage.scala 37:36]
      end
    end
    d2eReg_pc <= io_f2d_pc; // @[DecodeStage.scala 27:13]
    d2eReg_instruction <= io_f2d_instruction; // @[DecodeStage.scala 28:22]
    if (4'hf == _d2eReg_rs1_T_3) begin // @[DecodeStage.scala 29:14]
      d2eReg_rs1 <= registerFile_15; // @[DecodeStage.scala 29:14]
    end else if (4'he == _d2eReg_rs1_T_3) begin // @[DecodeStage.scala 29:14]
      d2eReg_rs1 <= registerFile_14; // @[DecodeStage.scala 29:14]
    end else if (4'hd == _d2eReg_rs1_T_3) begin // @[DecodeStage.scala 29:14]
      d2eReg_rs1 <= registerFile_13; // @[DecodeStage.scala 29:14]
    end else if (4'hc == _d2eReg_rs1_T_3) begin // @[DecodeStage.scala 29:14]
      d2eReg_rs1 <= registerFile_12; // @[DecodeStage.scala 29:14]
    end else begin
      d2eReg_rs1 <= _GEN_11;
    end
    if (4'hf == io_f2d_instruction[3:0]) begin // @[DecodeStage.scala 30:14]
      d2eReg_rs2 <= registerFile_15; // @[DecodeStage.scala 30:14]
    end else if (4'he == io_f2d_instruction[3:0]) begin // @[DecodeStage.scala 30:14]
      d2eReg_rs2 <= registerFile_14; // @[DecodeStage.scala 30:14]
    end else if (4'hd == io_f2d_instruction[3:0]) begin // @[DecodeStage.scala 30:14]
      d2eReg_rs2 <= registerFile_13; // @[DecodeStage.scala 30:14]
    end else if (4'hc == io_f2d_instruction[3:0]) begin // @[DecodeStage.scala 30:14]
      d2eReg_rs2 <= registerFile_12; // @[DecodeStage.scala 30:14]
    end else begin
      d2eReg_rs2 <= _GEN_27;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registerFile_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  registerFile_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  registerFile_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  registerFile_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  registerFile_4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  registerFile_5 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  registerFile_6 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  registerFile_7 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  registerFile_8 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  registerFile_9 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  registerFile_10 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  registerFile_11 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  registerFile_12 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  registerFile_13 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  registerFile_14 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  registerFile_15 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  d2eReg_pc = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  d2eReg_instruction = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  d2eReg_rs1 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  d2eReg_rs2 = _RAND_19[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ExecuteStage(
  input         clock,
  input         reset,
  output        io_branch_enable,
  output [15:0] io_branch_pc,
  input  [15:0] io_d2e_pc,
  input  [15:0] io_d2e_instruction,
  input  [15:0] io_d2e_rs1,
  input  [15:0] io_d2e_rs2,
  output [15:0] io_e2m_resultOrAdress,
  output [15:0] io_e2m_rdAdressOrStoreValue,
  output        io_e2m_writeBack,
  output        io_e2m_store,
  output        io_e2m_load
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] e2mReg_resultOrAdress; // @[ExecuteStage.scala 38:23]
  reg [15:0] e2mReg_rdAdressOrStoreValue; // @[ExecuteStage.scala 38:23]
  reg  e2mReg_writeBack; // @[ExecuteStage.scala 38:23]
  reg  e2mReg_store; // @[ExecuteStage.scala 38:23]
  reg  e2mReg_load; // @[ExecuteStage.scala 38:23]
  wire [3:0] opcode = io_d2e_instruction[15:12]; // @[ExecuteStage.scala 41:34]
  wire [15:0] _GEN_0 = 4'hf == opcode ? io_d2e_pc : 16'h0; // @[ExecuteStage.scala 125:14 44:27 74:38]
  wire [15:0] _GEN_2 = 4'hc == opcode ? io_d2e_pc : _GEN_0; // @[ExecuteStage.scala 118:14 74:38]
  wire [15:0] _GEN_4 = 4'he == opcode ? io_d2e_pc : _GEN_2; // @[ExecuteStage.scala 114:14 74:38]
  wire [15:0] _GEN_7 = 4'hb == opcode ? 16'h0 : _GEN_4; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _GEN_10 = 4'ha == opcode ? 16'h0 : _GEN_7; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _GEN_12 = 4'h8 == opcode | 4'h9 == opcode ? io_d2e_rs1 : _GEN_10; // @[ExecuteStage.scala 104:14 74:38]
  wire [15:0] _GEN_16 = 4'h7 == opcode ? 16'h0 : _GEN_12; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _GEN_19 = 4'h6 == opcode ? 16'h0 : _GEN_16; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _GEN_22 = 4'h5 == opcode ? 16'h0 : _GEN_19; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _GEN_25 = 4'h4 == opcode ? 16'h0 : _GEN_22; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _GEN_27 = 4'h3 == opcode ? io_d2e_rs1 : _GEN_25; // @[ExecuteStage.scala 74:38 86:14]
  wire [15:0] _GEN_30 = 4'h2 == opcode ? io_d2e_rs1 : _GEN_27; // @[ExecuteStage.scala 74:38 82:14]
  wire [15:0] _GEN_34 = 4'h1 == opcode ? 16'h0 : _GEN_30; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] toAdd1 = 4'h0 == opcode ? 16'h0 : _GEN_34; // @[ExecuteStage.scala 44:27 74:38]
  wire [15:0] _toAdd2_T = io_d2e_rs2; // @[ExecuteStage.scala 87:31]
  wire [15:0] _toAdd2_T_4 = 16'sh0 - $signed(io_d2e_rs2); // @[ExecuteStage.scala 87:39]
  wire [7:0] _toAdd2Temp_T_1 = io_d2e_instruction[7:0]; // @[ExecuteStage.scala 121:46]
  wire [15:0] _toAdd2_T_6 = {{8{_toAdd2Temp_T_1[7]}},_toAdd2Temp_T_1}; // @[ExecuteStage.scala 122:28]
  wire [11:0] _toAdd2Temp_T_3 = io_d2e_instruction[11:0]; // @[ExecuteStage.scala 128:47]
  wire [15:0] _toAdd2_T_7 = {{4{_toAdd2Temp_T_3[11]}},_toAdd2Temp_T_3}; // @[ExecuteStage.scala 129:28]
  wire [15:0] _GEN_1 = 4'hf == opcode ? _toAdd2_T_7 : 16'h0; // @[ExecuteStage.scala 129:14 45:27 74:38]
  wire [15:0] _GEN_3 = 4'hc == opcode ? _toAdd2_T_6 : _GEN_1; // @[ExecuteStage.scala 122:14 74:38]
  wire [15:0] _GEN_5 = 4'he == opcode ? 16'h2 : _GEN_3; // @[ExecuteStage.scala 115:14 74:38]
  wire [15:0] _GEN_8 = 4'hb == opcode ? 16'h0 : _GEN_5; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] _GEN_11 = 4'ha == opcode ? 16'h0 : _GEN_8; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] _GEN_13 = 4'h8 == opcode | 4'h9 == opcode ? {{12'd0}, io_d2e_instruction[3:0]} : _GEN_11; // @[ExecuteStage.scala 105:14 74:38]
  wire [15:0] _GEN_17 = 4'h7 == opcode ? 16'h0 : _GEN_13; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] _GEN_20 = 4'h6 == opcode ? 16'h0 : _GEN_17; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] _GEN_23 = 4'h5 == opcode ? 16'h0 : _GEN_20; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] _GEN_26 = 4'h4 == opcode ? 16'h0 : _GEN_23; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] _GEN_28 = 4'h3 == opcode ? _toAdd2_T_4 : _GEN_26; // @[ExecuteStage.scala 74:38 87:14]
  wire [15:0] _GEN_31 = 4'h2 == opcode ? io_d2e_rs2 : _GEN_28; // @[ExecuteStage.scala 74:38 83:14]
  wire [15:0] _GEN_35 = 4'h1 == opcode ? 16'h0 : _GEN_31; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] toAdd2 = 4'h0 == opcode ? 16'h0 : _GEN_35; // @[ExecuteStage.scala 45:27 74:38]
  wire [15:0] added = toAdd1 + toAdd2; // @[ExecuteStage.scala 46:34]
  wire  _io_branch_enable_T = opcode == 4'hd; // @[ExecuteStage.scala 51:14]
  wire  _io_branch_enable_T_1 = opcode == 4'he; // @[ExecuteStage.scala 52:14]
  wire  _io_branch_enable_T_2 = opcode == 4'hd | _io_branch_enable_T_1; // @[ExecuteStage.scala 51:28]
  wire  _io_branch_enable_T_3 = opcode == 4'hf; // @[ExecuteStage.scala 53:14]
  wire  _io_branch_enable_T_4 = _io_branch_enable_T_2 | _io_branch_enable_T_3; // @[ExecuteStage.scala 52:30]
  wire  _io_branch_enable_T_5 = opcode == 4'hc; // @[ExecuteStage.scala 54:14]
  wire  _io_branch_enable_T_6 = io_d2e_rs1 == 16'h0; // @[ExecuteStage.scala 55:18]
  wire  _io_branch_enable_T_7 = opcode == 4'hc & _io_branch_enable_T_6; // @[ExecuteStage.scala 54:29]
  wire  _e2mReg_rdAdressOrStoreValue_T = opcode == 4'h9; // @[ExecuteStage.scala 63:46]
  wire [15:0] _e2mReg_resultOrAdress_T = io_d2e_rs1 & io_d2e_rs2; // @[ExecuteStage.scala 76:43]
  wire [15:0] _e2mReg_resultOrAdress_T_1 = io_d2e_rs1 | io_d2e_rs2; // @[ExecuteStage.scala 79:45]
  wire [15:0] _e2mReg_resultOrAdress_T_2 = ~_e2mReg_resultOrAdress_T_1; // @[ExecuteStage.scala 79:32]
  wire [15:0] _e2mReg_resultOrAdress_T_5 = 16'h0 - io_d2e_rs2; // @[ExecuteStage.scala 91:67]
  wire [15:0] _e2mReg_resultOrAdress_T_6 = io_d2e_rs1 >> _e2mReg_resultOrAdress_T_5; // @[ExecuteStage.scala 91:63]
  wire [65550:0] _GEN_37 = {{65535'd0}, io_d2e_rs1}; // @[ExecuteStage.scala 91:99]
  wire [65550:0] _e2mReg_resultOrAdress_T_7 = _GEN_37 << io_d2e_rs2; // @[ExecuteStage.scala 91:99]
  wire [65550:0] _e2mReg_resultOrAdress_T_8 = io_d2e_rs2[15] ? {{65535'd0}, _e2mReg_resultOrAdress_T_6} :
    _e2mReg_resultOrAdress_T_7; // @[ExecuteStage.scala 91:35]
  wire [15:0] _e2mReg_resultOrAdress_T_9 = io_d2e_rs1; // @[ExecuteStage.scala 94:44]
  wire [16:0] _e2mReg_resultOrAdress_T_15 = $signed(io_d2e_rs1) / $signed(io_d2e_rs2); // @[ExecuteStage.scala 98:72]
  wire [31:0] _e2mReg_resultOrAdress_T_19 = $signed(io_d2e_rs1) * $signed(io_d2e_rs2); // @[ExecuteStage.scala 101:72]
  wire [15:0] _e2mReg_resultOrAdress_T_22 = {io_d2e_instruction[7:0],io_d2e_rs1[7:0]}; // @[ExecuteStage.scala 108:57]
  wire [15:0] _e2mReg_resultOrAdress_T_25 = {io_d2e_rs1[15:8],io_d2e_instruction[7:0]}; // @[ExecuteStage.scala 111:50]
  wire [15:0] _GEN_6 = 4'hb == opcode ? _e2mReg_resultOrAdress_T_25 : added; // @[ExecuteStage.scala 111:29 59:25 74:38]
  wire [15:0] _GEN_9 = 4'ha == opcode ? _e2mReg_resultOrAdress_T_22 : _GEN_6; // @[ExecuteStage.scala 108:29 74:38]
  wire [15:0] _GEN_14 = 4'h8 == opcode | 4'h9 == opcode ? added : _GEN_9; // @[ExecuteStage.scala 59:25 74:38]
  wire [31:0] _GEN_15 = 4'h7 == opcode ? _e2mReg_resultOrAdress_T_19 : {{16'd0}, _GEN_14}; // @[ExecuteStage.scala 101:29 74:38]
  wire [31:0] _GEN_18 = 4'h6 == opcode ? {{15'd0}, _e2mReg_resultOrAdress_T_15} : _GEN_15; // @[ExecuteStage.scala 74:38 98:29]
  wire [31:0] _GEN_21 = 4'h5 == opcode ? {{31'd0}, $signed(_e2mReg_resultOrAdress_T_9) < $signed(_toAdd2_T)} : _GEN_18; // @[ExecuteStage.scala 74:38 94:29]
  wire [65550:0] _GEN_24 = 4'h4 == opcode ? _e2mReg_resultOrAdress_T_8 : {{65519'd0}, _GEN_21}; // @[ExecuteStage.scala 74:38 91:29]
  wire [65550:0] _GEN_29 = 4'h3 == opcode ? {{65535'd0}, added} : _GEN_24; // @[ExecuteStage.scala 59:25 74:38]
  wire [65550:0] _GEN_32 = 4'h2 == opcode ? {{65535'd0}, added} : _GEN_29; // @[ExecuteStage.scala 59:25 74:38]
  wire [65550:0] _GEN_33 = 4'h1 == opcode ? {{65535'd0}, _e2mReg_resultOrAdress_T_2} : _GEN_32; // @[ExecuteStage.scala 74:38 79:29]
  wire [65550:0] _GEN_36 = 4'h0 == opcode ? {{65535'd0}, _e2mReg_resultOrAdress_T} : _GEN_33; // @[ExecuteStage.scala 74:38 76:29]
  wire [65550:0] _GEN_39 = reset ? 65551'h0 : _GEN_36; // @[ExecuteStage.scala 38:{23,23}]
  assign io_branch_enable = _io_branch_enable_T_4 | _io_branch_enable_T_7; // @[ExecuteStage.scala 53:27]
  assign io_branch_pc = _io_branch_enable_T_1 | _io_branch_enable_T ? io_d2e_rs1 : added; // @[ExecuteStage.scala 58:22]
  assign io_e2m_resultOrAdress = e2mReg_resultOrAdress; // @[ExecuteStage.scala 39:10]
  assign io_e2m_rdAdressOrStoreValue = e2mReg_rdAdressOrStoreValue; // @[ExecuteStage.scala 39:10]
  assign io_e2m_writeBack = e2mReg_writeBack; // @[ExecuteStage.scala 39:10]
  assign io_e2m_store = e2mReg_store; // @[ExecuteStage.scala 39:10]
  assign io_e2m_load = e2mReg_load; // @[ExecuteStage.scala 39:10]
  always @(posedge clock) begin
    e2mReg_resultOrAdress <= _GEN_39[15:0]; // @[ExecuteStage.scala 38:{23,23}]
    if (reset) begin // @[ExecuteStage.scala 38:23]
      e2mReg_rdAdressOrStoreValue <= 16'h0; // @[ExecuteStage.scala 38:23]
    end else if (opcode == 4'h9) begin // @[ExecuteStage.scala 63:38]
      e2mReg_rdAdressOrStoreValue <= io_d2e_rs1;
    end else begin
      e2mReg_rdAdressOrStoreValue <= {{12'd0}, io_d2e_instruction[11:8]};
    end
    if (reset) begin // @[ExecuteStage.scala 38:23]
      e2mReg_writeBack <= 1'h0; // @[ExecuteStage.scala 38:23]
    end else begin
      e2mReg_writeBack <= ~(_e2mReg_rdAdressOrStoreValue_T | _io_branch_enable_T_3 | _io_branch_enable_T |
        _io_branch_enable_T_5); // @[ExecuteStage.scala 66:20]
    end
    if (reset) begin // @[ExecuteStage.scala 38:23]
      e2mReg_store <= 1'h0; // @[ExecuteStage.scala 38:23]
    end else begin
      e2mReg_store <= _e2mReg_rdAdressOrStoreValue_T; // @[ExecuteStage.scala 69:16]
    end
    if (reset) begin // @[ExecuteStage.scala 38:23]
      e2mReg_load <= 1'h0; // @[ExecuteStage.scala 38:23]
    end else begin
      e2mReg_load <= opcode == 4'h8; // @[ExecuteStage.scala 71:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  e2mReg_resultOrAdress = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  e2mReg_rdAdressOrStoreValue = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  e2mReg_writeBack = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  e2mReg_store = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  e2mReg_load = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryStage(
  input         clock,
  output [15:0] io_data_adress,
  output        io_data_read,
  input  [15:0] io_data_readValue,
  output        io_data_write,
  output [15:0] io_data_writeValue,
  input  [15:0] io_e2m_resultOrAdress,
  input  [15:0] io_e2m_rdAdressOrStoreValue,
  input         io_e2m_writeBack,
  input         io_e2m_store,
  input         io_e2m_load,
  output [15:0] io_m2w_rd,
  output [3:0]  io_m2w_rdAdress,
  output        io_m2w_writeBack
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] writeValueReg; // @[MemoryStage.scala 21:30]
  assign io_data_adress = io_e2m_resultOrAdress; // @[MemoryStage.scala 17:18]
  assign io_data_read = io_e2m_load; // @[MemoryStage.scala 20:16]
  assign io_data_write = io_e2m_store; // @[MemoryStage.scala 19:17]
  assign io_data_writeValue = io_e2m_rdAdressOrStoreValue; // @[MemoryStage.scala 18:22]
  assign io_m2w_rd = io_e2m_load ? io_data_readValue : writeValueReg; // @[MemoryStage.scala 22:21 23:16 25:16]
  assign io_m2w_rdAdress = io_e2m_rdAdressOrStoreValue[3:0]; // @[MemoryStage.scala 27:51]
  assign io_m2w_writeBack = io_e2m_load | io_e2m_writeBack; // @[MemoryStage.scala 28:35]
  always @(posedge clock) begin
    writeValueReg <= io_e2m_rdAdressOrStoreValue; // @[MemoryStage.scala 21:30]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  writeValueReg = _RAND_0[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DataMemory(
  input         clock,
  input         reset,
  input  [15:0] io_data_adress,
  input         io_data_read,
  output [15:0] io_data_readValue,
  input         io_data_write,
  input  [15:0] io_data_writeValue,
  output [15:0] io_leds,
  output [15:0] io_displayValue,
  input  [15:0] io_switches
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] memory [0:17]; // @[DataMemory.scala 22:27]
  wire  memory_lsB_en; // @[DataMemory.scala 22:27]
  wire [4:0] memory_lsB_addr; // @[DataMemory.scala 22:27]
  wire [7:0] memory_lsB_data; // @[DataMemory.scala 22:27]
  wire  memory_msB_en; // @[DataMemory.scala 22:27]
  wire [4:0] memory_msB_addr; // @[DataMemory.scala 22:27]
  wire [7:0] memory_msB_data; // @[DataMemory.scala 22:27]
  wire [7:0] memory_MPORT_data; // @[DataMemory.scala 22:27]
  wire [4:0] memory_MPORT_addr; // @[DataMemory.scala 22:27]
  wire  memory_MPORT_mask; // @[DataMemory.scala 22:27]
  wire  memory_MPORT_en; // @[DataMemory.scala 22:27]
  wire [7:0] memory_MPORT_1_data; // @[DataMemory.scala 22:27]
  wire [4:0] memory_MPORT_1_addr; // @[DataMemory.scala 22:27]
  wire  memory_MPORT_1_mask; // @[DataMemory.scala 22:27]
  wire  memory_MPORT_1_en; // @[DataMemory.scala 22:27]
  reg  memory_lsB_en_pipe_0;
  reg [4:0] memory_lsB_addr_pipe_0;
  reg  memory_msB_en_pipe_0;
  reg [4:0] memory_msB_addr_pipe_0;
  wire [15:0] _msB_T_1 = io_data_adress + 16'h1; // @[DataMemory.scala 31:40]
  wire [15:0] _io_data_readValue_T = {memory_msB_data,memory_lsB_data}; // @[DataMemory.scala 32:28]
  reg [15:0] leds; // @[DataMemory.scala 46:21]
  reg [15:0] displayValue; // @[DataMemory.scala 47:29]
  reg [15:0] switches; // @[DataMemory.scala 48:25]
  assign memory_lsB_en = memory_lsB_en_pipe_0;
  assign memory_lsB_addr = memory_lsB_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign memory_lsB_data = memory[memory_lsB_addr]; // @[DataMemory.scala 22:27]
  `else
  assign memory_lsB_data = memory_lsB_addr >= 5'h12 ? _RAND_1[7:0] : memory[memory_lsB_addr]; // @[DataMemory.scala 22:27]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign memory_msB_en = memory_msB_en_pipe_0;
  assign memory_msB_addr = memory_msB_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign memory_msB_data = memory[memory_msB_addr]; // @[DataMemory.scala 22:27]
  `else
  assign memory_msB_data = memory_msB_addr >= 5'h12 ? _RAND_2[7:0] : memory[memory_msB_addr]; // @[DataMemory.scala 22:27]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign memory_MPORT_data = io_data_writeValue[7:0];
  assign memory_MPORT_addr = io_data_adress[4:0];
  assign memory_MPORT_mask = 1'h1;
  assign memory_MPORT_en = io_data_write;
  assign memory_MPORT_1_data = io_data_writeValue[15:8];
  assign memory_MPORT_1_addr = _msB_T_1[4:0];
  assign memory_MPORT_1_mask = 1'h1;
  assign memory_MPORT_1_en = io_data_write;
  assign io_data_readValue = io_data_adress == 16'h4 ? switches : _io_data_readValue_T; // @[DataMemory.scala 32:21 64:32 65:23]
  assign io_leds = leds; // @[DataMemory.scala 51:11]
  assign io_displayValue = displayValue; // @[DataMemory.scala 52:19]
  always @(posedge clock) begin
    if (memory_MPORT_en & memory_MPORT_mask) begin
      memory[memory_MPORT_addr] <= memory_MPORT_data; // @[DataMemory.scala 22:27]
    end
    if (memory_MPORT_1_en & memory_MPORT_1_mask) begin
      memory[memory_MPORT_1_addr] <= memory_MPORT_1_data; // @[DataMemory.scala 22:27]
    end
    memory_lsB_en_pipe_0 <= io_data_read;
    if (io_data_read) begin
      memory_lsB_addr_pipe_0 <= io_data_adress[4:0];
    end
    memory_msB_en_pipe_0 <= io_data_read;
    if (io_data_read) begin
      memory_msB_addr_pipe_0 <= _msB_T_1[4:0];
    end
    if (reset) begin // @[DataMemory.scala 46:21]
      leds <= 16'h0; // @[DataMemory.scala 46:21]
    end else if (io_data_write) begin // @[DataMemory.scala 56:23]
      if (io_data_adress == 16'h0) begin // @[DataMemory.scala 57:34]
        leds <= io_data_writeValue; // @[DataMemory.scala 58:12]
      end
    end
    if (reset) begin // @[DataMemory.scala 47:29]
      displayValue <= 16'h0; // @[DataMemory.scala 47:29]
    end else if (io_data_write) begin // @[DataMemory.scala 56:23]
      if (io_data_adress == 16'h2) begin // @[DataMemory.scala 60:34]
        displayValue <= io_data_writeValue; // @[DataMemory.scala 61:20]
      end
    end
    switches <= io_switches; // @[DataMemory.scala 48:25]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
  _RAND_2 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 18; initvar = initvar+1)
    memory[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  memory_lsB_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  memory_lsB_addr_pipe_0 = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  memory_msB_en_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  memory_msB_addr_pipe_0 = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  leds = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  displayValue = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  switches = _RAND_9[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SevenSegDec(
  input  [3:0] io_in,
  output [6:0] io_out
);
  wire [6:0] _GEN_0 = 4'hf == io_in ? 7'h71 : 7'h0; // @[DisplayMultiplexer.scala 67:18 83:24 65:27]
  wire [6:0] _GEN_1 = 4'he == io_in ? 7'h79 : _GEN_0; // @[DisplayMultiplexer.scala 67:18 82:24]
  wire [6:0] _GEN_2 = 4'hd == io_in ? 7'h5e : _GEN_1; // @[DisplayMultiplexer.scala 67:18 81:24]
  wire [6:0] _GEN_3 = 4'hc == io_in ? 7'h39 : _GEN_2; // @[DisplayMultiplexer.scala 67:18 80:24]
  wire [6:0] _GEN_4 = 4'hb == io_in ? 7'h7c : _GEN_3; // @[DisplayMultiplexer.scala 67:18 79:24]
  wire [6:0] _GEN_5 = 4'ha == io_in ? 7'h77 : _GEN_4; // @[DisplayMultiplexer.scala 67:18 78:24]
  wire [6:0] _GEN_6 = 4'h9 == io_in ? 7'h6f : _GEN_5; // @[DisplayMultiplexer.scala 67:18 77:23]
  wire [6:0] _GEN_7 = 4'h8 == io_in ? 7'h7f : _GEN_6; // @[DisplayMultiplexer.scala 67:18 76:23]
  wire [6:0] _GEN_8 = 4'h7 == io_in ? 7'h7 : _GEN_7; // @[DisplayMultiplexer.scala 67:18 75:23]
  wire [6:0] _GEN_9 = 4'h6 == io_in ? 7'h7d : _GEN_8; // @[DisplayMultiplexer.scala 67:18 74:23]
  wire [6:0] _GEN_10 = 4'h5 == io_in ? 7'h6d : _GEN_9; // @[DisplayMultiplexer.scala 67:18 73:23]
  wire [6:0] _GEN_11 = 4'h4 == io_in ? 7'h66 : _GEN_10; // @[DisplayMultiplexer.scala 67:18 72:23]
  wire [6:0] _GEN_12 = 4'h3 == io_in ? 7'h4f : _GEN_11; // @[DisplayMultiplexer.scala 67:18 71:23]
  wire [6:0] _GEN_13 = 4'h2 == io_in ? 7'h5b : _GEN_12; // @[DisplayMultiplexer.scala 67:18 70:23]
  wire [6:0] _GEN_14 = 4'h1 == io_in ? 7'h6 : _GEN_13; // @[DisplayMultiplexer.scala 67:18 69:23]
  assign io_out = 4'h0 == io_in ? 7'h3f : _GEN_14; // @[DisplayMultiplexer.scala 67:18 68:23]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [15:0] io_value,
  output [6:0]  io_display_segments,
  output [3:0]  io_display_selector
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] sevenSegDec_io_in; // @[DisplayMultiplexer.scala 30:27]
  wire [6:0] sevenSegDec_io_out; // @[DisplayMultiplexer.scala 30:27]
  reg [16:0] countReg; // @[DisplayMultiplexer.scala 19:25]
  wire [16:0] _countReg_T_1 = countReg + 17'h1; // @[DisplayMultiplexer.scala 20:24]
  wire  tick = countReg == 17'h1869f; // @[DisplayMultiplexer.scala 21:23]
  reg [1:0] digitReg; // @[DisplayMultiplexer.scala 27:25]
  wire [1:0] _GEN_9 = {{1'd0}, tick}; // @[DisplayMultiplexer.scala 28:24]
  wire [1:0] _digitReg_T_1 = digitReg + _GEN_9; // @[DisplayMultiplexer.scala 28:24]
  wire [3:0] _GEN_1 = 2'h3 == digitReg ? io_value[15:12] : 4'h0; // @[DisplayMultiplexer.scala 34:20 32:21 48:25]
  wire [3:0] _GEN_2 = 2'h3 == digitReg ? 4'h8 : 4'h1; // @[DisplayMultiplexer.scala 34:20 49:14 15:27]
  wire [3:0] _GEN_3 = 2'h2 == digitReg ? io_value[11:8] : _GEN_1; // @[DisplayMultiplexer.scala 34:20 44:25]
  wire [3:0] _GEN_4 = 2'h2 == digitReg ? 4'h4 : _GEN_2; // @[DisplayMultiplexer.scala 34:20 45:14]
  wire [3:0] _GEN_5 = 2'h1 == digitReg ? io_value[7:4] : _GEN_3; // @[DisplayMultiplexer.scala 34:20 40:25]
  wire [3:0] _GEN_6 = 2'h1 == digitReg ? 4'h2 : _GEN_4; // @[DisplayMultiplexer.scala 34:20 41:14]
  wire [3:0] select = 2'h0 == digitReg ? 4'h1 : _GEN_6; // @[DisplayMultiplexer.scala 34:20 37:14]
  wire [6:0] sevSeg = sevenSegDec_io_out; // @[DisplayMultiplexer.scala 14:27 53:10]
  SevenSegDec sevenSegDec ( // @[DisplayMultiplexer.scala 30:27]
    .io_in(sevenSegDec_io_in),
    .io_out(sevenSegDec_io_out)
  );
  assign io_display_segments = ~sevSeg; // @[DisplayMultiplexer.scala 55:26]
  assign io_display_selector = ~select; // @[DisplayMultiplexer.scala 56:26]
  assign sevenSegDec_io_in = 2'h0 == digitReg ? io_value[3:0] : _GEN_5; // @[DisplayMultiplexer.scala 34:20 36:25]
  always @(posedge clock) begin
    if (reset) begin // @[DisplayMultiplexer.scala 19:25]
      countReg <= 17'h0; // @[DisplayMultiplexer.scala 19:25]
    end else if (tick) begin // @[DisplayMultiplexer.scala 23:15]
      countReg <= 17'h0; // @[DisplayMultiplexer.scala 24:14]
    end else begin
      countReg <= _countReg_T_1; // @[DisplayMultiplexer.scala 20:12]
    end
    if (reset) begin // @[DisplayMultiplexer.scala 27:25]
      digitReg <= 2'h0; // @[DisplayMultiplexer.scala 27:25]
    end else begin
      digitReg <= _digitReg_T_1; // @[DisplayMultiplexer.scala 28:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  countReg = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  digitReg = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Elidon(
  input         clock,
  input         reset,
  output [15:0] io_leds,
  output [6:0]  io_display_segments,
  output [3:0]  io_display_selector,
  input  [15:0] io_switches
);
  wire  fetchStage_clock; // @[Main.scala 15:26]
  wire  fetchStage_reset; // @[Main.scala 15:26]
  wire  fetchStage_io_branch_enable; // @[Main.scala 15:26]
  wire [15:0] fetchStage_io_branch_pc; // @[Main.scala 15:26]
  wire [15:0] fetchStage_io_f2d_pc; // @[Main.scala 15:26]
  wire [15:0] fetchStage_io_f2d_instruction; // @[Main.scala 15:26]
  wire  decodeStage_clock; // @[Main.scala 16:27]
  wire  decodeStage_reset; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_f2d_pc; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_f2d_instruction; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_d2e_pc; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_d2e_instruction; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_d2e_rs1; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_d2e_rs2; // @[Main.scala 16:27]
  wire [15:0] decodeStage_io_m2w_rd; // @[Main.scala 16:27]
  wire [3:0] decodeStage_io_m2w_rdAdress; // @[Main.scala 16:27]
  wire  decodeStage_io_m2w_writeBack; // @[Main.scala 16:27]
  wire  executeStage_clock; // @[Main.scala 17:28]
  wire  executeStage_reset; // @[Main.scala 17:28]
  wire  executeStage_io_branch_enable; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_branch_pc; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_d2e_pc; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_d2e_instruction; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_d2e_rs1; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_d2e_rs2; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_e2m_resultOrAdress; // @[Main.scala 17:28]
  wire [15:0] executeStage_io_e2m_rdAdressOrStoreValue; // @[Main.scala 17:28]
  wire  executeStage_io_e2m_writeBack; // @[Main.scala 17:28]
  wire  executeStage_io_e2m_store; // @[Main.scala 17:28]
  wire  executeStage_io_e2m_load; // @[Main.scala 17:28]
  wire  memoryStage_clock; // @[Main.scala 18:27]
  wire [15:0] memoryStage_io_data_adress; // @[Main.scala 18:27]
  wire  memoryStage_io_data_read; // @[Main.scala 18:27]
  wire [15:0] memoryStage_io_data_readValue; // @[Main.scala 18:27]
  wire  memoryStage_io_data_write; // @[Main.scala 18:27]
  wire [15:0] memoryStage_io_data_writeValue; // @[Main.scala 18:27]
  wire [15:0] memoryStage_io_e2m_resultOrAdress; // @[Main.scala 18:27]
  wire [15:0] memoryStage_io_e2m_rdAdressOrStoreValue; // @[Main.scala 18:27]
  wire  memoryStage_io_e2m_writeBack; // @[Main.scala 18:27]
  wire  memoryStage_io_e2m_store; // @[Main.scala 18:27]
  wire  memoryStage_io_e2m_load; // @[Main.scala 18:27]
  wire [15:0] memoryStage_io_m2w_rd; // @[Main.scala 18:27]
  wire [3:0] memoryStage_io_m2w_rdAdress; // @[Main.scala 18:27]
  wire  memoryStage_io_m2w_writeBack; // @[Main.scala 18:27]
  wire  dataMemory_clock; // @[Main.scala 30:26]
  wire  dataMemory_reset; // @[Main.scala 30:26]
  wire [15:0] dataMemory_io_data_adress; // @[Main.scala 30:26]
  wire  dataMemory_io_data_read; // @[Main.scala 30:26]
  wire [15:0] dataMemory_io_data_readValue; // @[Main.scala 30:26]
  wire  dataMemory_io_data_write; // @[Main.scala 30:26]
  wire [15:0] dataMemory_io_data_writeValue; // @[Main.scala 30:26]
  wire [15:0] dataMemory_io_leds; // @[Main.scala 30:26]
  wire [15:0] dataMemory_io_displayValue; // @[Main.scala 30:26]
  wire [15:0] dataMemory_io_switches; // @[Main.scala 30:26]
  wire  displayMultiplexer_clock; // @[Main.scala 36:34]
  wire  displayMultiplexer_reset; // @[Main.scala 36:34]
  wire [15:0] displayMultiplexer_io_value; // @[Main.scala 36:34]
  wire [6:0] displayMultiplexer_io_display_segments; // @[Main.scala 36:34]
  wire [3:0] displayMultiplexer_io_display_selector; // @[Main.scala 36:34]
  FetchStage fetchStage ( // @[Main.scala 15:26]
    .clock(fetchStage_clock),
    .reset(fetchStage_reset),
    .io_branch_enable(fetchStage_io_branch_enable),
    .io_branch_pc(fetchStage_io_branch_pc),
    .io_f2d_pc(fetchStage_io_f2d_pc),
    .io_f2d_instruction(fetchStage_io_f2d_instruction)
  );
  DecodeStage decodeStage ( // @[Main.scala 16:27]
    .clock(decodeStage_clock),
    .reset(decodeStage_reset),
    .io_f2d_pc(decodeStage_io_f2d_pc),
    .io_f2d_instruction(decodeStage_io_f2d_instruction),
    .io_d2e_pc(decodeStage_io_d2e_pc),
    .io_d2e_instruction(decodeStage_io_d2e_instruction),
    .io_d2e_rs1(decodeStage_io_d2e_rs1),
    .io_d2e_rs2(decodeStage_io_d2e_rs2),
    .io_m2w_rd(decodeStage_io_m2w_rd),
    .io_m2w_rdAdress(decodeStage_io_m2w_rdAdress),
    .io_m2w_writeBack(decodeStage_io_m2w_writeBack)
  );
  ExecuteStage executeStage ( // @[Main.scala 17:28]
    .clock(executeStage_clock),
    .reset(executeStage_reset),
    .io_branch_enable(executeStage_io_branch_enable),
    .io_branch_pc(executeStage_io_branch_pc),
    .io_d2e_pc(executeStage_io_d2e_pc),
    .io_d2e_instruction(executeStage_io_d2e_instruction),
    .io_d2e_rs1(executeStage_io_d2e_rs1),
    .io_d2e_rs2(executeStage_io_d2e_rs2),
    .io_e2m_resultOrAdress(executeStage_io_e2m_resultOrAdress),
    .io_e2m_rdAdressOrStoreValue(executeStage_io_e2m_rdAdressOrStoreValue),
    .io_e2m_writeBack(executeStage_io_e2m_writeBack),
    .io_e2m_store(executeStage_io_e2m_store),
    .io_e2m_load(executeStage_io_e2m_load)
  );
  MemoryStage memoryStage ( // @[Main.scala 18:27]
    .clock(memoryStage_clock),
    .io_data_adress(memoryStage_io_data_adress),
    .io_data_read(memoryStage_io_data_read),
    .io_data_readValue(memoryStage_io_data_readValue),
    .io_data_write(memoryStage_io_data_write),
    .io_data_writeValue(memoryStage_io_data_writeValue),
    .io_e2m_resultOrAdress(memoryStage_io_e2m_resultOrAdress),
    .io_e2m_rdAdressOrStoreValue(memoryStage_io_e2m_rdAdressOrStoreValue),
    .io_e2m_writeBack(memoryStage_io_e2m_writeBack),
    .io_e2m_store(memoryStage_io_e2m_store),
    .io_e2m_load(memoryStage_io_e2m_load),
    .io_m2w_rd(memoryStage_io_m2w_rd),
    .io_m2w_rdAdress(memoryStage_io_m2w_rdAdress),
    .io_m2w_writeBack(memoryStage_io_m2w_writeBack)
  );
  DataMemory dataMemory ( // @[Main.scala 30:26]
    .clock(dataMemory_clock),
    .reset(dataMemory_reset),
    .io_data_adress(dataMemory_io_data_adress),
    .io_data_read(dataMemory_io_data_read),
    .io_data_readValue(dataMemory_io_data_readValue),
    .io_data_write(dataMemory_io_data_write),
    .io_data_writeValue(dataMemory_io_data_writeValue),
    .io_leds(dataMemory_io_leds),
    .io_displayValue(dataMemory_io_displayValue),
    .io_switches(dataMemory_io_switches)
  );
  DisplayMultiplexer displayMultiplexer ( // @[Main.scala 36:34]
    .clock(displayMultiplexer_clock),
    .reset(displayMultiplexer_reset),
    .io_value(displayMultiplexer_io_value),
    .io_display_segments(displayMultiplexer_io_display_segments),
    .io_display_selector(displayMultiplexer_io_display_selector)
  );
  assign io_leds = dataMemory_io_leds; // @[Main.scala 35:11]
  assign io_display_segments = displayMultiplexer_io_display_segments; // @[Main.scala 38:14]
  assign io_display_selector = displayMultiplexer_io_display_selector; // @[Main.scala 38:14]
  assign fetchStage_clock = clock;
  assign fetchStage_reset = reset;
  assign fetchStage_io_branch_enable = executeStage_io_branch_enable; // @[Main.scala 27:24]
  assign fetchStage_io_branch_pc = executeStage_io_branch_pc; // @[Main.scala 27:24]
  assign decodeStage_clock = clock;
  assign decodeStage_reset = reset;
  assign decodeStage_io_f2d_pc = fetchStage_io_f2d_pc; // @[Main.scala 21:22]
  assign decodeStage_io_f2d_instruction = fetchStage_io_f2d_instruction; // @[Main.scala 21:22]
  assign decodeStage_io_m2w_rd = memoryStage_io_m2w_rd; // @[Main.scala 24:22]
  assign decodeStage_io_m2w_rdAdress = memoryStage_io_m2w_rdAdress; // @[Main.scala 24:22]
  assign decodeStage_io_m2w_writeBack = memoryStage_io_m2w_writeBack; // @[Main.scala 24:22]
  assign executeStage_clock = clock;
  assign executeStage_reset = reset;
  assign executeStage_io_d2e_pc = decodeStage_io_d2e_pc; // @[Main.scala 22:23]
  assign executeStage_io_d2e_instruction = decodeStage_io_d2e_instruction; // @[Main.scala 22:23]
  assign executeStage_io_d2e_rs1 = decodeStage_io_d2e_rs1; // @[Main.scala 22:23]
  assign executeStage_io_d2e_rs2 = decodeStage_io_d2e_rs2; // @[Main.scala 22:23]
  assign memoryStage_clock = clock;
  assign memoryStage_io_data_readValue = dataMemory_io_data_readValue; // @[Main.scala 31:23]
  assign memoryStage_io_e2m_resultOrAdress = executeStage_io_e2m_resultOrAdress; // @[Main.scala 23:22]
  assign memoryStage_io_e2m_rdAdressOrStoreValue = executeStage_io_e2m_rdAdressOrStoreValue; // @[Main.scala 23:22]
  assign memoryStage_io_e2m_writeBack = executeStage_io_e2m_writeBack; // @[Main.scala 23:22]
  assign memoryStage_io_e2m_store = executeStage_io_e2m_store; // @[Main.scala 23:22]
  assign memoryStage_io_e2m_load = executeStage_io_e2m_load; // @[Main.scala 23:22]
  assign dataMemory_clock = clock;
  assign dataMemory_reset = reset;
  assign dataMemory_io_data_adress = memoryStage_io_data_adress; // @[Main.scala 31:23]
  assign dataMemory_io_data_read = memoryStage_io_data_read; // @[Main.scala 31:23]
  assign dataMemory_io_data_write = memoryStage_io_data_write; // @[Main.scala 31:23]
  assign dataMemory_io_data_writeValue = memoryStage_io_data_writeValue; // @[Main.scala 31:23]
  assign dataMemory_io_switches = io_switches; // @[Main.scala 34:26]
  assign displayMultiplexer_clock = clock;
  assign displayMultiplexer_reset = reset;
  assign displayMultiplexer_io_value = dataMemory_io_displayValue; // @[Main.scala 37:31]
endmodule
