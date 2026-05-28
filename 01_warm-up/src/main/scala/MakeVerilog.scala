package adder

import chisel3.stage.ChiselStage

object MakeVerilog extends App {
  // This line tells Chisel to generate Verilog for your 4-bit adder
  (new ChiselStage).emitSystemVerilog(new FourBitAdder())
}
