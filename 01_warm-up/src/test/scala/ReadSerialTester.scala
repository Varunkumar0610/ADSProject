package readserial

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ReadSerialTester extends AnyFlatSpec with ChiselScalatestTester {

  "ReadSerial" should "work" in {

    test(new ReadSerial)
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      // Release reset

      dut.io.reset_n.poke(false.B)

      // Idle bus

      dut.io.rxd.poke(true.B)

      dut.clock.step(2)

      dut.io.valid.expect(false.B)

      
      // TEST CASE 1
      // 10101010
      

      dut.io.rxd.poke(false.B)
      dut.clock.step(1)

      val data1 = Seq(
        true.B,
        false.B,
        true.B,
        false.B,
        true.B,
        false.B,
        true.B,
        false.B
      )

      for(bit <- data1){

        dut.io.rxd.poke(bit)

        dut.clock.step(1)
      }

      dut.io.valid.expect(true.B)

      dut.io.data.expect("b10101010".U)

      dut.clock.step(1)

      
      // TEST CASE 2
      // RESET DURING TRANSMISSION
      

      dut.io.rxd.poke(false.B)   // start bit
      dut.clock.step(1)

      dut.io.rxd.poke(true.B)    // bit7
      dut.clock.step(1)

      dut.io.rxd.poke(false.B)   // bit6
      dut.clock.step(1)

      dut.io.rxd.poke(true.B)    // bit5
      dut.clock.step(1)

      

      dut.io.reset_n.poke(true.B)

      dut.clock.step(1)

      // Receiver should be reset

      dut.io.valid.expect(false.B)

      //dut.io.data.expect(0.U)

      // Release reset

      dut.io.reset_n.poke(false.B)

      dut.clock.step(1)

      // Start a NEW transmission

      dut.io.rxd.poke(false.B)
      dut.clock.step(1)

      val resetData = Seq(
        true.B,
        true.B,
        true.B,
        true.B,
        false.B,
        false.B,
        false.B,
        false.B
      )

      for(bit <- resetData){

        dut.io.rxd.poke(bit)

        dut.clock.step(1)
      }

      dut.io.valid.expect(true.B)

      dut.io.data.expect("b11110000".U)

      dut.clock.step(5)

      }
  }
}