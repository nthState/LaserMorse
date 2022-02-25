// Code your design here
module Sentence #(parameter CLK_SPEED=16_000_000)
  (
    input  UnitClock,
    output wire ONOFF,
    output wire isDash
  );

  // Why 5 bits [4:0]? 26 characters in the alphabet + space
  reg [16:0] characters [16:0];
  reg [16:0] characterLengths [16:0];
  reg [16:0] currentCharacter = 0;
  reg [7:0] currentCharacterLength = 0;
  reg [7:0] characterIncrementer = 0;
  reg [31:0] bitIncrementer = 0;

  reg reset = 1;
  reg onoff = 0;
  reg indash = 0;

  /*
  Dot = 1 unit
  Dash = 3 units
  Time between dots = 1 unit
  Time between characters = 3 units
  time between words = 7 units
  */


  reg [3:0] Sx = 4'd5;
  reg [3:0] Ox = 4'd11;

  localparam A = 32'b11101;
  localparam B = 32'b101010111;
  localparam C = 32'b11101011101;
  localparam D = 32'b1110101;
  localparam E = 32'b1;
  localparam F = 32'b101011101;
  localparam G = 32'b111011101;
  localparam H = 32'b1010101;
  localparam I = 32'b101;
  localparam J = 32'b1011101110111;
  localparam K = 32'b111010111;
  localparam L = 32'b101011101;
  localparam M = 32'b1110111;
  localparam N = 32'b10111;
  localparam O = 32'b11101110111;
  localparam P = 32'b10111011101;
  localparam Q = 32'b1110101110111;
  localparam R = 32'b1011101;
  localparam S = 32'b10101;
  localparam T = 32'b111;
  localparam U = 32'b1110101;
  localparam V = 32'b111010101;
  localparam W = 32'b111011101;
  localparam X = 32'b11101010111;
  localparam Y = 32'b1110111010111;
  localparam Z = 32'b10101110111;

  localparam Num_0 = 32'b1110111011101110111;
  localparam Num_1 = 32'b11101110111011101;
  localparam Num_2 = 32'b11101110101;
  localparam Num_3 = 32'b1110111010101;
  localparam Num_4 = 32'b11101010101;
  localparam Num_5 = 32'b101010101;
  localparam Num_6 = 32'b10101010111;
  localparam Num_7 = 32'b1010101110111;
  localparam Num_8 = 32'b101011101110111;
  localparam Num_9 = 32'b10111011101110111;

  localparam CHAR = 0;
  localparam AFTER_CHAR = 1;
  localparam SPACE = 2;

  reg [3:0] STATE = 0;

  localparam MAX = 3;


  /**
  Calculates if we are in a dash
  */
    function AreWeInADash (input [16:0] character,
                           input reg [31:0] bit,
                           input reg [31:0] maxLength);
      reg out;

      begin

        if (character[bit] == 1 && character[bit + 1] == 1)
        begin
          out = 1;
        end
        else if (character[bit] == 1 && character[bit - 1] == 1)
        begin
          out = 1;
        end
        else
          begin
            out = 0;
          end

        AreWeInADash = out;

      end
    endfunction




  always @ (posedge UnitClock) begin
    if (reset == 1)
    begin
      characters[0] = S;
      characters[1] = O;
      characters[2] = S;

      characterLengths[0] = Sx;
      characterLengths[1] = Ox;
      characterLengths[2] = Sx;

      reset = 0;
    end
  end

  always @ (posedge UnitClock) begin
    if (reset == 0)
    begin

      case(STATE)
        CHAR:
          begin
            currentCharacter = characters[characterIncrementer];
            currentCharacterLength = characterLengths[characterIncrementer];

            onoff = currentCharacter[bitIncrementer];
            indash = AreWeInADash(currentCharacter, bitIncrementer, currentCharacterLength);

            if (bitIncrementer == currentCharacterLength)
            begin
              bitIncrementer = 0;
              characterIncrementer = characterIncrementer + 1;
              STATE = AFTER_CHAR;
              onoff = 0;
            end
            else
            begin
              bitIncrementer = bitIncrementer + 1;
            end

          end
        AFTER_CHAR:
          begin

            onoff = 0;

            if (bitIncrementer == 3)
            begin
              if (characterIncrementer == MAX)
              begin
                // We're done
                characterIncrementer = 0;
                bitIncrementer = 0;
                STATE = CHAR;
              end
              else
              begin
                bitIncrementer = 0;
                STATE = CHAR;
              end

            end
            else
            begin
              bitIncrementer = bitIncrementer + 1;
            end


          end
      endcase


    end
  end

  assign ONOFF = onoff;
  assign isDash = indash;

endmodule
