module square_wave_generator (
                              clk,
                              enable,
                              divider,
                              out
                            );

  input clk;
  input enable;
  input [18:0] divider;
  reg [18:0] counter;
  reg polarity;
  output reg signed [31:0] out;

  always @(posedge clk) begin
    if (!enable) begin
      counter <= 19'b0;
      out <= 32'b0;
      polarity <= 1'b0;
    end

    else begin
      counter <= counter + 1;

      if (counter == divider) begin
        counter <= 32'b0;
        polarity <= !polarity;
      end

      out <= polarity ? 32'd65534 : -32'd65534;
    end
  end
endmodule