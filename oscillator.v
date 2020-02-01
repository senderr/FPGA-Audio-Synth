module oscillator (
                    clk,
                    reset_n,
                    gain,
                    note,
                    octave,
                    waveform,
                    enable,
                    sound_out,
                    Attack,
                    Decay,
                    Sustain,
                    Release,
                    phase
                  );

  input clk;
  input reset_n;
  input [3:0] gain;
  input [4:0] note;
  input [1:0] octave;
  input waveform;
  input enable;
  output [3:0] phase;

  wire ASDR_done;

  wire enable_oscillator = !ASDR_done || enable;

  input [3:0] Attack;
  input [3:0] Decay;
  input [3:0] Sustain;
  input [3:0] Release;

  wire [10:0] sine_connection;
  wire sine_signed_bit;
  wire frequency_clock;

  wire signed [31:0] sine_wave;
  wire signed [31:0] square_wave;

  output signed [31:0] sound_out;
  
  wire [18:0] divider;
  reg  [7:0] sine_divider;
  reg  [18:0] square_divider;

  wire [12:0] gain_out;
  wire [12:0] sine_multiplier;
  wire [12:0] square_multiplier;

  assign sine_multiplier[12:9] = gain;
  assign sine_multiplier[8:0] = 9'b0;

  assign square_multiplier[12:9] = gain;
  assign square_multiplier[8:0] = 9'b0;

  // 1 = sine || 0 = square
  assign divider = waveform ? (sine_divider >> octave) : (square_divider >> octave);
  assign sound_out = waveform ? (sine_wave * gain_out) : (square_wave * gain_out);

  localparam  C2        = 5'd1,
              C2_SHARP  = 5'd2,
              D2        = 5'd3,
              D2_SHARP  = 5'd4,
              E2        = 5'd5,
              F2        = 5'd6,
              F2_SHARP  = 5'd7,
              G2        = 5'd8,
              G2_SHARP  = 5'd9,
              A2        = 5'd10,
              A2_SHARP  = 5'd11,
              B2        = 5'd12,
              C3        = 5'd13,
              C3_SHARP  = 5'd14,
              D3        = 5'd15,
              D3_SHARP  = 5'd16,
              E3        = 5'd17,
              F3        = 5'd18;

  always @(posedge clk)
    case(note)
        C2:         begin sine_divider   <= 8'd92; square_divider   <= 19'd382225; end
        C2_SHARP:   begin sine_divider   <= 8'd87; square_divider   <= 19'd360772; end
        D2:         begin sine_divider   <= 8'd82; square_divider   <= 19'd340523; end
        D2_SHARP:   begin sine_divider   <= 8'd78; square_divider   <= 19'd321411; end
        E2:         begin sine_divider   <= 8'd73; square_divider   <= 19'd303372; end
        F2:         begin sine_divider   <= 8'd69; square_divider   <= 19'd286345; end
        F2_SHARP:   begin sine_divider   <= 8'd65; square_divider   <= 19'd270273; end
        G2:         begin sine_divider   <= 8'd61; square_divider   <= 19'd255104; end
        G2_SHARP:   begin sine_divider   <= 8'd58; square_divider   <= 19'd240786; end
        A2:         begin sine_divider   <= 8'd54; square_divider   <= 19'd227272; end
        A2_SHARP:   begin sine_divider   <= 8'd51; square_divider   <= 19'd214515; end
        B2:         begin sine_divider   <= 8'd48; square_divider   <= 19'd202476; end
        C3:         begin sine_divider   <= 8'd46; square_divider   <= 19'd191112; end
        C3_SHARP:   begin sine_divider   <= 8'd43; square_divider   <= 19'd180386; end
        D3:         begin sine_divider   <= 8'd41; square_divider   <= 19'd170261; end
        D3_SHARP:   begin sine_divider   <= 8'd38; square_divider   <= 19'd160705; end
        E3:         begin sine_divider   <= 8'd36; square_divider   <= 19'd151685; end
        F3:         begin sine_divider   <= 8'd34; square_divider   <= 19'd143172; end
      endcase

  envelope env0 (
    .clk(clk),
    .reset_n(reset_n),
    .gain_in(gain),
    .key_held(| note),
    .Attack(Attack),
    .Decay(Decay),
    .Sustain(Sustain),
    .Release(Release),
    .gain_out(gain_out),
    .phase(phase),
    .ASDR_done(ASDR_done)
  );

  frequency_generator generator1 (
    .clk(clk),
    .enable(enable_oscillator),
    .divider(divider),
    .pulse_out(frequency_clock)
  );

  triangle_counter_8bit triangle1 (
    .clk(clk),
    .enable(enable_oscillator),
    .pulse(frequency_clock),
    .sign(sine_signed_bit),
    .out(sine_connection)
  );

  sine_wave_generator sine1 (
    .fn_in(sine_connection),
    .clk(clk),
    .enable(enable_oscillator && waveform),
    .signed_bit(sine_signed_bit),
    .out(sine_wave)
  );

  square_wave_generator square1 (
    .clk(clk),
    .enable(enable_oscillator && !waveform),
    .divider(divider),
    .out(square_wave)
  );

endmodule