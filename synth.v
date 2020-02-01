module synth (
              clk,
              FPGA_I2C_SCLK,
              FPGA_I2C_SDAT,
              KEY,
              SW,
              LEDR,
              HEX0,
              HEX1,
              HEX2,
              HEX3,
              HEX4,
              HEX5,
              
              AUD_ADCDAT,
              AUD_BCLK,
              AUD_ADCLRCK,
              AUD_DACLRCK,
              AUD_XCK,
              AUD_DACDAT,
              PS2_CLK,
              PS2_DAT
            );

  input clk;
  input [9:0] SW;
  input [3:0] KEY;
  output FPGA_I2C_SCLK;
  inout FPGA_I2C_SDAT;

  input	 AUD_ADCDAT;

  inout	 AUD_BCLK;
  inout	 AUD_ADCLRCK;
  inout	 AUD_DACLRCK;

  inout PS2_CLK;
  inout PS2_DAT;

  output AUD_XCK;
  output AUD_DACDAT;

  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output [9:0] LEDR;

  wire audio_in_available;
  wire signed [31:0] left_channel_audio_in;
  wire signed [31:0] right_channel_audio_in;
  wire read_audio_in;

  wire audio_out_allowed;
  wire signed [31:0] left_channel_audio_out;
  wire signed [31:0] right_channel_audio_out;
  wire write_audio_out;

  wire signed [31:0] sound;

  wire signed [31:0] sound_out_A, sound_out_B, sound_out_C;

  assign sound = sound_out_A + sound_out_B + sound_out_C;

  assign read_audio_in = audio_in_available & audio_out_allowed;

  assign left_channel_audio_out = left_channel_audio_in + sound;
  assign right_channel_audio_out = right_channel_audio_in + sound;
  assign write_audio_out = audio_in_available & audio_out_allowed;

  //
  //
  //
  //
  //
  //
  //

  wire enableA, enableB, enableC;
  wire waveformA, waveformB, waveformC;
  wire [3:0] gainA, gainB, gainC;
  wire [1:0] octA, octB, octC;
  wire [3:0] AttackA, AttackB, AttackC;
  wire [3:0] DecayA, DecayB, DecayC;
  wire [3:0] SustainA, SustainB, SustainC;
  wire [3:0] ReleaseA, ReleaseB, ReleaseC;

  wire [4:0] note;

  wire [7:0] key_code; 
  wire new_keyboard_data;   

  reg [3:0] hex0;
  reg [3:0] hex1;
  reg [3:0] hex2;
  reg [3:0] hex3;
  reg [3:0] hex4;
  reg [3:0] hex5;

  // Visual outputs

  assign LEDR[9] = | note;

  // Register values
  always @(*) 
    case(SW[9:4])
      6'b001000: begin 
        hex0 <= enableA;
        hex1 <= waveformA;
        hex2 <= gainA;
        hex3 <= octA;
      end

      6'b010000: begin 
        hex0 <= enableB;
        hex1 <= waveformB;
        hex2 <= gainB;
        hex3 <= octB;
      end

      6'b100000: begin 
        hex0 <= enableC;
        hex1 <= waveformC;
        hex2 <= gainC;
        hex3 <= octC;
      end

      6'b001001: begin 
        hex0 <= AttackA;
        hex1 <= DecayA;
        hex2 <= SustainA;
        hex3 <= ReleaseA;
      end

      6'b010010: begin 
        hex0 <= AttackB;
        hex1 <= DecayB;
        hex2 <= SustainB;
        hex3 <= ReleaseB;
      end

      6'b100100: begin 
        hex0 <= AttackC;
        hex1 <= DecayC;
        hex2 <= SustainC;
        hex3 <= ReleaseC;
      end

      default: begin 
        hex0 <= 4'b0;
        hex1 <= 4'b0;
        hex2 <= 4'b0;
        hex3 <= 4'b0;
      end
    endcase

  always @(*) begin
    hex4 = note;
    hex5 = key_code[3:0];
  end

  hex_decoder h0 (hex0, HEX0);
  hex_decoder h1 (hex1, HEX1);
  hex_decoder h2 (hex2, HEX2);
  hex_decoder h3 (hex3, HEX3);
  hex_decoder h4 (hex4, HEX4);
  hex_decoder h5 (hex5, HEX5);

  keyboard_state keyboard0 (
    .clk(clk),
    .reset_n(KEY[0]),
    .key_code(key_code),
    .new_keyboard_data(new_keyboard_data),
    .note(note)
  );

  data_store store0 (
    .clk(clk),
    .reset_n(KEY[0]),
    .go(~KEY[1]),
    .data_in(SW),
    .load_a(SW[0]),
    .load_b(SW[1]),
    .load_c(SW[2]),
    .load_A(SW[7]),
    .load_B(SW[8]),
    .load_C(SW[9]),
    .begin_load(~KEY[3]),
    .return(~KEY[2]),
    .gainA(gainA),
    .gainB(gainB),
    .gainC(gainC),
    .enableA(enableA),
    .enableB(enableB),
    .enableC(enableC),
    .waveformA(waveformA),
    .waveformB(waveformB),
    .waveformC(waveformC),
    .octA(octA),
    .octB(octB),
    .octC(octC),
    .AttackA(AttackA),
    .DecayA(DecayA),
    .SustainA(SustainA),
    .ReleaseA(ReleaseA),
    .AttackB(AttackB),
    .DecayB(DecayB),
    .SustainB(SustainB),
    .ReleaseB(ReleaseB),
    .AttackC(AttackC),
    .DecayC(DecayC),
    .SustainC(SustainC),
    .ReleaseC(ReleaseC)
  );

  oscillator osc1 (
    .clk(clk),
    .reset_n(KEY[0]),
    .gain(gainA),
    .note(note),
    .octave(octA),
    .waveform(waveformA),
    .enable((| note) && enableA),
    .sound_out(sound_out_A),
    .Attack(AttackA),
    .Decay(DecayA),
    .Sustain(SustainA),
    .Release(ReleaseA),
    .phase(LEDR[3:0])
  );

  oscillator osc2 (
    .clk(clk),
    .reset_n(KEY[0]),
    .gain(gainB),
    .note(note),
    .octave(octB),
    .waveform(waveformB),
    .enable((| note) && enableB),
    .sound_out(sound_out_B),
    .Attack(AttackB),
    .Decay(DecayB),
    .Sustain(SustainB),
    .Release(ReleaseB)
  );

  oscillator osc3 (
    .clk(clk),
    .reset_n(KEY[0]),
    .gain(gainC),
    .note(note),
    .octave(octC),
    .waveform(waveformC),
    .enable((| note) && enableC),
    .sound_out(sound_out_C),
    .Attack(AttackC),
    .Decay(DecayC),
    .Sustain(SustainC),
    .Release(ReleaseC)
  );

  Audio_Controller controller0(
    .CLOCK_50(clk),
    .reset(~KEY[0]),
    
    .clear_audio_in_memory(),
    .read_audio_in(read_audio_in),

    .clear_audio_out_memory(),  // Clear audio out buffer
    .left_channel_audio_out(left_channel_audio_out),   // Left out channel
    .right_channel_audio_out(right_channel_audio_out),  // Right out channel
    .write_audio_out(write_audio_out),

    .AUD_ADCDAT(AUD_ADCDAT),

    .AUD_BCLK(AUD_BCLK),
    .AUD_ADCLRCK(AUD_ADCLRCK),
    .AUD_DACLRCK(AUD_DACLRCK),
    
    .audio_in_available(audio_in_available),
    .left_channel_audio_in(left_channel_audio_in),
    .right_channel_audio_in(right_channel_audio_in),

    .audio_out_allowed(audio_out_allowed),

    .AUD_XCK(AUD_XCK),
    .AUD_DACDAT(AUD_DACDAT)
  );

  PS2_Controller PS2 (
    .CLOCK_50(clk),
    .reset(~KEY[0]),
    .PS2_CLK(PS2_CLK),
    .PS2_DAT(PS2_DAT),
    .received_data(key_code),
    .received_data_en(new_keyboard_data)
  );
endmodule