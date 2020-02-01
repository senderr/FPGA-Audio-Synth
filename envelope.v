module envelope (
                  clk,
                  reset_n,
                  gain_in,      // input gain multiplier    Max value = 15

                  key_held,     // 1 if key is being held
                  ASDR_done,

                  Attack,     // 0-15 Value for attack    2^Attack - 1 ms
                  Decay,      // 0-15 Value for decay     2^Decay - 1 ms
                  Sustain,    // 0-15 Value for sustain
                  Release,    // 0-15 Value for release   2^Release - 1 ms

                  gain_out,   // output gain multiplier   Max value = 7680    gain_out = gain_out_multiplier * gain_in
                  phase
                );

  // 50000 clock cycles = 1ms

  input clk;
  input reset_n;
  input [3:0] gain_in;

  input key_held;
  output reg ASDR_done;

  input [3:0] Attack;
  input [3:0] Decay;
  input [3:0] Sustain;
  input [3:0] Release;

  output reg [12:0] gain_out;
  output [3:0] phase;

  wire [12:0] peak_gain = {gain_in, 9'b0};
  wire [16:0] peak_times_sustained = peak_gain * Sustain;
  wire [12:0] sustained_gain = peak_times_sustained / 4'd15;

  reg [2:0] current_state;
  reg [2:0] next_state;

  reg [15:0] attack_cycles_counter;
  reg [15:0] decay_cycles_counter;
  reg [15:0] release_cycles_counter;

  wire [15:0] cycles_for_attack_increment = 16'b1 << Attack;
  wire [15:0] cycles_for_decay_decrement = 16'b1 << Decay;
  wire [15:0] cycles_for_release_decrement = 16'b1 << Release;

  reg initial_state;
  reg attack_phase;
  reg peak_attack;
  reg decay_phase;
  reg lowest_decay;
  reg sustain_phase;
  reg release_phase;
  reg silent_hold;

  assign phase = current_state;

  localparam  INITIAL_STATE   = 3'd0,
              ATTACK_PHASE    = 3'd1,
              PEAK_ATTACK     = 3'd2,
              DECAY_PHASE     = 3'd3,
              LOWEST_DECAY    = 3'd4,
              SUSTAIN_PHASE   = 3'd5,
              RELEASE_PHASE   = 3'd6,
              SILENT_HOLD     = 3'd7;

  always @(*)
  begin: state_table
    case (current_state)
      INITIAL_STATE: begin
        if (key_held) next_state = ATTACK_PHASE;
        else next_state = INITIAL_STATE;
      end

      ATTACK_PHASE: begin
        if (Attack == 4'b0) next_state = PEAK_ATTACK;
        else if (!key_held) next_state = RELEASE_PHASE;
        else if (gain_out <= peak_gain) next_state = ATTACK_PHASE;
        else next_state = PEAK_ATTACK;
      end

      PEAK_ATTACK: begin
        if (!key_held) next_state = RELEASE_PHASE;
        else next_state = DECAY_PHASE;
      end

      DECAY_PHASE: begin
        if (Decay == 4'b0) next_state = LOWEST_DECAY;
        else if (!key_held) next_state = RELEASE_PHASE;
        else if (gain_out >= sustained_gain) next_state = DECAY_PHASE;
        else next_state = LOWEST_DECAY;
      end

      LOWEST_DECAY: begin
        if (!key_held) next_state = RELEASE_PHASE;
        else next_state = SUSTAIN_PHASE;
      end

      SUSTAIN_PHASE: begin
        if (!key_held) next_state = RELEASE_PHASE;
        else next_state = SUSTAIN_PHASE;
      end

      RELEASE_PHASE: begin
        if (key_held) next_state = INITIAL_STATE;
        else if (gain_out == 13'b0) next_state = INITIAL_STATE;
        else next_state = RELEASE_PHASE;
      end

      SILENT_HOLD: begin
        if (!key_held) next_state = INITIAL_STATE;
        else next_state = SILENT_HOLD;
      end
    endcase
  end

  always @(*)
  begin: enable_signals

    initial_state = 1'b0;
    attack_phase = 1'b0;
    peak_attack = 1'b0;
    decay_phase = 1'b0; 
    lowest_decay = 1'b0;
    sustain_phase = 1'b0;
    release_phase = 1'b0;
    silent_hold = 1'b0;

    case (current_state)
      INITIAL_STATE: initial_state = 1'b1;
      ATTACK_PHASE: attack_phase = 1'b1;
      PEAK_ATTACK: peak_attack = 1'b1;
      DECAY_PHASE: decay_phase = 1'b1;
      LOWEST_DECAY: lowest_decay = 1'b1;
      SUSTAIN_PHASE: sustain_phase = 1'b1;
      RELEASE_PHASE: release_phase = 1'b1;
      SILENT_HOLD: silent_hold = 1'b1;
    endcase
  end



  always @(posedge clk)
  begin: datapath
  if (!reset_n) begin
    attack_cycles_counter <= 16'b0;
    decay_cycles_counter <= 16'b0;
    release_cycles_counter <= 16'b0;
    gain_out <= 13'b0;
    ASDR_done <= 1'b0;
  end

  else begin
    if (initial_state) begin
      attack_cycles_counter <= 16'b0;
      decay_cycles_counter <= 16'b0;
      release_cycles_counter <= 16'b0;
      gain_out <= 13'b0;
      ASDR_done <= 1'b1;
    end

    if (attack_phase) begin
      ASDR_done <= 1'b0;
      attack_cycles_counter <= attack_cycles_counter + 1;
      if (Attack != 4'b0 && attack_cycles_counter == cycles_for_attack_increment) begin
        gain_out <= gain_out + 1;
        attack_cycles_counter <= 16'b0;
      end
    end

    if (peak_attack) begin  
      ASDR_done <= 1'b0;
      gain_out <= peak_gain;
    end

    if (decay_phase) begin
      ASDR_done <= 1'b0;
      decay_cycles_counter <= decay_cycles_counter + 1;
      if (Decay != 4'b0 && decay_cycles_counter == cycles_for_decay_decrement) begin
        gain_out <= gain_out - 1;
        decay_cycles_counter <= 16'b0;
      end
    end

    if (lowest_decay) begin
      ASDR_done <= 1'b0;
      gain_out <= sustained_gain;
    end

    if (sustain_phase) begin
      ASDR_done <= 1'b0;
      gain_out <= sustained_gain;
    end

    if (release_phase) begin
      ASDR_done <= 1'b0;
      release_cycles_counter <= release_cycles_counter + 1;
      if (Release != 4'b0 && release_cycles_counter == cycles_for_release_decrement) begin
        gain_out <= gain_out - 1;
        release_cycles_counter <= 16'b0;
      end
    end

    if (silent_hold) begin
      ASDR_done <= 1'b0;
      gain_out <= 13'b0;
    end
  end
  end

  always@(posedge clk)
  begin: state_FFs
    if (!reset_n) begin 
      current_state <= INITIAL_STATE;
    end
    else current_state <= next_state;
  end
endmodule