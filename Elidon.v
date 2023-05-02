module DisplayMultiplexer(
  input        clock,
  input        reset,
  output [3:0] io_display_selector
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] countReg; // @[DisplayMultiplexer.scala 18:25]
  wire [16:0] _countReg_T_1 = countReg + 17'h1; // @[DisplayMultiplexer.scala 19:24]
  wire  tick = countReg == 17'h1869f; // @[DisplayMultiplexer.scala 20:23]
  reg [1:0] digitReg; // @[DisplayMultiplexer.scala 26:25]
  wire [1:0] _GEN_9 = {{1'd0}, tick}; // @[DisplayMultiplexer.scala 27:24]
  wire [1:0] _digitReg_T_1 = digitReg + _GEN_9; // @[DisplayMultiplexer.scala 27:24]
  wire [3:0] _GEN_2 = 2'h3 == digitReg ? 4'h8 : 4'h1; // @[DisplayMultiplexer.scala 33:20 48:14 14:27]
  wire [3:0] _GEN_4 = 2'h2 == digitReg ? 4'h4 : _GEN_2; // @[DisplayMultiplexer.scala 33:20 44:14]
  wire [3:0] _GEN_6 = 2'h1 == digitReg ? 4'h2 : _GEN_4; // @[DisplayMultiplexer.scala 33:20 40:14]
  wire [3:0] select = 2'h0 == digitReg ? 4'h1 : _GEN_6; // @[DisplayMultiplexer.scala 33:20 36:14]
  assign io_display_selector = ~select; // @[DisplayMultiplexer.scala 55:26]
  always @(posedge clock) begin
    if (reset) begin // @[DisplayMultiplexer.scala 18:25]
      countReg <= 17'h0; // @[DisplayMultiplexer.scala 18:25]
    end else if (tick) begin // @[DisplayMultiplexer.scala 22:15]
      countReg <= 17'h0; // @[DisplayMultiplexer.scala 23:14]
    end else begin
      countReg <= _countReg_T_1; // @[DisplayMultiplexer.scala 19:12]
    end
    if (reset) begin // @[DisplayMultiplexer.scala 26:25]
      digitReg <= 2'h0; // @[DisplayMultiplexer.scala 26:25]
    end else begin
      digitReg <= _digitReg_T_1; // @[DisplayMultiplexer.scala 27:12]
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
  wire  displayMultiplexer_clock; // @[Main.scala 28:34]
  wire  displayMultiplexer_reset; // @[Main.scala 28:34]
  wire [3:0] displayMultiplexer_io_display_selector; // @[Main.scala 28:34]
  DisplayMultiplexer displayMultiplexer ( // @[Main.scala 28:34]
    .clock(displayMultiplexer_clock),
    .reset(displayMultiplexer_reset),
    .io_display_selector(displayMultiplexer_io_display_selector)
  );
  assign io_leds = 16'h0; // @[Main.scala 27:11]
  assign io_display_segments = 7'h40; // @[Main.scala 30:14]
  assign io_display_selector = displayMultiplexer_io_display_selector; // @[Main.scala 30:14]
  assign displayMultiplexer_clock = clock;
  assign displayMultiplexer_reset = reset;
endmodule
