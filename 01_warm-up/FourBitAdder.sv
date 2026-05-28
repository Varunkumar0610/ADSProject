module HalfAdder(
  input   io_a,
  input   io_b,
  output  io_sum,
  output  io_carry
);
  assign io_sum = io_a ^ io_b; // @[Adder.scala 20:18]
  assign io_carry = io_a & io_b; // @[Adder.scala 21:20]
endmodule
module FullAdder(
  input   io_a,
  input   io_b,
  input   io_cin,
  output  io_sum,
  output  io_cout
);
  wire  ha1_io_a; // @[Adder.scala 51:19]
  wire  ha1_io_b; // @[Adder.scala 51:19]
  wire  ha1_io_sum; // @[Adder.scala 51:19]
  wire  ha1_io_carry; // @[Adder.scala 51:19]
  wire  ha2_io_a; // @[Adder.scala 52:19]
  wire  ha2_io_b; // @[Adder.scala 52:19]
  wire  ha2_io_sum; // @[Adder.scala 52:19]
  wire  ha2_io_carry; // @[Adder.scala 52:19]
  HalfAdder ha1 ( // @[Adder.scala 51:19]
    .io_a(ha1_io_a),
    .io_b(ha1_io_b),
    .io_sum(ha1_io_sum),
    .io_carry(ha1_io_carry)
  );
  HalfAdder ha2 ( // @[Adder.scala 52:19]
    .io_a(ha2_io_a),
    .io_b(ha2_io_b),
    .io_sum(ha2_io_sum),
    .io_carry(ha2_io_carry)
  );
  assign io_sum = ha2_io_sum; // @[Adder.scala 65:10]
  assign io_cout = ha1_io_carry | ha2_io_carry; // @[Adder.scala 66:27]
  assign ha1_io_a = io_a; // @[Adder.scala 55:12]
  assign ha1_io_b = io_b; // @[Adder.scala 56:12]
  assign ha2_io_a = ha1_io_sum; // @[Adder.scala 59:12]
  assign ha2_io_b = io_cin; // @[Adder.scala 60:12]
endmodule
module FourBitAdder(
  input        clock,
  input        reset,
  input  [3:0] io_a,
  input  [3:0] io_b,
  output [3:0] io_sum,
  output       io_cout
);
  wire  fa1_io_a; // @[Adder.scala 91:19]
  wire  fa1_io_b; // @[Adder.scala 91:19]
  wire  fa1_io_cin; // @[Adder.scala 91:19]
  wire  fa1_io_sum; // @[Adder.scala 91:19]
  wire  fa1_io_cout; // @[Adder.scala 91:19]
  wire  fa2_io_a; // @[Adder.scala 92:19]
  wire  fa2_io_b; // @[Adder.scala 92:19]
  wire  fa2_io_cin; // @[Adder.scala 92:19]
  wire  fa2_io_sum; // @[Adder.scala 92:19]
  wire  fa2_io_cout; // @[Adder.scala 92:19]
  wire  fa3_io_a; // @[Adder.scala 93:19]
  wire  fa3_io_b; // @[Adder.scala 93:19]
  wire  fa3_io_cin; // @[Adder.scala 93:19]
  wire  fa3_io_sum; // @[Adder.scala 93:19]
  wire  fa3_io_cout; // @[Adder.scala 93:19]
  wire  fa4_io_a; // @[Adder.scala 94:19]
  wire  fa4_io_b; // @[Adder.scala 94:19]
  wire  fa4_io_cin; // @[Adder.scala 94:19]
  wire  fa4_io_sum; // @[Adder.scala 94:19]
  wire  fa4_io_cout; // @[Adder.scala 94:19]
  wire [1:0] io_sum_lo = {fa2_io_sum,fa1_io_sum}; // @[Cat.scala 31:58]
  wire [1:0] io_sum_hi = {fa4_io_sum,fa3_io_sum}; // @[Cat.scala 31:58]
  FullAdder fa1 ( // @[Adder.scala 91:19]
    .io_a(fa1_io_a),
    .io_b(fa1_io_b),
    .io_cin(fa1_io_cin),
    .io_sum(fa1_io_sum),
    .io_cout(fa1_io_cout)
  );
  FullAdder fa2 ( // @[Adder.scala 92:19]
    .io_a(fa2_io_a),
    .io_b(fa2_io_b),
    .io_cin(fa2_io_cin),
    .io_sum(fa2_io_sum),
    .io_cout(fa2_io_cout)
  );
  FullAdder fa3 ( // @[Adder.scala 93:19]
    .io_a(fa3_io_a),
    .io_b(fa3_io_b),
    .io_cin(fa3_io_cin),
    .io_sum(fa3_io_sum),
    .io_cout(fa3_io_cout)
  );
  FullAdder fa4 ( // @[Adder.scala 94:19]
    .io_a(fa4_io_a),
    .io_b(fa4_io_b),
    .io_cin(fa4_io_cin),
    .io_sum(fa4_io_sum),
    .io_cout(fa4_io_cout)
  );
  assign io_sum = {io_sum_hi,io_sum_lo}; // @[Cat.scala 31:58]
  assign io_cout = fa4_io_cout; // @[Adder.scala 121:11]
  assign fa1_io_a = io_a[0]; // @[Adder.scala 97:19]
  assign fa1_io_b = io_b[0]; // @[Adder.scala 98:19]
  assign fa1_io_cin = 1'h0; // @[Adder.scala 99:14]
  assign fa2_io_a = io_a[1]; // @[Adder.scala 102:19]
  assign fa2_io_b = io_b[1]; // @[Adder.scala 103:19]
  assign fa2_io_cin = fa1_io_cout; // @[Adder.scala 104:14]
  assign fa3_io_a = io_a[2]; // @[Adder.scala 107:19]
  assign fa3_io_b = io_b[2]; // @[Adder.scala 108:19]
  assign fa3_io_cin = fa2_io_cout; // @[Adder.scala 109:14]
  assign fa4_io_a = io_a[3]; // @[Adder.scala 112:19]
  assign fa4_io_b = io_b[3]; // @[Adder.scala 113:19]
  assign fa4_io_cin = fa3_io_cout; // @[Adder.scala 114:14]
endmodule
