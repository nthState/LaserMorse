
//`include "MultiplierLookup.v"

// Code your design here
module LaserMorse_Top #(parameter CLK_SPEED=16_000_000)
  (input  CLK,          // Main Clock (16 MHz)
   output PIN_12,
    output PIN_13,
    output LED,
    output USBPU,  // USB pull-up resistor

// Multipliers
  input  PIN_24, // * 1
	input  PIN_23, // * 10
	input  PIN_22, // * 1_000
	input  PIN_21, // * 1_000_000

  input  PIN_19, // Speed
	input  PIN_18,
	input  PIN_17,
	input  PIN_16,
	input  PIN_15,
	input  PIN_14
    );

  wire unitClock;

  wire ledOnOff;
  wire isDash;

  localparam IDLE       = 0; // Default state
  localparam DOT				= 1;
  localparam DASH				= 2;

    UnitGenerator unit(.CLK(CLK),
                        .UnitClock(unitClock),

                        .PIN_24(PIN_24),
                        .PIN_23(PIN_23),
                        .PIN_22(PIN_22),
                        .PIN_21(PIN_21),

                        .PIN_19(PIN_19),
                        .PIN_18(PIN_18),
                        .PIN_17(PIN_17),
                        .PIN_16(PIN_16),
                        .PIN_15(PIN_15),
                        .PIN_14(PIN_14)
                        );

    Sentence sentence(.UnitClock(unitClock),
                      .ONOFF(ledOnOff),
                      .isDash(isDash)
                      );


	assign LED = ledOnOff;

  assign PIN_13 = ledOnOff;
  assign PIN_12 = isDash;

  assign USBPU = 0;


endmodule
