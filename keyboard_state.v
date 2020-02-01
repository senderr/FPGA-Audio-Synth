module keyboard_state (
                        clk,
                        reset_n,
                        key_code,
                        new_keyboard_data,
                        note
                      );

  input clk;
  input reset_n;
  input [7:0] key_code;
  input new_keyboard_data;
  output reg [4:0] note;

  reg [4:0] current_state;
  reg [4:0] next_state;
  reg [7:0] last_held_key;

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

  // States
  localparam  KEY_Q_HOLD  = 5'd1,
              KEY_2_HOLD  = 5'd2,
              KEY_W_HOLD  = 5'd3,
              KEY_3_HOLD  = 5'd4,
              KEY_E_HOLD  = 5'd5,
              KEY_R_HOLD  = 5'd6,
              KEY_5_HOLD  = 5'd7,
              KEY_T_HOLD  = 5'd8,
              KEY_6_HOLD  = 5'd9,
              KEY_Y_HOLD  = 5'd10,
              KEY_7_HOLD  = 5'd11,
              KEY_U_HOLD  = 5'd12,
              KEY_I_HOLD  = 5'd13,
              KEY_9_HOLD  = 5'd14,
              KEY_O_HOLD  = 5'd15,
              KEY_0_HOLD  = 5'd16,
              KEY_P_HOLD  = 5'd17,
              KEY_x_HOLD  = 5'd18,
              KEY_RELEASE = 5'd19,
              IDLE        = 5'd20;        

  // Keyboard values
  localparam  keyQ     = 8'h15,
              key2     = 8'h1e,
              keyW     = 8'h1d,
              key3     = 8'h26,
              keyE     = 8'h24,
              keyR     = 8'h2d,
              key5     = 8'h2e,
              keyT     = 8'h2c,
              key6     = 8'h36,
              keyY     = 8'h35,
              key7     = 8'h3d,
              keyU     = 8'h3c,
              keyI     = 8'h43,
              key9     = 8'h46,
              keyO     = 8'h44,
              key0     = 8'h45,
              keyP     = 8'h4D,
              keyx     = 8'h54,
              keyBreak = 8'hf0;

  always @(*) begin: state_table
    case (current_state)
      IDLE: 
            if  (new_keyboard_data && key_code == keyQ) next_state = KEY_Q_HOLD;
        else if (new_keyboard_data && key_code == key2) next_state = KEY_2_HOLD;
        else if (new_keyboard_data && key_code == keyW) next_state = KEY_W_HOLD;
        else if (new_keyboard_data && key_code == key3) next_state = KEY_3_HOLD;
        else if (new_keyboard_data && key_code == keyE) next_state = KEY_E_HOLD;
        else if (new_keyboard_data && key_code == keyR) next_state = KEY_R_HOLD;
        else if (new_keyboard_data && key_code == key5) next_state = KEY_5_HOLD;
        else if (new_keyboard_data && key_code == keyT) next_state = KEY_T_HOLD;
        else if (new_keyboard_data && key_code == key6) next_state = KEY_6_HOLD;
        else if (new_keyboard_data && key_code == keyY) next_state = KEY_Y_HOLD;
        else if (new_keyboard_data && key_code == key7) next_state = KEY_7_HOLD;
        else if (new_keyboard_data && key_code == keyU) next_state = KEY_U_HOLD;
        else if (new_keyboard_data && key_code == keyI) next_state = KEY_I_HOLD;
        else if (new_keyboard_data && key_code == key9) next_state = KEY_9_HOLD;
        else if (new_keyboard_data && key_code == keyO) next_state = KEY_O_HOLD;
        else if (new_keyboard_data && key_code == key0) next_state = KEY_0_HOLD;
        else if (new_keyboard_data && key_code == keyP) next_state = KEY_P_HOLD;
        else if (new_keyboard_data && key_code == keyx) next_state = KEY_x_HOLD;
        else next_state = IDLE;


      KEY_Q_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_Q_HOLD; 
      KEY_2_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_2_HOLD; 
      KEY_W_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_W_HOLD; 
      KEY_3_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_3_HOLD; 
      KEY_E_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_E_HOLD; 
      KEY_R_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_R_HOLD; 
      KEY_5_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_5_HOLD; 
      KEY_T_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_T_HOLD; 
      KEY_6_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_6_HOLD; 
      KEY_Y_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_Y_HOLD; 
      KEY_7_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_7_HOLD; 
      KEY_U_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_U_HOLD; 
      KEY_I_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_I_HOLD; 
      KEY_9_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_9_HOLD; 
      KEY_O_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_O_HOLD; 
      KEY_0_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_0_HOLD; 
      KEY_P_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_P_HOLD; 
      KEY_x_HOLD: next_state = (new_keyboard_data && (key_code == 8'hf0)) ? KEY_RELEASE : KEY_x_HOLD; 

      KEY_RELEASE: next_state = (new_keyboard_data && (key_code == last_held_key)) ? IDLE : KEY_RELEASE;
    endcase
  end

  always@(posedge clk) begin: state_FFs
    if (!reset_n) current_state <= IDLE;
    else current_state <= next_state;
  end   

  always@(posedge clk) begin: data_path
    if (!reset_n) begin
      note <= 5'b0;
      last_held_key <= 8'b0;
    end

    else 
      case (current_state)
        KEY_Q_HOLD:  begin note <= C2;       last_held_key <= keyQ; end
        KEY_2_HOLD:  begin note <= C2_SHARP; last_held_key <= key2; end
        KEY_W_HOLD:  begin note <= D2;       last_held_key <= keyW; end
        KEY_3_HOLD:  begin note <= D2_SHARP; last_held_key <= key3; end
        KEY_E_HOLD:  begin note <= E2;       last_held_key <= keyE; end
        KEY_R_HOLD:  begin note <= F2;       last_held_key <= keyR; end
        KEY_5_HOLD:  begin note <= F2_SHARP; last_held_key <= key5; end
        KEY_T_HOLD:  begin note <= G2;       last_held_key <= keyT; end
        KEY_6_HOLD:  begin note <= G2_SHARP; last_held_key <= key6; end
        KEY_Y_HOLD:  begin note <= A2;       last_held_key <= keyY; end
        KEY_7_HOLD:  begin note <= A2_SHARP; last_held_key <= key7; end
        KEY_U_HOLD:  begin note <= B2;       last_held_key <= keyU; end
        KEY_I_HOLD:  begin note <= C3;       last_held_key <= keyI; end
        KEY_9_HOLD:  begin note <= C3_SHARP; last_held_key <= key9; end
        KEY_O_HOLD:  begin note <= D3;       last_held_key <= keyO; end
        KEY_0_HOLD:  begin note <= D3_SHARP; last_held_key <= key0; end
        KEY_P_HOLD:  begin note <= E3;       last_held_key <= keyP; end
        KEY_x_HOLD:  begin note <= F3;       last_held_key <= keyx; end
        KEY_RELEASE: note <= 5'd0;
        IDLE:        note <= 5'd0;     
        default:     note <= 5'd0;
      endcase
  end
endmodule