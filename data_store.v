module data_store (
                  // Inputs
                  clk,            // Clock
                  reset_n,        // Active Low Reset
                  go,             // Continue states
                  data_in,        // Input data
                  load_a,         // Load OSC1
                  load_b,         // Load OSC2
                  load_c,         // Load OSC3
                  load_A,         // Load Env A
                  load_B,         // Load Env B
                  load_C,         // Load Env C
                  begin_load,     // Move from initial state to load state
                  return,         // Return to initial state

                  // Outputs

                  // Osc A settings
                  gainA,
                  octA,
                  enableA,
                  waveformA,

                  // Osc B settings
                  gainB,
                  octB,
                  enableB,
                  waveformB,

                  // Osc C settings
                  gainC,
                  octC,
                  enableC,
                  waveformC,

                  //Envelope Settings
                  AttackA,
                  DecayA,
                  SustainA,
                  ReleaseA,

                  AttackB,
                  DecayB,
                  SustainB,
                  ReleaseB,

                  AttackC,
                  DecayC,
                  SustainC,
                  ReleaseC
                );

  input clk;
  input reset_n;
  input go;
  input [9:0] data_in;
  input load_a;
  input load_b;
  input load_c;
  input load_A;
  input load_B;
  input load_C;
  input begin_load;
  input return;

  output [3:0] gainA, gainB, gainC;
  output [1:0] octA, octB, octC;
  output enableA, enableB, enableC;
  output waveformA, waveformB, waveformC;

  output [3:0] AttackA, AttackB, AttackC;
  output [3:0] DecayA, DecayB, DecayC;
  output [3:0] SustainA, SustainB, SustainC;
  output [3:0] ReleaseA, ReleaseB, ReleaseC;

  wire ld_gainA;
  wire ld_octA;
  wire ld_enableA;
  wire ld_waveformA;

  wire ld_gainB;
  wire ld_octB;
  wire ld_enableB;
  wire ld_waveformB;

  wire ld_gainC;
  wire ld_octC;
  wire ld_enableC;
  wire ld_waveformC;

  wire ld_AttackA;
  wire ld_AttackB;
  wire ld_AttackC;

  wire ld_DecayA;
  wire ld_DecayB;
  wire ld_DecayC;

  wire ld_SustainA;
  wire ld_SustainB;
  wire ld_SustainC;

  wire ld_ReleaseA;
  wire ld_ReleaseB;
  wire ld_ReleaseC;
        
  datapath d0 (
    .clk(clk),
    .reset_n(reset_n),
    .data_in(data_in),
    .ld_gainA(ld_gainA),
    .ld_gainB(ld_gainB),
    .ld_gainC(ld_gainC),
    .ld_octA(ld_octA),
    .ld_octB(ld_octB),
    .ld_octC(ld_octC),
    .ld_enableA(ld_enableA),
    .ld_enableB(ld_enableB),
    .ld_enableC(ld_enableC),
    .ld_waveformA(ld_waveformA),
    .ld_waveformB(ld_waveformB),
    .ld_waveformC(ld_waveformC),
    .ld_AttackA(ld_AttackA),
    .ld_AttackB(ld_AttackB),
    .ld_AttackC(ld_AttackC),
    .ld_DecayA(ld_DecayA),
    .ld_DecayB(ld_DecayB),
    .ld_DecayC(ld_DecayC),
    .ld_SustainA(ld_SustainA),
    .ld_SustainB(ld_SustainB),
    .ld_SustainC(ld_SustainC),
    .ld_ReleaseA(ld_ReleaseA),
    .ld_ReleaseB(ld_ReleaseB),
    .ld_ReleaseC(ld_ReleaseC),
    .gainA(gainA),
    .gainB(gainB),
    .gainC(gainC),
    .octA(octA),
    .octB(octB),
    .octC(octC),
    .enableA(enableA),
    .enableB(enableB),
    .enableC(enableC),
    .waveformA(waveformA),
    .waveformB(waveformB),
    .waveformC(waveformC),
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

  control c0 (
    .clk(clk),
    .reset_n(reset_n),
    .go(go),
    .load_a(load_a),
    .load_b(load_b),
    .load_c(load_c),
    .load_A(load_A),
    .load_B(load_B),
    .load_C(load_C),
    .begin_load(begin_load),
    .return(return),
    .ld_gainA(ld_gainA),
    .ld_gainB(ld_gainB),
    .ld_gainC(ld_gainC),
    .ld_octA(ld_octA),
    .ld_octB(ld_octB),
    .ld_octC(ld_octC),
    .ld_enableA(ld_enableA),
    .ld_enableB(ld_enableB),
    .ld_enableC(ld_enableC),
    .ld_waveformA(ld_waveformA),
    .ld_waveformB(ld_waveformB),
    .ld_waveformC(ld_waveformC),
    .ld_AttackA(ld_AttackA),
    .ld_AttackB(ld_AttackB),
    .ld_AttackC(ld_AttackC),
    .ld_DecayA(ld_DecayA),
    .ld_DecayB(ld_DecayB),
    .ld_DecayC(ld_DecayC),
    .ld_SustainA(ld_SustainA),
    .ld_SustainB(ld_SustainB),
    .ld_SustainC(ld_SustainC),
    .ld_ReleaseA(ld_ReleaseA),
    .ld_ReleaseB(ld_ReleaseB),
    .ld_ReleaseC(ld_ReleaseC)
  );

endmodule

module control (
                // Inputs
                clk,            // Clock
                reset_n,        // Active Low Reset
                go,             // Continue states
                load_a,         // Load OSC1
                load_b,         // Load OSC2
                load_c,         // Load OSC3
                load_A,
                load_B,
                load_C,
                begin_load,     // Move from initial state to load state
                return,         // Return to initial state

                // Outputs

                // Osc A settings
                ld_gainA,
                ld_octA,
                ld_enableA,
                ld_waveformA,

                // Osc B settings
                ld_gainB,
                ld_octB,
                ld_enableB,
                ld_waveformB,

                // Osc C settings
                ld_gainC,
                ld_octC,
                ld_enableC,
                ld_waveformC,

                //Envelope Settings
                ld_AttackA,
                ld_AttackB,
                ld_AttackC,

                ld_DecayA,
                ld_DecayB,
                ld_DecayC,

                ld_SustainA,
                ld_SustainB,
                ld_SustainC,

                ld_ReleaseA,
                ld_ReleaseB,
                ld_ReleaseC
              );

  input clk;
  input reset_n;
  input go;
  input load_a;
  input load_b;
  input load_c;
  input load_A;
  input load_B;
  input load_C;
  input begin_load;
  input return;

  reg [5:0] current_state, next_state;

  output reg ld_gainA;
  output reg ld_octA;
  output reg ld_enableA;
  output reg ld_waveformA;

  output reg ld_gainB;
  output reg ld_octB;
  output reg ld_enableB;
  output reg ld_waveformB;

  output reg ld_gainC;
  output reg ld_octC;
  output reg ld_enableC;
  output reg ld_waveformC;

  output reg ld_AttackA;
  output reg ld_AttackB;
  output reg ld_AttackC;

  output reg ld_DecayA;
  output reg ld_DecayB;
  output reg ld_DecayC;

  output reg ld_SustainA;
  output reg ld_SustainB;
  output reg ld_SustainC;

  output reg ld_ReleaseA;
  output reg ld_ReleaseB;
  output reg ld_ReleaseC;

  localparam  DEFAULT_STATE             = 6'd0,

              LOAD_A_ENABLE             = 6'd1,
              LOAD_A_ENABLE_WAIT        = 6'd2,
              LOAD_A_WAVEFORM           = 6'd3,
              LOAD_A_WAVEFORM_WAIT      = 6'd4,
              LOAD_A_GAIN               = 6'd5,
              LOAD_A_GAIN_WAIT          = 6'd6,
              LOAD_A_OCT                = 6'd7,
              LOAD_A_OCT_WAIT           = 6'd8,

              LOAD_B_ENABLE             = 6'd9,
              LOAD_B_ENABLE_WAIT        = 6'd10,
              LOAD_B_WAVEFORM           = 6'd11,
              LOAD_B_WAVEFORM_WAIT      = 6'd12,
              LOAD_B_GAIN               = 6'd13,
              LOAD_B_GAIN_WAIT          = 6'd14,
              LOAD_B_OCT                = 6'd15,
              LOAD_B_OCT_WAIT           = 6'd16,

              LOAD_C_ENABLE             = 6'd17,
              LOAD_C_ENABLE_WAIT        = 6'd18,
              LOAD_C_WAVEFORM           = 6'd19,
              LOAD_C_WAVEFORM_WAIT      = 6'd20,
              LOAD_C_GAIN               = 6'd21,
              LOAD_C_GAIN_WAIT          = 6'd22,
              LOAD_C_OCT                = 6'd23,
              LOAD_C_OCT_WAIT           = 6'd24,

              LOAD_ATTACK_A             = 6'd25,
              LOAD_ATTACK_A_WAIT        = 6'd26,
              LOAD_DECAY_A              = 6'd27,
              LOAD_DECAY_A_WAIT         = 6'd28,
              LOAD_SUSTAIN_A            = 6'd29,
              LOAD_SUSTAIN_A_WAIT       = 6'd30,
              LOAD_RELEASE_A            = 6'd31,
              LOAD_RELEASE_A_WAIT       = 6'd32,

              LOAD_ATTACK_B             = 6'd33,
              LOAD_ATTACK_B_WAIT        = 6'd34,
              LOAD_DECAY_B              = 6'd35,
              LOAD_DECAY_B_WAIT         = 6'd36,
              LOAD_SUSTAIN_B            = 6'd37,
              LOAD_SUSTAIN_B_WAIT       = 6'd38,
              LOAD_RELEASE_B            = 6'd39,
              LOAD_RELEASE_B_WAIT       = 6'd40,

              LOAD_ATTACK_C             = 6'd41,
              LOAD_ATTACK_C_WAIT        = 6'd42,
              LOAD_DECAY_C              = 6'd43,
              LOAD_DECAY_C_WAIT         = 6'd44,
              LOAD_SUSTAIN_C            = 6'd45,
              LOAD_SUSTAIN_C_WAIT       = 6'd46,
              LOAD_RELEASE_C            = 6'd47,
              LOAD_RELEASE_C_WAIT       = 6'd48;

  always @(*)
  begin: state_table
    case (current_state)
      DEFAULT_STATE: begin
        if (load_a && begin_load)       next_state = LOAD_A_ENABLE;
        else if (load_b && begin_load)  next_state = LOAD_B_ENABLE;
        else if (load_c && begin_load)  next_state = LOAD_C_ENABLE;
        else if (load_A && begin_load)  next_state = LOAD_ATTACK_A;
        else if (load_B && begin_load)  next_state = LOAD_ATTACK_B;
        else if (load_C && begin_load)  next_state = LOAD_ATTACK_C;
        else                            next_state = DEFAULT_STATE;
      end

      LOAD_A_ENABLE:            if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_ENABLE_WAIT : LOAD_A_ENABLE;
      LOAD_A_ENABLE_WAIT:       if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_ENABLE_WAIT : LOAD_A_WAVEFORM;
      LOAD_A_WAVEFORM:          if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_WAVEFORM_WAIT : LOAD_A_WAVEFORM;
      LOAD_A_WAVEFORM_WAIT:     if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_WAVEFORM_WAIT : LOAD_A_GAIN;
      LOAD_A_GAIN:              if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_GAIN_WAIT : LOAD_A_GAIN;
      LOAD_A_GAIN_WAIT:         if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_GAIN_WAIT : LOAD_A_OCT;
      LOAD_A_OCT:               if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_OCT_WAIT : LOAD_A_OCT;
      LOAD_A_OCT_WAIT:          if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_A_OCT_WAIT : DEFAULT_STATE;

      LOAD_B_ENABLE:            if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_ENABLE_WAIT : LOAD_B_ENABLE;
      LOAD_B_ENABLE_WAIT:       if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_ENABLE_WAIT : LOAD_B_WAVEFORM;
      LOAD_B_WAVEFORM:          if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_WAVEFORM_WAIT : LOAD_B_WAVEFORM;
      LOAD_B_WAVEFORM_WAIT:     if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_WAVEFORM_WAIT : LOAD_B_GAIN;
      LOAD_B_GAIN:              if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_GAIN_WAIT : LOAD_B_GAIN;
      LOAD_B_GAIN_WAIT:         if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_GAIN_WAIT : LOAD_B_OCT;
      LOAD_B_OCT:               if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_OCT_WAIT : LOAD_B_OCT;
      LOAD_B_OCT_WAIT:          if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_B_OCT_WAIT : DEFAULT_STATE;

      LOAD_C_ENABLE:            if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_ENABLE_WAIT : LOAD_C_ENABLE;
      LOAD_C_ENABLE_WAIT:       if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_ENABLE_WAIT : LOAD_C_WAVEFORM;
      LOAD_C_WAVEFORM:          if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_WAVEFORM_WAIT : LOAD_C_WAVEFORM;
      LOAD_C_WAVEFORM_WAIT:     if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_WAVEFORM_WAIT : LOAD_C_GAIN;
      LOAD_C_GAIN:              if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_GAIN_WAIT : LOAD_C_GAIN;
      LOAD_C_GAIN_WAIT:         if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_GAIN_WAIT : LOAD_C_OCT;
      LOAD_C_OCT:               if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_OCT_WAIT : LOAD_C_OCT;
      LOAD_C_OCT_WAIT:          if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_C_OCT_WAIT : DEFAULT_STATE;

      LOAD_ATTACK_A:            if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_ATTACK_A_WAIT : LOAD_ATTACK_A;
      LOAD_ATTACK_A_WAIT:       if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_ATTACK_A_WAIT : LOAD_DECAY_A;
      LOAD_DECAY_A:             if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_DECAY_A_WAIT : LOAD_DECAY_A;
      LOAD_DECAY_A_WAIT:        if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_DECAY_A_WAIT : LOAD_SUSTAIN_A;
      LOAD_SUSTAIN_A:           if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_SUSTAIN_A_WAIT : LOAD_SUSTAIN_A;
      LOAD_SUSTAIN_A_WAIT:      if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_SUSTAIN_A_WAIT : LOAD_RELEASE_A;
      LOAD_RELEASE_A:           if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_RELEASE_A_WAIT : LOAD_RELEASE_A;
      LOAD_RELEASE_A_WAIT:      if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_RELEASE_A_WAIT : DEFAULT_STATE;

      LOAD_ATTACK_B:            if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_ATTACK_B_WAIT : LOAD_ATTACK_B;
      LOAD_ATTACK_B_WAIT:       if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_ATTACK_B_WAIT : LOAD_DECAY_B;
      LOAD_DECAY_B:             if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_DECAY_B_WAIT : LOAD_DECAY_B;
      LOAD_DECAY_B_WAIT:        if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_DECAY_B_WAIT : LOAD_SUSTAIN_B;
      LOAD_SUSTAIN_B:           if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_SUSTAIN_B_WAIT : LOAD_SUSTAIN_B;
      LOAD_SUSTAIN_B_WAIT:      if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_SUSTAIN_B_WAIT : LOAD_RELEASE_B;
      LOAD_RELEASE_B:           if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_RELEASE_B_WAIT : LOAD_RELEASE_B;
      LOAD_RELEASE_B_WAIT:      if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_RELEASE_B_WAIT : DEFAULT_STATE;

      LOAD_ATTACK_C:            if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_ATTACK_C_WAIT : LOAD_ATTACK_C;
      LOAD_ATTACK_C_WAIT:       if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_ATTACK_C_WAIT : LOAD_DECAY_C;
      LOAD_DECAY_C:             if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_DECAY_C_WAIT : LOAD_DECAY_C;
      LOAD_DECAY_C_WAIT:        if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_DECAY_C_WAIT : LOAD_SUSTAIN_C;
      LOAD_SUSTAIN_C:           if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_SUSTAIN_C_WAIT : LOAD_SUSTAIN_C;
      LOAD_SUSTAIN_C_WAIT:      if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_SUSTAIN_C_WAIT : LOAD_RELEASE_C;
      LOAD_RELEASE_C:           if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_RELEASE_C_WAIT : LOAD_RELEASE_C;
      LOAD_RELEASE_C_WAIT:      if (return) next_state = DEFAULT_STATE; else next_state = go ? LOAD_RELEASE_C_WAIT : DEFAULT_STATE;
    endcase
  end

  always@(*)
  begin: enable_signals
    ld_enableA    = 1'b0;
    ld_enableB    = 1'b0;
    ld_enableC    = 1'b0;

    ld_gainA      = 1'b0;
    ld_gainB      = 1'b0;
    ld_gainC      = 1'b0;

    ld_octA       = 1'b0;
    ld_octB       = 1'b0;
    ld_octC       = 1'b0;

    ld_waveformA  = 1'b0;
    ld_waveformB  = 1'b0;
    ld_waveformC  = 1'b0;

    ld_AttackA    = 1'b0;
    ld_DecayA     = 1'b0;
    ld_SustainA   = 1'b0;
    ld_ReleaseA   = 1'b0;

    ld_AttackB    = 1'b0;
    ld_DecayB     = 1'b0;
    ld_SustainB   = 1'b0;
    ld_ReleaseB   = 1'b0;

    ld_AttackC    = 1'b0;
    ld_DecayC     = 1'b0;
    ld_SustainC   = 1'b0;
    ld_ReleaseC   = 1'b0;

    case (current_state)
      LOAD_A_ENABLE: ld_enableA     = 1'b1;
      LOAD_B_ENABLE: ld_enableB     = 1'b1;
      LOAD_C_ENABLE: ld_enableC     = 1'b1;

      LOAD_A_GAIN: ld_gainA         = 1'b1;
      LOAD_B_GAIN: ld_gainB         = 1'b1;
      LOAD_C_GAIN: ld_gainC         = 1'b1;

      LOAD_A_OCT: ld_octA           = 1'b1;
      LOAD_B_OCT: ld_octB           = 1'b1;
      LOAD_C_OCT: ld_octC           = 1'b1;

      LOAD_A_WAVEFORM: ld_waveformA = 1'b1;
      LOAD_B_WAVEFORM: ld_waveformB = 1'b1;
      LOAD_C_WAVEFORM: ld_waveformC = 1'b1;

      LOAD_ATTACK_A: ld_AttackA     = 1'b1;
      LOAD_DECAY_A: ld_DecayA       = 1'b1;
      LOAD_SUSTAIN_A: ld_SustainA   = 1'b1;
      LOAD_RELEASE_A: ld_ReleaseA   = 1'b1;

      LOAD_ATTACK_B: ld_AttackB     = 1'b1;
      LOAD_DECAY_B: ld_DecayB       = 1'b1;
      LOAD_SUSTAIN_B: ld_SustainB   = 1'b1;
      LOAD_RELEASE_B: ld_ReleaseB   = 1'b1;

      LOAD_ATTACK_C: ld_AttackC     = 1'b1;
      LOAD_DECAY_C: ld_DecayC       = 1'b1;
      LOAD_SUSTAIN_C: ld_SustainC   = 1'b1;
      LOAD_RELEASE_C: ld_ReleaseC   = 1'b1;
    endcase
  end

  always@(posedge clk)
  begin: state_FFs
    if (!reset_n) current_state <= DEFAULT_STATE;
    else current_state <= next_state;
  end       
endmodule

module datapath (
                // Inputs
                clk,            // Clock
                reset_n,        // Active Low Reset
                data_in,        // Input data

                // LOAD SIGNALS
                ld_gainA,
                ld_octA,
                ld_enableA,
                ld_waveformA,

                ld_gainB,
                ld_octB,
                ld_enableB,
                ld_waveformB,

                ld_gainC,
                ld_octC,
                ld_enableC,
                ld_waveformC,

                ld_AttackA,
                ld_AttackB,
                ld_AttackC,

                ld_DecayA,
                ld_DecayB,
                ld_DecayC,

                ld_SustainA,
                ld_SustainB,
                ld_SustainC,

                ld_ReleaseA,
                ld_ReleaseB,
                ld_ReleaseC,

                // Outputs

                // Osc A settings
                gainA,
                octA,
                enableA,
                waveformA,

                // Osc B settings
                gainB,
                octB,
                enableB,
                waveformB,

                // Osc C settings
                gainC,
                octC,
                enableC,
                waveformC,

                //Envelope Settings
                AttackA,
                DecayA,
                SustainA,
                ReleaseA,

                AttackB,
                DecayB,
                SustainB,
                ReleaseB,

                AttackC,
                DecayC,
                SustainC,
                ReleaseC
                );

  input clk;
  input reset_n;
  input [9:0] data_in;

  input ld_gainA;
  input ld_octA;
  input ld_enableA;
  input ld_waveformA;

  input ld_gainB;
  input ld_octB;
  input ld_enableB;
  input ld_waveformB;

  input ld_gainC;
  input ld_octC;
  input ld_enableC;
  input ld_waveformC;

  input ld_AttackA;
  input ld_AttackB;
  input ld_AttackC;

  input ld_DecayA;
  input ld_DecayB;
  input ld_DecayC;

  input ld_SustainA;
  input ld_SustainB;
  input ld_SustainC;

  input ld_ReleaseA;
  input ld_ReleaseB;
  input ld_ReleaseC;

  output reg [3:0] gainA, gainB, gainC;
  output reg [1:0] octA, octB, octC;
  output reg enableA, enableB, enableC;
  output reg waveformA, waveformB, waveformC;

  output reg [3:0] AttackA, AttackB, AttackC;
  output reg [3:0] DecayA, DecayB, DecayC;
  output reg [3:0] SustainA, SustainB, SustainC;
  output reg [3:0] ReleaseA, ReleaseB, ReleaseC;

  always@(posedge clk) begin
    if(!reset_n) begin
      enableA     <= 1'b0;
      enableB     <= 1'b0;
      enableC     <= 1'b0;
      gainA       <= 4'b0;
      gainB       <= 4'b0;
      gainC       <= 4'b0;
      octA        <= 2'b0;
      octB        <= 2'b0;
      octC        <= 2'b0;
      waveformA   <= 1'b0;
      waveformB   <= 1'b0;
      waveformC   <= 1'b0;
      AttackA     <= 4'b0;
      DecayA      <= 4'b0;
      SustainA    <= 4'b0;
      ReleaseA    <= 4'b0;
      AttackB     <= 4'b0;
      DecayB      <= 4'b0;
      SustainB    <= 4'b0;
      ReleaseB    <= 4'b0;
      AttackC     <= 4'b0;
      DecayC      <= 4'b0;
      SustainC    <= 4'b0;
      ReleaseC    <= 4'b0;
    end

    else begin
      if (ld_enableA) enableA     <= data_in[0];
      if (ld_enableB) enableB     <= data_in[0];
      if (ld_enableC) enableC     <= data_in[0];

      if (ld_gainA)   gainA       <= data_in[3:0];
      if (ld_gainB)   gainB       <= data_in[3:0];
      if (ld_gainC)   gainC       <= data_in[3:0];

      if (ld_octA)    octA        <= data_in[1:0];
      if (ld_octB)    octB        <= data_in[1:0];
      if (ld_octC)    octC        <= data_in[1:0];

      if (ld_waveformA) waveformA <= data_in[0];
      if (ld_waveformB) waveformB <= data_in[0];
      if (ld_waveformC) waveformC <= data_in[0];

      if (ld_AttackA)  AttackA  <= data_in[3:0];
      if (ld_DecayA)   DecayA   <= data_in[3:0];
      if (ld_SustainA) SustainA <= data_in[3:0];
      if (ld_ReleaseA) ReleaseA <= data_in[3:0];

      if (ld_AttackB)  AttackB  <= data_in[3:0];
      if (ld_DecayB)   DecayB   <= data_in[3:0];
      if (ld_SustainB) SustainB <= data_in[3:0];
      if (ld_ReleaseB) ReleaseB <= data_in[3:0];

      if (ld_AttackC)  AttackC  <= data_in[3:0];
      if (ld_DecayC)   DecayC   <= data_in[3:0];
      if (ld_SustainC) SustainC <= data_in[3:0];
      if (ld_ReleaseC) ReleaseC <= data_in[3:0];
    end
  end

endmodule

