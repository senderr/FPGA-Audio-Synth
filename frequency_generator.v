module frequency_generator (
                            clk,
                            enable,
                            divider,
                            pulse_out   // output pulse
                          );

  input clk;
  input enable;
  input [18:0] divider;
  reg [18:0] counter;
  output reg pulse_out;
  
  always @(posedge clk) begin
    if (!enable) begin
      counter <= 19'b0;
      pulse_out <= 1'b0;  
    end

    else begin
      if (counter == divider) begin
        pulse_out <= 1'b1;
        counter <= 19'b0;
      end

      else begin 
        counter <= counter + 1;
        pulse_out <= 1'b0;
      end
    end
  end

endmodule