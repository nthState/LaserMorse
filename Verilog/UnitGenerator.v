module UnitGenerator #(parameter CLK_SPEED=16_000_000)
(
  input  CLK,          // Main Clock (16 MHz)
  output wire UnitClock,

  input  PIN_24, // Multipliers
	input  PIN_23,
	input  PIN_22,
	input  PIN_21,

  input  PIN_19, // Speed
	input  PIN_18,
	input  PIN_17,
	input  PIN_16,
	input  PIN_15,
	input  PIN_14
  );

  reg morse_clk = 1;

  reg [31:0] result;
  reg [3:0] multiplier = 4'b0001;
  reg [31:0] speed = 6'b000000;

  reg [31:0] calculatedValue = 0;
  reg [31:0] clockCounter = 0;

/**
Calculates a multipler effect
*/
  function [31:0] funct (input [3:0] multiplierFlags);
    reg [31:0] out;

    begin
      case(multiplierFlags)
        4'b0001: out = 32'd1;
        4'b0010: out = 32'd10;
        4'b0100: out = 32'd1_000; //3e8
        4'b1000: out = 32'd1_000_000; //f4240
        default: out = 32'd0;
      endcase

      funct = out;

    end
  endfunction

  always @(posedge CLK)
    begin

          multiplier = {PIN_24, PIN_23, PIN_22, PIN_21};
          result = funct(multiplier);

          speed = {PIN_19, PIN_18, PIN_17, PIN_16, PIN_15, PIN_14 };

          calculatedValue = result * speed;

// toggle if we hit the desired down clock
      if (clockCounter >= (CLK_SPEED / calculatedValue))
      begin
        morse_clk <= ~morse_clk;
        clockCounter <= 0;
      end
      else clockCounter <= clockCounter + 1;
    end

    assign UnitClock = morse_clk;

endmodule
