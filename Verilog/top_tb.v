// Code your testbench here
// or browse Examples
module LaserMorse_Top_TB ();

  reg r_Clock = 1'b0;

  wire LED;

  always #1 r_Clock <= ~r_Clock;

  wire on = 1;
  reg off = 0;

  LaserMorse_Top #(.CLK_SPEED(160)) UUT
  (.CLK(r_Clock),
    .PIN_12(),
     .PIN_13(),
     .LED(LED),
   .USBPU(),

     .PIN_24(off),
     .PIN_23(off),
     .PIN_22(off),
     .PIN_21(off),

     .PIN_19(off),
     .PIN_18(off),
     .PIN_17(off),
     .PIN_16(off),
   .PIN_15(on),
   .PIN_14(off)
    );

  initial
    begin
      $display("Starting Testbench...");
      #2000;
      $finish();
    end

  initial
  begin
    // Required to dump signals to EPWave
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

endmodule
