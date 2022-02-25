
module UnitGenerator_TB ();

  reg r_Clock = 1'b0;

  always #1 r_Clock <= ~r_Clock;

  wire outputValue;

  wire on = 1;
  reg off = 0;

  UnitGenerator #() UUT
  (.CLK(r_Clock),
   .UnitClock(outputValue),
   .PIN_24(off),
   .PIN_23(off),
   .PIN_22(off),
   .PIN_21(off),

   .PIN_19(off),
   .PIN_18(off),
   .PIN_17(off),
   .PIN_16(off),
 .PIN_15(on),
 .PIN_14(off));

  initial
    begin
      $display("Starting Testbench...");
      #200;
      $finish();
    end

  initial
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

endmodule
