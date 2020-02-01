module triangle_counter_8bit (
                clk,
                enable,
                pulse,
                sign,       // 1 = negative, 0 = positive (signed bit for sine LUT)
                out
              );

  input clk;
  input enable;
  input pulse;
  reg direction; // 1 = right, 0 = left
  output reg sign;
  output reg [10:0] out;

  always @(posedge clk) begin
    if (!enable) begin
      out <= 11'b0;
      sign <= 1'b0;     // Initialize as positive
      direction <= 1'b1;
    end

    else if (pulse) begin
      // Moving to the right
      if (direction) begin
        if (out == 11'b11111111111) direction <= 1'b0;  // Move left now
        else out <= out + 1;
      end

      // Moving to the left 
      else if (!direction) begin
        if (out == 11'b0) begin
          direction <= 1'b1;  // Move right now
          sign <= ~sign;      // Change sign when hitting 1 from right
        end
        else out <= out - 1;
      end
    end
  end

endmodule
