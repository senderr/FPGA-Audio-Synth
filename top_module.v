module top_module (
                    KEY,
                    CLOCK_50,
                    SW,
                    LEDR,
                    HEX0,
                    HEX1,
                    HEX2,
                    HEX3,
                    HEX4,
                    HEX5,

                    FPGA_I2C_SCLK,
                    FPGA_I2C_SDAT,
                    PS2_CLK,
                    PS2_DAT,

                    AUD_ADCDAT,
                    AUD_BCLK,
                    AUD_ADCLRCK,
                    AUD_DACLRCK,
                    AUD_XCK,
                    AUD_DACDAT);
  
  input [9:0] SW;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  output [9:0] LEDR;
  input [3:0] KEY;
  input CLOCK_50;
  output FPGA_I2C_SCLK;
  inout FPGA_I2C_SDAT;

  inout PS2_CLK;
  inout PS2_DAT;

  input	 AUD_ADCDAT;
  inout	 AUD_BCLK;
  inout	 AUD_ADCLRCK;
  inout	 AUD_DACLRCK;
  output AUD_XCK;
  output AUD_DACDAT;

  synth synth0 (
    .clk(CLOCK_50),
    .KEY(KEY),
    .SW(SW),
    .LEDR(LEDR),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5),
    .FPGA_I2C_SCLK(FPGA_I2C_SCLK),
    .FPGA_I2C_SDAT(FPGA_I2C_SDAT),
    .AUD_ADCDAT(AUD_ADCDAT),
    .AUD_BCLK(AUD_BCLK),
    .AUD_ADCLRCK(AUD_ADCLRCK),
    .AUD_DACLRCK(AUD_DACLRCK),
    .AUD_XCK(AUD_XCK),
    .AUD_DACDAT(AUD_DACDAT),
    .PS2_CLK(PS2_CLK),
    .PS2_DAT(PS2_DAT)
  );
endmodule