// Code your testbench here
// or browse Examples

module Sentence_TB ();

  reg r_Clock = 1'b0;

  wire onoff;
  wire isDash;

  always #1 r_Clock <= ~r_Clock;

  Sentence #(.CLK_SPEED(160)) UUT
  (.UnitClock(r_Clock),
   .ONOFF(onoff),
   .isDash(isDash));

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
