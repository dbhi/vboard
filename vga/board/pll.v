module PLL #(
  parameter DIVF = 7'b0000000,
  parameter DIVQ = 3'b000
) (
  input  wire clki,
  output wire clko
);

SB_PLL40_CORE #(
  .FEEDBACK_PATH("SIMPLE"),
  .PLLOUT_SELECT("GENCLK"),
  .DIVR(4'd0),
  .DIVF(DIVF),
  .DIVQ(DIVQ),
  .FILTER_RANGE(3'b001)
)
uut (
  .REFERENCECLK(clki),
  .PLLOUTCORE(clko),
  .RESETB(1'b1),
  .BYPASS(1'b0)
);

endmodule
